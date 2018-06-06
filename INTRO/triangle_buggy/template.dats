(* ****** ****** *)
//
// LG 2018-03-15
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

typedef layer = list0(int)
typedef triangle = list0(layer)

extern
fun
max_path(tr: triangle): int

extern
fun
myfold(acc: list0(int), lay: list0(int)): list0(int)

extern
fun
list0_max(xs: list0(int)): int

(* ****** ****** *)

fun
print_list(xs: list0(int)): void =
case+ xs of
| nil0() => println!()
| cons0(x, xs) => (print!(x, " "); print_list(xs))


implement
max_path(tr) = 
case- tr of
| cons0(l, tr) => 
  list0_max(list0_foldleft<list0(int)>(tr, l, lam(acc, x) => myfold(acc, x)))


implement
list0_max(xs) = let
  val-cons0(x, ys) = xs
  fun aux(xs: list0(int), max: int): int =
    case+ xs of
    | nil0() => max
    | cons0(x, xs) => 
    if x > max then aux(xs, x) else aux(xs, max)
in
  aux(ys, x)
end


implement
myfold(acc, lay) = let
  val shiftr = cons0(0, lay)
  val shiftl = list0_extend(lay, 0)
  val tempr = list0_map2<int, int><int>(shiftr, acc, lam(x, y) => x + y)
  val templ = list0_map2<int, int><int>(shiftl, acc, lam(x, y) => x + y)
in
  list0_map2(tempr, templ, lam(x, y) => if x > y then x else y)
end


(* ****** ****** *)

#define :: cons0

implement
main0() = ()
where
{
  val l1 = 3 :: nil0()
  val l2 = 7 :: 4 :: nil0()
  val l3 = 2 :: 4 :: 6 :: nil0()
  val l4 = 8 :: 5 :: 9 :: 3 :: nil0()
  val tr = l1 :: l2 :: l3 :: l4 :: nil0()
  val res = max_path(tr)
  val () = println!("Max path in triangle is ", res)
}

(* ****** ****** *)

(* end of [template.dats] *)