(* ****** ****** *)
//
// LG 2018-04-05
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

dataview 
myarray 
( a:t@ype (* element types *)
, addr (* location *)
, int (* size *)
) =
  | {l:addr}
    myarray_nil(a, l, 0)
  | {l:addr}{n:int}
    myarray_cons(a, l, n + 1) of (a@l, myarray(a, l + sizeof(a), n))

(* ****** ****** *)

extern
fun
{a:t@ype}
myarray_get_first
{l: addr}{n: int | n > 0}
(pf: !myarray(a, l, n) | p0: ptr(l)): a

extern
fun
{a:t@ype}
myarray_get_ith
{l: addr}{n: int | n > 0}{i: int | i >= 0 && i < n}
(pf: !myarray(a, l + (i * sizeof(a)), n - i) | pi: ptr(l + (i *sizeof(a)))): a

(* ****** ****** *)

implement
{a}
myarray_get_first(pf | p0) = let
  prval myarray_cons(pf1, pf2) = pf
  val res = ptr_get<a>(pf1 | p0)
in
  pf := myarray_cons(pf1, pf2); res
end


implement
{a}
myarray_get_ith(pf | pi) = let
  prval myarray_cons(pf1, pf2) = pf
  val res = ptr_get<a>(pf1 | pi)
in
  pf := myarray_cons(pf1, pf2); res
end


(* ****** ****** *)

implement
main0() = ()
where
{

}

(* ****** ****** *)

(* end of [array.dats] *)