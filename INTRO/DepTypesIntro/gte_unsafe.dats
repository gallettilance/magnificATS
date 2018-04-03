(* ****** ****** *)
//
// LG 2018-04-03
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

datatype GTE (int, int) =
  | {x: int}   eq(x, x) of ()
  | {x,y: int} gt(x, y) of (GTE(x - 1, y))

(* ****** ****** *)

val pf1gte1 = eq{1}()
val pf2gte1 = gt{2,1}(pf1gte1)
val pf3gte1 = gt{3,1}(pf2gte1)

(* ****** ****** *)

extern
fun
is_gte_zero
{n: int | n >= 0}
(i: int(n)): GTE(n, 0)

(* ****** ****** *)

implement
is_gte_zero(i) =
if i = 0
then eq()
else gt(is_gte_zero(i - 1))

(* ****** ****** *)

(* end of [gte_unsafe.dats] *)