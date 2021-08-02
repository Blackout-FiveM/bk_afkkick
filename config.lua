Config = {}

-- You can set the time that the player must remain without moving for the kick (in seconds)
Config.Time = 300 -- 5 minutes

-- Here you can put the STEAMID dice people who will not be kicked even if they are afk (http://www.vacbanned.com/ (Hex))
Config.Bypass = {
    "steam:11000010e05330b",
}

-- You can translate the alert message and the kicker message (do not delete %s)
Locale = {
    alertMessage = "~r~Move or you will be kicked in ~w~%s seconds.",
    kickMessage = "You were kick for the reason: AFK."
}