(* ****** ****** *)
//
// LG 2018-04-01
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
spiral(n: int): int

(* ****** ****** *)

implement
spiral(n) = let
  fun loop(i: int, res: int): int =
    if i > n then res
    else let
        val top_R = i * i
        val top_L = top_R - (i - 1)
        val bot_L = top_L - (i - 1)
        val bot_R = bot_L - (i - 1)
      in
        loop(i + 2, res + top_R + top_L + bot_L + bot_R)
      end
in
  loop(3, 1)
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val s = spiral(1001)
  val () = println!("The sum of the diagonals of a 1001 by 1001 spiral is ", s)
}

(* ****** ****** *)

(* end of [spiral.dats] *)