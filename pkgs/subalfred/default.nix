{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "subalfred";
  version = "0.9.3";

  src = fetchFromGitHub {
    owner = "hack-ink";
    repo = "subalfred";
    rev = "v${version}";
    hash = "sha256-YQiSZcyKzn+43+vgNdg6fkKFpwlG1qso1lsoTq2X58w=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "subcryptor-0.10.2" = "sha256-lX+EXUsEha1wT9OeQezxnB6DdTWBNViLZYSddONCktg=";
    };
  };

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
