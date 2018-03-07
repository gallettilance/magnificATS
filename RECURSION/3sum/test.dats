(* ****** ****** *)
//
// LG 2018-03-06
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"
#include "./3sum.dats"

(* ****** ****** *)

implement
main0() = ()
where
{
  val xs = g0ofg1($list(~2, 1, ~1, 2, 0, ~2, 4, 3, ~3))
  val () = (search3(xs, 0, nil0())).foreach()(lam(ys) => println!("(", ys.0, ", ", ys.1, ", ", ys.2, ")"))
}

(* ****** ****** *)

(* end of [test.dats] *)