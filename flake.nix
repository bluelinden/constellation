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
    barbarianSystem = import ./servers/barbarian.configuration.nix {
      pkgs = custom-nixpkgs.stable;
      upkgs = custom-nixpkgs.unstable;
    };
    in {
      colmena = {
        meta = {
          nixpkgs = custom-nixpkgs.stable;
        };
        barbarian = {
            deployment.targetHost = "192.168.1.244";
            deployment.targetUser = "blue";
        } // barbarianSystem;
      };
    };
}
