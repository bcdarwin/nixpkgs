{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, hatchling
, hatch-nodejs-version
, hatch-jupyter-builder
, ipywidgets
, msgpack
, numpy
, jupyterlab
, traitlets
, traittypes
}:

buildPythonPackage rec {
  pname = "k3d";
  version = "2.16.1";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-1MYxTJD64TYoaZCdKMBKhugFs10yDseNRCVQkMVoxgk=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml --replace 'jupyterlab~=3.0' 'jupyterlab'
  '';

  nativeBuildInputs = [
    hatchling
    hatch-nodejs-version
    hatch-jupyter-builder
    jupyterlab
  ];

  propagatedBuildInputs = [
    ipywidgets
    msgpack
    numpy
    traitlets
    traittypes
  ];

  doCheck = false;  # no tests in PyPI dist
  pythonImportsCheck = [ "k3d" ];

  meta = with lib; {
    description = "Create 3D plots backed by WebGL with high-level API";
    homepage = "https://k3d-jupyter.org";
    changelog = "https://github.com/K3D-tools/K3D-jupyter/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
