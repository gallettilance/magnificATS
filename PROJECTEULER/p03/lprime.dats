(* ****** ****** *)
//
// LG 2018-03-10
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
theNats(n: intinf): stream_vt(intinf)

extern
fun
sieve(nats: stream_vt(intinf)): stream_vt(intinf)

extern
fun
lprime(n: intinf, ps: stream_vt(intinf), max: intinf): intinf

extern
fun
char2intinf(c: char): intinf

extern
fun
make_intinf(s: string): intinf

(* ****** ****** *)

implement
theNats(n) = $ldelay
(
  stream_vt_cons(n, theNats(n + intinf(1)))
)

implement
sieve(nats) = 
case- !nats of
| ~stream_vt_cons(n, nats) => $ldelay
    ( 
      let
        val rnats = nats
      in
        stream_vt_cons(n, 
        stream_vt_filter_cloptr<intinf>(sieve(rnats), lam(i) => compare(i % n, intinf(0)) != 0) )
      end
      ,
      ~nats // free nats
    )

implement
lprime(n, ps, max) =
case- !ps of
| ~stream_vt_cons(p, ps) => 
        if compare(n, p) < 0 then (~ps; max)
        else 
        (
          if compare(n % p, intinf(0)) = 0 then (println!("Found = ", p); lprime(n, ps, p))
          else lprime(n, ps, max)
        )

implement
char2intinf(c) =
case+ c of
| '0' => intinf(0)
| '1' => intinf(1)
| '2' => intinf(2)
| '3' => intinf(3)
| '4' => intinf(4)
| '5' => intinf(5)
| '6' => intinf(6)
| '7' => intinf(7)
| '8' => intinf(8)
| '9' => intinf(9)
| _ => (println!("not a valid char"); intinf(~1))

implement
make_intinf(s) = let
  val xs = string_explode(s)
  
  fun aux(xs: list0(char), res: intinf): intinf =
    case+ xs of
    | list0_nil() => res
    | list0_cons(x, xs) => aux(xs, (res * intinf(10)) + char2intinf(x))
in
  aux(xs, intinf(0))
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val n = make_intinf("600851475143")
  val () = println!("n = ", n)
  val primes = sieve(theNats(intinf(2)))
  val lp = lprime(n, primes, intinf(2))
  val () = println!("Largest prime factor of ", n, " is ", lp)
}

(* ****** ****** *)

(* end of [lprime.dats] *)