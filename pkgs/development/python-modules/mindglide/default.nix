{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  huggingface-hub,
  monai,
  nibabel,
  numpy,
  scikit-image,
  torch,
  tqdm,
}:

let
  stableVersion = "1.0.1";
in
buildPythonPackage rec {
  pname = "mindglide";
  version = "${stableVersion}-unstable-2025-10-14";
  pyproject = true;

  # change back to upstream repo (github.com/MS-PINPOINT/mindGlide) after
  # https://github.com/MS-PINPOINT/mindGlide/pull/41 is merged
  src = fetchFromGitHub {
    owner = "LemuelPuglisi";
    repo = "mindGlide";
    rev = "1aa3a60a1134a2f4dbd92248fe6a5b4b8d2c7574";
    hash = "sha256-IjNPvSLd1lxXNHHDHFljk5ap7Pogvdeib4lSvlMXII4=";
    fetchSubmodules = true;
  };

  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail 'version = "0.0.0"' 'version = "${stableVersion}"'
    rm -r inference/mindglide.egg-info
  '';

  build-system = [
    setuptools
  ];

  dependencies = [
    huggingface-hub
    monai
    nibabel
    numpy
    scikit-image
    torch
    tqdm
  ];

  # package only claims to support numpy 1.x
  pythonRelaxDeps = [ "numpy" ];

  doCheck = false; # no tests

  pythonImportsCheck = [
    "mindglide"
  ];

  meta = {
    description = "Multiple sclerosis brain lesion segmentation using MONAI and Dynamic U-Nets";
    homepage = "https://github.com/LemuelPuglisi/mindGlide";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bcdarwin ];
    mainProgram = "mindglide";
  };
}
