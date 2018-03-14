(* ****** ****** *)
//
// LG 2018-03-12
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

#include
"$PATSHOMELOCS\
/atscntrb-hx-intinf/mylibies.hats"

#include
"$PATSHOMELOCS\
/atscntrb-hx-mytesting/mylibies.hats"

(* ****** ****** *)

typedef
intinf = $GINTINF_t.intinf

overload
print with $GINTINF_t.print_intinf

(* ****** ****** *)

val intinf = gnumber_int<intinf>

(* ****** ****** *)

val gadd = gadd_val_val<intinf>
val gsub = gsub_val_val<intinf>
val gmul = gmul_val_val<intinf>
val gdiv = gdiv_val_val<intinf>
val gcompare = gcompare_val_val<intinf>

overload * with gmul
overload + with gadd
overload / with gdiv
overload - with gsub
overload compare with gcompare

fun
gmod(x: intinf, y: intinf) = x - (x / y)  * y

overload % with gmod

(* ****** ****** *)

extern
fun
fibo(n: intinf): intinf

extern
fun
num_dig(n: intinf): int

extern
fun
find(n:intinf): intinf

(* ****** ****** *)

implement
num_dig(n) = let
  fun aux(i: intinf, res: int): int =
    if compare(i, intinf(0)) > 0 then aux(i / intinf(10), res + 1)
    else res
in
  aux(n, 0)
end

implement
fibo(n) = let
  fun aux(i: intinf, prev: intinf, curr: intinf): intinf =
    if compare(n, i) <= 0  then curr
    else aux(i + intinf(1), curr, prev + curr)
in
  aux(intinf(1), intinf(0), intinf(1))
end

implement
find(n) = let
  val fibn = fibo(n)
  val ndf = num_dig(fibn)
in
  if ndf >= 1000
  then n
  else find(n + intinf(1))
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val () = println!("The index of the 1st fibonacci with 1000 digits is ", find(intinf(1)))
}

(* ****** ****** *)

(* end of [fibo.dats] *)