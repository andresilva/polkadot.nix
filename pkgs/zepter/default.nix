{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "zepter";
  version = "1.78.2";

  src = fetchFromGitHub {
    owner = "ggwpez";
    repo = "zepter";
    rev = "v${version}";
    hash = "sha256-rtDJAZprSxOQOW39/BuDDN9duLpUQ79qqMA2pd5y7/A=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-5cdnu/gF4L8uGMmjObKAQ2aJVLGBlJL9HuHsHwlZWQg=";

  meta = with lib; {
    description = "Analyze, Fix and Format features in your Rust workspace";
    homepage = "https://github.com/ggwpez/zepter";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
