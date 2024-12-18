{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  protobuf,
  rocksdb,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "subkey";
  version = "2412";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "polkadot-sdk";
    rev = "polkadot-stable${version}";
    hash = "sha256-Qg5WXRfaRSDi2707zpZgeJEH/qviEKlBDmm4FR9LN5k=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "ark-secret-scalar-0.0.2" = "sha256-yvgTxccxeUrnBhElI7AY3ad0PqmGCDlsoi8jH2Cceks=";
      "common-0.1.0" = "sha256-Jbl5b0zIDFBcu2lYi5LYRdABq3vxgPlE4EsFucTWQd8=";
      "fflonk-0.1.0" = "sha256-+BvZ03AhYNP0D8Wq9EMsP+lSgPA6BBlnWkoxTffVLwo=";
      "ipfs-hasher-0.21.3" = "sha256-AH3NMil07F+kkWjqAbMaMbjnTisSQiCd3tJz934ZICw=";
      "simple-mermaid-0.1.0" = "sha256-IekTldxYq+uoXwGvbpkVTXv2xrcZ0TQfyyE2i2zH+6w=";
      "sp-ark-bls12-381-0.4.2" = "sha256-nNr0amKhSvvI9BlsoP+8v6Xppx/s7zkf0l9Lm3DW8w8=";
      "sp-crypto-ec-utils-0.4.1" = "sha256-KXyG43YIzMG2r6kCTyQyCIHSAkXSlZv8pbFEXXvC4JU=";
      "sp-debug-derive-8.0.0" = "sha256-/Sw1ZM/JcJBokFE4y2mv/P43ciTL5DEm0PDG0jZvMkI=";
    };
  };

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

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
