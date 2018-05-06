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

val fibo = TMfix("f", "x", TMifnz(x, TMifnz(x-TMint(1), TMapp(f, x-TMint(1)) + TMapp(f, x-TMint(2)), TMint(1)), TMint(0)))

(* ****** ****** *)

implement
main0() = ()
where
{
  val out0 = fileref_open_exn("./fibo.txt", file_mode_a)
  val () = fprint!(out0, TMapp(fibo, TMint(10)))
}

(* ****** ****** *)

(* end of [fibo.dats] *)