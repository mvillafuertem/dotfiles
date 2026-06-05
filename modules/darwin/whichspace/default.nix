{ pkgs, lib, user, ... }:
let
  # Llamamos al paquete directamente con callPackage (no via overlay): el
  # flake pasa `pkgs` explicitamente a darwinSystem, asi que `nixpkgs.overlays`
  # en un modulo se ignoraria. Para un overlay global, la convencion del repo
  # es ./overlays/*.nix (auto-cargados por mkPkgs en flake.nix).
  whichspace = pkgs.callPackage ../../../pkgs/whichspace { };
in
{
  environment.systemPackages = [ whichspace ];

  # --- Ajustes escalares: declarativos y legibles -------------------------
  # Mismo patron que macos-keyboard-shortcuts (dominio de usuario via
  # CustomUserPreferences). Ver/editar a mano: defaults read io.gechr.WhichSpace
  system.defaults.CustomUserPreferences."io.gechr.WhichSpace" = {
    clickToSwitchSpaces = true; # clic en el numero -> cambia de espacio
    dimInactiveSpaces = true; # atenua los espacios inactivos
    showAllSpaces = false; # IMPORTANTE: true ensancha el item y lo esconde tras el notch
    showAllDisplays = false;
    sizeScale = 85; # tamaño del indicador
    paddingScale = 0; # espaciado lateral
    # Sparkle no puede autoactualizar desde el store de solo lectura de Nix;
    # silenciamos sus chequeos. El aviso de version nueva lo da el script de abajo.
    SUEnableAutomaticChecks = false;
  };

  system.activationScripts.postActivation.text = lib.mkAfter ''
    # --- Colores/fuentes/simbolos por espacio -------------------------------
    # Son blobs binarios de NSColor/NSFont archivados: Nix no tiene tipo "data",
    # asi que CustomUserPreferences no puede expresarlos -> los importamos de un
    # .plist (defaults import FUSIONA, no pisa los escalares de arriba).
    # La activacion corre como root, pero defaults debe escribir en el dominio
    # del USUARIO, de ahi el `sudo -u`.
    # Para actualizar este snapshot tras recolorear espacios en la app:
    #   defaults export io.gechr.WhichSpace - | \
    #     plutil -extract ... (dejar solo space*; ver git diff)
    /usr/bin/sudo -u ${user} /usr/bin/defaults import io.gechr.WhichSpace \
      ${./whichspace.plist} 2>/dev/null || true

    # --- Aviso de version nueva (no bloqueante) ----------------------------
    pinned="${whichspace.version}"
    latest=$(/usr/bin/curl -fsSL --max-time 5 \
      https://api.github.com/repos/gechr/WhichSpace/releases/latest 2>/dev/null \
      | /usr/bin/sed -n 's/.*"tag_name": *"v\{0,1\}\([^"]*\)".*/\1/p' | head -1) || true
    if [ -n "$latest" ] && [ "$latest" != "$pinned" ]; then
      printf '\033[1;33mwarning:\033[0m WhichSpace %s disponible (pineada %s) -> bump pkgs/whichspace/default.nix\n' "$latest" "$pinned"
    fi
  '';
}
