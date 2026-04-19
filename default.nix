{ stdenv, lib, fetchFromGitHub, nushell }:

stdenv.mkDerivation rec {
  pname = "novelist";
  version = "2.0.0";

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
    mkdir -p $out/{bin,share/${pname}}
    cp -r * $out/share/${pname}
    bin=$out/bin/${pname}
    cat > $bin <<EOF
      #!/bin/sh -e
      exec $out/share/${pname}/${pname} "\$@"
    EOF
    chmod +x $bin
  '';

  propagatedBuildInputs = [ nushell ];

  meta = with lib; {
    description = "Add, view, remove and edit your novels within local database.";
    homepage = "https://github.com/kaizen4dev/novelist";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
