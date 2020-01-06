{ buildPythonPackage
, lib
, fetchPypi
, pytest
, pytestcov
, mock
, pytorch
, numpy
, scipy
, networkx
, scikitlearn
, scikitimage
, numba
, requests
, plyfile
, pandas
, rdflib
, h5py
# , googledrivedownloader
}:

buildPythonPackage rec {
  version = "1.3.2";
  pname   = "pytorch_geometric";

  format = "wheel";

  src = fetchPypi {
    inherit pname version;
    format = "wheel";
    sha256 = "11111abkmzfjg47ns0lw38mf85ry28nq1mas5rzlwvb4l5zmw2ms";
  };

  propagatedBuildInputs = [
    pytorch
    numpy
    scipy
    networkx
    scikitlearn
    scikitimage
    numba
    requests
    plyfile
    pandas
    rdflib
    h5py
    #googledrivedownloader
  ];
  checkInputs = [ pytest pytestcov mock ];

  meta = {
    description = "Geometric Deep Learning extension library for PyTorch";
    homepage    = https://pytorch.org/;
    license     = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ bdarwin ];
  };
}
