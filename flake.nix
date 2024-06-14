{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    disko,
  } @ attrs: {
    formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;

    nixosConfigurations = builtins.listToAttrs (map (name: {
      inherit name;
      value = nixpkgs.lib.nixosSystem rec {
        pkgs = import nixpkgs {
          inherit system;
          config = {};
        };
        system = "aarch64-linux";
        modules = [./common disko.nixosModules.disko ./hosts/${name}];
      };
    }) (builtins.attrNames (builtins.readDir ./hosts)));
  };
}
