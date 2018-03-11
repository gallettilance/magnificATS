(* ****** ****** *)
//
// LG 2018-03-10
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
mul35(n: int): int

(* ****** ****** *)

implement
mul35(n) = let
  fun union(i: int, res: int): int =
    if i = n then res
    else
    ( 
      if i % 3 = 0 orelse i % 5 = 0 
      then union(i + 1, res + i)
      else union(i + 1, res)
    )
  
  fun inter(i: int, res: int): int =
    if i = n then res
    else
    (
      if i % 3 = 0 andalso i % 5 = 0 
      then inter(i + 1, res + i)
      else inter(i + 1, res)
    )
in
  union(1, 0)
end 

(* ****** ****** *)

implement
main0() = ()
where
{
  val () = println!("Number of mult35 below 10 = ", mul35(10))
  val () = println!("Number of mult35 below 1000 = ", mul35(1000))
}

(* ****** ****** *)

(* end of [mul35.dats] *)