{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "subalfred";
  version = "0.9.4";

  src = fetchFromGitHub {
    owner = "hack-ink";
    repo = "subalfred";
    rev = "v${version}";
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
