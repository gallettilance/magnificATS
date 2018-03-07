(* ****** ****** *)
//
// LG 2018-03-07
//
(* ****** ****** *)
(*
  Goal: find triples of 
  unique triangular numbers
  that sum to a target value
*)
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

typedef int3 = (int, int, int)
typedef int2 = (int, int)

(* ****** ****** *)

extern
fun
search2(orig: list0(int), target: int, res: list0(int2)): list0(int2)

extern
fun
search3(orig: list0(int), target: int, res: list0(int3)): list0(int3)

extern
fun
triangulars(n: int): stream(int)

extern
fun
list0_triangs(triangs: stream(int), max: int, res: list0(int)): list0(int)

extern
fun
triang_repr(triangs: list0(int), target: int): list0(int3)

(* ****** ****** *)

implement
search2(orig, target, res) = let

  fun search1(orig: list0(int), target: int, res: list0(int)): list0(int) =
    case+ orig of
    | nil0() => res
    | cons0(num, orig) => 
        if num = target 
        then search1(orig, target, cons0(num, res)) 
        else search1(orig, target, res)
    
in
  case+ orig of
  | nil0() => res
  | cons0(num, orig1) => 
      let
        val newtar = target - num
        val sings = search1(orig, newtar, nil0())
        val tups = list0_map<int><int2>(sings, lam(s) => (num, s))
      in
        search2(orig1, target, list0_append(tups, res))
      end
end

implement
search3(orig, target, res) = 
case+ orig of
| nil0() => res
| cons0(num, orig1) => let
    val newtar = target - num
    val tups = search2(orig, newtar, nil0())
    val trips = list0_map<int2><int3>(tups, lam(tup) => (num, tup.0, tup.1))
  in
    search3(orig1, target, list0_append(res, trips))
  end

(* ****** ****** *)

implement
list0_triangs(triangs, max, res) =
case- !triangs of
| stream_cons(t, triangs) => 
    if t > max then res
    else list0_triangs(triangs, max, cons0(t, res))

implement
triangulars(n) = $delay
(
  stream_cons(n, triangulars(2*n + 1))
)

implement
triang_repr(triangs, target) = search3(triangs, target, nil0())

(* ****** ****** *)

implement
main0() = ()
where
{
  val triangs = triangulars(0)
  val x = 8
  val () = println!("x = ", x)
  val () = println!("triang_repr(", x ,") = ")
  val () = (triang_repr(list0_triangs(triangs, x, nil0), x)).foreach()(lam(xs) => println!("(", xs.0, ", ", xs.1, ", ", xs.2, ")"))
}

(* ****** ****** *)

(* end of [triangular.dats] *)