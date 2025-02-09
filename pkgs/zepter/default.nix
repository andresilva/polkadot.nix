{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "zepter";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "ggwpez";
    repo = "zepter";
    rev = "v${version}";
    hash = "sha256-wUQq5yTs0aV8vVH/Vwu/ql2I9BL7vsxEf2TvT5RVIJ8=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-x3My/soXwyo9r66si8zO4rKQD658nljBZITiivEqrHc=";

  meta = with lib; {
    description = "Analyze, Fix and Format features in your Rust workspace";
    homepage = "https://github.com/ggwpez/zepter";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
