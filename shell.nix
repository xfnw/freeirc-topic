{ pkgs ? import <nixpkgs> { } }:

let
  freeirc-topic = pkgs.stdenv.mkDerivation
    {
      name = "freeirc-topic";

      src = builtins.path { path = ./.; name = "freeirc-topic"; };

      buildInputs = [ pkgs.zsh ];

      installPhase = ''
        mkdir -p $out/bin
        cp *.sh $out/bin
      '';
    }; in

pkgs.mkShell {
  nativeBuildInputs = with import ./vulppkgs { };
    [ freeirc-topic pkgs.zsh pkgs.catgirl scirc expdays ];
}

