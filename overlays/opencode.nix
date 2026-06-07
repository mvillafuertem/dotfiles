final: prev: {
  opencode = prev.opencode.overrideAttrs (oldAttrs: {
    version = "1.16.2";
    src = final.fetchFromGitHub {
      owner = "anomalyco";
      repo = "opencode";
      tag = "v1.16.2";
      hash = "sha256-IpTD4YCgGNtYlZ6EoyY+YLD81rIFR0D2A4W3uhWSSfo=";
    };
    node_modules = oldAttrs.node_modules.overrideAttrs (_: {
      outputHash = "sha256-4yjQlxN+U4CKwA/hE8gACuvA4bBeTrX0ACVBIK4UQCg=";
    });
  });
}
