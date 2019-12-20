{ stdenv, buildDunePackage, fetchurl, ocaml, findlib, ocamlbuild, topkg
, bos, cmdliner, ocamlgraph, functoria
}:

if !stdenv.lib.versionAtLeast ocaml.version "4.03"
then throw "functoria is not available for OCaml ${ocaml.version}" else

buildDunePackage rec {
    pname = "functoria-runtime";

    inherit (functoria) version src meta;

	buildInputs = [ ocaml ];
	propagatedBuildInputs = [ bos cmdliner ocamlgraph ];

    buildPhase = ''
      dune build -p ${pname} # TODO add hooks
    '';

    doCheck = true;

	#meta = {
	#	description = "A DSL to organize functor applications";
	#	homepage = https://github.com/mirage/functoria;
	#	license = stdenv.lib.licenses.isc;
	#	maintainers = [ stdenv.lib.maintainers.vbgl ];
	#	inherit (ocaml.meta) platforms;
	#};
}
