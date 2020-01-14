{ lib, buildPythonPackage, fetchFromGitHub, pytest, pytorch, blas }:

assert blas.implementation == "mkl";  # gpytorch/issues/194

buildPythonPackage rec {
  pname = "gpytorch";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "cornellius-gp";
    repo = pname;
    rev = "v${version}";
    sha256 = "0nq3w8fnglb109yqyx8ka0w3swhkx45kff2hi154frsc8rl3lrrm";
  };

  propagatedBuildInputs = [ pytorch ];
  checkInputs = [ pytest ];

  checkPhase = ''
    runHook preCheck
    python3 -m unittest
    runHook postCheck
  '';

  meta = with lib; {
    description = "Gaussian processes in PyTorch";
    homepage = "https://gpytorch.ai";
    license = licenses.mit;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
