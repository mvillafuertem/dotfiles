{ lib, stdenvNoCC, fetchurl, unzip }:

# WhichSpace: indicador del Space/escritorio activo en la barra de menus.
#
# Se empaqueta desde el release oficial (no desde el cask de Homebrew, que
# esta deprecado por no pasar Gatekeeper). El binario viene firmado ad-hoc,
# asi que se ejecuta en Apple Silicon sin re-firmar; y al instalarse via Nix
# no lleva el atributo com.apple.quarantine, por lo que abre sin el dialogo
# de Gatekeeper.
#
# Actualizacion: Sparkle NO puede autoactualizar desde el store de solo
# lectura, asi que el bump es manual. Sube `version` y recalcula `hash` con:
#   nix-prefetch-url --type sha256 \
#     https://github.com/gechr/WhichSpace/releases/download/vX.Y.Z/WhichSpace.zip
#   nix hash to-sri --type sha256 <salida>
# El modulo modules/darwin/whichspace.nix avisa en cada rebuild si hay una
# version mas nueva publicada en GitHub.

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "whichspace";
  version = "0.18.2";

  src = fetchurl {
    url = "https://github.com/gechr/WhichSpace/releases/download/v${finalAttrs.version}/WhichSpace.zip";
    hash = "sha256-tz98F0R2MkpXGboEBsb+4GpIICJrpIMfx0HYAoQOmZw=";
  };

  nativeBuildInputs = [ unzip ];

  # El zip extrae WhichSpace.app en la raiz; evitamos que stdenv haga cd al
  # propio bundle.
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications"
    cp -R WhichSpace.app "$out/Applications/WhichSpace.app"
    runHook postInstall
  '';

  meta = {
    description = "Menu bar indicator showing the currently active macOS Space";
    homepage = "https://github.com/gechr/WhichSpace";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    mainProgram = "WhichSpace";
  };
})
