{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "psvm";
  version = "0-unstable-2025-12-10";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "psvm";
    rev = "025d82108d2f9e4758459ab91557d7e7c945be70";
    hash = "sha256-NrArS6GjxhI+didtloEQiKc6TIRbRMhPPpRVLxw+fHk=";
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
