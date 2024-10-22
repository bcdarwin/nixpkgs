{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  acvl-utils,
  batchgenerators,
  dicom2nifti,
  dynamic-network-architectures,
  graphviz,
  matplotlib,
  nibabel,
  numpy,
  pandas,
  requests,
  scikit-image,
  scikit-learn,
  scipy,
  seaborn,
  simpleitk,
  tifffile,
  torch,
  tqdm,
  yacs,
}:

buildPythonPackage rec {
  pname = "nnunetv2";
  version = "2.4.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "MIC-DKFZ";
    repo = "nnUNet";
    tag = "v${version}";
    hash = "sha256-/lRRyp318DXBzXNnbhajyLM6xuI5o2qWBzvS5eA9z/E=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail '"imagecodecs",' ""
  '';

  build-system = [
    setuptools
  ];

  dependencies = [
    acvl-utils
    batchgenerators
    dicom2nifti
    dynamic-network-architectures
    graphviz
    matplotlib
    nibabel
    numpy
    pandas
    requests
    scikit-image
    scikit-learn
    scipy
    seaborn
    simpleitk
    tifffile
    torch
    tqdm
    yacs
  ];

  pythonImportsCheck = [ "nnunetv2" ];

  doCheck = false; # see nnunetv2/tests/integration_tests, but probably too expensive to run

  meta = {
    description = "Automated pipeline for semantic segmentation of medical images";
    homepage = "https://github.com/MIC-DKFZ/nnUNet";
    changelog = "https://github.com/MIC-DKFZ/nnUNet/releases/tag/${src.tag}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ bcdarwin ];
  };
}
