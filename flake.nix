{
  inputs = {
    u-nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    s-nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nix-minecraft-systemd.url = "github:frantisekhanzlikbl/nix-minecraft/systemd-socket";

  };

  outputs = inputs:
    let
      custom-nixpkgs = {
        unstable = import inputs.u-nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
        stable = import inputs.s-nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; overlays = [ inputs.nix-minecraft.overlay ]; };
      };
      barbarianSystem = import ./servers/barbarian.configuration.nix {
        pkgs = custom-nixpkgs.stable;
        upkgs = custom-nixpkgs.unstable;
        lib = custom-nixpkgs.stable.lib;
        inputs = inputs;
      };

      ninjaSystem = import ./servers/ninja.configuration.nix {
        pkgs = custom-nixpkgs.stable;
        upkgs = custom-nixpkgs.unstable;
        lib = custom-nixpkgs.stable.lib;
        hardware = inputs.nixos-hardware.nixosModules.raspberry-pi-4;
      };
      beekeeperSystem = import ./servers/beekeeper.configuration.nix {
        pkgs = custom-nixpkgs.stable;
        upkgs = custom-nixpkgs.unstable;
        lib = custom-nixpkgs.stable.lib;
      };
    in
    {
      colmena = {
        meta = {
          nixpkgs = custom-nixpkgs.stable;
        };
        barbarian = {
          deployment.targetHost = "100.69.42.7";
          deployment.targetUser = "blue";
          deployment.keys = {
            # ghost-keys = {
            #   keyCommand = ["cat /home/blue/Projects/code/constellation/secrets/ghost-keys.env"];
            # };
            # ghost-db = {
            #   keyCommand = ["cat /home/blue/Projects/code/constellation/secrets/ghost-db.env"];
            # };
            # mysql-pass = {
            #   keyCommand = ["cat /home/blue/Projects/code/constellation/secrets/mysql-pass.env"];
            # };
          };
        } // barbarianSystem;
        ninja = {
          deployment.targetHost = "100.69.42.8";
          deployment.targetUser = "blue";
          deployment.keys = { };
          deployment.buildOnTarget = true;
        } // ninjaSystem;
        beekeeper = {
          deployment.targetHost = "100.69.42.9";
          deployment.targetUser = "blue";
          deployment.keys = {
            # ghost-keys = {
            #   keyCommand = ["cat /home/blue/Projects/code/constellation/secrets/ghost-keys.env"];
            # };
            # ghost-db = {
            #   keyCommand = ["cat /home/blue/Projects/code/constellation/secrets/ghost-db.env"];
            # };
            # mysql-pass = {
            #   keyCommand = ["cat /home/blue/Projects/code/constellation/secrets/mysql-pass.env"];
            # };
          };
        } // beekeeperSystem;
      };
    };
}
