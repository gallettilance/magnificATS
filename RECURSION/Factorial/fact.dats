(* ****** ****** *)
//
// LG 2018-03-30
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
fact(n : int) : int

(* ****** ****** *)

implement
fact(n) = let
  val () = assertloc(n >= 0)
  
  fun helper
  (i: int, res: int): int =
      if i > 0 
      then helper(i - 1, res * i)
      else res
in
  helper(n, 1)
end // end of [fact]

(* ****** ****** *)

implement
main0(argc, argv) = let
//
  val input = (if (argc >= 2) then g0string2int_int(argv[1]) else 10): int
//
in
  println!("fact(", input, ") = ", fact(input))
end

(* ****** ****** *)

(* end of [fact.dats] *)