(* ****** ****** *)
//
// LG 2018-04-03
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

datatype mylist (A: t@ype, int) =
  | nil(A, 0)    of ()
  | {n:nat} 
    cons(A, n+1) of (A, mylist(A, n))

(* ****** ****** *)

val lst1 = cons(1, cons(2, cons(3, nil()))) : mylist(int, 3)
val lst2 = cons('h', cons('i', nil())) : mylist(char, 2)

(* ****** ****** *)

fun
{A:t@ype}
get
{n,m:int | n>= 0 && m >= 0 && n > m}
(xs: mylist(A, n), i: int(m)): A =
  case+ xs of
  | cons(a, tail) => 
      if i = 0 then a
      else get(tail, i - 1)

(* ****** ****** *)

implement
main0() = ()
where
{
  val () = println!(get(lst1, 1))
  // val () = println!(get(lst1, 3))
  // val () = println!(get(nil(), 0))
}

(* ****** ****** *)

(* end of [list_safe.dats] *)