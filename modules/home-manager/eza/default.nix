{ pkgs, ... }: {
  xdg.configFile."eza/theme.yml".source = "${
      pkgs.fetchFromGitHub {
        owner = "eza-community";
        repo = "eza-themes";
        rev = "main";
        sha256 = "d+bbjgI1JrOGenqZ2aIRK8itkTUV2L4L3vtEN9tEgf8=";
      }
    }/themes/catppuccin.yml";
}
