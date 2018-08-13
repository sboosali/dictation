{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, aeson, async, base, bifunctors, bytestring
      , containers, deepseq, exceptions, hashable, lens, mtl, parallel
      , prettyprinter, profunctors, reducers, servant, servant-foreign
      , servant-server, spiros, stdenv, text, transformers
      , unordered-containers, wl-pprint-text
      }:
      mkDerivation {
        pname = "dictation-server";
        version = "0.0.0";
        src = ./dictation-server;
        libraryHaskellDepends = [
          aeson async base bifunctors bytestring containers deepseq
          exceptions hashable lens mtl parallel prettyprinter profunctors
          reducers servant servant-foreign servant-server spiros text
          transformers unordered-containers wl-pprint-text
        ];
        homepage = "http://github.com/sboosali/dictation#readme";
        description = "Dragon NaturallySpeaking on Linux";
        license = stdenv.lib.licenses.gpl3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
