{ lib
, buildPythonPackage
, fetchPypi
, isPy27
, ipywidgets
, ipydatawidgets
, traittypes
, traitlets
, numpy
}:

buildPythonPackage rec {
  pname = "K3D";
  version = "2.8.0";

  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    sha256 = "0mhfl1n298ab1z8d04c7ra9k5ilxcai6p9gkn1vina8msxz373n6";
  };

  propagatedBuildInputs = [
    ipywidgets
    ipydatawidgets
    traittypes
    traitlets
    numpy
  ];

  meta = with lib; {
    description = "Create 3D plots backed by WebGL with high-level API";
    homepage = "https://k3d-jupyter.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
