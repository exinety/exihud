resource.AddSingleFile("resource/fonts/unicode-impact.ttf")

surface.CreateFont( "Impact", {
	font = "Impact", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 25,
	weight = 100,
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

/*

If you want to translate this addon, please use the strings (The things in "")

For Example: "JOB: " ---> "ARBEIT: "

*/

exihud = exihud || {}

exihud.job = "JOB: "
exihud.money = "MONEY: "
exihud.salary = "SALARY: "
exihud.currency = "$"