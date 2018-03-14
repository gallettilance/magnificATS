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
nats(n: int): list0(int)

extern
fun
sum_divs(n: int): int

extern
fun
abundant(n: int, abunds: list0(int)): bool

(* ****** ****** *)

implement
nats(n) = 
if n <= 0 then nil0()
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
abundant(n, abunds) = let
  val abd = abunds
    
  fun loop(xs: list0(int), y: int): bool =
    case+ xs of
    | nil0() => false
    | cons0(x, xs) =>
          if x > y then false
          else
          ( 
            if x = y then true 
            else loop(xs, y)
          )
            
  fun looploop(xs: list0(int)): bool = 
    case+ xs of
    | nil0() => false
    | cons0(x, xs) => 
          if loop(abd, n - x) then true 
          else looploop(xs)
in
  looploop(abunds)
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val ns = list0_reverse(nats(28123))
  val dns = list0_map<int><int>(ns, lam(n) => sum_divs(n))
  val abunds = list0_filter(list0_map2<int, int><int>(ns, dns, lam(n, dn) => if n < dn then n else 0), lam(x) => x > 0)
  //val () = println!("Abundant Numbers are ", abunds)
  val xs = list0_filter(ns, lam(n) => ~abundant(n, abunds))
  //val () = println!("Integers that can be expressed as the sum of two abundant numbers are ", xs)
  val () = println!("Their sum is ", list0_foldleft<int>(xs, 0, lam(res, x) => (println!("res = ", res); x + res)))
}

(* ****** ****** *)

(* end of [abundant.dats] *)