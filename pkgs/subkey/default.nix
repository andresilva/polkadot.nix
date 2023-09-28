{ lib
, fetchFromGitHub
, protobuf
, rocksdb
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "subkey";
  version = "unstable-2023-09-28";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "polkadot-sdk";
    rev = "de71fecc4e58d99474ff655789801e5edf3764b1";
    sha256 = "0qj0n6lq6j0f0ihldfh7kxwd8r6789jr7w1dvja9gdfxx1ir8ff1";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "ark-secret-scalar-0.0.2" = "sha256-Tcrz2tT561ICAJzMgarSTOnaUEPeTFKZzE7rkdL3eUQ=";
      "common-0.1.0" = "sha256-dnZKDx3Rw5cd4ejcilo3Opsn/1XK9yWGxhceuwvBE0o=";
      "fflonk-0.1.0" = "sha256-MNvlePHQdY8DiOq6w7Hc1pgn7G58GDTeghCKHJdUy7E=";
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
