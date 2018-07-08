{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false, doCheck ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, bytestring, containers, deepseq
      , doctest, exceptions, hashable, lens, mtl, servant-client
      , servant-js, servant-matrix-param, servant-nix, servant-py
      , servant-server, spiros, stdenv, text, transformers
      , unordered-containers
      }:
      mkDerivation {
        pname = "dictation-server-windows";
        version = "0.0.0";
        src = ./.;
        libraryHaskellDepends = [
          base bytestring containers deepseq exceptions hashable lens mtl
          servant-client servant-js servant-matrix-param servant-nix
          servant-py servant-server spiros text transformers
          unordered-containers
        ];
        testHaskellDepends = [ base doctest ];
        homepage = "http://github.com/sboosali/dictation-server-windows#readme";
        description = "TODO";
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  bench = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;
  test  = if doCheck     then pkgs.haskell.lib.doCheck     else pkgs.lib.id;

  drv = bench (test (haskellPackages.callPackage f {}));

in

  if pkgs.lib.inNixShell then drv.env else drv
