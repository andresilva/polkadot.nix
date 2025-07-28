{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "zepter";
  version = "1.82.0";

  src = fetchFromGitHub {
    owner = "ggwpez";
    repo = "zepter";
    rev = "v${version}";
    hash = "sha256-pykbXkehf3NuH/lDT+GlUFD78Q1/xD2sq7lrffWWotA=";
  };

  cargoHash = "sha256-T+p+ivZBoArJrAQ6bJeW7UiDv8dtlZpxkOXXS+uhBxA=";

  meta = with lib; {
    description = "Analyze, Fix and Format features in your Rust workspace";
    homepage = "https://github.com/ggwpez/zepter";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
