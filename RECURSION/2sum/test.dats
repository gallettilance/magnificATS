(* ****** ****** *)
//
// LG 2018-03-06
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"
#include "./2sum.dats"

(* ****** ****** *)

implement
main0() = ()
where
{
  val xs = g0ofg1($list(~1, 1, ~3, 2, 0, ~2, 0, 3))
  val () = (search2(xs, 0, nil0())).foreach()(lam(ys) => println!("(", ys.0, ", ", ys.1, ")"))
}

(* ****** ****** *)

(* end of [test.dats] *)