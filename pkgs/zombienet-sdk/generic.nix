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

  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "zombienet-sdk";
    rev = "v${version}";
    hash = "sha256-GrX0ABNLkOy+YgSKUIo4Q/foMMhJQcMCc9pAQX3Q6/k=";
  };

  cargoHash = "sha256-P6cxc80QHe0fqG/qWMVBTplkFs6tIjphziPK175ppLY=";

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
