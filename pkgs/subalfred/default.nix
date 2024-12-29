{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "subalfred";
  version = "0.9.3-unstable-2024-11-13";

  src = fetchFromGitHub {
    owner = "hack-ink";
    repo = "subalfred";
    # NOTE: current released version doesn't build with latest rust
    rev = "64c93c47834eb786356fb4b0784e8486a27ab050";
    hash = "sha256-N2mSkIN+2xMX/pbXNsn48fu58vE1fQUSQFsZ6mAANvo=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-9JfdcneN40on1i0quGP33Cf/fWlBkHsgBdB1U3PpeT4=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  doCheck = false;

  meta = with lib; {
    description = "An All-In-One Substrate Development Toolbox";
    homepage = "https://github.com/hack-ink/subalfred";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
