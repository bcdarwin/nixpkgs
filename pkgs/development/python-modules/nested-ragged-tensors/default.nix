{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,
  numpy,
  safetensors,
}:

buildPythonPackage rec {
  pname = "nested-ragged-tensors";
  version = "0.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mmcdermott";
    repo = "nested_ragged_tensors";
    rev = version;
    hash = "sha256-B5aT/H75SzpYxo5QdxtUkcZfbyqVAA4cJ6UgDGOD0Ig=";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    numpy
    safetensors
  ];

  doCheck = false; # no tests

  pythonImportsCheck = [
    "nested_ragged_tensors"
  ];

  meta = {
    description = "Utilities for efficiently working with, saving, and loading, collections of connected nested ragged tensors in PyTorch";
    homepage = "https://github.com/mmcdermott/nested_ragged_tensors";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
