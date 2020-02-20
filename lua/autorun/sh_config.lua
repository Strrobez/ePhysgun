--[[
	Name: ePhysgun Settings

	Developer: Strobez

	Language: GLua (Garry's Mod Lua)

		-- Information --
	• Supports xAdmin and ULX.
	• Physgun Colors can be changed based on their usergroup in the table below.
	• Right clicking when you are physgunning someone will do the following:
		• Freeze
		• God
		• Stop 'suicide'
		~ Player can be unfrozen by picking them up again with the physgun.

		-- Future Updates --
	• Rainbow Physgun Option.
		~ Allow all players to have rainbow physguns.
	• Negate fall damage when dropped from physgun.
		~ Players will not take fall damage when 'accidently' dropped from height.

]]

ePhysgun = {}
ePhysgun.Settings = {}
ePhysgun.Colors = {}

--[[ General Settings ]]

// No need to touch, just for Strobez
ePhysgun.Settings.Version = "v1.0.1"

// Are you using xAdmin or ULX?
ePhysgun.Settings.AdminSystem = true

--[[ Color Settings ]]

// Set a static physgun color for the following ranks.
ePhysgun.Colors.Usergroups = {
	["Owner"] = Color(255, 100, 80),
	["Admin"] = Color(0, 255, 0),
	["User"] = Color(65, 65, 65),
}