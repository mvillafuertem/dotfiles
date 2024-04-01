{pkgs, ...}: {
  xdg.configFile."starship.toml" = {
    source = ./config/starship.toml;
    recursive = true;
  };
  programs.starship.enable = true;
  #programs.starship =
  #  let
  #    flavour = "mocha"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
  #  in
  #  {
  #    enable = true;
  #    settings = {
  #      palette = "catppuccin_${flavour}";
  #    } // builtins.fromTOML (builtins.readFile
  #      (pkgs.fetchFromGitHub
  #        {
  #          owner = "catppuccin";
  #          repo = "starship";
  #          rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f"; # Replace with the latest commit hash
  #          sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
  #        } + /palettes/${flavour}.toml));
  #  };
}
