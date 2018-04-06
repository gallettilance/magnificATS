(* ****** ****** *)
//
// LG 2018-04-03
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

datatype MOD (int, int) =
| {i,j: int | i >=0 && j > 0 && i < j}
  MOD0(i, j) of ()
| {i,j: int | i >=0 && j > 0 && i >= j}
  MOD1(i, j) of (MOD(i - j, j))

(* ****** ****** *)

prfun
dmod
{n,m:int | n >= 0 && m > 0}
.<n>. 
(i: int(n), j: int(m)) : MOD(n, m) =
  if i < j then MOD0()
  else MOD1(dmod(i - j, j))

(* ****** ****** *)

prval d01 = dmod(0, 1)

(* ****** ****** *)

(* end of [mod.dats] *)