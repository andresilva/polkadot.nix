{
  pname,
  target,
  description,

  lib,
  fetchFromGitHub,
  rustPlatform,
  openssl,
  pkg-config,
  protobuf,
}:

rustPlatform.buildRustPackage rec {
  inherit pname;

  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "zombienet-sdk";
    rev = "v${version}";
    hash = "sha256-dt/BxXhGzHBpmrvS1I6qiFQRgbH9ufWgJsrdACm//eM=";
  };

  cargoHash = "sha256-9VIqAD+BKT1VqU30e9f3RBXPrDZDO8UW+xB1NgRNBao=";

  buildAndTestSubdir = target;

  nativeBuildInputs = [
    pkg-config
    protobuf
  ];

  buildInputs = [
    openssl
  ];

  PROTOC = "${protobuf}/bin/protoc";

  doCheck = false;

  meta = with lib; {
    inherit description;

    homepage = "https://github.com/paritytech/zombienet-sdk";
    license = with licenses; [
      asl20
      gpl3Only
    ];
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
