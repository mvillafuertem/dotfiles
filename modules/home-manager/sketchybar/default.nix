{ pkgs, ... }:
let
  # Config Lua + binarios helpers (cpu_load, network_load, menus) compilados.
  # Toda la estructura se enlaza bajo ~/.config/sketchybar/ vía xdg.configFile.
  sketchybarConfig = pkgs.stdenv.mkDerivation {
    pname = "sketchybar-config";
    version = "0";
    src = ./config;
    dontConfigure = true;
    nativeBuildInputs = [ pkgs.clang ];
    buildPhase = ''
      runHook preBuild

      mkdir -p helpers/event_providers/cpu_load/bin
      clang -std=c99 -O3 \
        helpers/event_providers/cpu_load/cpu_load.c \
        -o helpers/event_providers/cpu_load/bin/cpu_load

      mkdir -p helpers/event_providers/network_load/bin
      clang -std=c99 -O3 \
        helpers/event_providers/network_load/network_load.c \
        -o helpers/event_providers/network_load/bin/network_load

      mkdir -p helpers/menus/bin
      clang -std=c99 -O3 \
        -F/System/Library/PrivateFrameworks/ \
        -framework Carbon -framework SkyLight \
        helpers/menus/menus.c \
        -o helpers/menus/bin/menus

      runHook postBuild
    '';
    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -R . $out/
      runHook postInstall
    '';
  };
in {
  xdg.configFile.sketchybar = {
    source = sketchybarConfig;
    recursive = true;
  };

  # Fuente con los iconos de aplicación que usa SketchyBar.
  home.packages = with pkgs; [ sketchybar-app-font ];
}
