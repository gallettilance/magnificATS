(* ****** ****** *)
//
// LG 2018-03-25
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

typedef triangle = list0(list0(int))

(* ****** ****** *)

extern
fun
find_max_path(tr: triangle): int

extern
fun
myfold(xs: list0(int), ys: list0(int)): list0(int)

extern
fun
max(xs: list0(int)): int

(* ****** ****** *)

implement
find_max_path(tr) = 
max
(
  list0_foldleft(tr, nil0(), lam(acc, x) => myfold(acc, x))
)

implement
myfold(xs, ys) = let
  val lst1 = cons0(0, xs)
  val lst2 = list0_append(xs, list0_sing(0))
  val m1 = list0_map2<int, int><int>(lst1, ys, lam(l1, l2) => l1 + l2)
  val m2 = list0_map2<int, int><int>(lst2, ys, lam(l1, l2) => l1 + l2)
in
  list0_map2<int, int><int>(m1, m2, lam(x1, x2) => if x1 > x2 then x1 else x2)
end

implement
max(xs) = let
  val () = assertloc(list0_length(xs) > 0)
  
  fun aux(xs: list0(int), curr: int): int =
    case+ xs of
    | nil0() => curr
    | cons0(x, xs) => if x > curr then aux(xs, x) else aux(xs, curr)
in
  case- xs of
  | cons0(x, xs) => aux(xs, x) 
end 

(* ****** ****** *)

implement
main0() = ()
where
{
  val triangle = g0ofg1
                 (
                   $list
                   (
                     g0ofg1($list(3)), 
                     g0ofg1($list(7, 4)), 
                     g0ofg1($list(2, 4, 6)), 
                     g0ofg1($list(8, 5, 9, 3))
                   )
                 )
  
  val () = println!(find_max_path(triangle))
} 

(* ****** ****** *)

(* end of [triangle.dats] *)