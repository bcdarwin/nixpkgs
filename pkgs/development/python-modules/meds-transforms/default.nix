{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,
  filelock,
  hydra-core,
  meds,
  meds-testing-helpers,
  nested-ragged-tensors,
  numpy,
  polars,
  pretty-print-directory,
  pyarrow,
  pytestCheckHook,
  pytest-cov-stub,
}:

buildPythonPackage rec {
  pname = "meds-transforms";
  version = "0.1.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mmcdermott";
    repo = "MEDS_transforms";
    tag = version;
    hash = "sha256-ZYmStwGsLmWBZKZ+eXcoB0wFGjgBiagGy46Vh68svu0=";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    filelock
    hydra-core
    meds
    meds-testing-helpers
    nested-ragged-tensors
    numpy
    polars
    pretty-print-directory
    pyarrow
  ];

  pythonRelaxDeps = [ "polars" ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-cov-stub
  ];

  pytestFlagsArray = [ "tests" ];

  preCheck = ''
    export PATH=$out/bin:$PATH
  '';

  disabledTests = [
    # requires unpackaged optional dependencies
    "test_example_pipeline_parallel"
  ];

  doCheck = false; # hack

  pythonImportsCheck = [
    "MEDS_transforms"
  ];

  meta = {
    description = "Simple set of Polars-based ETL and transformation functions for MEDS data";
    homepage = "https://github.com/mmcdermott/MEDS_transforms";
    changelog = "https://github.com/mmcdermott/MEDS_transforms/releases/tag/${src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bcdarwin ];
  };
}
