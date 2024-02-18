{
  outputs = inputs:
    let custom-nixpkgs-x86_64- = rec {
      unstable = import inputs.u-nixpkgs {system = "x86_64-linux"; config.allowUnfree = true;};
      stable = import inputs.s-nixpkgs {system = "x86_64-linux"; config.allowUnfree = true; };
    };
    in {
      colmena = {
        meta = {
          nixpkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [];
          };
        };
        beekeeper = inputs.s-nixpkgs.lib.nixosSystem {
          import ./servers/beekeeper.configuration.nix { };
        };
        barbarian = inputs.s-nixpkgs.lib.nixosSystem {
          import ./servers/barbarian.configuration.nix { };
        };
        fencer = inputs.s-nixpkgs.lib.nixosSystem {
          import ./servers/fencer.configuration.nix { };
        };
        thief = inputs.s-nixpkgs.lib.nixosSystem {
          import ./servers/thief.configuration.nix { };
        };
      };
    };

  inputs = {
    nix-software-center = {
      type = "github";
      owner = "vlinkz";
      repo = "nix-software-center";
    };
    nixos-conf-editor = {
      type = "github";
      owner = "vlinkz";
      repo = "nixos-conf-editor";
    };
    nix-alien = {
      type = "github";
      owner = "thiagokokada";
      repo = "nix-alien";
    };

    niri.url = "github:sodiboo/niri-flake";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "u-nixpkgs";
    
    u-nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    s-nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flatpaks.url = "github:GermanBread/declarative-flatpak/dev";
    lanzaboote.url = "github:nix-community/lanzaboote";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "s-nixpkgs";
    };
  };
}
