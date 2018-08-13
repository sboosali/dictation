{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc861"  -- "default"
, doBenchmark ? false, doCheck ? false 
}:

let

  inherit (nixpkgs) pkgs;

  f = import ./.;

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  bench = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;
  test  = if doCheck     then pkgs.haskell.lib.doCheck     else pkgs.lib.id;

  drv = bench (test (haskellPackages.callPackage f {
   servant-server = haskellPackages.servant-server_0_14;
   servant-client = haskellPackages.servant-client_0_14;
  }));

in

  if pkgs.lib.inNixShell then drv.env else drv
