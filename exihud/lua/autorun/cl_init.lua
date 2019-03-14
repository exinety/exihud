/*---------------------------------------------------------------------------
Hey, I see you are trying to modify the code (or at least read it).
No problem, do as you wish. But most things that should be edited are in the
language.lua and config.lua

If you know how to code in (g)lua, please help me optimize my code, as I am
new to this. Any help is appreciated and wanted. If you like my Hud, please
like it in the workshop to help others find it!

If you have any suggestions, feel free to ask, and I will try to implement it.

Thanks for reading and have fun :)
---------------------------------------------------------------------------*/
if (engine.ActiveGamemode()) != "darkrp" then return false end

local wanted_icon = Material("materials/wanted.png") //cache image
local license_icon = Material("materials/has_license.png") //cache image

if CLIENT then
	
	//stuff outside the function is cached and won't change until you reload the script (hopefully)
	
	local function draw_exihud()
	
		//store variables for later use
		local health_text = LocalPlayer():Health() //for displaying health as numbers
		local health = LocalPlayer():Health() //for healthbar calculations
		local armor = LocalPlayer():Armor() //for armorbar calculations
		local job = LocalPlayer():getDarkRPVar("job")
		local money = LocalPlayer():getDarkRPVar("money")
		local salary = LocalPlayer():getDarkRPVar("salary")
		local is_wanted = LocalPlayer():getDarkRPVar("wanted")
		local has_license = LocalPlayer():getDarkRPVar("HasGunlicense")
	
		include("language/lang.lua") //allow translation without editing this file
		include("config.lua") //allows me to easily edit stuff (and maybe you)
	
		if health_text <= 0 then health_text = "" end //display nothing if dead
	
		if health > 100 then health = 100 end
		if health < 0 then health = 0 end //these checks prevent the health/armor bar from going out of the hud
		if armor > 100 then armor = 100 end
	
		draw.RoundedBox(5, 5, ScrH()-155, 250, 150, Color(255, 255, 255)) //create white rectangle (background)
		draw.RoundedBox(5, 10, ScrH()-150, health * 2.4, 50, Color(255, 100, 100)) //create healthbar
		draw.RoundedBox(5, 10, ScrH()-110, armor * 2.4, 10, Color(100, 100, 255)) //create armorbar
	
		draw.SimpleText(health_text, "Impact", 130, ScrH()-140, Color(35, 35, 35), TEXT_ALIGN_CENTER) //display health as number
		draw.SimpleText(exihud.lang.job .. job, "Impact", 10, ScrH()-95, Color(35, 35, 35)) //display player job
		draw.SimpleText(exihud.lang.money .. money .. exihud.lang.currencysymbol, "Impact", 10, ScrH()-65, Color(35, 35, 35))
		draw.SimpleText(exihud.lang.salary .. salary .. exihud.lang.currencysymbol, "Impact", 10, ScrH()-35, Color(35, 35, 35))
	
		if is_wanted then //shows triangle with exclamation mark if player is wanted
			surface.SetMaterial( wanted_icon )
	    	surface.SetDrawColor( 35, 35, 35, 220 )
	    	surface.DrawTexturedRect( 200, ScrH()-90, 45, 40 )
		end
	
	   	if has_license then //shows gun if player has gun license
	   		surface.SetMaterial( license_icon )
	   		surface.SetDrawColor( 35, 35, 35, 225 )
	   		surface.DrawTexturedRect( 200, ScrH()-50, 45, 40 )
	   	end
	end
	
	hook.Add("HUDPaint","Draw_Exihud",draw_exihud) //draw the hud
	
	
	//this bit of code just disables the default hud elements
	
	local hide = {
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
	
	hook.Add( "HUDShouldDraw", "Hide_default_HUD", function( name )
		if ( hide[ name ] ) then return false end
	end )
end //end client