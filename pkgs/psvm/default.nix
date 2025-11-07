{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "psvm";
  version = "0-unstable-2025-11-06";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "psvm";
    rev = "bc993e92147199754d4860176bb692e4c5d6f15a";
    hash = "sha256-UqRUwlYNRAVkshTBgAH9i3VJQ58HUvy9uFzW5HDIhvU=";
  };

  cargoHash = "sha256-kwo3NLp9BPInWkAPIKTMrQsl9G1MT2bZxSF4x0alBVo=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/paritytech/psvm";
    description = "Polkadot SDK Version Manager";
    license = lib.licenses.asl20;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
