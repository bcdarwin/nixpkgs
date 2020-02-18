{ stdenv, fetchFromGitHub, cmake, zlib, netcdf, nifticlib, hdf5 }:

stdenv.mkDerivation rec {
  pname   = "libminc";
  version = "unstable-2019-10-09";

  owner = "BIC-MNI";

  src = fetchFromGitHub {
    inherit owner;
    repo   = pname;
    rev    = "5044544825b4b3ca98eb7f20b3b87fc569f9bb02";
    sha256 = "084l1k77qs3vqkvd2lk12927hvg8amcdmjr84yy1ky8f4vqa2kbj";
  };

  postPatch = ''
    patchShebangs .
  '';

  nativeBuildInputs = [ cmake ];
  buildInputs = [ zlib netcdf nifticlib hdf5 ];

  cmakeFlags = [
    "-DLIBMINC_MINC1_SUPPORT=ON"
    "-DLIBMINC_BUILD_SHARED_LIBS=ON"
    "-DLIBMINC_USE_SYSTEM_NIFTI=ON"
  ];

  doCheck = !stdenv.isDarwin;
  checkPhase = ''
    export LD_LIBRARY_PATH="$(pwd)"  # see #22060
    ctest -E 'ezminc_rw_test' --output-on-failure
    # ezminc_rw_test can't find libminc_io.so.5.2.0
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    homepage = "https://github.com/${owner}/${pname}";
    description = "Medical imaging library based on HDF5";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.unix;
    license   = licenses.free;
  };
}
