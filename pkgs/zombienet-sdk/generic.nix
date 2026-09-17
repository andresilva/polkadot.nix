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

  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "zombienet-sdk";
    rev = "v${version}";
    hash = "sha256-c8ZatriKOD2f0ZKIxFULk+1sVrMKfCnJZNO5N/ol8Yw=";
  };

  cargoHash = "sha256-yItG90XpAF2xSEnJ7+arycvYiN57BawdHStieH7bRQU=";

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
