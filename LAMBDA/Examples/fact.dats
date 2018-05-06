(* ****** ****** *)
//
// LG 2018-02-17
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "./../mylibies.dats"

(* ****** ****** *)

val x = TMvar("x")
val f = TMvar("f")

val fact =
TMfix("f", "x", TMifnz(x, x * TMapp(f, x-TMint(1)), TMint(1)))

(* ****** ****** *)

implement
main0() = ()
where
{
  val out0 = fileref_open_exn("./fact.txt", file_mode_a)
  val () = fprint!(out0, TMapp(fact, TMint(10)))
}

(* ****** ****** *)

(* end of [fact.dats] *)