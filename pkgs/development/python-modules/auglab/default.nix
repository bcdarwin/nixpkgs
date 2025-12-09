{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  batchgeneratorsv2,
  kornia,
  monai,
  numpy,
  progress,
  torchio,
  tqdm,
  wandb,
  nnunetv2,
}:

buildPythonPackage {
  pname = "auglab";
  version = "unstable-2025-12-09";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "neuropoly";
    repo = "AugLab";
    rev = "4c70e49c18554f925b46fa6229e31d6ff01b7b1f";
    hash = "sha256-5F7NaV9ZLjQUJzocX3E8afCT+48DmPnTcF9aTIZLg/g=";
  };

  postPatch = ''
    sed -i -e 's/"pip.*", //g' pyproject.toml
  '';

  build-system = [
    setuptools
  ];

  dependencies = [
    batchgeneratorsv2
    kornia
  ];

  optional-dependencies = {
    all = [
      monai
      numpy
      progress
      torchio
      tqdm
      wandb
    ];
    nnunetv2 = [
      nnunetv2
    ];
  };

  pythonImportsCheck = [
    "auglab"
  ];

  doCheck = false; # no tests

  meta = {
    description = "Investigates the influence of various data augmentation strategies on MRI training performance";
    homepage = "https://github.com/neuropoly/AugLab";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ bcdarwin ];
  };
}
