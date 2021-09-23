{ pkgs ? import <nixpkgs>{}
}:

let
  inherit (pkgs.dockerTools) buildImage;

in buildImage {
  name = "nix-redis";
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
}
