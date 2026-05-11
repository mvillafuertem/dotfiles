{ pkgs, ... }: {
  # https://github.com/FelixKratz/SketchyBar
  # nix-darwin gestiona el launchd agent que lanza sketchybar al iniciar sesión.
  # La configuración (Lua) se carga desde ~/.config/sketchybar/sketchybarrc
  # (gestionada por home-manager en el host que importe este módulo).
  services.sketchybar = {
    enable = true;
    # `lua` wrapeado con el binding SbarLua (https://github.com/FelixKratz/SbarLua)
    # para que el shebang del sketchybarrc encuentre un intérprete con
    # `require("sketchybar")` ya resuelto.
    extraPackages = with pkgs; [
      (lua5_5.withPackages (_: [ sbarlua ]))
    ];
  };
}
