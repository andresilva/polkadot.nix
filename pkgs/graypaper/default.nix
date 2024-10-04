{ fetchFromGitHub
, runCommand
, texliveFull
}:

let
  version = "0.3.8";
in
runCommand "graypaper" {
  inherit version;

  src = fetchFromGitHub {
    owner = "gavofyork";
    repo = "graypaper";
    rev = "v${version}";
    hash = "sha256-68Xirm8RtnoL021JYUVi5X99Ah89s1x44xXN49VMOK8=";
  };
  nativeBuildInputs = [ texliveFull ];
} ''
  mkdir -p $out/share/doc/graypaper

  TMP=$(mktemp -d)
  cp -r $src/* $TMP
  cd $TMP

  xelatex -halt-on-error graypaper.tex
  mv graypaper.pdf $out/share/doc/graypaper/graypaper-${version}.pdf

  patch -p1 < ${./printer-friendly.patch}
  xelatex -halt-on-error graypaper.tex
  mv graypaper.pdf $out/share/doc/graypaper/graypaper-${version}-printer-friendly.pdf
''
