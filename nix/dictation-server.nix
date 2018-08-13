{ mkDerivation, aeson, async, base, bifunctors, bytestring
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
}
