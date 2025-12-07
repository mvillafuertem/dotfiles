# https://github.com/ConstantinCezarBegu/nix/blob/master/module/darwin/macos-keyboard-shortcuts-configuration.nix
# defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys
{
  system.defaults.CustomUserPreferences = {
    # NSGlobalDomain.NSUserKeyEquivalents = {
    #   "Fill" = "~^\\U000D";                  # Control + Option + Enter
    #   "Bottom &amp; Quarters" = "~^\\U2193"; # Control + Option + ↓
    #   "Left &amp; Right" = "~^\\U2190";      # Control + Option + ←
    #   "Right &amp; Left" = "~^\\U2192";      # Control + Option + →
    #   "Top &amp; Quarters" = "~^\\U2191";    # Control + Option + ↑
    #   "Bottom Left" = "~^i";
    #   "Bottom Right" = "~^o";
    #   "Top Left" = "~^u";
    #   "Top Right" = "~^p";
    #   "Center" = "~^c";
    #   "Centre" = "~^c";
    #   "Left of Screen" = "~^h";
    #   "Right of Screen" = "~^l";
    # };
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        "118" = {
          enabled = 1;
          value = {
            parameters = [ 65535 18 262144 ];
            type = "standard";
          };
        };
        "119" = {
          enabled = 1;
          value = {
            parameters = [ 65535 19 262144 ];
            type = "standard";
          };
        };
        "120" = {
          enabled = 1;
          value = {
            parameters = [ 65535 20 262144 ];
            type = "standard";
          };
        };
        "121" = {
          enabled = 1;
          value = {
            parameters = [ 65535 21 262144 ];
            type = "standard";
          };
        };
        "122" = {
          enabled = 1;
          value = {
            parameters = [ 65535 23 262144 ];
            type = "standard";
          };
        };
        "123" = {
          enabled = 1;
          value = {
            parameters = [ 65535 22 262144 ];
            type = "standard";
          };
        };
        "124" = {
          enabled = 1;
          value = {
            parameters = [ 65535 26 262144 ];
            type = "standard";
          };
        };
        "125" = {
          enabled = 1;
          value = {
            parameters = [ 65535 28 262144 ];
            type = "standard";
          };
        };
        "126" = {
          enabled = 1;
          value = {
            parameters = [ 65535 25 262144 ];
            type = "standard";
          };
        };
        "233" = {
          enabled = 1;
          value = {
            parameters = [ 109 46 1048576 ];
            type = "standard";
          };
        };
        "235" = {
          enabled = 1;
          value = {
            parameters = [ 65535 65535 0 ];
            type = "standard";
          };
        };
        "237" = {
          enabled = 1;
          value = {
            parameters = [ 65535 36 786432 ];
            type = "standard";
          };
        };
        "238" = {
          enabled = 1;
          value = {
            parameters = [ 99 8 786432 ];
            type = "standard";
          };
        };
        "239" = {
          enabled = 1;
          value = {
            parameters = [ 114 15 8650752 ];
            type = "standard";
          };
        };
        "244" = {
          enabled = 1;
          value = {
            parameters = [ 117 32 786432 ];
            type = "standard";
          };
        };
        "245" = {
          enabled = 1;
          value = {
            parameters = [ 112 35 786432 ];
            type = "standard";
          };
        };
        "246" = {
          enabled = 1;
          value = {
            parameters = [ 105 34 786432 ];
            type = "standard";
          };
        };
        "247" = {
          enabled = 1;
          value = {
            parameters = [ 111 31 786432 ];
            type = "standard";
          };
        };
        "248" = {
          enabled = 1;
          value = {
            parameters = [ 65535 123 9175040 ];
            type = "standard";
          };
        };
        "249" = {
          enabled = 1;
          value = {
            parameters = [ 65535 124 9175040 ];
            type = "standard";
          };
        };
        "250" = {
          enabled = 1;
          value = {
            parameters = [ 65535 126 9175040 ];
            type = "standard";
          };
        };
        "251" = {
          enabled = 1;
          value = {
            parameters = [ 65535 125 9175040 ];
            type = "standard";
          };
        };
        "256" = {
          enabled = 1;
          value = {
            parameters = [ 113 12 786432 ];
            type = "standard";
          };
        };
        "79" = {
          enabled = 0;
          value = {
            parameters = [ 65535 123 8650752 ];
            type = "standard";
          };
        };
        "81" = {
          enabled = 0;
          value = {
            parameters = [ 65535 124 8650752 ];
            type = "standard";
          };
        };
      };
    };

  };
}
