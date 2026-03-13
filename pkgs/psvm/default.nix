{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "psvm";
  version = "0-unstable-2026-03-12";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "psvm";
    rev = "bb5817f0ecada8c6b67f9a86cae99fe01a14df86";
    hash = "sha256-JxKtTDWH2uofI0e/5107yPrS4SAjDe/mSV3LykGSLug=";
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
