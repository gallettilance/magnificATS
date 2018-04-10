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

extern
fun
{a:t@ype}
myarray_set_first
{l: addr}{n: int | n > 0}
(pf: !myarray(a, l, n) | p0: ptr(l), elm: a): void

extern
fun
{a:t@ype}
myarray_set_ith
{l: addr}{n: int | n > 0}{i: int | i >= 0 && i < n}
(pf: !myarray(a, l + (i * sizeof(a)), n - i) | pi: ptr(l + (i *sizeof(a))), elm: a): void

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


implement
{a}
myarray_set_first(pf | p0, elm) = let
  prval myarray_cons(pf1, pf2) = pf
  val () = ptr_set<a>(pf1 | p0, elm)
in
  pf := myarray_cons(pf1, pf2)
end


implement
{a}
myarray_set_ith(pf | pi, elm) = let
  prval myarray_cons(pf1, pf2) = pf
  val () = ptr_set<a>(pf1 | pi, elm)
in
  pf := myarray_cons(pf1, pf2)
end

(* ****** ****** *)

extern
fun
{a:t@ype}
myarray_map
{l: addr}{n: nat | n > 0}
(pf: !myarray(a, l, n) | p0: ptr(l), n: int(n), f:a-<cloref1>a):  void

(* ****** ****** *)

implement
{a}
myarray_map(pf | p0, n, f) = let
    prval myarray_cons(pf1, pf2) = pf
    val elm = ptr_get<a>(pf1 | p0)
    val ()  = ptr_set<a>(pf1 | p0, f(elm))
    val p1  = ptr_succ<a>(p0)
  in
    if n = 1
    then ()
    else myarray_map(pf2 | p1, n - 1, f); pf := myarray_cons(pf1, pf2)
  end

(* ****** ****** *)

implement
main0() = ()
where
{

}

(* ****** ****** *)

(* end of [array.dats] *)