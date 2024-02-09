{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, pytestCheckHook
, batchgenerators
, dicom2nifti
, matplotlib
, medpy
, nibabel
, numpy
, pandas
, torch
, tqdm
, requests
, scikit-image
, scikitlearn
, scipy
, simpleitk
, tifffile
}:

buildPythonPackage rec {
  pname = "mednext";
  version = "unstable-2023-12-06";
  pyproject = true;
  #format = "setuptools";

  src = fetchFromGitHub {
    owner = "MIC-DKFZ";
    repo = "MedNeXt";
    rev = "c5ed3f38b56d58c80581c75fea856865f42ddb75";
    hash = "sha256-zCVxgfldDkl2smUNendWrB7Py5+4+/VleoiExcZXJlM=";
  };

  postPatch = ''
    substituteInPlace setup.py  \
      --replace  'include=["mednextv1", "mednextv1.*"]'  'include=["nnunet_mednext", "nnunet_mednext.*"]'
  '';

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    batchgenerators
    dicom2nifti
    matplotlib
    medpy
    nibabel
    numpy
    pandas
    torch
    tqdm
    requests
    scikit-image
    scikitlearn
    scipy
    simpleitk
    tifffile
  ];

  doCheck = false;

  pythonImportsCheck = [ "nnunet_mednext" ];

  meta = with lib; {
    description = "Fully ConvNeXt architecture for 3D medical image segmentation";
    homepage = "https://github.com/MIC-DKFZ/MedNeXt";
    license = licenses.asl20;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
