{ stdenv, fetchPypi, buildPythonPackage, isPy27
, numpy, scipy, matplotlib, nibabel, mayavi
, wrapQtAppsHook
}:

buildPythonPackage rec {
  pname = "pysurfer";
  version = "0.10.0";

  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    sha256 = "1wbhcj1f1khw89j8hsm32k3i7j3c7mijz48b2k4l3z66x6zynbq4";
  };

  nativeBuildInputs = [ wrapQtAppsHook ];

  propagatedBuildInputs = [ numpy scipy matplotlib mayavi nibabel ];

  preFixup = ''
    makeWrapperArgs+=("''${qtWrapperArgs[@]}")
  '';

  doCheck = false;  # TODO qt xcb stuffs

  meta = with stdenv.lib; {
    description = "Cortical neuroimaging visualization in Python";
    homepage = "https://pysurfer.github.com";
    maintainers = with stdenv.lib.maintainers; [ bcdarwin ];
    license = licenses.bsd3;
  };
}
