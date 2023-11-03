{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs : {
      homeConfigurations = {
        m-mvillafuerte = inputs.home-manager.lib.homeManagerConfiguration {
          modules = [ ./nixpkgs/home-manager/work.nix ];
        };
      };
    };
}
