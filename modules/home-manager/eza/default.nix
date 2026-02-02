{ pkgs, ... }: {
  xdg.configFile."eza/theme.yml".source = "${
      pkgs.fetchFromGitHub {
        owner = "eza-community";
        repo = "eza-themes";
        rev = "main";
        sha256 = "WcwzKm2mi/tyA+zZCpyvTdrOrZ1R1ENA3t622SGzFas=";
      }
    }/themes/catppuccin.yml";
}
