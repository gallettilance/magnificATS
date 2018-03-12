(* ****** ****** *)
//
// LG 2018-03-12
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
nats(n: int): stream(int)

extern
fun
triangulars(n: stream(int)): stream(int)

extern
fun
num_divs(i: int): int

extern
fun
div_check(i: int): bool

(* ****** ****** *)

implement
nats(n) = $delay
(
  stream_cons(n, nats(n + 1))
)

implement
triangulars(nats) = 
case- !nats of
| stream_cons(n, nats) => 
      $delay(stream_cons(n*(n + 1) / 2, triangulars(nats)))
      
implement
num_divs(i) = let
  fun aux(n: int, res: int): int =
    if n > i then res
    else 
    (
      if i % n = 0 
      then aux(n + 1, res + 1)
      else aux(n + 1, res)
    )
in
  aux(1, 0)
end

implement
div_check(i) = 
  num_divs(i) >= 500

(* ****** ****** *)

implement
main0() = ()
where
{
  val nats = nats(1)
  val tris = triangulars(nats)
  val div500 = stream_filter(tris, lam(t) => $effmask_all(div_check(t)))
  val-stream_cons(d, div500) = !div500
  val () = println!("Frist Triangular Number with more than 500 divisors is ", d)
}

(* ****** ****** *)

(* end of [triang.dats] *)