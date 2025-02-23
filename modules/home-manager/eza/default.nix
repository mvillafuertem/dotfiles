{ pkgs, ... }: {
  xdg.configFile."eza/theme.yml".source = "${
      pkgs.fetchFromGitHub {
        owner = "eza-community";
        repo = "eza-themes";
        rev = "main";
        sha256 = "vu6QLz0RvPavpD2VED25D2PJlHgQ8Yis+DnL+BPlvHw=";
      }
    }/themes/catppuccin.yml";
}
