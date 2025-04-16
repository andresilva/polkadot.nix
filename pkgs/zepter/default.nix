{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "zepter";
  version = "1.78.1";

  src = fetchFromGitHub {
    owner = "ggwpez";
    repo = "zepter";
    rev = "v${version}";
    hash = "sha256-ILL1BSuvtUDp4pKU9v9bnmK4W1dw+T4tvjVXbKwG8ko=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-korW4yTeXRUjuXFUHAjlnuHj+pOQ25+2/ee9XYxpgTw=";

  meta = with lib; {
    description = "Analyze, Fix and Format features in your Rust workspace";
    homepage = "https://github.com/ggwpez/zepter";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
