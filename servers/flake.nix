{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { nixpkgs, disko, ... }:
    {
      nixosConfigurations.barbarian = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          { disko.devices.disk.disk1.device = "/dev/sda"; }
          ./barbarian.configuration.nix
        ];
      };
      # nixosConfigurations.hetzner-cloud-aarch64 = nixpkgs.lib.nixosSystem {
      #   system = "aarch64-linux";
      #   modules = [
      #     disko.nixosModules.disko
      #     ./configuration.nix
      #   ];
      # };
    };
}