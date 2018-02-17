(* ****** ****** *)
//
// LG 2018-02-17
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
drop(xs: list0(int), i:int) : list0(int)

extern
fun
take(xs: list0(int), i:int): list0(int)

extern
fun
swap(xs: list0(int), i:int, j:int): list0(int)

extern
fun
permutate
(xs: list0(int), p1: int, p2: int): list0(int)

extern
fun
find_pivot(xs: list0(int)): int

extern
fun
perm(xs: list0(int)): list0(int)

(* ****** ****** *)

implement
take(xs, i) = let
  fun helper(xs: list0(int), i: int, res: list0(int)): list0(int) =
    if i = 0 then list0_reverse(res)
    else let val-cons0(x, xs) = xs in helper(xs, i - 1, cons0(x, res)) end
in
  helper(xs, i, nil0())
end

implement
drop(xs, i) = 
  case+ xs of
  | nil0() => nil0()
  | cons0(x, xs1) => if i = 0 then xs else drop(xs1, i - 1)

implement
swap(xs, i, j) =
list0_append(
  list0_append(
    list0_append(
      list0_append(
          take(xs, i-1),
          take(drop(xs, j-1), 1)
          ), take(drop(xs, i), j - i - 1)
          ), take(drop(xs, i - 1), 1)
          ), drop(xs, j))
          
implement
permutate(xs, p1, p2) =
  if xs[p1 - 1] > xs[p2] then permutate(xs, p1, p2 -1)
  else (let val ys = swap(xs, p1, p2 + 1) in list0_append( take(ys, p1), list0_reverse( drop(ys, p1) )) end)

implement
find_pivot(xs) = let
  val n = list0_length(xs)
  
  fun helper(xs: list0(int), i:int): int =
    if i = 0 then i
    else (if xs[i] > xs[i - 1] then i 
          else helper(xs, i - 1))
in
  helper(xs, n-1)
end

implement
perm(xs) = let 
  val pivot = find_pivot(xs)
  val n = list0_length(xs)
  
  fun isrev(xs: list0(int)): bool =
    case+ xs of 
    | nil0() => true
    | cons0(x1, xs1) =>
        case+ xs1 of
        | nil0() => true
        | cons0(x2, xs2) => if x1 < x2 then false else isrev(xs1)

in
  case+ xs of
  | nil0() => nil0()
  | _ => if isrev(xs) then nil0() 
         else permutate(xs, pivot, n - 1)
end

(* ****** ****** *)

fun
print_lst(xs: list0(int)) :void =
case+ xs of
| nil0() => ()
| cons0(x, xs) => let
    val () = print!(x, " ")
  in
    print_lst(xs)
  end

implement
main0() = () 
where
{
val xs = cons0(1, cons0(2, cons0(3, cons0(4, nil0()))))
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
val () = println!("Next Permutation = ")
val xs = perm(xs)
val () = print_lst(xs)
val () = println!()
}

(* ****** ****** *)

(* end of [perm.dats] *)