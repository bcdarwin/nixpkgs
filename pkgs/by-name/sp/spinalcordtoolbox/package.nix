{
  lib,
  python3Packages,
  fetchFromGitHub,
  testers,
  spinalcordtoolbox,
}:

python3Packages.buildPythonApplication rec {
  pname = "spinalcordtoolbox";
  version = "7.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "spinalcordtoolbox";
    repo = "spinalcordtoolbox";
    rev = version;
    hash = "sha256-3A0LnuvP7iHpUOh9u/rkV7qmmyS/3fKC7gURUNQ6xnY=";
  };

  # currently setup.py configures all scripts to use spinalcordtoolbox/compat/launcher.py,
  # which adds an extra layer of process indirection and breaks PYTHONPATH etc., so remove this for now:
  postPatch = ''
    for f in spinalcordtoolbox/scripts/sct_*.py; do
      substituteInPlace $f --replace-warn "def main(argv: Sequence[str])" "def main(argv: Sequence[str] = sys.argv[1:])"
    done
    substituteInPlace setup.py --replace-fail \
      "'{}=spinalcordtoolbox.compat.launcher:main'.format(x)" "'{}=spinalcordtoolbox.scripts.{}:main'.format(x, x)"
  '';

  build-system = [
    python3Packages.setuptools
  ];

  dependencies = with python3Packages; [
    acvl-utils
    blosc2
    dipy
    h5py
    ivadomed
    matplotlib
    matplotlib-inline
    monai
    nibabel
    nilearn
    nnunetv2
    #nnunetv2-neuropoly
    numexpr
    numpy
    onnx
    onnxruntime
    pandas
    portalocker
    psutil
    pyqt5
    #pyqt5-qt5
    pystrum
    pyyaml
    requests
    requirements-parser
    scikit-image
    scikit-learn
    scipy
    totalspineseg
    tqdm
    transforms3d
    urllib3
    voxelmorph
    wquantiles
    xlsxwriter
    xlwt
  ];

  pythonImportsCheck = [
    "spinalcordtoolbox"
    "spinalcordtoolbox.compat"
    "spinalcordtoolbox.deepseg"
    "spinalcordtoolbox.qmri"
    "spinalcordtoolbox.reports"
    "spinalcordtoolbox.scripts"
    "spinalcordtoolbox.utils"
  ];

  nativeCheckInputs = with python3Packages; [
    pytestCheckHook
    pytest-cov-stub
    pytest-console-scripts
  ];

  doCheck = false; # tries to download data

  passthru.tests.version = testers.testVersion {
    package = spinalcordtoolbox;
    command = "sct_version";
  };

  meta = {
    description = "Comprehensive and open-source library of analysis tools for MRI of the spinal cord";
    homepage = "https://spinalcordtoolbox.com";
    changelog = "https://github.com/spinalcordtoolbox/spinalcordtoolbox/blob/${src.rev}/CHANGES.md";
    license = lib.licenses.lgpl3;
    maintainers = with lib.maintainers; [ bcdarwin ];
  };
}
