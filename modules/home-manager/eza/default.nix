{ pkgs, ... }: {
  xdg.configFile."eza/theme.yml".source = "${
      pkgs.fetchFromGitHub {
        owner = "eza-community";
        repo = "eza-themes";
        rev = "main";
        sha256 = "toqj3bv2kCC2FHbGfeFpS3g9DoxQeZ7cwPYVpD8cfgg=";
      }
    }/themes/catppuccin.yml";
}
