--[[

ePhysgun Settings

Coded by Strobez for Github

Supports GLua (Garry's Mod Lua)

]]

AddCSLuaFile("autorun/sh_config.lua")

local function SendLog(sType, sLog)
    MsgC(Color(255, 255, 255), "[" .. sType .. "] ", Color(255, 255, 255), sLog)
end

-- Physgun Colors:
--[[
	Physgun Colors can be applied to the usergroups.
	This will happen on each spawn of the player.
]]
function ePhysgunColorsSet(ply)

	if ePhysgun.Settings.AdminSystem then
		if ePhysgun.Colors.Usergroups[ply:GetUserGroup()] == nil then
			-- lua...
		else
			timer.Simple(0.1, function()
				local vColor = ePhysgun.Colors.Usergroups[ply:GetUserGroup()]
				ply:SetWeaponColor( Vector( vColor.r / 255, vColor.g / 255, vColor.b / 255 ) )
			end)
		end
	else
		print("| [ePhysgun] UNSUPPORTED ADMIN MOD // CONTACT STROBEZ FOR SUPPORT")
	end

end
hook.Add("PlayerSpawn", "ePhysgun.Colors.Set.PlayerSpawn", ePhysgunColorsSet)

-- Physgun Freeze:
--[[
	Player will be frozen on right click.
	Player can not suicide when frozen.
	Player is invincible when frozen.
]]
function ePhysgunFreezeGod( ply, dmginfo )

	if(ply:GetNWInt("ePhysgunFGod") == 1) then
			dmginfo:ScaleDamage( 0 )
	end

end
hook.Add("EntityTakeDamage", "ePhysgun.Freeze.God", ePhysgunFreezeGod)

function ePhysgunOnDrop(ply, ent)

	ent._physgunned = false
	
	if( ent:IsPlayer() ) then         		   
		ent:SetMoveType(ply:KeyDown(IN_ATTACK2) and MOVETYPE_NOCLIP or MOVETYPE_WALK)
		
		if(ply:KeyDown(IN_ATTACK2)) then
			ent:Freeze(true)
			ent:SetNWInt("ePhysgunFGod", 1)
		else
			ent:Freeze(false)
			ent:SetNWInt("ePhysgunFGod", 0)
		end
		   
		if SERVER then
			
			if !ent:Alive() then
				ent:Spawn()
				self:PlayerSpawn(ent)
				ent:SetPos(ply:GetEyeTrace().HitPos)
			end
		end
		
		return
	end

end
hook.Add("PhysgunDrop", "ePhysgun.Drop", ePhysgunOnDrop)

function ePhysgunOnPickup(ply, ent)

	ent._physgunned = true

end
hook.Add( "PhysgunPickup", "ePhysgun.Pickup", ePhysgunOnPickup)

function ePhysgunCanPlayerSuicide( ply, weapon, killer )

	if(ply._physgunned) then
		return false
	else
		return true
	end

end
hook.Add( "CanPlayerSuicide", "ePhysgun.Player.CanSuicide", ePhysgunPlayerCanSuicide )

-- Physgun Negate Fall Damage:
--[[
	Player will not loose health when dropped by a physgun.
]]

function ePhysgunNegateFDamage(ply, ent)

	if( ent:IsPlayer() ) then
		ent:SetNWInt("ePhysgunFGod", 1)
	else
		ent:SetNWInt("ePhysgunFGod", 0)
	end

end
hook.Add("PhysgunDrop", "ePhysgun.NegateFallDamage", ePhysgunNegateFDamage)


-- Send Confirmation Log
SendLog("ePhysgun Settings", "Loaded ePhysgun "..ePhysgun.Settings.Version.. " by Strobez")