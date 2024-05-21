{ lib
, fetchFromGitHub
, openssl
, pkg-config
, protobuf
, rocksdb
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "subkey";
  version = "polkadot-v1.12.0";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "polkadot-sdk";
    rev = version;
    hash = "sha256-/m7Tg+9JHbnwKwWPY8gWIJkIHktGFlqcrbLLgNWjfwU=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "ark-secret-scalar-0.0.2" = "sha256-91sODxaj0psMw0WqigMCGO5a7+NenAsRj5ZmW6C7lvc=";
      "ckb-merkle-mountain-range-0.6.0" = "sha256-oTe1l406lTpgOefPai664JYwzezLjkIDXpiZTfjbd28=";
      "common-0.1.0" = "sha256-LHz2dK1p8GwyMimlR7AxHLz1tjTYolPwdjP7pxork1o=";
      "fflonk-0.1.0" = "sha256-+BvZ03AhYNP0D8Wq9EMsP+lSgPA6BBlnWkoxTffVLwo=";
      "litep2p-0.3.0" = "sha256-y0my2vi0+2CWNOtCh/vtsUbIcU1iNSFAJbLiCktEcOc=";
      "sp-ark-bls12-381-0.4.2" = "sha256-nNr0amKhSvvI9BlsoP+8v6Xppx/s7zkf0l9Lm3DW8w8=";
      "sp-crypto-ec-utils-0.4.1" = "sha256-/Sw1ZM/JcJBokFE4y2mv/P43ciTL5DEm0PDG0jZvMkI=";
    };
  };

  nativeBuildInputs = [ pkg-config rustPlatform.bindgenHook ];
  buildInputs = [ openssl ];

  buildAndTestSubdir = "substrate/bin/utils/subkey";

  doCheck = false;

  OPENSSL_NO_VENDOR = 1;
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
