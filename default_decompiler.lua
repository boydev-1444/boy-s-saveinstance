--Short but complex unluau
local function random_var_name(index)
	return "v" .. index
end

local function encode_string(str)
	local encoded = {}
	for i = 1, #str do
		table.insert(encoded, "\\" .. str:byte(i))
	end
	return table.concat(encoded)
end

local function DecompileMain(lua_code)
	local var_count = 0
	local var_map = {}

	lua_code = lua_code:gsub("([%a_][%w_]*)", function(var)
		if not _G[var] and not var_map[var] then
			var_map[var] = random_var_name(var_count)
			var_count = var_count + 1
		end
		return var_map[var] or var
	end)

	lua_code = lua_code:gsub('"(.-)"', function(str)
		return '"' .. encode_string(str) .. '"'
	end)

	return lua_code
end

return DecompileMain
