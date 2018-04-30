(* ****** ****** *)
(*
** For testing functions 
*)
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

#staload "./../mylibies.dats"
#staload "./../mylibies.sats"

(* ****** ****** *)

implement main0 () = () where
{
  val () = println!("testing template")
  val () = foo()
  val () = bar()
}

(* end of [test00.dats] *)