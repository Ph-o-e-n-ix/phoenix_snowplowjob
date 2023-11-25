Config = {}

Config.Locale = 'en'

Config.Framework = { -- Just Enable one of them
    QBCore = false, -- If you use QB, remember to remove the ex_extended line in fxmanifest.lua
    ESX = true
}

Config.MSG = function(msg)
    ESX.ShowNotification(msg) 
    -- QBCore.Functions.Notify(msg, "success", 3000)
end

Config.UseNewESX = true -- Ignore if using QB

Config.Target = { -- Enable of one of them
    oxtarget = false, 
    qbtarget = false,
    drawtext3d = true, 
}

Config.Settings = { -- the driver needs to drive between this values to earn money
    usekmh = true,  -- false is mph
    minspeed = 10, 
    maxspeed = 50,
}

Config.Blip = { --https://docs.fivem.net/docs/game-references/blips/
    mapstart =  {id = 529,  color = 4},
    prop =      {id = 1,    color = 4},
    delivery =  {id = 474,  color = 4}
}

Config.StartMission = {
    {   
    vehicle = 'biff', -- https://gta5-mods.com/vehicles/snow-plow-salter-els recommended :)
    startcoords = vector4(109.4040, -1088.8149, 29.3025, 349.0272), -- Coords where u can start Mission
    vehiclespawn = vector4(116.6079, -1080.1251, 29.1924, 338.1011), -- Coords where the Vehicle will Spawn/where u also can complete the Mission
    npcname = 'u_f_o_prolhost_01' -- [PEDS -> https://wiki.rage.mp/index.php?title=Peds ]
    },
    -- {   
    --     vehicle = 'vehicleid',
    --     startcoords = vector4(0.000 , 0.000, 0.000, 0.000),
    --     vehiclespawn = vector4(0.000 , 0.000, 0.000, 0.000), 
    --     npcname = 'pedid'
    -- },
}

Config.UseTimerOnScreen = true -- Timer on top-left Screen

--Time in Seconds, where the Player receive Money in each Intervall | Vehicle speed has to be in Config.MinSpeed -> Maxspeed
Config.RewardTimeIntervall = 120 -- You get Money each this Intervall (in seconds) -- a.e each 120 seconds you get Money
Config.MaxTime = 600 -- When the Job is done. Like after 600 seconds (10 minutes) you can go back to the Company to get your Bonus

Config.SpawnProps = true -- if true, some props will spawn on the map
Config.VisibleforAll = false -- if true, other people will see the Prop / not recommended
Config.DistancetoProp = 6.5 -- Distance to Prop to disapear. If you hit the Prop too often just increase this value
Config.SnowProps = { 
    vector3(103.8158, -1024.8324, 29.4071),
    vector3(172.6301, -849.2394, 330.97191),
    vector3(238.7007, -847.7914, 29.9331),
    vector3(77.9428, -778.7978, 31.6544),
    vector3(133.8815, -809.6364, 31.2708),
    vector3(133.8129, -905.4333, 30.2190),
    vector3(129.2562, -1126.7788, 29.2905),
    vector3(60.6349, -988.1392, 29.4040),
    vector3(219.0637, -706.9691, 35.5489),
    vector3(186.8823, -762.3929, 32.6858),
    vector3(332.4607, -746.7215, 29.3286),
    vector3(308.5694, -782.4158, 29.3341),
    vector3(254.6548, -917.2175, 28.9836),
    vector3(-72.0292, -1136.8202, 25.8178),
    vector3(-72.4545, -1136.6708, 25.8155),
    vector3(-56.5929, -1028.3176, 28.5868),
    vector3(28.9108, -1039.2098, 29.3404),
    vector3(357.1462, -865.0643, 29.2968),
    vector3(395.6137, -1022.3083, 29.3855),
    vector3(306.4080, -1128.6543, 29.4557),
    vector3(275.1374, -926.0326, 28.9389),
    vector3(-36.6817, -735.1991, 32.9178),
    vector3(588.0074, -858.7973, 41.2244),
    vector3(735.7950, 86.5703, 81.2196),
    vector3(582.3945, -69.5639, 71.5640),
    vector3(606.0276, -75.6365, 72.1664),
    vector3(525.6019, -237.8178, 49.3976),
    vector3(783.8528, 130.9942, 79.7666),
    vector3(694.7155, 5.4797, 84.1303),
    vector3(640.1769, 46.6597, 87.5415),
    vector3(212.5045, -1212.2719, 29.3521),
    vector3(112.2947, -1354.7338, 29.3326),
    vector3(71.5445, -1182.2197, 29.3153),
    vector3(-15.1352, -1098.2195, 26.9247),
    vector3(3.6901, -862.1467, 30.4460),
    vector3(-19.9866, -903.6641, 29.5812),
    vector3(365.3056, -824.1799, 29.2799),
    vector3(350.6093, -951.0411, 29.4200),
    vector3(396.6166, -1099.7793, 29.4210),
    vector3(252.1514, -1273.9119, 29.1409),
    vector3(185.2671, -1280.0908, 29.0367),
    vector3(169.1727, -1329.0369, 29.1286),
    vector3(24.3434, -1303.7732, 29.0807),
    vector3(-28.7134, -1145.3683, 26.7980),
    vector3(-60.3075, -1054.9619, 27.7599),
    vector3(57.5091, -883.4468, 30.3094),
    vector3(256.4771, -975.1610, 29.3168),
    vector3(277.6601, -1054.5660, 29.2071)
}

Translation = {
    ['de'] = {
    -- Benachrichtigungen
    ["start_mission"] = '~g~[E]~s~ Schneeschieben starten',
    ["cancel_mission"] = '~r~[G]~s~ Mission abbrechen',
    ["job_not_started"] = 'Du hast den Job noch nicht gestartet',
    ["job_canceled"] = 'Du hast den Job abgebrochen',
    ["info_on_start"] = 'Fahr mit dem Schneeschieber, um Geld zu verdienen',
    ["mission_success"] = 'Du hast den Job erfolgreich erledigt.',
    ["not_enough"] = 'Du musst noch mehr Schnee schieben',
    ["need_your_car"] = 'Du brauchst dein Job Fahrzeug, um die Mission abzuschließen',
    ["already_started_Mission"] = 'Du hast bereits die Mission gestartet',
    ["need_car"] = 'Du brauchst dein Fahrzeug, um den Job abzuschließen',
    ["try_to_end"] = 'Falls du das Fahrzeug nicht mehr hast, beende den Job beim Ped',
    ["max_speed"] = '~r~Max. 50 Km/h', -- Need to change if MPH if needed
    ["complete_mission"] = '~g~[E]~s~ Job abschließen',

    ["bail_removed"] = 'Dir wurde eine Kaution abgezogen',
    ["bail_added"] = 'Du hast deine Kaution zurückerhalten',

    -- PictureNotification
    ["Picture"] = 'CHAR_PROPERTY_CINEMA_VINEWOOD',
    ["snow_Title"] = 'Schneeschieber Job',
    ["snow_message"] = 'Schneehaufen entfernt',

    --Intervall Benachrichtigung
    ["title_stepintervall"] = 'Belohnung erhalten',
    ["message_stepintervall"] = 'Du hast eine Belohnung erhalten:',

    --Letzte Stufe(Ende)
    ["Title_Step10"] = 'Belohnung erhalten',
    ["message_step10"] = 'Du hast eine Belohnung erhalten',
    ["message_step10_end"] = 'Gut Gemacht! Fahr jetzt zum AbgabeOrt Zurück',

    --Mission beendet
    ["Title_complete"] = 'Bonus erhalten',
    ["Mission_Complete_MSG"] = 'Dein Bonus beträgt:',

    --Blips
    ["blipname_delivery"] = 'Abgabepunkt',
    ["your_car"] = 'Dein Fahrzeug',
    ["Snow"] = 'Schneeberg',
    ["start_mission_blip"] = 'Schnee Schieben',

    ["webhook_message"] = 'hat den Job erledigt.\nVerdienst:'
    },
------------------------------------------------------------------------------------------------------
    ['en'] = {
        ["start_mission"] = '~g~[E]~s~ Start Snowplow Job',
        ["cancel_mission"] = '~r~[G]~s~ Cancel Mission',
        ["job_not_started"] = 'You havent started the Job yet',
        ["job_canceled"] = 'You canceled the Job',
        ["info_on_start"] = 'Drive with the Vehicle to earn Money',
        ["mission_success"] = 'You completed the Job.',
        ["not_enough"] = 'Your work is not over yet',
        ["need_your_car"] = 'You need your Job Vehicle, to complete the Job',
        ["already_started_Mission"] = 'You have already started the Job',
        ["need_car"] = 'You need your SnowPlow Vehicle to finish the Job',
        ["try_to_end"] = 'If you lost the Vehicle, try to cancel the Job by the Ped',
        ["max_speed"] = '~r~Max. 50 Km/h', -- Need to change if MPH if needed
        ["complete_mission"] = '~g~[E]~s~ Complete Job',

        ["bail_removed"] = 'You left a Bail for the Vehicle',
        ["bail_added"] = 'You got the Cash back from the Vehicle',

        -- PictureNotification
        ["Picture"] = 'CHAR_PROPERTY_CINEMA_VINEWOOD',
        ["snow_Title"] = 'Snowplow Job',
        ["snow_message"] = 'Snow removed',

        --Step Intervall Notify
        ["title_stepintervall"] = 'Received Reward',
        ["message_stepintervall"] = 'You Received a Reward:',

        -- Last Step Notify
        ["Title_Step10"] = 'SnowPlow Job',
        ["message_step10"] = 'You Received a Reward:',
        ["message_step10_end"] = 'Good Job! Now drive back to the Company',

        --Mission complete
        ["Title_complete"] = 'Received Bonus',
        ["Mission_Complete_MSG"] = 'Your Bonus is:',


        --Blips
        ["blipname_delivery"] = 'Company',
        ["your_car"] = 'Your Vehicle',
        ["Snow"] = 'Snow',
        ["start_mission_blip"] = 'Snowplow Job',

        ["webhook_message"] = 'has done the Job\nReward:'
    }
}
