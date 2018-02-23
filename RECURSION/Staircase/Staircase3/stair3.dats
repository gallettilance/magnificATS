(* ****** ****** *)
//
// LG 2018-02-15
//
// Staircase 3:
// Given a staircase of size N
// find the number of ways to
// go up the staircase if at
// every step you can only go
// either to the next step or
// to the third next step (i.e.
// by skipping the next two)
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
staircase(n : int) : int

(* ****** ****** *)

implement
staircase(n) = let
  val () = assertloc(n >= 0)
  
  fun helper
  (i: int, prev2: int, prev1: int, curr: int): int =
      if i > n then curr
      else helper(i + 1, prev1, curr, curr + prev2)

in
  helper(0, 0, 0, 1)
end // end of [staircase]

(* ****** ****** *)

implement
main0(argc, argv) = let
//
  val input = (if (argc >= 2) then g0string2int_int(argv[1]) else 10): int
//
in
  println!("staircase(", input, ") = ", staircase(input))
end

(* ****** ****** *)

(* end of [stair3.dats] *)