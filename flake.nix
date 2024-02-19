{
  inputs = {
    u-nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    s-nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = inputs:
    let custom-nixpkgs = {
      unstable = import inputs.u-nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
      stable = import inputs.s-nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    };
    in {
      colmena = {
        meta = {
          nixpkgs = custom-nixpkgs.stable;
        };
        barbarian = { 
            inputs, 
            outputs, 
            lib, 
            config, 
            pkgs, 
            name, 
            nodes, 
            ... 
          }: {
            deployment.targetHost = "192.168.1.169";
            deployment.targetUser = "blue";
            imports = [
              ./servers/hw/barbarian.hardware.nix
            ];
            nixpkgs = {
              config = {
                allowUnfree = true;
              };
            };
            nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
            nix.nixPath = ["/etc/nix/path"];
            environment.etc =
              lib.mapAttrs'
              (name: value: {
                name = "nix/path/${name}";
                value.source = value.flake;
              })
              config.nix.registry;
            nix.settings = {
              experimental-features = "nix-command flakes";
              auto-optimise-store = true;
            };
            networking.hostName = "your-hostname";
            boot.loader.systemd-boot.enable = true;
            users.users = {
              blue = {
                initialPassword = "correcthorsebatterystaple";
                isNormalUser = true;
                openssh.authorizedKeys.keys = [
                  # Add your SSH public key(s) here
                ];
                extraGroups = ["wheel"];
              };
            };
            services.openssh = {
              enable = true;
              settings = {
                PermitRootLogin = "no";
                PasswordAuthentication = false;
              };
            };
            system.stateVersion = "23.11";
          };
      };
    };
}
