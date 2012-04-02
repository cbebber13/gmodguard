--[[ 

	GModGuard v.development
	A global, shared banning database for GMod.

	Authors: 
		Phoenixf129 - http://steamcommunity.com/id/Phoenixf129
		Bzaraticus - http://steamcommunity.com/id/Bzaraticus
		Drakehawke - http://steamcommunity.com/id/Drakehawke

	File: lua/gmodguard/sv_hooks.lua
	- Any GMod gamemode hooks that GModGuard uses.

]]--

function gmodguard.PlayerInitialSpawn( ply )

	if gmodguard.config.admin_mod then

		umsg.Start( "GG_AdminMod", ply )

			umsg.String( gmodguard.config.admin_mod )

		umsg.End()

	end

	gmodguard.SendChatNotify( ply, Color( 255, 255, 255 ), "Server protected by GModGuard: v.", Color( 255, 0, 0 ), "development" )

end
hook.Add( "PlayerInitialSpawn", "GG_PlayerInitialSpawn", gmodguard.PlayerInitialSpawn )