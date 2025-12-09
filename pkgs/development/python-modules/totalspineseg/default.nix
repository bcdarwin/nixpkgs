{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  auglab,
  gryds,
  nibabel,
  nilearn,
  numpy,
  pillow,
  psutil,
  scipy,
  simpleitk,
  torchio,
  tqdm,
  #nnunetv2-neuropoly,
  nnunetv2,
}:

buildPythonPackage rec {
  pname = "totalspineseg";
  version = "20251124";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "neuropoly";
    repo = "totalspineseg";
    rev = "r${version}";
    hash = "sha256-1gv7gGeIr29lAleka/Qv5xkKt/4DBhOC8CosBBgWk6Y=";
  };

  postPatch = ''
    sed -i -e 's/"pip.*", //g' pyproject.toml
  '';

  build-system = [
    setuptools
  ];

  dependencies = [
    auglab
    gryds
    nibabel
    nilearn
    nnunetv2
    numpy
    pillow
    psutil
    scipy
    simpleitk
    torchio
    tqdm
  ];

  optional-dependencies = {
    #neuropoly = [
    #  nnunetv2-neuropoly
    #];
    #nnunetv2 = [
    #];
  };

  pythonImportsCheck = [
    "totalspineseg"
  ];

  meta = {
    description = "Robust Segmentation and Labeling of Vertebrae, Intervertebral Discs, Spinal Cord, and Spinal Canal in MRI Images Using nnU-Net and Iterative Algorithm";
    homepage = "https://github.com/neuropoly/totalspineseg";
    license = lib.licenses.lgpl3;
    maintainers = with lib.maintainers; [ bcdarwin ];
  };
}
