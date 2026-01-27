{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  protobuf,
  rocksdb,
  rustc,
  rust-jemalloc-sys,
}:

rustPlatform.buildRustPackage rec {
  pname = "try-runtime-cli";
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "try-runtime-cli";
    rev = "v${version}";
    hash = "sha256-wKTbj46HGMzSQMBjOkqQRKUKUluVmMc+qdu6WKvn3WM=";
  };

  cargoPatches = [
    # deduplicates sp-crypto-hashing dependency and makes picosimd
    # compile on nix (https://github.com/koute/picosimd/pull/3)
    ./fix-cargo-toml.patch
  ];

  cargoHash = "sha256-MnOM9XXpIopn0IXprjZvInjhVKVlExkqQuCPBMPsVfo=";

  nativeBuildInputs = [
    rustPlatform.bindgenHook
    rustc
    rustc.llvmPackages.lld
  ];

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [ rust-jemalloc-sys ];

  doCheck = false;

  PROTOC = "${protobuf}/bin/protoc";
  ROCKSDB_LIB_DIR = "${rocksdb}/lib";

  meta = with lib; {
    description = "Substrate's programmatic testing framework";
    homepage = "https://github.com/paritytech/try-runtime-cli";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
