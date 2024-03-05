{ lib
, fetchFromGitHub
, protobuf
, rocksdb
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "subkey";
  version = "unstable-2024-03-05";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "polkadot-sdk";
    rev = "c367ac2488db23a68e1cdf446cece58c66ea93d5";
    sha256 = "1s3545sidp4zrq558vf6g27izk5c78m6hi77pi6354pjkw222mi3";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "ark-secret-scalar-0.0.2" = "sha256-91sODxaj0psMw0WqigMCGO5a7+NenAsRj5ZmW6C7lvc=";
      "common-0.1.0" = "sha256-LHz2dK1p8GwyMimlR7AxHLz1tjTYolPwdjP7pxork1o=";
      "fflonk-0.1.0" = "sha256-+BvZ03AhYNP0D8Wq9EMsP+lSgPA6BBlnWkoxTffVLwo=";
      "sp-ark-bls12-381-0.4.2" = "sha256-nNr0amKhSvvI9BlsoP+8v6Xppx/s7zkf0l9Lm3DW8w8=";
      "sp-crypto-ec-utils-0.4.1" = "sha256-KXyG43YIzMG2r6kCTyQyCIHSAkXSlZv8pbFEXXvC4JU=";
      "sp-debug-derive-8.0.0" = "sha256-/Sw1ZM/JcJBokFE4y2mv/P43ciTL5DEm0PDG0jZvMkI=";
    };
  };

  nativeBuildInputs = [ rustPlatform.bindgenHook ];

  buildAndTestSubdir = "substrate/bin/utils/subkey";

  PROTOC = "${lib.makeBinPath [ protobuf ]}/protoc";
  ROCKSDB_LIB_DIR = lib.makeLibraryPath [ rocksdb ];

  meta = with lib; {
    description = "Utility for generating and using Substrate keys";
    homepage = "https://github.com/paritytech/polkadot-sdk/tree/master/substrate/bin/utils/subkey";
    license = licenses.gpl3ClasspathPlus;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.unix;
  };
}
