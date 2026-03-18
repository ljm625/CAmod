
SetupPlayers = function()
	Multi0 = Player.GetPlayer("Multi0")
	Multi1 = Player.GetPlayer("Multi1")
	Multi2 = Player.GetPlayer("Multi2")
	Multi3 = Player.GetPlayer("Multi3")
	Multi4 = Player.GetPlayer("Multi4")
	Multi5 = Player.GetPlayer("Multi5")
	GDI = Player.GetPlayer("GDI")
	Scrin = Player.GetPlayer("Scrin")
	Nod = Player.GetPlayer("Nod")
	Neutral = Player.GetPlayer("Neutral")
	MissionPlayers = Utils.Where({ Multi0, Multi1, Multi2, Multi3, Multi4, Multi5 }, function(p) return p ~= nil end)
	MissionEnemies = { Nod, Scrin }
	SinglePlayerPlayer = GDI
	CoopInit()
end

AfterWorldLoaded = function()
	StartCashSpread(3500)
end

AfterTick = function()

end

InitMcv = function()
	PlaySpeechNotificationToMissionPlayers("ReinforcementsArrived")
	Notification("增援已抵达。")
    local exitPath =  { CarryallSpawn.Location }
	local MCVIterator = 0
	if #MissionPlayers > 1 then
		Tip("这座岛上的建造空间有限。建议由一名玩家建造海军船坞，再把你们的MCV运到大陆。")
	end
	Utils.Do(GetMcvPlayers(), function(p)
		local entryPath = { CarryallSpawn.Location, CarryallDest.Location + CVec.New((MCVIterator-3),(MCVIterator-3)) }
		ReinforcementsCA.ReinforceWithTransport(p, "ocar.amcv", nil, entryPath, exitPath)
		MCVIterator = MCVIterator + 2
	end)
end
