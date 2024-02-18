

rec {
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { nixpkgs, disko, ... }:
    {
      nixosConfigurations.barbarian = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          { system.build.diskoScript = {
            disko.devices = {
              disk = {
                sda = {
                  device = "/dev/sda";
                  type = "disk";
                  content = {
                    type = "gpt";
                    partitions = {
                      ESP = {
                        end = "500M";
                        type = "EF00";
                        content = {
                          type = "filesystem";
                          format = "vfat";
                          mountpoint = "/boot";
                        };
                      };
                      root = {
                        name = "root";
                        end = "-0";
                        content = {
                          type = "filesystem";
                          format = "btrfs";
                          mountpoint = "/";
                        };
                      };
                    };
                  };
                };
              };
            };
          }; }
          ./barbarian.configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
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