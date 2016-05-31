{ stdenv, fetchurl, cmake, libX11, libuuid, xz }:

stdenv.mkDerivation rec {
  name = "itk-4.9.1";

  src = fetchurl {
    url = mirror://sourceforge/itk/InsightToolkit-4.9.1.tar.xz;  # TODO fix
    sha256 = "1sghdw4m8y2lzn330l6ybc69fal8h5fmif937i6g4d9bl2qd9mip";
  };

  cmakeFlags = [
    "-DBUILD_TESTING=OFF"
    "-DBUILD_EXAMPLES=OFF"
    "-DBUILD_SHARED_LIBS=ON"
    "-DCMAKE_CXX_FLAGS=-fPIC"
  ];

  enableParallelBuilding = true;

  nativeBuildInputs = [ cmake xz ];
  buildInputs = [ libX11 libuuid ];

  meta = {
    description = "Insight Segmentation and Registration Toolkit";
    homepage = http://www.itk.org/;
    license = stdenv.lib.licenses.asl20;
    maintainers = with stdenv.lib.maintainers; [viric];
    platforms = with stdenv.lib.platforms; linux;
  };
}
