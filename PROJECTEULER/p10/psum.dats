(* ****** ****** *)
//
// LG 2018-03-11
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
theNats(n: int): stream_vt(int)

extern
fun
sieve(nats: stream_vt(int)): stream_vt(int)

extern
fnx
psum(ps: stream_vt(int), max: int): intinf

extern
fun
{res:t@ype
}{a:t@ype}
stream_vt_foldleft
(
xs: stream_vt(a),
r0: res, fopr: cfun(res, a, res)
) : res // end-of-function
//
implement
{res}{a}
stream_vt_foldleft(xs, r0, fopr) =
(
//
case+ !xs of
| ~stream_vt_nil() => r0
| ~stream_vt_cons(x, xs) =>
   stream_vt_foldleft<res><a>(xs, fopr(r0, x), fopr)
//
) (* end of [stream_vt_foldleft] *)
//
(* ****** ****** *)

implement
theNats(n) = $ldelay
(
  stream_vt_cons(n, theNats(n + 1))
)

implement
sieve(nats) = $ldelay(
case- !nats of
| ~stream_vt_cons(n, nats) =>  
        stream_vt_cons(n, 
        stream_vt_filter_cloptr<int>(sieve(nats), lam(i) => i % n > 0 ))
      ,
      ~nats
)

implement
psum(ps, max) = let
  fun get_at(xs: stream_vt(int), res: stream_vt(int)): stream_vt(int) = let
      val-~stream_vt_cons(x, xs) = !xs 
    in
      if max < x then (~xs; res)
      else 
      (
        let
          val lres = $ldelay( stream_vt_cons(x, res), ~res)
        in
          get_at(xs, lres)
        end
      )
    end
in
  let 
    val xs = get_at(ps, $ldelay(stream_vt_nil()))
    val () = println!("done")
  in
    stream_vt_foldleft<intinf><int>(xs, intinf(0), lam(res, x) => intinf(x) + res)
  end
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val nats = theNats(2)
  val primes = sieve(nats)
  val sum = psum(primes, 2000000)
  val () = println!("Sum of primes below 2million is ", sum)
}

(* ****** ****** *)

(* end of [psum.dats] *)