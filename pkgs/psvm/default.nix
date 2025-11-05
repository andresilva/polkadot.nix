{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "psvm";
  version = "0-unstable-2025-11-04";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "psvm";
    rev = "f0f7e5183b1765d3f0d67934b24c5ad1cd1bb173";
    hash = "sha256-TfgRZaLzRWH4ZWVGvCDbB1TW+dSgEaRwEGpTNF7Jysg=";
  };

  cargoHash = "sha256-fG9h//7YuRigbvNmI5+dxDvk//sz1peN9ppHcj9lMGc=";

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
