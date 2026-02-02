return {
  "mvillafuertem/dependencies.nvim",
  enabled = true,
  opts = {
    -- Incluir versiones pre-release (alpha, beta, milestone, RC, SNAPSHOT)
    -- false = solo versiones estables (default)
    -- true = incluir también pre-releases
    include_prerelease = true,

    -- Prefijo del virtual text que muestra la última versión
    -- Se mostrará al final de la línea cuando haya una versión más reciente
    virtual_text_prefix = "   " -- "󰀪  󰌶  󰆧      󱉟",
  },
}
