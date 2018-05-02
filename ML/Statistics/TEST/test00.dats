(* ****** ****** *)
(*
** For testing stats-functions 
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#staload "./../SATS/stats.sats"

(* ****** ****** *)

implement
main0(argc, argv) =
{
//
val () =
println!
  ("Hello from [test00]!")
//
val () =
println! ("argc = ", argc)
//
val () =
println! ("argv[0] = ", argv[0])
//
val () =
if (argc >= 2)
then println! ("argv[1] = ", argv[1])
//
val () =
if (argc >= 3)
then println! ("argv[2] = ", argv[2])
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test00.dats] *)