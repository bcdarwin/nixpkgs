{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  hydra-core,
  hydra-joblib-launcher,
  loguru,
  meds-transforms,
  numpy,
  polars,
  pyarrow,
  safetensors,
  torch,
  tqdm,
  transformers,
  wandb,
}:

buildPythonPackage rec {
  pname = "ethos-ares";
  version = "unstable-2025-07-03";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ipolharvard";
    repo = "ethos-ares";
    rev = "21d35d823e9cf0ac2095392a054f95773ca50e57";
    hash = "sha256-r3rxyk5fSYZkY43Rnd5S2q16tzkK99ttsmszdQexkf8=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    hydra-core
    hydra-joblib-launcher
    loguru
    meds-transforms
    numpy
    polars
    pyarrow
    safetensors
    torch
    tqdm
    transformers
    wandb
  ];

  pythonRelaxDeps = true;

  doCheck = false; # no tests

  pythonImportsCheck = [
    "ethos"
  ];

  meta = {
    description = "";
    homepage = "https://github.com/ipolharvard/ethos-ares";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
