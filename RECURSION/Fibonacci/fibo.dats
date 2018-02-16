(* ****** ****** *)
//
// LG 2018-02-15
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
fibo(n : int) : int

(* ****** ****** *)

implement
fibo(n) = let
  val () = assertloc(n >= 0)
  
  fun helper
  (i: int, curr: int, next: int): int =
      if i = n then curr
      else helper(i + 1, next, curr + next)

in
  helper(0, 0, 1)
end // end of [fibo]

(* ****** ****** *)

implement
main0(argc, argv) = let
//
  val input = (if (argc >= 2) then g0string2int_int(argv[1]) else 10): int
//
in
  println!("fibo(", input, ") = ", fibo(input))
end

(* ****** ****** *)

(* end of [fibo.dats] *)