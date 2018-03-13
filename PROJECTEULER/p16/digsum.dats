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
pow2(n:int): intinf 

extern
fun
digsum(n: intinf): intinf

(* ****** ****** *)

implement
pow2(n) = let
  fun aux(i: int, res: intinf): intinf =
    if i >= n then res
    else aux(i + 1, intinf(2) * res)
in
  aux(1, intinf(2))
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
  val p = pow2(1000)
  val () = println!("p = ", p)
  val () = println!("Sum of digits of 2^1000 = ", digsum(p))
}

(* ****** ****** *)

(* end of [digsum.dats] *)