local wezterm = require 'wezterm'
local M = {}
function M.create_local_tab(cmd)
 local mux = wezterm.mux
 -- Crear una ventana nueva y ejecutar tmux directamente en el primer pane
 mux.spawn_window{
   workspace = "default",
   spawn = {
     args = { "/etc/profiles/per-user/miguel villafuerte/bin/bash", "-l", "-c", "tmux new-session -A -s local" }
   },
 }
 -- Nota: no necesitamos active_tab ni active_pane
 return nil
end
return M
