{ pkgs ? import <nixpkgs>{}
, name ? "nix-redis-layered"
, redis ? pkgs.redis
#, redis ? pkgs.pkgsStatic.redis
}:

let
  inherit (pkgs.dockerTools) buildLayeredImage;

in buildLayeredImage {
  inherit name;
  tag = "latest";

  contents = with pkgs; [
    redis
  ];

  config = {
    Cmd = [ "/bin/redis-server" ];
    WorkingDir = "/data";
    Volumes = {
      "/data" = {};
    };
  };
  created = "now";
  maxLayers = 100;

}
