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
  zstd,
}:

rustPlatform.buildRustPackage rec {
  inherit pname;

  version = "0.7.2";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "zombienet-sdk";
    rev = "v${version}";
    hash = "sha256-KSNMoDBHjxghzZxl2W1WYanE0qcCWUENQ+UonEon9jw=";
  };

  cargoHash = "sha256-RsTWMPo87BmUaUEBpXHQtvKK8p4tLu/UondGqCf3cpE=";

  buildAndTestSubdir = target;

  nativeBuildInputs = [
    pkg-config
    protobuf
  ];

  buildInputs = [
    openssl
    zstd
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
