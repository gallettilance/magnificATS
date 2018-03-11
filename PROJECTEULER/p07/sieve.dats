(* ****** ****** *)
//
// LG 2018-03-11
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
theNats(i:int): stream_vt(int)

extern
fun
sieve(nats: stream_vt(int)): stream_vt(int)

extern
fun
get_at(n: int, xs: stream_vt(int)): int

(* ****** ****** *)

implement
theNats(i: int) = $ldelay
(
  stream_vt_cons(i, theNats(i + 1))
)

implement
sieve(nats) = $ldelay
(
case- !nats of
| ~stream_vt_cons(n, nats) => 
      let
        val rnats = nats
      in
        stream_vt_cons(n, 
        stream_vt_filter_cloptr<int>(sieve(rnats), lam(i) => i % n > 0) )
      end
      ,
      ~nats // free nats
)

implement
get_at(n, xs) = let
  fnx aux(i: int, xs: stream_vt(int)):<cloref1> int =
    case- !xs of
    | ~stream_vt_cons(x, xs) => if i >= n then (~xs; n) else aux(i + 1, xs)
in
  aux(1, xs)
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val primes = sieve(theNats(2))
  val p = get_at(100001, primes)
  val () = println!("The 10001th prime is ", p)
}

(* ****** ****** *)

(* end of [sieve.dats] *)