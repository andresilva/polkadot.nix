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

  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "zombienet-sdk";
    rev = "v${version}";
    hash = "sha256-ZP8AF7uTfEfCF0VTyziRMB9wY2DMpUYu5pVSODE9Fv8=";
  };

  cargoHash = "sha256-l8A3iqZA8axEDlLR5y6lQE+TuPA4s3mL+pivmDikugA=";

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
