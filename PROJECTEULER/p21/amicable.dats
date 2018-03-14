(* ****** ****** *)
//
// LG 2018-03-13
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
nats(n: int): list0(int)

extern
fun
sum_divs(n: int): int

extern
fun
amicable(n: int): bool

(* ****** ****** *)

implement
nats(n) = 
if n <= 1 then nil0()
else cons0(n, nats(n - 1))
      
implement
sum_divs(n) = let
  fun aux(i: int, res: int): int =
    if i >= n then res
    else 
    (
      if n % i = 0 
      then aux(i + 1, res + i)
      else aux(i + 1, res)
    )
in
  aux(1, 0)
end

implement
amicable(a) = let
  val b = sum_divs(a)
  val db = sum_divs(b)
  val () = println!("a = ", a, ", b = ", b, " -> d(b) = ", db)
in
  if a != b 
  then
  (
    if db = a then true
    else false
  )
  else false
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val ns = nats(10000)
  val ams = list0_filter<int>(ns, lam(n) => amicable(n))
  val () = println!("All amicable numbers below 10000 are ", ams)
  val () = println!("Their sum is ", list0_foldleft<int>(ams, 0, lam(x, res) => x + res))
}

(* ****** ****** *)

(* end of [amicable.dats] *)