(* ****** ****** *)
//
// LG 2018-03-11
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
diff(n: int): int

(* ****** ****** *)

implement
diff(n) = let
  fun form(i: int): int =
    i*i*i
  
  fun aux(i:int, df: int): int =
    if i >= n
    then df
    else (println!("i = ", i, " diff = ", df); aux(i + 1, df + form(i+1) - (i+1)*(i+1)))
in
  aux(1, 0)
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val () = println!("Difference between sum of sq and sq of sum of 1-100 = ", diff(100))
}

(* ****** ****** *)

(* end of [smallmul.dats] *)