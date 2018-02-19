(* ****** ****** *)
//
// LG 2018-02-15
//
// Staircase M:
// Given a staircase of size N
// find the number of ways to
// go up the staircase if at
// every step you can only go
// either to the next step or
// to the Mth next step (i.e.
// by skipping the next M-1)
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
{a:t@ype}
get_last(xs : list0(a)) : a

extern
fun
{a:t@ype}
append(xs : list0(a), x : a) : list0(a)

(* ****** ****** *)

implement
{a}
get_last(xs) = let
  exception Empty

  fun helper(ys : list0(a), y: a) : a =
    case+ ys of
    | list0_nil() => y
    | list0_cons(y, ys) => helper(ys, y)

in
  case+ xs of
  | list0_nil() => $raise Empty()
  | list0_cons(x, xs) => helper(xs, x)
end

//

implement
{a}
append(xs, x) = let
  
  fun rev(ys : list0(a), res: list0(a)) : list0(a) =
      case+ ys of
      | list0_nil() => res
      | list0_cons(y, ys) => rev(ys, cons0(y, res))

in
  rev(cons0(x, rev(xs, nil0())), nil0())
end

(* ****** ****** *)

extern
fun
staircase(n : int, M : int) : int

(* ****** ****** *)

implement
staircase(n, M) = let
  val () = assertloc(n >= 0)
  val () = assertloc(M >= 0)
  
  fun helper
  (i : int, Mlst : list0(int)): int =
      if i > n then get_last<int>(Mlst)
      else if i < M then helper(i + 1, cons0(1, Mlst))
           else let 
              val-cons0(x, Mlst) = Mlst
              val last = get_last<int>(Mlst) :int
                in
                  helper(i + 1, append<int>(Mlst, x + last))
                end
                
in
  helper(0, nil0())
end // end of [staircase]

(* ****** ****** *)

implement
main0(argc, argv) = let
//
  val n = (if (argc >= 3) then g0string2int_int(argv[1]) else 10): int
  val M = (if (argc >= 3) then g0string2int_int(argv[2]) else 2): int
//
in
  println!("staircase(", n, ", ", M, ") = ", staircase(n, M))
end

(* ****** ****** *)

(* end of [stairM.dats] *)
