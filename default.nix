{ stdenv, lib, fetchFromGitHub, nushell }:

stdenv.mkDerivation rec {
  pname = "novelist";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "kaizen4dev";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Lv8EZnQAYcG41BMT9/1gA3QUml/4z82zj29P+iWPkro=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp ${pname} $out/bin/
    cp -r modules/ $out/bin/
    chmod +x $out/bin/${pname}
  '';

  propagatedBuildInputs = [ nushell ];

  meta = with lib; {
    description = "Add, view, remove and edit your novels within local database.";
    homepage = "https://github.com/kaizen4dev/novelist";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
