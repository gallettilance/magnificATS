(* ****** ****** *)
//
// LG 2018-03-01
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
theNats(i:int): stream(int)

extern
fun
sieve(nats: stream(int)): stream(int)

extern
fun
read_loop(xs: stream_vt(string), primes: stream(int)): void

(* ****** ****** *)

implement
theNats(i: int) = delay
(
stream_cons(i, theNats(i + 1))
)

implement
sieve(nats) = delay
(
case- !nats of
| stream_cons(n, nats) => stream_cons(n, stream_filter(sieve(nats), lam(i) => i % n > 0))
)

implement
read_loop(xs, primes) =
case+ !xs of
| ~stream_vt_nil() => ()
| ~stream_vt_cons(x, xs) => 
  let
    val-stream_cons(p, primes) = !primes
  in
    (println!(p) ; read_loop(xs, primes))
  end

(* ****** ****** *)

implement
main0() = ()
where 
{
  val Nats = theNats(2)
  val Primes = sieve(Nats)
  val-stream_cons(p, Primes) = !Primes
  val () = println!(p)
  val () = println!("Press ENTER for next prime - Ctrl-C to quit")
  val () = read_loop(streamize_fileref_line(stdin_ref), Primes)  
}

(* ****** ****** *)

(* end of [fibo.dats] *)