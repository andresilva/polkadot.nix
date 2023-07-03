{ lib
, fetchFromGitHub
, protobuf
, rocksdb
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "subkey";
  version = "unstable-2023-07-03";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "substrate";
    rev = "ffbc02fecc5507b6a21415eeaffcdd80da5054da";
    sha256 = "1nw35vgjvm022iv4rrvhz30xqsy30llmvcpbbp7v820aqkrzwvm4";
  };

  cargoHash = "sha256-T6IomWetYLzcP8/IhblMLDHGb40wHxoVgGLzHpj7owo=";

  nativeBuildInputs = [ rustPlatform.bindgenHook ];

  buildAndTestSubdir = "bin/utils/subkey";

  PROTOC = "${lib.makeBinPath [ protobuf ]}/protoc";
  ROCKSDB_LIB_DIR = lib.makeLibraryPath [ rocksdb ];

  meta = with lib; {
    description = "Utility for generating and using Substrate keys";
    homepage = "https://github.com/paritytech/substrate/tree/master/bin/utils/subkey";
    license = licenses.gpl3ClasspathPlus;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
