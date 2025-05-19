{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "subalfred";
  version = "0.9.4-unstable-2025-05-19";

  src = fetchFromGitHub {
    owner = "hack-ink";
    repo = "subalfred";
    # NOTE: current released version doesn't build with latest rust
    rev = "7e94bbb3616b0d356c735373a239d823e7534cce";
    hash = "sha256-R+5j4KLizbX2daCbSQWVlWDe2UK1UUXGru1WPlGKzYo=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-/jKveC2iO1/r2euBG3dSTr0vhU8g781wHRxpM9TTZWo=";

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
