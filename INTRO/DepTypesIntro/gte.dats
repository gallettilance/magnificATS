(* ****** ****** *)
//
// LG 2018-04-03
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

dataprop GTE (int, int) =
  | {x: int}   eq(x, x) of ()
  | {x,y: int} gt(x, y) of (GTE(x - 1, y))

(* ****** ****** *)

prval pf1gte1 = eq() : GTE(1, 1)
prval pf2gte1 = gt{2,1}(pf1gte1)
prval pf3gte1 = gt{3,1}(pf2gte1)

(* ****** ****** *)

prfun
is_gte_zero
{n: int | n >= 0}
.<n>.
(i: int(n)): GTE(n, 0) =
  if i = 0
  then eq()
  else gt(is_gte_zero(i - 1))

(* ****** ****** *)

(* end of [gte.dats] *)