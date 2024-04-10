{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "zepter";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "ggwpez";
    repo = "zepter";
    rev = "v${version}";
    hash = "sha256-CT5ZDwPHRtmC9+xf28b4F4QHTE9Bb88Tjeq+pu6ACMo=";
  };

  cargoHash = "sha256-KuCryMr3Jhx5fNZp8doCu6c6dATntiBTe18dN6VqEiA=";

  meta = with lib; {
    description = "Analyze, Fix and Format features in your Rust workspace";
    homepage = "https://github.com/ggwpez/zepter";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
