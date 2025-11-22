{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "psvm";
  version = "0-unstable-2025-11-21";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "psvm";
    rev = "a41e760a3afd8aea00d00b084657db3ce02c3c5f";
    hash = "sha256-StjA9l7cbF981MMxPrXwUfwjGYB4ysltblk21E8abJE=";
  };

  cargoHash = "sha256-FK/ynjaWmBhlQ9tnfECDzUwZWhZR6gS9GKyyCRIJjnU=";

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
