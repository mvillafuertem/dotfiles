{ ... }:
{
  homebrew = {
    enable = true;
    enableBashIntegration = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
      extraFlags = [ "--verbose" ];
    };
    global.autoUpdate = true;

    # Evita que brew necesite sudo para tocar /Applications.
    # Las apps se instalan en ~/Applications del usuario que ejecuta brew.
    # Descomenta solo en hosts donde el usuario no tenga sudo amplio (p. ej.
    # equipos corporativos con sudoers restringido). En el resto de Macs es
    # preferible mantener /Applications para compartir apps entre usuarios.
    # caskArgs = {
    #   appdir = "~/Applications";
    #   no_quarantine = true;
    # };

    # Paquetes comunes a TODOS los hosts darwin.
    # Para paquetes específicos por host, ver: modules/darwin/hosts/<hostname>.nix
    brews = [
      "tree-sitter"
      "tree-sitter-cli"
    ];
    casks = [
      { name = "wezterm"; greedy = true; }
      { name = "google-chrome"; greedy = true; }
    ];
  };
}
