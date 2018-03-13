(* ****** ****** *)
//
// LG 2018-03-04
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

typedef int2 = (int, int)

(* ****** ****** *)

extern
fun
theNats(i:int): stream(int)

extern
fun
theNats2(nats: stream(int)): stream(stream(int2))

extern
fun
read_loop(xs: stream_vt(string), nats2: stream(int2)): void

(* ****** ****** *)

implement
theNats(i: int) = $delay
(
stream_cons(i, theNats(i + 1))
)

implement
theNats2(nats) = let
  fun tuple(i: int, j:int, res: stream(int2)): stream(int2) =
    if i - j < 0 then res
    else tuple(i, j + 1, $delay( stream_cons((i - j, j), res) ))
in
  case- !nats of
  | stream_cons(n, nats) => $delay( stream_cons(tuple(n, 0, $delay( stream_nil() )), theNats2(nats)) )
end

implement
read_loop(xs, nats2) = 
case+ !xs of
| ~stream_vt_nil() => ()
| ~stream_vt_cons(x, xs) => 
  let
    val-stream_cons(n2, nats2) = !nats2
  in
    (println!("(", n2.0, ", ", n2.1, ")") ; read_loop(xs, nats2))
  end

(* ****** ****** *)

implement
main0() = ()
where 
{
  val Nats = theNats(0)
  val Nats2 = theNats2(Nats)
  val () = println!("Press ENTER for next diagonal - Ctrl-C to quit")
  val () = read_loop(streamize_fileref_line(stdin_ref), stream_concat(Nats2))
}

(* ****** ****** *)

(* end of [nats2.dats] *)