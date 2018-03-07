(* ****** ****** *)
//
// LG 2018-03-06
//
(* ****** ****** *)

#include "./../2sum/2sum.dats"

(* ****** ****** *)

typedef int3 = (int, int, int)

(* ****** ****** *)

extern
fun
search3(orig: list0(int), target: int, res: list0(int3)): list0(int3)

(* ****** ****** *)

implement
search3(orig, target, res) = 
case+ orig of
| nil0() => res
| cons0(num, orig) => let
    val newtar = target - num
    val tups = search2(orig, newtar, nil0())
    val trips = list0_map<int2><int3>(tups, lam(tup) => (num, tup.0, tup.1))
  in
    search3(orig, target, list0_append(res, trips))
  end

(* ****** ****** *)

(* end of [3sum.dats] *)