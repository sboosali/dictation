{ mkDerivation, base, bytestring, containers, deepseq, doctest
, exceptions, hashable, lens, mtl, servant-client, servant-server
, spiros, stdenv, text, transformers, unordered-containers
}:
mkDerivation {
  pname = "dictation-server-windows";
  version = "0.0.0";
  src = ./.;
  libraryHaskellDepends = [
    base bytestring containers deepseq exceptions hashable lens mtl
    servant-client servant-server spiros text transformers
    unordered-containers
  ];
  testHaskellDepends = [ base doctest ];
  homepage = "http://github.com/sboosali/dictation-server-windows#readme";
  description = "TODO";
  license = stdenv.lib.licenses.bsd3;
}
