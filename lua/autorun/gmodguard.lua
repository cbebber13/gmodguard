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
gmodguard.APIKEY = file.Read( "addons/GModGuard/apikey.txt" )
if gmodguard.APIKEY == "" then gmodguard.APIKEY = nil end

MsgN( "[GModGuard - Development]" )
MsgN( "[GModGuard] Loading files..." )

if SERVER then

	AddCSLuaFile( "gmodguard.lua" )

end

for _, v in pairs( file.FindInLua( "gmodguard/*.lua" ) ) do

	local instance = string.sub( v, 1, 3 )

	if instance == "cl_" then

		if SERVER then 

			AddCSLuaFile( "../gmodguard/" .. v ) 

		end

		if CLIENT then 

			MsgN( "[GModGuard] File Loading: " .. v )
			include( "../gmodguard/" .. v )
			MsgN( "[GModGuard] File Loaded: " .. v )

		end

	elseif instance == "sh_" then

		if SERVER then

			AddCSLuaFile( "../gmodguard/" .. v ) 

		end

		MsgN( "[GModGuard] File Loading: " .. v )
		include( "../gmodguard/" .. v )
		MsgN( "[GModGuard] File Loaded: " .. v )

	else

		if SERVER then 

			MsgN( "[GModGuard] File Loading: " .. v )
			include( "../gmodguard/" .. v )
			MsgN( "[GModGuard] File Loaded: " .. v )

		end

	end

end

MsgN( "[GModGuard] Files Loaded." )