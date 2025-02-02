# https://github.com/ConstantinCezarBegu/nix/blob/master/module/darwin/macos-keyboard-shortcuts-configuration.nix
# defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys
{
  system.defaults.CustomUserPreferences = {
    NSGlobalDomain.NSUserKeyEquivalents = {
      "Fill" = "~^\\U000D";   # Control + Option + Enter
      "Bottom" = "~^\\U2193"; # Control + Option + ↓
      "Left" = "~^\\U2190";   # Control + Option + ←
      "Right" = "~^\\U2192";  # Control + Option + →
      "Top" = "~^\\U2191";    # Control + Option + ↑
      "Bottom Left" = "~^i";
      "Bottom Right" = "~^o";
      "Top Left" = "~^u";
      "Top Right" = "~^p";
    };
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        "10" = {
          enabled = 1;
          value = {
            parameters = [ 65535 96 8650752 ];
            type = "standard";
          };
        };
        "11" = {
          enabled = 1;
          value = {
            parameters = [ 65535 97 8650752 ];
            type = "standard";
          };
        };
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
        "12" = {
          enabled = 1;
          value = {
            parameters = [ 65535 122 8650752 ];
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
        "13" = {
          enabled = 1;
          value = {
            parameters = [ 65535 98 8650752 ];
            type = "standard";
          };
        };
        "15" = { enabled = 0; };
        "16" = { enabled = 0; };
        "163" = {
          enabled = 1;
          value = {
            parameters = [ 65535 65535 0 ];
            type = "standard";
          };
        };
        "164" = {
          enabled = 0;
          value = {
            parameters = [ 65535 65535 0 ];
            type = "standard";
          };
        };
        "17" = { enabled = 0; };
        "175" = {
          enabled = 1;
          value = {
            parameters = [ 65535 65535 0 ];
            type = "standard";
          };
        };
        "18" = { enabled = 0; };
        "19" = { enabled = 0; };
        "190" = {
          enabled = 1;
          value = {
            parameters = [ 113 12 8388608 ];
            type = "standard";
          };
        };
        "20" = { enabled = 0; };
        "21" = {
          enabled = 0;
          value = {
            parameters = [ 56 28 1835008 ];
            type = "standard";
          };
        };
        "22" = { enabled = 0; };
        "222" = {
          enabled = 1;
          value = {
            parameters = [ 65535 65535 0 ];
            type = "standard";
          };
        };
        "23" = { enabled = 0; };
        "24" = { enabled = 0; };
        "25" = {
          enabled = 0;
          value = {
            parameters = [ 46 47 1835008 ];
            type = "standard";
          };
        };
        "26" = {
          enabled = 0;
          value = {
            parameters = [ 44 43 1835008 ];
            type = "standard";
          };
        };
        "27" = {
          enabled = 1;
          value = {
            parameters = [ 96 50 1048576 ];
            type = "standard";
          };
        };
        "32" = {
          enabled = 1;
          value = {
            parameters = [ 65535 126 8650752 ];
            type = "standard";
          };
        };
        "33" = {
          enabled = 1;
          value = {
            parameters = [ 65535 125 8650752 ];
            type = "standard";
          };
        };
        "34" = {
          enabled = 1;
          value = {
            parameters = [ 65535 126 8781824 ];
            type = "standard";
          };
        };
        "35" = {
          enabled = 1;
          value = {
            parameters = [ 65535 125 8781824 ];
            type = "standard";
          };
        };
        "36" = {
          enabled = 1;
          value = {
            parameters = [ 65535 103 8388608 ];
            type = "standard";
          };
        };
        "37" = {
          enabled = 1;
          value = {
            parameters = [ 65535 103 8519680 ];
            type = "standard";
          };
        };
        "57" = {
          enabled = 1;
          value = {
            parameters = [ 65535 100 8650752 ];
            type = "standard";
          };
        };
        "60" = {
          enabled = 1;
          value = {
            parameters = [ 32 49 262144 ];
            type = "standard";
          };
        };
        "61" = {
          enabled = 1;
          value = {
            parameters = [ 32 49 786432 ];
            type = "standard";
          };
        };
        "7" = {
          enabled = 1;
          value = {
            parameters = [ 65535 120 8650752 ];
            type = "standard";
          };
        };
        "79" = {
          enabled = 1;
          value = {
            parameters = [ 65535 123 8650752 ];
            type = "standard";
          };
        };
        "8" = {
          enabled = 1;
          value = {
            parameters = [ 65535 99 8650752 ];
            type = "standard";
          };
        };
        "80" = {
          enabled = 1;
          value = {
            parameters = [ 65535 123 8781824 ];
            type = "standard";
          };
        };
        "81" = {
          enabled = 1;
          value = {
            parameters = [ 65535 124 8650752 ];
            type = "standard";
          };
        };
        "82" = {
          enabled = 1;
          value = {
            parameters = [ 65535 124 8781824 ];
            type = "standard";
          };
        };
        "9" = {
          enabled = 1;
          value = {
            parameters = [ 65535 118 8650752 ];
            type = "standard";
          };
        };
        "98" = {
          enabled = 1;
          value = {
            parameters = [ 47 44 1179648 ];
            type = "standard";
          };
        };
      };
    };
  };
}
