{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, pytest
, hatchling
, hatch-vcs
, aiohttp
, numpy
, pillow
, pygltflib
, scipy
, setuptools
, vtk
, xlib
, xvfb-run
, dipy
, matplotlib
, nibabel
}:

buildPythonPackage rec {
  pname = "fury";
  version = "0.9.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "fury-gl";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-Go7rlyhnfbSwgTiS4yms4EPfRCFLtm8zK/QQ7GXSb5s=";
  };

  nativeBuildInputs = [
    hatchling hatch-vcs
  ];

  propagatedBuildInputs = [
    aiohttp
    numpy
    setuptools  # needed for version_cmp not to be None
    pillow
    pygltflib
    scipy
    vtk
  ];

  passthru.optional-dependencies = {
    medical = [ dipy nibabel ];
    plot = [ matplotlib ];
  };

  nativeCheckInputs = [ pytest xvfb-run xlib ];  # TODO are dipy/matplotlib needed?
  doCheck = false;  # segfaults; maybe doesn't properly detect missing X server? see https://fury.gl/stable/installation.html
  #dontUsePytestXdist = true;  # doesn't help
  checkPhase = ''
    runHook preCheck
    xvfb-run -s "-screen 0 1920x1080x24" python3 -m pytest fury
    runHook postCheck
  '';

  pythonImportsCheck = [
    "fury"
    "fury.actor"
    "fury.colormap"
    "fury.convert"
    "fury.data"
    "fury.decorators"
    "fury.deprecator"
    "fury.gltf"
    "fury.io"
    "fury.layout"
    "fury.lib"
    "fury.material"
    "fury.molecular"
    "fury.pick"
    "fury.primitive"
    "fury.shaders"
    "fury.stream"
    "fury.transform"
    "fury.ui"
    "fury.utils"
    "fury.window"
  ];

  meta = with lib; {
    description = "Library for scientific visualization in Python";
    homepage = "https://fury.gl";
    license = licenses.bsd3;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
