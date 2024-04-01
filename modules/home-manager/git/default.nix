{pkgs, ...}: {
  home.packages = with pkgs; [
  ];
  xdg.configFile.git = {
    source = ./config;
    recursive = true;
  };
}
