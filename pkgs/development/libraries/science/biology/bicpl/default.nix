{ stdenv, fetchFromGitHub, cmake, libminc, netpbm }:

stdenv.mkDerivation rec {
  pname = "bicpl";
  version = "unstable-2018-07-28";

  owner = "BIC-MNI";

  # current master is significantly ahead of most recent release, so use Git version:
  src = fetchFromGitHub {
    inherit owner;
    repo   = pname;
    rev    = "cbb66ea1de4efe582b37f807e136c1086509895a";
    sha256 = "008md83d4j10ykyd337ljcxhlk2nvg8gxrdahyksmcnv2bf0pgcs";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ libminc netpbm ];

  cmakeFlags = [ "-DLIBMINC_DIR=${libminc}/lib" "-DBICPL_BUILD_SHARED_LIBS=TRUE" ];

  doCheck = false;
  # internal_volume_io.h: No such file or directory

  meta = with stdenv.lib; {
    homepage = "https://github.com/${owner}/${pname}";
    description = "Brain Imaging Centre programming library";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.unix;
    license   = licenses.free;
  };
}
