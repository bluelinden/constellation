{ pkgs, ... }:

{
  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers = {
      bluesea = {
        enable = true;
        package = pkgs.fabricServers.fabric_1_20_4;
        serverProperties = {
          network-compression-threshold = 256;
          simulation-distance = 8;
          view-distance = 12;
        };
        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods"
            # nix run github:Infinidoge/nix-minecraft#nix-modrinth-prefetch -- [version_id]
            (builtins.attrValues {
              fabricApi = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/tAwdMmKY/fabric-api-0.97.1%2B1.20.4.jar";
                sha512 = "161d5d8c67330cbda4ce825f92f23b96bfa884f881d5931c0375aba9ceef0f5e14b11c8607b5368fb6b72b796694a86a48271eecc3d9b63991f4b01352d66d5f";
              };
              resourcefulLib = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/G1hIVOrD/versions/TiIWVg2u/resourcefullib-fabric-1.20.4-2.4.10.jar";
                sha512 = "fed65173b10510b46728c34e9b8dd85c171a5505d42e2e7e1d90ab34f27475c85ba9b3fc291fb3049ed74340dd45f788b23816446d4f60066cbe55d7faa716ed";
              };
              argonauts = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/bb2EpKpx/versions/nP4rBNWT/argonauts-fabric-1.20.4-1.2.4.jar";
                sha512 = "53fba1d92cdee4d04fcbd0b7764c016a8fa29af449a308453c1b6635e1d9bb155f9266b53cf5034fcd4e9968ceddc8306cd994ea7ba834d73ec74637874b03b4";
              };
              cadmus = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/fEWKxVzh/versions/EiatAg7l/cadmus-fabric-1.20.4-1.2.2.jar";
                sha512 = "fa85f5ef36be71c89541a516fc0161054ed7160c8da94dd5c4b74158735d4f8d0866371b7c6e5662fccc968f1557abdbc8f4e55b09fb9448fb2681a47bbd2559";
              };
              prometheus = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/iYcNKH7W/versions/mRxmKKwW/prometheus-fabric-1.20.4-1.4.2.jar";
                sha512 = "126679195d64010f44745e1f123bc4d5f140d8270fc72cc3bae149185646f91624f36589a048142d2cf56a6fa0e2720987b340f9d73ea85cfb6ededac9c00c83";
              };
              lithium = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/nMhjKWVE/lithium-fabric-mc1.20.4-0.12.1.jar";
                sha512 = "70bea154eaafb2e4b5cb755cdb12c55d50f9296ab4c2855399da548f72d6d24c0a9f77e3da2b2ea5f47fa91d1258df4d08c6c6f24a25da887ed71cea93502508";
              };
              modernFix = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/nmDcB62a/versions/Kf6nINYI/modernfix-neoforge-5.17.0%2Bmc1.20.4.jar";
                sha512 = "e593815a77fd457eb693489a17a8fd0eab377d78c53454ae7250583092b62d887516a11c7c0ed51120019e0e141aaa4d1ab70e2ae8a136bf4f9cf9a82d258167";
              };
              ferriteCore = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/uXXizFIs/versions/pguEMpy9/ferritecore-6.0.3-fabric.jar";
                sha512 = "709ab6362dd1dcc432edd1e6c33aafba6f2d12be701bc14911107340f8ac2466779c4e57d8a303f0350c46478f23008e6eeca78e4eadedd0bdee63d4ae72ed9a";
              };
              superhot = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/Jwqd7M4F/versions/kvfc7GPD/superhot-1.0.1.jar";
                sha512 = "e49e161ca9dcb03ae98652f164abb94ba63e621573a9eebded38d5624687c7ba9c49b336bdaf4a98408882afa3d739f6859312fe1a9d31b9a771a882c59ee524";
              };
              leashablePlayers = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/BKyMf6XK/versions/d3hLk9n5/leashmod-1.0.6.jar";
                sha512 = "2b9ca8393eea78f0438fbd5d6e5b57c749351ecf6c5a154b8e0cc421e3dae848ee9992b4156edff45b0bc0534c73301d41ae33b10a5d6eaa042c931923c48afc";
              };
              dropsIntoShulker = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/Pk6THAjp/versions/J6x2nt3D/drops-into-shulker-1.2.3.jar";
                sha512 = "123965a4f008b39823e68d4834af1fd53b2f2006a908cde05fe48a96901c42f07da1cec0779abaae9064b727e9f5e6c5a7bc33e9f722159a08d35bf4b1f5bc63";
              };

            });
          "world/datapacks" = pkgs.linkFarmFromDrvs "datapacks"
            (builtins.attrValues {
              keepSomeInventory = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/VHSdL301/versions/PmdpULTr/KeepSomeInventory-v1.3.3.zip";
                sha512 = "8e68265bef62e63e08931c0fd68582ea0725093f752ff5247cbfae581ebb949586d5cd501dfe57d824feb0d3672f3437b478856aa0705b77e5f419639001ecde";
              };
              spawnAnimations = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/zrzYrlm0/versions/aGw3yWky/spawnanimations-v1.9.4-mc1.17x-1.20x-datapack.zip";
                sha512 = "f8d36ccc282434c8a7e09eb93a3ee77b2315224a2042b0174913e825ab0037cd1707c3644b12d11de903db64fb544987d06fad5bfd2da6a3df4f353cfccb2414";
              };
              treeCapitator = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/ok5ehON9/versions/QKqwcwJ4/TreeCapitator%20v3.0.zip";
                sha512 = "c21ed2c73194fbf1aa5847f800e314b3cc356d7f30e21fd621623c11c017fca433994faf6317ad151e98fafa69b168b7cff74b8fd33371713b4f12ae18abddef";
              };
            });

          "allowed_symlinks.txt" = pkgs.writeText "allowed_symlinks.txt" "/nix/store";

        };
      };
    };
  };
};
}
