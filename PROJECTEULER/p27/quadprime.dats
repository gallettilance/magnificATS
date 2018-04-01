(* ****** ****** *)
//
// LG 2018-03-14
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
is_prime(n: int): bool

extern
fun
num_quad(a: int, b: int): int

extern
fun
max_quad(): int 

(* ****** ****** *)

implement
is_prime(n) = let
  fun loop(i: int): bool =
    if i >= n
    then true
    else
    (
      if n % i = 0 
      then false
      else loop(i + 1)
    )
in
  if n < 2 then false
  else loop(2)
end

implement
num_quad(a, b) = let
  fun aux(n: int): int =
    if is_prime( (n*n) + (a*n) + b )
    then aux(n + 1)
    else n
in
  aux(0)
end


implement
max_quad() = let
  fun search(a:int, b: int, max: int, ab: int): int =
    if a >= 1000
    then search(~999, b + 1, max, ab)
    else
    (
      if b >= 1000 
      then ab
      else
      (
        let 
          val nq = num_quad(a, b)
          val () = println!("num_quad(", a, ", ", b, ") = ", nq)
        in 
          if nq > max
          then search(a + 1, b, nq, a * b)
          else search(a + 1, b, max, ab)
        end
      )
    )
in
  search(~999, 2, 0, ~999 * 2)
end


(* ****** ****** *)

implement
main0() = ()
where
{
  val maxq = max_quad()
  val () = println!("Product of the coefficients a, b that maximizes the number of primes for consecutive n is ", maxq)
}

(* ****** ****** *)

(* end of [quadprime.dats] *)