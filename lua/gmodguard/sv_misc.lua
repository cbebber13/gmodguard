--[[ 

	GModGuard v.development
	A global, shared banning database for GMod.

	Authors: 
		Phoenixf129 - http://steamcommunity.com/id/Phoenixf129
		Bzaraticus - http://steamcommunity.com/id/Bzaraticus
		Drakehawke - http://steamcommunity.com/id/Drakehawke

	File: lua/gmodguard/sv_misc.lua
	- Miscellaneous serverside code.

]]--

function umsg.Color( col )

	umsg.Char( col.r - 128 )
	umsg.Char( col.g - 128 )	
	umsg.Char( col.b - 128 )

end

function gmodguard.SendChatNotify( target, ... )

	local RP
	if string.lower( type( target ) ) == "table" then

		RP = RecipientFilter()
		for _, p in pairs( target ) do 

			RP:AddPlayer( p )

		end

	else

		RP = target

	end

	umsg.Start( "GG_ChatNotify", RP )

		umsg.Short( #arg / 2 )

		for i = 1, #arg, 2 do

			umsg.Color( arg[ i ] )
			umsg.String( arg[ i + 1 ] )

		end

	umsg.End()

end




