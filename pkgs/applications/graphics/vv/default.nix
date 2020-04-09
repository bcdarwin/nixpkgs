{ stdenv
, fetchFromGitHub
, cmake
, itk
, qt514
, vtkWithQt5
, libGL
, libGLU
, libX11
, libXext }:

stdenv.mkDerivation rec {
  pname = "vv";
  version = "unstable-2020-05-12";

  src = fetchFromGitHub {
    owner = "open-vv";
    repo = pname;
    rev = "7a783a8b0d66246668d821430b03b4c7ffc26276";
    sha256 = "0g7krl099xcks16g9amgj2dy079hyd99m50yvyz7cfgcq3kjnczk";
  };

  nativeBuildInputs = [ cmake qt514.wrapQtAppsHook ];

  buildInputs = [
    itk
    vtkWithQt5
    libGL
    libGLU
    libX11
    libXext
  ] ++ (with qt514; [
    full
  ]);

  postPatch = ''
    substituteInPlace cmake/build_opt.cmake  \
      --replace 'set(vv_QT_VERSION "4"' 'set(vv_QT_VERSION "5"'
  '';

  meta = with stdenv.lib; {
    homepage = "https://www.creatis.insa-lyon.fr/rio/vv/";
    description = "ITK-based image viewer for 2D, 3D, and 4D images";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.linux;
    license   = licenses.bsd3;
  };
}
