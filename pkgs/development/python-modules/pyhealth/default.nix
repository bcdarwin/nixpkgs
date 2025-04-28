{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  editdistance,
  mne,
  networkx,
  numpy,
  pandarallel,
  pandas,
  polars,
  pydantic,
  rdkit,
  rouge-score,
  scikit-learn,
  torch,
  torchvision,
  tqdm,
  transformers,
  urllib3,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "pyhealth";
  version = "1.1.6-unstable-2025-06-07";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "sunlabuiuc";
    repo = "PyHealth";
    rev = "7a0a86c9d62b1347b95a00b7398c7e7146b2e37b";
    hash = "sha256-DX+oW7C5bMsiOG8Sras6O5+k5PN5MvLFoBY4fy9c+F4=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    editdistance
    mne
    networkx
    numpy
    pandarallel
    pandas
    polars
    pydantic
    rdkit
    rouge-score
    scikit-learn
    torch
    torchvision
    tqdm
    transformers
    urllib3
  ];

  pythonRelaxDeps = [
    "pandas"
    "urllib3"
  ];

  # Nixpkgs rdkit does not create a -dist-info directory site-packages:
  pythonRemoveDeps = [ "rdkit" ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  pytestFlagsArray = [
    "pyhealth"
    "tests"
  ];

  disabledTestPaths = [
    # try to download data:
    "pyhealth/unittests/test_datasets"
    "pyhealth/unittests/test_medcode.py"
    "pyhealth/unittests/test_mortality_prediction.py"
    # "TypeError: Event.__init__() got an unexpected keyword argument 'type'" - probably broken test:
    "pyhealth/unittests/test_data/test_data.py"
  ];

  # tries to write to $HOME
  #pythonImportsCheck = [
  #  "pyhealth"
  #];

  meta = {
    description = "Deep learning toolkit for healthcare applications";
    homepage = "https://pyhealth.readthedocs.io";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bcdarwin ];
  };
}
