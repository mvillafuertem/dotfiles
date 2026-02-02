-- ~/.wezterm/remote_servers.lua
-- Lista de servidores remotos con usuario y host
local servers = {
	{ user = "maximus", host = "192.168.0.11" },
}
-- Tabla del módulo
local M = {}
-- Función que genera el launch_menu dinámicamente
function M.create_launch_menu()
	local menu = {}
	for _, s in ipairs(servers) do
		table.insert(menu, {
			label = s.host,
			args = { "ssh", "-t", s.user .. "@" .. s.host, "tmux new -A -s main" },
		})
	end
	return menu
end

return M
