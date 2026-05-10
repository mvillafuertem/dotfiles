# https://github.com/ConstantinCezarBegu/nix/blob/master/module/darwin/macos-keyboard-shortcuts-configuration.nix
# defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys
{ lib, ... }:
{
  # Forzar a macOS a recargar symbolichotkeys tras cada rebuild.
  # Sin esto los cambios se escriben al plist pero no surten efecto
  # hasta cerrar y abrir sesión.
  # mkAfter para componerlo con otros postActivation (ver darwin.nix).
  system.activationScripts.postActivation.text = lib.mkAfter ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u || true
  '';

  system.defaults.CustomUserPreferences = {
    # Atajos por nombre de menú (Ventana → Trasladar y redimensionar /
    # Window → Move & Resize). Sequoia/Tahoe exponen Window Tiling como
    # ítems de menú, así que la vía correcta es NSUserKeyEquivalents
    # (no symbolichotkeys). Como NSUserKeyEquivalents matchea por texto
    # exacto del menú, incluimos las claves en español Y en inglés para
    # que el mismo módulo funcione en ambos hosts (las que no matchean
    # se ignoran sin error).
    # Nombres oficiales:
    # https://support.apple.com/es-es/guide/mac-help/mchl9674d0b0/mac
    # https://support.apple.com/guide/mac-help/mchl9674d0b0/mac (en)
    # Sintaxis: @ = Cmd, ^ = Ctrl, ~ = Option, $ = Shift
    NSGlobalDomain.NSUserKeyEquivalents = {
      # --- Español ---
      # Esquinas (Ctrl+Opt+U/I/O/P)
      "Parte superior izquierda" = "~^u";
      "Parte superior derecha"   = "~^p";
      "Parte inferior izquierda" = "~^i";
      "Parte inferior derecha"   = "~^o";
      "Centro"             = "~^c";
      "Rellenar"           = "~^\r"; # Ctrl+Opt+Enter
      "Izquierda y derecha" = "~^←";
      "Derecha e izquierda" = "~^→";
      "Superior e inferior" = "~^↑";
      "Inferior y superior" = "~^↓";

      # --- English ---
      "Top Left"     = "~^u";
      "Top Right"    = "~^p";
      "Bottom Left"  = "~^i";
      "Bottom Right" = "~^o";
      "Center"       = "~^c";
      "Centre"       = "~^c"; # variante en-GB
      "Fill"         = "~^\r";
      "Left & Right" = "~^←";
      "Right & Left" = "~^→";
      "Top & Bottom" = "~^↑";
      "Bottom & Top" = "~^↓";
    };

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
          enabled = 0;
          value = {
            parameters = [ 117 32 786432 ];
            type = "standard";
          };
        };
        "245" = {
          enabled = 0;
          value = {
            parameters = [ 112 35 786432 ];
            type = "standard";
          };
        };
        "246" = {
          enabled = 0;
          value = {
            parameters = [ 105 34 786432 ];
            type = "standard";
          };
        };
        "247" = {
          enabled = 0;
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
          enabled = 1;
          value = {
            parameters = [ 65535 123 262144 ];
            type = "standard";
          };
        };
        "81" = {
          enabled = 1;
          value = {
            parameters = [ 65535 124 262144 ];
            type = "standard";
          };
        };
      };
    };

  };
}
