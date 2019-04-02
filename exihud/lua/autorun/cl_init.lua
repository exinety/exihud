/*---------------------------------------------------------------------------
Hey, I see you are trying to modify the code (or at least read it).
No problem, do as you wish. But most things that should be edited are in the
language.lua and config.lua

If you know how to code in (g)lua, please help me optimize my code, as I am
new to this. Any help is appreciated and wanted. If you like my Hud, please
like it in the workshop to help others find it!
---------------------------------------------------------------------------*/

if CLIENT then

	----------------------------------------------------------------------------------------
	surface.CreateFont( "Font", {
	font = "Marlett",
	extended = false,
	size = 25,
	weight = 10,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
	} )
	----------------------------------------------------------------------------------------
	include("config.lua")
	include("lang.lua")

	local current_gamemode = engine.ActiveGamemode()
	local gun_icon = Material("materials/gunlicense.png")
	local wanted_icon = Material("materials/wanted.png")
	/*---------------------------------------------------------------------------------------
	Everything above this line is cached and only refreshes if the script is reloaded
	---------------------------------------------------------------------------------------*/

	if current_gamemode != "darkrp" then return false end

		local function draw_exihud()
			
			local health = LocalPlayer():Health()
			local health_text = LocalPlayer():Health()
			local armor = LocalPlayer():Armor()

			if health > 100 then health = 100 end
			if health < 0 then health = 0 end
	
			draw.RoundedBox(5, 5, ScrH()-155, 300, 150,Color(255,255,255))
			draw.RoundedBox(5, 10, ScrH()-150, health * 2.9, 50, Color(255, 100, 100))
			draw.RoundedBox(5, 10, ScrH()-110, armor * 2.9, 10, Color(100, 100, 255))
			draw.SimpleText(health_text, "Font", 150, ScrH()-130,Color(35,35,35),1 ,1)
	
			if current_gamemode == "darkrp" then
				
				local job = LocalPlayer():getDarkRPVar("job")
				local money = LocalPlayer():getDarkRPVar("money")
				local salary = LocalPlayer():getDarkRPVar("salary")
				local is_wanted = LocalPlayer():getDarkRPVar("wanted")
				local has_license = LocalPlayer():getDarkRPVar("HasGunlicense")
	
				draw.SimpleText(exihud.lang.job..job, "Font", 10, ScrH()-95, Color(35,35,35))
				draw.SimpleText(exihud.lang.money..money, "Font", 10, ScrH()-65, Color(35,35,35))
				draw.SimpleText(exihud.lang.salary..salary, "Font", 10, ScrH()-35, Color(35,35,35))

				if is_wanted then

					surface.SetDrawColor( 255, 35, 35, 175 )
					surface.SetMaterial( wanted_icon )
					surface.DrawTexturedRect( 260, ScrH()-95, 40, 40)

				end

				if has_license then

					surface.SetDrawColor( 35, 35, 35, 175 )
					surface.SetMaterial( gun_icon )
					surface.DrawTexturedRect( 260, ScrH()-50, 40, 40)	

				end
				
			/*
			if current_gamemode is "******" then
				(maybe coming in a future version ;)
			end
			*/
			
			end
		end
		------------------------------------------------------------------------------
		local function draw_playerui( ply )

			if ( !IsValid( ply ) ) then return end
			if ( ply == LocalPlayer() ) then return end -- Don't draw a name when the player is you
			if ( !ply:Alive() ) then return end -- Check if the player is alive
			if !exihud.config.playerui_enabled then return end
		
			local Distance = LocalPlayer():GetPos():Distance( ply:GetPos() ) --Get the distance between you and the player
		
			if ( Distance < 1000 ) then --If the distance is less than 1000 units, it will draw the name
		
				local offset = Vector( 0, 0, 100 ) --Lifts the playerui, so it isn't in the body
				local ang = LocalPlayer():EyeAngles()
				local pos = ply:GetPos() + offset + ang:Up()
				local health = ply:Health()
				local armor = ply:Armor()
				local job = ply:getDarkRPVar("job")
				local is_wanted = ply:getDarkRPVar("wanted")
				local has_license = ply:getDarkRPVar("HasGunlicense")

				if health > 100 then health = 100 end --prevent the healthbar from going offscreen
				if health < 0 then health = 0 end
		
				ang:RotateAroundAxis( ang:Forward(), 90 )
				ang:RotateAroundAxis( ang:Right(), 90 )
		
		
				cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.2 )

					draw.RoundedBox(5, -150, 0, 300, 120, Color(255,255,255))
					draw.RoundedBox(5, -145, 5, health * 2.9, 50,Color(255,100,100))
					draw.RoundedBox(5, -145, 45, 100 * 2.9, 10,Color(100,100,255))

					draw.SimpleText(exihud.lang.name .. ply:GetName(), "Font", -145, 60, Color(35,35,35))
					draw.SimpleText(exihud.lang.job .. job, "Font", -145, 90,Color(35,35,35))
					draw.SimpleText(health,"Font", 0, 25,Color(35,35,35), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

					if is_wanted then
	
						surface.SetDrawColor(255, 35, 35, 175)
						surface.SetMaterial( wanted_icon )
						surface.DrawTexturedRect(120, 60, 25, 25)
	
					end
	
					if has_license then
	
						surface.SetDrawColor(35, 35, 35, 175)
						surface.SetMaterial( gun_icon )
						surface.DrawTexturedRect(120, 90, 25, 25)	
	
					end

				cam.End3D2D()
			end
		end
		
		hook.Add("HUDPaint","Draw_ExiHUD", draw_exihud)
		hook.Add("PostPlayerDraw","Draw_PlayerUI", draw_playerui)

	----------------------------------------------------------------------------------------------

		local hide = {
			["DarkRP_EntityDisplay"] = true,
			["DarkRP_LocalPlayerHUD"] = true,
			["CHudHealth"] = true,
			["CHudAmmo"] = true,
			["CHudBattery"] = true
		}
		
		hook.Add( "HUDShouldDraw", "HideHUD", function( name )
			if ( hide[ name ] ) then return false end
		end )

end