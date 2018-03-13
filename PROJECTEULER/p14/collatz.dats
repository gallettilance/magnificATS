(* ****** ****** *)
//
// LG 2018-03-13
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
collatz(n:int): int

extern
fnx
search_coll(n: int, max: int, start: int): int

(* ****** ****** *)

implement
collatz(n) = let
  fnx aux(i: intinf, len: int): int =
    if compare(i, intinf(1)) = 0 then len + 1
    else 
    (
      if compare(i % intinf(2), intinf(0)) = 0
      then aux(i / intinf(2), len + 1)
      else aux((intinf(3) * i) + intinf(1), len + 1)
    )
in
  aux(intinf(n), 0)
end

implement
search_coll(n, max, start) =
if n <= 1 then start
else
(
  let
    val len = collatz(n)
  in
    if len > max then (println!("current max = ", len, " for n = ", n); search_coll(n - 1, len, n))
    else search_coll(n - 1, max, start)
  end
)

(* ****** ****** *)

implement
main0() = ()
where
{
  val s = search_coll(1000000, 1, 1)
  val () = println!("The starting number, under one million, that produces the longest chain is ", s)
}

(* ****** ****** *)

(* end of [collatz.dats] *)