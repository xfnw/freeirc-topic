{ pkgs ? import <nixpkgs> { } }:

let
  freeirc-topic = pkgs.stdenv.mkDerivation
    {
      name = "freeirc-topic";
      buildInputs = with import ./vulppkgs { };
        [ pkgs.zsh pkgs.catgirl scirc expdays ];

      src = builtins.path { path = ./.; name = "freeirc-topic"; };

      installPhase = ''
        mkdir -p $out/bin
        cp *.sh $out/bin
      '';
    }; in

pkgs.mkShell {
  nativeBuildInputs = [ freeirc-topic ];
}

