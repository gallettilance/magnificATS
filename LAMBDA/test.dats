(* ****** ****** *)
//
// LG 2018-02-17
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "./mylibies.dats"

(* ****** ****** *)

implement
main0(argc, argv) = let
  val myfile = (if (argc >= 2) then argv[1] else "Examples/basic.txt"): string
  val out0 = fileref_open_exn("Examples/output.txt", file_mode_a)
in
  fprint!(out0, interp(parse_lisp(myfile)))
end

(* ****** ****** *)