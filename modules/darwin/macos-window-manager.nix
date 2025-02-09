# https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/dock.nix
{
  system.defaults.WindowManager = {
    EnableTiledWindowMargins = false;
    EnableTilingByEdgeDrag = true;
    EnableTopTilingByEdgeDrag = true;
  };
}
