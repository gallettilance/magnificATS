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

extern
fun
even_fib_sum(n: int): int

(* ****** ****** *)

implement
fibo(n) = let
  val () = assertloc(n >= 0)
  
  fun helper
  (i: int, curr: int, next: int): int =
      if i = n then curr
      else helper(i + 1, next, curr + next)

in
  helper(0, 1, 2)
end // end of [fibo]

implement
even_fib_sum(n) = let
  fun aux(i: int, sum: int): int = let
      val fi = fibo(i)
    in
      if fi > n then sum
      else
      (
        if fi % 2 = 0 then aux(i + 1, sum + fi)
        else aux(i + 1, sum)
      )
    end
in
  aux(0, 0)
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val () = println!("Number of even fibs below 4 million = ", even_fib_sum(4000000))}

(* ****** ****** *)

(* end of [fibo.dats] *)