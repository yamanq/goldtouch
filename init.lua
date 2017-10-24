goldtouch = {}
goldtouch.players = {}
minetest.register_privilege("midas", "turns blocks beneath you into gold")

minetest.register_chatcommand("goldtouch", {
	params = "<name>",
	privs = {midas=true},

	func = function (name, param)
		if not goldtouch.players[name] then
			goldtouch.players[name] = true
		else
			goldtouch.players[name] = not goldtouch.players[name]
		end

		minetest.register_globalstep(function(dtime)
			local player = minetest.get_player_by_name(param)
			local blockPos = player:getpos()
			blockPos.x = math.floor(blockPos.x)
			blockPos.y = math.floor(blockPos.y)
			blockPos.z = math.floor(blockPos.z)
			if minetest.get_node(blockPos) ~= "default:air" and minetest.get_node(blockPos) ~= "default:goldblock" then
				minetest.set_node(blockPos, {name="default:goldblock"})
			end
		end)

	end

})