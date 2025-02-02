# https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/trackpad.nix
{
  system.defaults = {
    NSGlobalDomain = { 
      "com.apple.trackpad.scaling" = 2.75; 
    };
    trackpad = {
      Clicking = true;
      FirstClickThreshold = 2;
      TrackpadThreeFingerDrag = true;
    };
  };
}
