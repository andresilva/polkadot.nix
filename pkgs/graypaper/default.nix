{ fetchFromGitHub
, runCommand
, texliveFull
}:

runCommand "graypaper"
{
  version = "unstable-2024-04-18";
  src = fetchFromGitHub {
    owner = "gavofyork";
    repo = "graypaper";
    rev = "3222bb39f3d6121c7fe86fa33a9620d43b558476";
    sha256 = "1vgygikw8bzkh0wkg743xbfaw361f8kammlf5zggn2w5wcgkzl6f";
  };
  nativeBuildInputs = [ texliveFull ];
} ''
  mkdir -p $out/share/doc/graypaper

  TMP=$(mktemp -d)
  cp -r $src/* $TMP
  cd $TMP

  xelatex graypaper.tex
  mv graypaper.pdf $out/share/doc/graypaper

  patch -p1 < ${./printer-friendly.patch}
  xelatex graypaper.tex
  mv graypaper.pdf $out/share/doc/graypaper/graypaper-printer-friendly.pdf
''
