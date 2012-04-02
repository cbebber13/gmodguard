--[[ 

	GModGuard v.development
	A global, shared banning database for GMod.

	Authors: 
		Phoenixf129 - http://steamcommunity.com/id/Phoenixf129
		Bzaraticus - http://steamcommunity.com/id/Bzaraticus
		Drakehawke - http://steamcommunity.com/id/Drakehawke

	File: lua/gmodguard/cl_misc.lua
	- Miscellaneous clientside code.

]]--

function _R.bf_read:ReadColor()

	return Color( self:ReadChar() + 128, self:ReadChar() + 128, self:ReadChar() + 128 )
end

function gmodguard.RecieveChatNotify( um )

	local tab = {}

	table.insert( tab, Color( 255, 0, 0 ) )
	table.insert( tab, "[GModGuard] " )

	local num = um:ReadShort()
	for i = 1, num, 1 do

		table.insert( tab, um:ReadColor() )
		table.insert( tab, um:ReadString() )

	end

	chat.AddText( unpack( tab ) )

end
usermessage.Hook( "GG_ChatNotify", gmodguard.RecieveChatNotify )

function gmodguard.RecieveAdminMod( um )

	local plugin = um:ReadString()

	MsgN( "[GModGuard] Loading Admin Mod Plugin: " .. plugin )

	include( "gmodguard/plugins/sh_" .. plugin .. ".lua" )

	MsgN( "[GModGuard] Admin Mod Plugin loaded: " ..  plugin )

end
usermessage.Hook( "GG_AdminMod", gmodguard.RecieveAdminMod )
