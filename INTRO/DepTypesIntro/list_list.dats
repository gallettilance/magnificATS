(* ****** ****** *)
//
// LG 2018-04-03
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "./list.dats"

(* ****** ****** *)

datatype 
mylistlist 
(A: t@ype, int, int) = 
  | {c: nat}
    ll_nil(A, 0, c) of (mylist(A, 0))
  | {r,c: nat}
    ll_cons(A, r + 1, c) of (mylist(A, c), mylistlist(A, r, c))

(* ****** ****** *)

val lst1 = cons(1, cons(2, cons(3, nil()))) : mylist(int, 3)
val lst2 = cons('h', cons('i', nil())) : mylist(char, 2)

val mat1 = ll_cons(lst1, ll_cons(lst1, ll_cons(lst1, ll_nil(nil())))) : mylistlist(int, 3, 3)
val mat2 = ll_cons(lst2, ll_cons(lst2, ll_nil(nil()))) : mylistlist(char, 2, 2)

(* ****** ****** *)

fun
{A:t@ype}
mylistlist_get
{r1,r2:int | r1 >= 0 && r2 >= 0 && r1 > r2}
{c1,c2:int | c1 >= 0 && c2 >= 0 && c1 > c2}
(xss: mylistlist(A, r1, c1), i: int(r2), j: int(c2)): A =
  case+ xss of
  | ll_cons(xs, tail) => 
      if i = 0 then get(xs, j)
      else mylistlist_get(tail, i - 1, j)

(* ****** ****** *)

overload [] with get

fun
{A,B:t@ype}
mylistlist_map
{r,c: nat}
( xss: mylistlist(A, r, c)
, f: mylist(A, c)-<cloref1>mylist(B, c) 
) : mylistlist(B, r, c) = 
  case+ xss of
  | ll_nil(nil()) => ll_nil(nil())
  | ll_cons(xs, xss) => ll_cons(f(xs), mylistlist_map(xss, f))

(* ****** ****** *)

fun
{A:t@ype}
mylistlist_num_row
{r,c: nat}
(xss: mylistlist(A, r, c)): int(r) =
  case+ xss of
  | ll_nil(nil()) => 0
  | ll_cons(xs, xss) => 1 + mylistlist_num_row(xss)


fun
{A:t@ype}
mylistlist_num_col
{r,c: nat | r > 0}
(xss: mylistlist(A, r, c)): int(c) =
  case+ xss of
  | ll_cons(xs, xss) => mylist_length(xs)

(* ****** ****** *)

fun
{A:t@ype}
mylistlist_get_row
{r,c: nat}{r1: nat | r1 < r}
(xss: mylistlist(A, r, c), i: int(r1)): mylist(A, c) =
  case+ xss of
  | ll_nil(nil()) => nil()
  | ll_cons(xs, xss) => 
      if i = 0 then xs
      else mylistlist_get_row(xss, i - 1)

fun
{A:t@ype}
mylistlist_get_col
{r,c: nat}{c1: nat | c1 < c}
(xss: mylistlist(A, r, c), j: int(c1)): mylist(A, r) =
  case+ xss of
  | ll_nil(nil()) => nil()
  | ll_cons(xs, xss) => cons(xs[j], mylistlist_get_col(xss, j))
  
(* ****** ****** *)
////
fun
{A:t@ype}
mylistlist_transpose
{r,c: nat}
(xss: mylistlist(A, r, c)): mylistlist(A, c, r) = let 
      
  fun
  aux
  {r,c:nat}{m: nat | m <= c}
  (col: int(c), i: int(m)): mylistlist(A, r, c) = 
      if i < col 
      then ll_cons(mylistlist_get_col(xss, i) : mylist(A, r), aux(col, i + 1))
      else ll_nil(nil())

in
  case+ xss of
  | ll_nil(nil()) => ll_nil(nil())
  | ll_cons(xs, _) => let
      val cols = mylist_length(xs) : int(c)
    in
      aux(cols, 0)
    end
end


(* ****** ****** *)

implement
main0() = ()
where
{

}

(* ****** ****** *)

(* end of [list_list.dats] *)