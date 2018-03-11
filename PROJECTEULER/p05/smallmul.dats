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
theNats(n: int): stream_vt(int)

extern
fun
smallmul(nats: stream_vt(int), i: int): stream_vt(int)

extern
fun
test(n: int, i:int): bool

(* ****** ****** *)

implement
test(n, i) = 
if i <= 1 then true
else if n % i = 0 then test(n, i - 1) else false

implement
theNats(n) = $ldelay
(
  stream_vt_cons(n, theNats(n + 1))
)

implement
smallmul(nats, i) = stream_vt_filter_cloptr(nats, lam(n) => $effmask_all(test(n, i)))

(* ****** ****** *)

implement
main0() = ()
where
{
  val nats = theNats(2519)
  val sm20 = smallmul(nats, 20)
  val-~stream_vt_cons(n20, sm) = !sm20
  val () = println!("Smallest Multiple of 1-20 = ", n20); 
  val () = ~sm
}

(* ****** ****** *)

(* end of [smallmul.dats] *)