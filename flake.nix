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
      };
    };
}
