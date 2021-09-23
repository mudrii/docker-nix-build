{ pkgs ? import <nixpkgs> {}
}:

import ./redis-multi.nix {
  inherit pkgs;

  name =  "nix-redis-layered-minimal";

  redis = pkgs.redis.overrideAttrs (old: {
#  redis = pkgs.pkgsStatic.redis.overrideAttrs (old: {
    makeFlags = old.makeFlags ++ ["USE_SYSTEMD=no"];
    preBuild = ''
      set -x
      makeFlagsArray=(PREFIX="$out"
#                      CC="${pkgs.musl.dev}/bin/musl-gcc -static"
                      CC="${pkgs.musl.dev}/bin/musl-gcc"
                      CFLAGS="-I${pkgs.musl.dev}/include"
                      LDFLAGS="-L${pkgs.musl.dev}/lib")
      '';
      postInstall = "rm -f $out/bin/redis-{benchmark,check-*,cli}";
    });
}
