{ lib
, fetchFromGitHub
, fetchzip
, buildPythonPackage
, makeWrapper
, ants
, parallel
, python
, pytest
, pytestcov
, numpy
, cryptography
, dipy
, h5py
, Keras
, matplotlib
, nibabel
, pandas
, psutil
, pyqt5
, raven
, requests
, scipy
, scikitimage
, scikitlearn
, tensorflow_1
, xlrd
, xlwt
, tqdm
, transforms3d
, urllib3
}:

buildPythonPackage rec {
  pname = "spinalcordtoolbox";
  version = "4.2.2";

  src = fetchFromGitHub {
    repo = pname;
    owner = "neuropoly";
    rev = version;
    sha256 = "1q5rp78096psdml8qs14haxcpk7czwcffssg4m33vhbqdpkz0893";
  };

  test_data = fetchzip {
    url = "https://www.neuro.polymtl.ca/_media/downloads/sct/20191031_sct_testing_data.zip";
    sha256 = "0vz6gk77jck8wykdkwwv8mq2ich2h68slkzj21rjzini8iaj304x";
  };

  propagatedBuildInputs = [
    ants
    parallel
    numpy
    cryptography
    dipy
    #futures
    h5py
    Keras
    matplotlib
    nibabel
    pandas
    psutil
    pyqt5
    raven
    requests
    scipy
    scikitimage
    scikitlearn
    tensorflow_1
    xlrd
    xlwt
    tqdm
    transforms3d
    urllib3
  ];

  # TODO use a 'let' to bind this only locally in postPatch ...
  pkgs = [
    "spinalcordtoolbox"
    "spinalcordtoolbox.centerline"
    "spinalcordtoolbox.compat"
    "spinalcordtoolbox.deepseg_gm"
    "spinalcordtoolbox.deepseg_lesion"
    "spinalcordtoolbox.deepseg_sc"
    "spinalcordtoolbox.gui"
    "spinalcordtoolbox.qmri"
    "spinalcordtoolbox.reports"
    "testing"  # will be "spinalcordtoolbox.testing" in next release
    "spinalcordtoolbox.vertebrae"
  ];

  pkgs_str = builtins.concatStringsSep "\", \"" pkgs;

  postPatch = ''
    substituteInPlace setup.py  \
      --replace '    "spinalcordtoolbox",' '    "${pkgs_str}"'
    substituteInPlace spinalcordtoolbox/compat/launcher.py  \
      --replace 'script = os.path.join(sct_dir, "scripts",' 'script = os.path.join(sct_dir, "../../../sct_scripts",'  \
      --replace 'command = os.path.basename(sys.argv[0])' 'command = os.path.basename(sys.argv[0])[1:-8]'
  '';

  postInstall = ''
    cp version.txt $out/${python.sitePackages}

    # hack for now due to weird launcher code
    for p in $out/bin/*; do
      wrapProgram $p --prefix PYTHONPATH : "$PYTHONPATH"
    done
  '';

  doCheck = false;
  checkInputs = [ pytest pytestcov ];
  #installCheckPhase = "pytest .";
  #installCheckPhase = ''
  #  pytest .  # is this needed?
  #  sct_testing -d0 --path ${test_data}
  #'';

  meta = with lib; {
    description = "Comprehensive toolbox for spinal cord imaging";
    license = licenses.mit;
    homepage = "https://github.com/neuropoly/spinalcordtoolbox";
    maintainers = [ maintainers.bcdarwin ];
  };
}
