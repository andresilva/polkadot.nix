{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "psvm";
  version = "0-unstable-2024-09-06";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "psvm";
    rev = "febe87df7e01ffb842853e1777b6519b933d0565";
    hash = "sha256-QKIr+2fqaysj+7EL/OBWhLCeD8HxgzpKaRAXfczEtM4=";
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
