{ pkgs, ... }: {
  xdg.configFile."eza/theme.yml".source = "${
      pkgs.fetchFromGitHub {
        owner = "eza-community";
        repo = "eza-themes";
        rev = "main";
        sha256 = "2WTbCQlhwMo5cOn3KwtNiIst0tNfASfZnPNsNBs+gcU=";
      }
    }/themes/catppuccin.yml";
}
