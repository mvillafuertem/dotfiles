# https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/WindowManager.nix
# https://www.reddit.com/r/MacOS/comments/15drk66/manipulating_and_managing_windows_without/
{
  system.defaults = {
    NSGlobalDomain.NSWindowResizeTime = 0.065;
    WindowManager = {
      EnableTiledWindowMargins = false;
      EnableTilingByEdgeDrag = true;
      EnableTopTilingByEdgeDrag = true;
    };
  };
}
