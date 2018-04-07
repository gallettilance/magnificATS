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
| {l:addr}{n:nat}
  mymatrix_nil(a, l, 0, n) of ()
| {l:addr}{m,n:nat}
  mymatrix_cons(a, l, m, n+1) of
  (myarray(a, l, n), mymatrix(a, l+n*sizeof(a), m, n))

(* ****** ****** *)



(* ****** ****** *)

implement
main0() = ()
where
{

}

(* ****** ****** *)

(* end of [matrix.dats] *)