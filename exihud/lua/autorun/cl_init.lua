/*
---------------------------------------------------------------------------
Hey, thanks for looking into my Code :)

Im new to coding, so the Code may be clunky/broken or makes no sense.
If you know coding and want to help me declutter my code, first of all: Thanks!
Second of all, just write me, I can really need help :) 

If you have any suggestions, feel free to ask me. I will see what I can do.

If you have no idea, what to change in this code: DON'T change it!

Go to the language and translate it there.
---------------------------------------------------------------------------
*/

if CLIENT then

local current_gamemode = engine.ActiveGamemode()

if current_gamemode != "darkrp" then return false end

	AddCSLuaFile("language/lang.lua")
	include("language/lang.lua")

	local wanted_icon = Material("materials/wanted.png")
	local license_icon = Material("materials/has_license.png")
	local exihud = exihud || {}

	hook.Add("HUDPaint","DRAW_EXIHUD",function() --Draw HUD

		local health_bar = LocalPlayer():Health()
		local health = LocalPlayer():Health()
		local armor = LocalPlayer():Armor()

		if health_bar > 100 then
			health_bar = 100
		end
		
		if health_bar <= 0 then
			health_bar = 0
		end

		if health <= 0 then
			health = ""
		end

		if armor > 100 then
			armor = 100
		end

		draw.RoundedBox(5, 5, ScrH()-155, 250, 150, Color(255, 255, 255))
		draw.RoundedBox(5, 15, ScrH()-145, health_bar * 2.3 , 50 , Color(255, 125, 125))
		draw.RoundedBox(5, 15, ScrH()-105, armor * 2.3 , 10 , Color(125, 125, 255))
		draw.SimpleText(health, "Impact", 115, ScrH()-135, Color(35, 35, 35))

			
		local job = LocalPlayer():getDarkRPVar("job")
		local money = LocalPlayer():getDarkRPVar("money")
		local salary = LocalPlayer():getDarkRPVar("salary")
		local is_wanted = LocalPlayer():getDarkRPVar("wanted")
		local has_license = LocalPlayer():getDarkRPVar("HasGunlicense")

		draw.SimpleText(exihud.job .. job,"Impact", 15, ScrH()- 90, Color(35, 35, 35))
		draw.SimpleText(exihud.money .. money .. exihud.currency,"Impact", 15, ScrH()- 65, Color(35, 35, 35))
		draw.SimpleText(exihud.salary .. salary .. exihud.currency ,"Impact", 15, ScrH()- 40, Color(35, 35, 35))

		if is_wanted then -- Shows triangle if wanted
			surface.SetMaterial( wanted_icon )
	    		surface.SetDrawColor( 35, 35, 35, 220 )
	    		surface.DrawTexturedRect( 200, ScrH()-90, 45, 40 )
		end

	   	if has_license then -- shows gun if gun license
	   		surface.SetMaterial( license_icon )
	   		surface.SetDrawColor( 35, 35, 35, 225 )
	   		surface.DrawTexturedRect( 200, ScrH()-50, 45, 40 )
	   	end

	end)

	local hide = { --Define HUD Elements to hide
		["DarkRP_HUD"] = true,
		["DarkRP_LocalPlayerHUD"] = false,
		["DarkRP_EntityDisplay"] = false,
		["DarkRP_ZombieInfo"] = true,
		["DarkRP_Hungermod"] = false,
		["DarkRP_Agenda"] = false,
		["CHudHealth"] = true,
		["CHudBattery"] = true,
		["CHudSuitPower"] = true,
		["CHudAmmo"] = true,
		["CHudSecondaryAmmo"] = true,
	}

	hook.Add( "HUDShouldDraw", "Hide_default_hudHUD", function( name ) --Hide defined HUD
		if ( hide[ name ] ) then return false end
	end )

end --End Client
