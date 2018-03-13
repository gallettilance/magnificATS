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
fact(n: int): intinf

extern
fun
digsum(n: intinf): intinf

(* ****** ****** *)

implement
fact(n) = let
  fun aux(n: int, res: intinf): intinf =
    if n <= 1 then res
    else aux(n - 1, res * intinf(n))
in
  aux(n, intinf(1))
end

implement
digsum(n) = let
  fun aux(i: intinf, res: intinf): intinf =
    if compare(i, intinf(0)) = 0 then res
    else aux(i / intinf(10), res + (i % intinf(10)))
in
  aux(n, intinf(0))
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val () = println!("Sum of digits of 100! is ", digsum(fact(100)))
}

(* ****** ****** *)

(* end of [fact.dats] *)