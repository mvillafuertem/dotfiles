final: prev: {
  github-copilot-cli = prev.github-copilot-cli.overrideAttrs (oldAttrs: rec {
    version = "1.0.52";
    src = prev.fetchurl {
      url = "https://github.com/github/copilot-cli/releases/download/v${version}/github-copilot-${version}-darwin-arm64.tgz";
      # nix-prefetch-url "https://github.com/github/copilot-cli/releases/download/v1.0.52/github-copilot-1.0.52-darwin-arm64.tgz" --type sha256 2>&1 | tail -1 | xargs nix hash convert --hash-algo sha256 --to sri
      hash = "sha256-mb4xpb/95PBo7KhCMt9cFmXUx5/Co/lNsCnPxWlWCok=";
    };
  });
}
