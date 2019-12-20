{ stdenv, fetchurl, buildDunePackage, ocaml, bos, logs, fpath, alcotest, ptime, fmt, cmdliner, ocamlgraph
}:

if !stdenv.lib.versionAtLeast ocaml.version "4.03"
then throw "functoria is not available for OCaml ${ocaml.version}" else

buildDunePackage rec {
	#name = "ocaml${ocaml.version}-functoria-${version}";
    pname = "functoria";
	version = "3.0.3";
	src = fetchurl {
		url = "https://github.com/mirage/functoria/releases/download/v${version}/functoria-v${version}.tbz";
		sha256 = "08wv2890gz7ci1fa2b3z4cvqf98nqb09f89y08kcmnsirlbbzlfh";
	};

	buildInputs = [ ocaml ];
	propagatedBuildInputs = [ bos cmdliner ocamlgraph ptime ];
    checkInputs = [ alcotest ];

    doCheck = true;

	meta = {
		description = "A DSL to organize functor applications";
		homepage = https://github.com/mirage/functoria;
		license = stdenv.lib.licenses.isc;
		maintainers = [ stdenv.lib.maintainers.vbgl ];
		inherit (ocaml.meta) platforms;
	};
}
