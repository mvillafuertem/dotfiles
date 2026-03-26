final: prev: {
  github-copilot-cli = prev.github-copilot-cli.overrideAttrs (oldAttrs: {
    version = "1.0.11";
    src = prev.fetchurl {
      url = "https://github.com/github/copilot-cli/releases/download/v1.0.11/copilot-darwin-arm64.tar.gz";
      # nix-prefetch-url --unpack "https://github.com/github/copilot-cli/releases/download/v1.0.11/copilot-darwin-arm64.tar.gz" --type sha256 2>&1 | tail -1 | xargs nix hash convert --hash-algo sha256 --to sri
      hash = "sha256-kb9gzkxeJvCe0qR98ioLKLTHmUtMB04rjxpPKOPLZy4=";
    };
  });
}

