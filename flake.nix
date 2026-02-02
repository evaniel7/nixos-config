{
  description = "Minimal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  

  outputs = { self, nixpkgs ,...}@inputs: 
  let

      system = "x86_64-linux";
  pkgs = import nixpkgs { config.allowUnfree = true; inherit system;};
  in 
  {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      inherit pkgs system; 
      specialArgs = {
        inherit inputs system;
      }; 
      modules = [
        ./configuration.nix
      ];
    };
  };
}
