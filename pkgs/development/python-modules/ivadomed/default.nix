{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonAtLeast,
  setuptools,
  pytestCheckHook,
  pytest-console-scripts,
  csv-diff,
  imageio,
  joblib,
  legacy-cgi,
  loguru,
  matplotlib,
  nibabel,
  onnx,
  onnxruntime,
  pandas,
  pybids,
  scikit-image,
  scikit-learn,
  scipy,
  seaborn,
  tensorboard,
  torch,
  torchio,
  torchvision,
  tqdm,
  wandb,
}:

buildPythonPackage rec {
  pname = "ivadomed";
  version = "2.9.10";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ivadomed";
    repo = "ivadomed";
    rev = "v${version}";
    hash = "sha256-QzfLg42Vda1jONJhgbMFfuzVOZMcLLKlkdnSajO+Nhs=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    csv-diff
    imageio
    joblib
    loguru
    matplotlib
    nibabel
    onnx
    onnxruntime
    pandas
    pybids
    scikit-image
    scikit-learn
    scipy
    seaborn
    tensorboard
    torch
    torchio
    torchvision
    tqdm
    wandb
  ] ++ lib.optionals (pythonAtLeast "3.13") [
    # cgi module removed in 3.13 by PEP 0594
    legacy-cgi
  ];

  pythonRelaxDeps = [
    "pandas"
    "pybids"
  ];

  pythonImportsCheck = [
    "ivadomed"
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-console-scripts
  ];

  doCheck = false; # tries to download data

  meta = {
    description = "Repository on the collaborative IVADO medical imaging project between the Mila and NeuroPoly labs";
    homepage = "https://github.com/ivadomed/ivadomed";
    changelog = "https://github.com/ivadomed/ivadomed/blob/${src.rev}/CHANGES.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bcdarwin ];
  };
}
