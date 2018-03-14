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
gcd(a: int, b: int): int

extern
fun
last_digit(d: int): int

extern
fun
magic_number(d: int, ak: int): int

extern
fun
get_period(d: int): list0(int)

extern
fun
max_period(n: int, max: int, v: int): int

(* ****** ****** *)

implement
gcd(a, b) =
if b = 0 then a
else gcd(b, a % b)

implement
last_digit(d) = let
  fun aux(ak: int):<cloref1> int =
    if d*ak % 10 = 9 then ak
    else aux(ak + 1)
in
  aux(0)
end

implement
magic_number(d, ak) = ((d*ak) + 1)/ 10

implement
get_period(d) = let
  val ak = last_digit(d)
  val m = magic_number(d, ak)

  fun aux(carry: int, res: list0(int)):<cloref1> list0(int) = let
      val-cons0(r, rs) = res
      val nxt = carry + (r * m)
    in
      if carry = 0 andalso r = ak then rs
      else aux(nxt / 10, cons0(nxt % 10, res))
    end

in
  aux((m * ak) / 10, cons0((m * ak) % 10, cons0(ak, nil0())))
end

implement
max_period(n, max, v) = 
if gcd(n, 10) = 1
then  let
    val pn = list0_length(get_period(n))
  in
    if n <= 0 then v
    else 
    (
      if pn > max then max_period(n - 1, pn, n)
      else max_period(n - 1, max, v)
    )
  end
else
(
  if n <= 0 then v
  else max_period(n - 1, max, v)
)

(* ****** ****** *)

implement
main0() = ()
where
{
  val x = max_period(1000, 0, ~1)
  val () = println!("Integer with max period < 1000 is ", x)
}

(* ****** ****** *)

(* end of [cycles.dats] *)