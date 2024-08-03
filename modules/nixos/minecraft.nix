{ flakeInputs, pkgs, ... }: {
  imports = [ flakeInputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ flakeInputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    user = "root";
    group = "minecraft";

    servers.stone-craft = {
      enable = true;
      # autoStart = true;
      openFirewall = true;
      restart = "no";
      # enableReload = true;
      package = pkgs.fabricServers.fabric;
      serverProperties = {
        server-port = 1402;
        difficulty = "hard";
        gamemode = "survival";
        max-players = 5;
        motd = "StoneCraft";
        view-distance = 32;
      };
      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" [
          (pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/P7dR8mSH/versions/gQS3JbZO/fabric-api-0.103.0%2B1.21.1.jar";
            sha512 =
              "085e985d3000afb0d0d799fdf83f7f084dd240e9852ccb4d94ad13fc3d3fad90b00b02dcc493e3c38a66ae4757389582eccf89238569bacae638b9ffd9885ebc";
          })

          (pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/gvQqBUqZ/versions/5szYtenV/lithium-fabric-mc1.21.1-0.13.0.jar";
            sha512 =
              "d4bd9a9cc37daad8828aa4fa9ca20e4f89d10e30cf6daf4546ef4cf4a684ba21ea0865a9c23cef9d1f4348e9ba4aca9aaca3db9f99534fc610fa78a5ca0bf151";
          })

          (pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/uXXizFIs/versions/wmIZ4wP4/ferritecore-7.0.0-fabric.jar";
            sha512 =
              "0f2f9b5aebd71ef3064fc94df964296ac6ee8ea12221098b9df037bdcaaca7bccd473c981795f4d57ff3d49da3ef81f13a42566880b9f11dc64645e9c8ad5d4f";
          })

          (pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/fQEb0iXm/versions/Acz3ttTp/krypton-0.2.8.jar";
            sha512 =
              "5f8cf96c79bfd4d893f1d70da582e62026bed36af49a7fa7b1e00fb6efb28d9ad6a1eec147020496b4fe38693d33fe6bfcd1eebbd93475612ee44290c2483784";
          })

          (pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/8oi3bsk5/versions/Mm6TmSwo/Terralith_1.21_v2.5.4.jar";
            sha512 =
              "d49f8a854a6ec8f49323986bbbffc061d62f2a85b91bc9ed442158c00551a66dcf8883b8151cfd732de8d6ba1006d0d94e6e456f15510eb32aacfd38da1095e1";
          })

          (pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/lWDHr9jE/versions/mSYrCaov/tectonic-fabric-1.21.1-2.4.1a.jar";
            sha512 =
              "a9dda4eb1912a724e1eff64ca70be9f165f9743e936dc703c42ebe2ecb4cfd1a66a68c22aafef08a95c832ce9eccf7cf8368c6e455756f9a50575520dd48191b";
          })

          (pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/KuNKN7d2/versions/nJBE6tif/noisium-neoforge-2.3.0%2Bmc1.21-1.21.1.jar";
            sha512 =
              "b50c37d2f69d51742d4407d272cea525b428784d2a39338d34b692937320495cd77d47b2d2321b3976713447028f50823e9ba44ca618900eba4ced907985ec84";
          })

          (pkgs.fetchurl {
            url =
              "https://edge.forgecdn.net/files/5442/991/Dynmap-3.7-beta-6-forge-1.21.jar";
            sha256 = "bsjjwRC5N27p7FYpXk4gcg6aO+mLwCARKrO9ZOTfKqs=";
          })
        ];
      };
    };
  };
}
