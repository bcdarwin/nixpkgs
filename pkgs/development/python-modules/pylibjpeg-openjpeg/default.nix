{ lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  poetry-core,
  cmake,
  cython,
  numpy,
  openjpeg,
  pytestCheckHook,
  pydicom,
  pylibjpeg,
  pylibjpeg-data,
}:

buildPythonPackage rec {
  pname = "pylibjpeg-openjpeg";
  version = "2.2.1";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "pydicom";
    repo = "pylibjpeg-openjpeg";
    rev = "refs/tags/v${version}";
    hash = "sha256-5G4s4O36aiElKV1BxAFXNIt3zDzZtOFrnxUp2aj7PwE=";
  };

  # don't use vendored openjpeg submodule:
  # (note build writes into openjpeg source dir, so we have to make it writable)
  postPatch = ''
    rmdir lib/openjpeg
    cp -r ${openjpeg.src} lib/openjpeg
    chmod +rwX -R lib/openjpeg
  '';

  dontUseCmakeConfigure = true;

  build-system = [
    cmake
    cython
    poetry-core
  ];

  dependencies = [
    numpy
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pydicom
    pylibjpeg-data
    pylibjpeg
  ];
  disabledTestPaths = [
    # a few Python test files (e.g. performance tests) in openjpeg itself; ignore them:
    "lib/openjpeg"
    # fails to raise some warnings, unclear why:
    "openjpeg/tests/test_handler.py"
  ];

  pythonImportsCheck = [ "openjpeg" ];

  meta = {
    description = "A J2K and JP2 plugin for pylibjpeg";
    homepage = "https://github.com/pydicom/pylibjpeg-openjpeg";
    license = [ lib.licenses.mit ];
    maintainers = with lib.maintainers; [ bcdarwin ];
  };
}
