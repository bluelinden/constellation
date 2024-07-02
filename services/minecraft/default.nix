{ pkgs, ... }:

{
  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers = {
      bluesea = {
        enable = true;
        openFirewall = true;
        package = pkgs.fabricServers.fabric-1_20_4;
        serverProperties = {
          network-compression-threshold = 256;
          simulation-distance = 4;
          view-distance = 12;
          enable-command-block = true;
          enforce-whitelist = true;
          motd = "the most non-oceanic sea server since 2024";
          snooper-enabled = false;
          white-list = true;
        };
        managementSystem = {
          tmux.enable = false;
          systemd-socket.enable = true;
        };
        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods"
            # nix run github:Infinidoge/nix-minecraft#nix-modrinth-prefetch -- [version_id]
            (builtins.attrValues {
              fabricApi = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/tAwdMmKY/fabric-api-0.97.1%2B1.20.4.jar";
                sha512 = "161d5d8c67330cbda4ce825f92f23b96bfa884f881d5931c0375aba9ceef0f5e14b11c8607b5368fb6b72b796694a86a48271eecc3d9b63991f4b01352d66d5f";
              };
              collective = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/e0M1UDsY/versions/qXM06FG6/collective-1.20.4-7.64.jar";
                sha512 = "5a3fe043db65c000d1f51372e3b40c6da09a60df45fd364d61d3ade7e3bddd708ab7958c36c2bccedc5d7cafc33ca81e99a8bf5ede7fa0a4103bf060d7f3c2df";
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
              fabricLanguageKotlin = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/Ha28R6CL/versions/afsFajDC/fabric-language-kotlin-1.11.0%2Bkotlin.2.0.0.jar";
                sha512 = "afc292e199869b982f18bbad208fed4a1d95b2f4292e0cc422ee8116d1da1d91132f554ac0608e7c87959d7ede37c20293133c811986dcfc80a8648f29d13028";
              };
              silk = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/aTaCgKLW/versions/qm0TSoQL/silk-all-1.10.3.jar";
                sha512 = "1763256c95c6a90e59737dc326349c281ec911078ea247a7f7be25e07c244b041ce2382beb643601efa967529be3412a5e5cf88ef19a130cdc1d67cd558c93d1";
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
              chunky = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/fALzjamp/versions/NHWYq9at/Chunky-1.3.146.jar";
                sha512 = "9dbb82993302a8dfbe6ce1f46a051d72b5ada924424f4e23674ce660d209257584159a33248fa9247793e9ba03d3a117299ce1ff6685f06a7fb87c96504459aa";
              };
              doubleDoors = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/JrvR9OHr/versions/xY8NOS7J/doubledoors-1.20.4-5.8.jar";
                sha512 = "16bd6079b0175bbc4cc378342269b31d792d2f2a5803f3c05fce61931e674d9bdf0e471ea4d221d2d61e467c1072bb138912ddf1cbd8d87953956d0fd4e29d8c";
              };
              vanish = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/UL4bJFDY/versions/H4yFnOYs/vanish-1.5.4%2B1.20.4.jar";
                sha512 = "b747d6d8d80e3b3a63248e9e463e6308a025891a08d5a7ca1b10416790b7d03c887c919502943ddea871cf97a0d1bb83334a396cb6e90ac45225a92d1ecbaa5a";
              };
              xaerosMinimap = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/1bokaNcj/versions/ebLQ6HBv/Xaeros_Minimap_24.2.0_Fabric_1.20.4.jar";
                sha512 = "aa91213b1d72b381d0135acf21e6f02584a92ea550206bd825bc4ddc79a75378dfa8fbc990479d80e02d1d0fd9f899a3ff93d46e77d252448686456dc62be6a7";
              };
              xaerosWorldMap = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/NcUtCpym/versions/jEhoJmNF/XaerosWorldMap_1.38.8_Fabric_1.20.4.jar";
                sha512 = "6ba1369435e9fa2f463eff8e70cb5d389c81971c4fa90bc2404cdf875e95cae6293171985732693222d7c2efdc37d0bc247f0537be1b8cfde5a6c8e90a962209";
              };
              geyser = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/wKkoqHrH/versions/WZydmEJv/geyser-fabric-2.2.3-SNAPSHOT%2Bbuild.582.jar";
                sha512 = "573fad0d2c4bd42303ec05104c9d9acf2886e0f196c0346ef1f81481f4822b9fde073af0683af125b0b84824c6eb9399fae5e10e0bf3f0e30b75c4f8cadd01a7";
              };
              floodgate = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/zUrRGwbT/floodgate-fabric-2.2.0-SNAPSHOT%2Bbuild.18.jar";
                sha512 = "8916113c6256f1cafa21fa637717f1457d63d191ba56377aed4caa71afd3a49925809a4546e25bcc24f7167085668779e52d75606d8212ec45d82a98f5b65fa1";
              };
              unloadedActivity = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/Oo4rJCDP/versions/Cb6q6J0E/unloadedactivity-v0.5.4%2B1.20.3-1.20.4.jar";
                sha512 = "718e7971d519b96194141920aa0bdf64a7a30c271c08e9a170475f7a445df6e3ce0f15911da855bacb1c540ea5d670c0e1fc08266cad6e184dfc4eb5bbab3f4b";
              };
              veinMiner = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/OhduvhIc/versions/KTrObKTw/Veinminer-2.0.4.jar";
                sha512 = "6e924204246c53ec49f5f1d1a9fdaff7f64d18cbe53cf9cb44f0fb94c99bdcbbcf55bfa6433072895faf4d0800be8236cc5e61bd0dc6ac4a868e06928dee1cc7";
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
}
