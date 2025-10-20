{ stdenv, lib, fetchFromGitHub, nushell }:

stdenv.mkDerivation rec {
  pname = "novelist";
  version = "1.1.4";

  src = ./.;

  # or fetch form github
  # src = fetchFromGitHub {
  #   owner = "kaizen4dev";
  #   repo = pname;
  #   rev = "v${version}";
  #   sha256 = ""; # you'll need to find out this yourself.
  # };

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
