(* ****** ****** *)
//
// LG 2018-04-03
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "./array.dats"

(* ****** ****** *)

dataview
mymatrix(a:t@ype, addr, int, int) =
| {l:addr}{m:nat}
  mymatrix_nil(a, l, 0, m) of ()
| {l:addr}{m,n:nat}
  mymatrix_cons(a, l, n, m+1) of
  (myarray(a, l, m), mymatrix(a, l+n*sizeof(a), n, m))

(* ****** ****** *)

extern
fun
{a:t@ype}
mymatrix_get_ijth
{l: addr}
{n: int | n > 0}{m: int | m > 0}
{i: int | i >= 0 && i < n}{j: int | j >= 0 && j < m}
(pf: !mymatrix(a, l + (i * m * sizeof(a)) + (j * sizeof(a)), n - i, m - j) | pi: ptr(l + (i * m * sizeof(a)) + (j * sizeof(a)))): a

(* ****** ****** *)
////
implement
{a}
mymatrix_get_ijth(pf | pi) = let
  prval mymatrix_cons(pf1, pf2) = pf
  prval myarray_cons(pf3, pf4) = pf1
  val res = ptr_get<a>(pf3 | pi)
in
  pf1 := myarray_cons(pf3, pf4); pf := mymatrix_cons(pf1, pf2); res
end


(* ****** ****** *)

implement
main0() = ()
where
{

}

(* ****** ****** *)

(* end of [matrix.dats] *)