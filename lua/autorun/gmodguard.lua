--[[ 

	GModGuard v.development
	A global, shared banning database for GMod.

	Authors: 
		Phoenixf129 - http://steamcommunity.com/id/Phoenixf129
		Bzaraticus - http://steamcommunity.com/id/Bzaraticus
		Drakehawke - http://steamcommunity.com/id/Drakehawke

	File: lua/autorun/gmodguard.lua
	- Loads GModGuard clientside and serverside.

]]--

gmodguard = {}

MsgN( "[GModGuard - Development]" )

if SERVER then

	MsgN( "[GModGuard] Loading config..." )

	local cfgfile = file.Read( "addons/GModGuard/config.txt", true )
	if cfgfile then

		MsgN( "[GModGuard] config.txt found." )

	else

		MsgN( "[GModGuard] WARNING - config.txt not found - expect errors!" )

	end

	gmodguard.config = {}

	local config = string.Explode( "\n", cfgfile or "" )
	for k, v in pairs( config ) do

		if v[ 1 ] == "#" then continue end -- comments :)
	 	local equals = string.find( v, "=" )
	 	if not equals then continue end

		gmodguard.config[ string.sub( v, 1, equals - 1 ) ] = string.sub( v, equals + 1, #v - 1 )

	end

	MsgN( "[GModGuard] Config loaded." )

end

MsgN( "[GModGuard] Loading files..." )

if SERVER then

	AddCSLuaFile( "autorun/gmodguard.lua" )

end

for _, v in pairs( file.FindInLua( "gmodguard/*.lua" ) ) do

	local instance = string.sub( v, 1, 3 )

	if instance == "cl_" then

		if SERVER then 

			AddCSLuaFile( "gmodguard/" .. v ) 

		end

		if CLIENT then 

			MsgN( "[GModGuard] File Loading: " .. v )
			include( "gmodguard/" .. v )
			MsgN( "[GModGuard] File Loaded: " .. v )

		end

	elseif instance == "sh_" then

		if SERVER then

			AddCSLuaFile( "gmodguard/" .. v ) 

		end

		MsgN( "[GModGuard] File Loading: " .. v )
		include( "gmodguard/" .. v )
		MsgN( "[GModGuard] File Loaded: " .. v )

	else

		if SERVER then 

			MsgN( "[GModGuard] File Loading: " .. v )
			include( "gmodguard/" .. v )
			MsgN( "[GModGuard] File Loaded: " .. v )

		end

	end

end

if SERVER and gmodguard.config.admin_mod then

	MsgN( "[GModGuard] Loading Admin Mod Plugin: " .. gmodguard.config.admin_mod )

	local plugin = "gmodguard/plugins/sh_" .. gmodguard.config.admin_mod .. ".lua"
	AddCSLuaFile( plugin )
	include( plugin )

	MsgN( "[GModGuard] Admin Mod Plugin loaded: " .. gmodguard.config.admin_mod )

end

MsgN( "[GModGuard] Files Loaded." )