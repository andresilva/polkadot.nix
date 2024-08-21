{ fetchFromGitHub
, runCommand
, texliveFull
}:

let
  version = "0.3.5";
in
runCommand "graypaper" {
  inherit version;

  src = fetchFromGitHub {
    owner = "gavofyork";
    repo = "graypaper";
    rev = "v${version}";
    hash = "sha256-F97m7ka9D9iavJ5R2xWIH7LTH8P/brGc+kcY++BSpOs=";
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
