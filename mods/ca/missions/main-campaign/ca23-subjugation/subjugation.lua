MissionDir = "ca|missions/main-campaign/ca23-subjugation"

RespawnEnabled = Map.LobbyOption("respawn") == "enabled"

PowerGrids = {
	{
		Providers = { NPower1, NPower2, NPower3, NPower4 },
		Consumers = { NPowered1, NPowered2, NPowered3, NPowered4, NPowered5, NPowered6 },
	},
	{
		Providers = { EPower1, EPower2, EPower3 },
		Consumers = { EPowered1, EPowered2, EPowered3, EPowered4, EPowered5 },
	},
	{
		Providers = { SPower1, SPower2, SPower3 },
		Consumers = { SPowered1, SPowered2, SPowered3, SPowered4, SPowered5, SPowered6, SPowered7 },
	},
	{
		Providers = { CPower1, CPower2, CPower3, CPower4 },
		Consumers = { CPowered1, CPowered2, CPowered3, CPowered4, CPowered5, CPowered6, CPowered7, CPowered8, CPowered9, CPowered10, CPowered11, CPowered12, CPowered13, CPowered14, CPowered15, CPowered16 },
	},
}

TibTrucks = {
	First = {
		Actor = ETibTruck,
		Delay = {
			easy = DateTime.Minutes(6),
			normal = DateTime.Minutes(5),
			hard = DateTime.Minutes(4),
			vhard = DateTime.Minutes(4),
			brutal = DateTime.Minutes(4),
		},
		Path = { ETibTruckPath1.Location, ETibTruckPath2.Location, ETibTruckPath3.Location, ETibTruckPath4.Location },
		ObjectiveText = "阻止第一批浓缩泰伯利亚运输\n抵达尤里。",
		Objective = nil,
	},
	Second = {
		Actor = NTibTruck,
		Delay = {
			easy = DateTime.Minutes(15),
			normal = DateTime.Minutes(12),
			hard = DateTime.Minutes(10),
			vhard = DateTime.Minutes(10),
			brutal = DateTime.Minutes(10),
		},
		Path = { NTibTruckPath1.Location, NTibTruckPath2.Location, NTibTruckPath3.Location, NTibTruckPath4.Location, NTibTruckPath5.Location, NTibTruckPath6.Location, NTibTruckPath7.Location, NTibTruckPath8.Location, NTibTruckPath9.Location, NTibTruckPath10.Location },
		ObjectiveText = "阻止第二批浓缩泰伯利亚运输\n抵达尤里。",
		Objective = nil,
	},
	Third = {
		Actor = STibTruck,
		Delay = {
			easy = DateTime.Minutes(25),
			normal = DateTime.Minutes(20),
			hard = DateTime.Minutes(16),
			vhard = DateTime.Minutes(16),
			brutal = DateTime.Minutes(16),
		},
		Path = { STibTruckPath1.Location, STibTruckPath2.Location, STibTruckPath3.Location, STibTruckPath4.Location, STibTruckPath5.Location, STibTruckPath6.Location },
		ObjectiveText = "阻止第三批浓缩泰伯利亚运输\n抵达尤里。",
		Objective = nil,
	},
}

TibFacilities = { NTibFacility, STibFacility, ETibFacility }

HindPatrolPath = { HindPatrol1.Location, HindPatrol2.Location, HindPatrol3.Location, HindPatrol4.Location, HindPatrol5.Location, HindPatrol6.Location, HindPatrol7.Location, HindPatrol8.Location, HindPatrol9.Location }

BombsEnabledTime = {
	vhard = DateTime.Minutes(20),
	brutal = DateTime.Minutes(10),
}

Squads = {
	Main = {
		Delay = AdjustDelayForDifficulty(DateTime.Minutes(6)),
		AttackValuePerSecond = {
			vhard = { Min = 5, Max = 15 },
			brutal = { Min = 10, Max = 20 },
		},
		FollowLeader = true,
		ProducerActors = { Infantry = { NorthEastBarracks, NorthWestBarracks, SouthEastBarracks, SouthWestBarracks, CentralBarracks } },
		Compositions = AdjustCompositionsForDifficulty({
			{ Infantry = { "e3", "e1", "e1", "e1", "e1", "e2", "brut" } },
			{ Infantry = { "e3", "e2", "tplr", "e1", "e1", "e1", "e1" } },
			{ Infantry = { "e3", "e2", "enli", "e1", "e1", "e1", "e1" }, MinTime = DateTime.Minutes(16) },
			{ Infantry = { "e3", "e2", "rmbc", "e1", "e1", "e1", "e1" }, MinTime = DateTime.Minutes(20) },
		}),
	},
}

SetupPlayers = function()
	Scrin = Player.GetPlayer("Scrin")
	USSR = Player.GetPlayer("USSR")
	Neutral = Player.GetPlayer("Neutral")
	MissionPlayers = { Scrin }
	MissionEnemies = { USSR }
end

WorldLoaded = function()
	SetupPlayers()

	TimerTicks = 0
	TibFacilitiesCaptured = 0
	Camera.Position = PlayerStart.CenterPosition

	InitObjectives(Scrin)
	InitUSSR()

	ObjectiveCaptureTibFacilities = Scrin.AddObjective("夺取3座泰伯利亚浓缩设施。")
	if not RespawnEnabled then
		ObjectiveMastermindSurvives = Scrin.AddObjective("摄魂师必须存活。")
	end

	Mastermind.GrantCondition("difficulty-" .. Difficulty)

	if IsHardOrAbove() then
		CapturedCreditsAmount = 1000
	elseif Difficulty == "normal" then
		CapturedCreditsAmount = 1250
	elseif Difficulty == "easy" then
		CapturedCreditsAmount = 1500
	end

	Utils.Do(MissionPlayers, function(p)
		Actor.Create("blink.upgrade", true, { Owner = p })
		Actor.Create("radar.dummy", true, { Owner = p })
	end)

	Trigger.AfterDelay(DateTime.Seconds(7), function()
		Media.DisplayMessage("你的力量在我面前不值一提。趁还能走，赶紧钻进你的虫洞逃命吧。", "尤里", HSLColor.FromHex("FF00BB"))
		MediaCA.PlaySound(MissionDir .. "/yuri_taunt.aud", 2)
		Trigger.AfterDelay(DateTime.Seconds(7), function()
			Tip("摄魂师最多可心控3个敌方单位。若心控第4个，最早被控制的单位会死亡。")
			Trigger.AfterDelay(DateTime.Seconds(7), function()
				Tip("摄魂师拥有定向技能，可在自身及其奴隶单位处引发心灵火花，对附近敌人造成伤害并减速（奴隶单位不受影响）。")
				Trigger.AfterDelay(DateTime.Seconds(7), function()
					Tip("摄魂师可控制敌方建筑。生产建筑可生产永久奴役单位。")
					Trigger.AfterDelay(DateTime.Seconds(7), function()
						Tip("在摄魂师足够强大、可保护部队免受尤里影响前，请远离尤里影响范围。")
					end)
				end)
			end)
		end)
	end)

	MastermindDeathTrigger(Mastermind)

	Utils.Do(PowerGrids, function(grid)
		Trigger.OnAllKilledOrCaptured(grid.Providers, function()
			Utils.Do(grid.Consumers, function(consumer)
				if not consumer.IsDead then
					consumer.GrantCondition("disabled")
				end
			end)
		end)
	end)

	Utils.Do(TibFacilities, function(a)
		Trigger.OnKilled(a, function(self, killer)
			if not IsMissionPlayer(self.Owner) then
				Scrin.MarkFailedObjective(ObjectiveCaptureTibFacilities)
			end
		end)

		Trigger.OnCapture(a, function(self, captor, oldOwner, newOwner)
			if IsMissionPlayer(newOwner) then
				TibFacilitiesCaptured = TibFacilitiesCaptured + 1
				Mastermind.GrantCondition("rank-veteran")
				Mastermind.Health = Mastermind.MaxHealth
			end

			if TibFacilitiesCaptured == 3 then
				if ObjectiveCaptureYuriHQ == nil then
					ObjectiveCaptureYuriHQ = Scrin.AddObjective("夺取尤里的指挥中心。")
				end
				Scrin.MarkCompletedObjective(ObjectiveCaptureTibFacilities)
				Trigger.AfterDelay(DateTime.Seconds(2), function()
					Notification("已吸收浓缩灵液。你的摄魂师已进化为夺魂师，可保护附近单位免受尤里影响。")
					MediaCA.PlaySound(MissionDir .. "/s_prodigy.aud", 2)
				end)
			else
				Trigger.AfterDelay(DateTime.Seconds(2), function()
					Notification("已吸收浓缩灵液。摄魂师心控容量+1。")
					MediaCA.PlaySound(MissionDir .. "/s_ichorconsumed.aud", 2)
				end)
			end
		end)
	end)

	Trigger.OnKilled(YuriHQ, function(self, killer)
		if ObjectiveCaptureYuriHQ == nil then
			ObjectiveCaptureYuriHQ = Scrin.AddObjective("夺取尤里的指挥中心。")
		end

		if not IsMissionPlayer(self.Owner) then
			Scrin.MarkFailedObjective(ObjectiveCaptureYuriHQ)
		end
	end)

	Trigger.OnCapture(YuriHQ, function(self, captor, oldOwner, newOwner)
		if ObjectiveCaptureYuriHQ == nil then
			ObjectiveCaptureYuriHQ = Scrin.AddObjective("夺取尤里的指挥中心。")
		end

		Scrin.MarkCompletedObjective(ObjectiveCaptureYuriHQ)
		if not RespawnEnabled then
			Scrin.MarkCompletedObjective(ObjectiveMastermindSurvives)
		end
	end)

	Utils.Do(TibTrucks, function(t)
		Trigger.AfterDelay(t.Delay[Difficulty], function()
			if not t.Actor.IsDead and t.Actor.Owner == USSR and t.Objective == nil then

				if not FirstShipmentAnnounced then
					FirstShipmentAnnounced = true
					Notification("检测到浓缩灵液运输队。即将出发。阻止其抵达尤里指挥中心。")
					MediaCA.PlaySound(MissionDir .. "/s_firstichorshipment.aud", 2)
				else
					Notification("检测到浓缩灵液运输队。")
					MediaCA.PlaySound(MissionDir .. "/s_ichorshipment.aud", 2)
				end

				t.Objective = Scrin.AddSecondaryObjective(t.ObjectiveText)
				local camera = Actor.Create("smallcamera", true, { Owner = Scrin, Location = t.Actor.Location })
				Trigger.AfterDelay(DateTime.Seconds(10), function()
					camera.Destroy()
				end)
				Beacon.New(Scrin, t.Actor.CenterPosition)
				Trigger.AfterDelay(DateTime.Seconds(30), function()
					if not t.Actor.IsDead and t.Actor.Owner == USSR and not Scrin.IsObjectiveFailed(t.Objective) then
						Utils.Do(t.Path, function(waypoint)
							t.Actor.Move(waypoint)
						end)
						Trigger.OnEnteredFootprint({ t.Path[#t.Path] }, function(a, id)
							if not YuriHQ.IsDead and YuriHQ.Owner == USSR and a == t.Actor and a.Owner == USSR then
								Trigger.RemoveFootprintTrigger(id)
								YuriHQ.GrantCondition("enriched")
								a.Destroy()
								Notification("一批浓缩灵液已抵达尤里指挥中心，尤里变得更强了。")
								MediaCA.PlaySound(MissionDir .. "/s_yuripower.aud", 2)
								if t.Objective ~= nil and not Scrin.IsObjectiveCompleted(t.Objective) then
									Scrin.MarkFailedObjective(t.Objective)
								end
							end
						end)
					end
				end)
			end
		end)
		Trigger.OnKilled(t.Actor, function(self, killer)
			if t.Objective == nil then
				t.Objective = Scrin.AddSecondaryObjective(t.ObjectiveText)
			end
			Trigger.AfterDelay(2, function()
				if not Scrin.IsObjectiveFailed(t.Objective) then
					Scrin.MarkCompletedObjective(t.Objective)
				end
			end)
		end)
	end)

	Trigger.OnEnteredProximityTrigger(YuriHQ.CenterPosition, WDist.New(18 * 1024), function(a, id)
		if IsMissionPlayer(a.Owner) and a.Type ~= "smallcamera" then
			Trigger.RemoveProximityTrigger(id)
			if not YuriDefenderTipShown then
				YuriDefenderTipShown = true
				Tip("尤里指挥中心戒备森严。正面强攻并非最佳方案。")
			end
		end
	end)

	SetupReveals({ EntranceReveal1, EntranceReveal2, EntranceReveal3, EntranceReveal4, EntranceReveal5, EntranceReveal6, EntranceReveal7, EntranceReveal8, EntranceReveal9, EntranceReveal10, EntranceReveal11 }, "smallcamera")
	AfterWorldLoaded()
end

Tick = function()
	OncePerSecondChecks()
	OncePerFiveSecondChecks()
	AfterTick()
end

OncePerSecondChecks = function()
	if DateTime.GameTime > 1 and DateTime.GameTime % 25 == 0 then
		USSR.Resources = USSR.ResourceCapacity - 500

		if TimerTicks > 0 then
			if TimerTicks > 25 then
				TimerTicks = TimerTicks - 25
			else
				TimerTicks = 0
			end
		end
	end
end

OncePerFiveSecondChecks = function()
	if DateTime.GameTime > 1 and DateTime.GameTime % 125 == 0 then
		UpdatePlayerBaseLocations()

		Utils.Do(TibTrucks, function(t)
			if not t.Actor.IsDead and IsMissionPlayer(t.Actor.Owner) then
				if t.Objective ~= nil and not Scrin.IsObjectiveFailed(t.Objective) then
					Scrin.MarkCompletedObjective(t.Objective)
				end
			end
		end)
	end
end

InitUSSR = function()
	AutoRepairBuildings(USSR)
	SetupRefAndSilosCaptureCredits(USSR)
	InitAiUpgrades(USSR, 0)

	if IsVeryHardOrAbove() then
		InitAttackSquad(Squads.Main, USSR)
		Trigger.AfterDelay(BombsEnabledTime[Difficulty], function()
			if not CentralDome.IsDead then
				CentralDome.GrantCondition("bombs-enabled")
			end
			if not CentralHelipad.IsDead then
				CentralHelipad.GrantCondition("bombs-enabled")
			end
		end)
	end

	Actor.Create("ai.unlimited.power", true, { Owner = USSR })
	Actor.Create("cyborgspeed.upgrade", true, { Owner = USSR })
	Actor.Create("cyborgarmor.upgrade", true, { Owner = USSR })

	local ussrGroundAttackers = USSR.GetGroundAttackers()

	Utils.Do(ussrGroundAttackers, function(a)
		TargetSwapChance(a, 10)
		CallForHelpOnDamagedOrKilled(a, WDist.New(5120), IsUSSRGroundHunterUnit)
	end)

	local hinds = USSR.GetActorsByType("hind")
	Utils.Do(hinds, function(a)
		a.Patrol(HindPatrolPath, true)
		Trigger.OnDamaged(a, function(self, attacker, damage)
			if not self.IsDead and self.AmmoCount() == 0 then
				Trigger.ClearAll(self)
				self.Stop()
				self.ReturnToBase()
				Trigger.AfterDelay(DateTime.Seconds(1), function()
					if not self.IsDead then
						self.Patrol(HindPatrolPath, true)
					end
				end)
			end
		end)
	end)
end

RespawnMastermind = function()
	local mastermindName = "摄魂师"

	if TibFacilitiesCaptured == 3 then
		mastermindName = "夺魂师"
	end

	Notification("" .. mastermindName .. "动用了强大的心灵力量逃过一死。将在20秒后返回战场。")

	Trigger.AfterDelay(DateTime.Seconds(20), function()
		local wormhole = Actor.Create("wormhole", true, { Owner = Scrin, Location = PlayerStart.Location })
		Beacon.New(Scrin, PlayerStart.CenterPosition, DateTime.Seconds(20))

		Trigger.AfterDelay(DateTime.Seconds(2), function()
			PlaySpeechNotificationToMissionPlayers("ReinforcementsArrived")
			Mastermind = Reinforcements.Reinforce(Scrin, { "mast" }, { PlayerStart.Location }, 1)[1]
			Mastermind.Scatter()

			if IsNormalOrBelow() then
				Mastermind.GrantCondition("difficulty-" .. Difficulty)
			end

			for i=1, TibFacilitiesCaptured do
				Mastermind.GrantCondition("rank-veteran")
			end

			Trigger.AfterDelay(DateTime.Seconds(5), function()
				wormhole.Kill()
			end)

			MastermindDeathTrigger(Mastermind)
		end)
	end)
end

MastermindDeathTrigger = function(mastermind)
	Trigger.OnKilled(mastermind, function(self, killer)
		if RespawnEnabled then
			RespawnMastermind()
		else
			Scrin.MarkFailedObjective(ObjectiveMastermindSurvives)
		end
	end)
end
