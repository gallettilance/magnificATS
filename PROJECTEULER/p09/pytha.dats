(* ****** ****** *)
//
// LG 2018-03-12
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

typedef int2 = (int, int)
typedef int3 = (int, int, int)

(* ****** ****** *)

extern
fun
theNats(i:int): stream_vt(int)

extern
fun
theNats2(nats: stream_vt(int)): stream_vt(stream_vt(int2))

extern
fun
theNats3(nats: stream_vt(int)): stream_vt(stream_vt(int3))

extern
fun
pythago(nats3: stream_vt(int3)): int3

(* ****** ****** *)

implement
theNats(i) = $ldelay
(
  stream_vt_cons(i, theNats(i + 1))
)

implement
theNats2(nats) = let
  fun diag(n: int, i: int): stream_vt(int2) = $ldelay
    (
      if i > n then stream_vt_nil()
      else stream_vt_cons((i, n-i), diag(n, i + 1))
    )    
in
  $ldelay
  (
    case- !nats of
    | ~stream_vt_cons(n, nats) =>
        stream_vt_cons(diag(n, 0), theNats2(nats))
        , ~nats
  )
end

implement
theNats3(nats) = let
  fun diag(n: int, i: int): stream_vt(int2) = $ldelay
    (
      if i > n then stream_vt_nil()
      else stream_vt_cons((i, n-i), diag(n, i + 1))
    )
  
  fun diag2(n: int, i: int): stream_vt(stream_vt(int3)) = $ldelay
    (
      if i > n then stream_vt_nil()
      else let
          val d1 = diag(n - i, 0)
          val d2 = stream_vt_map_cloptr<int2><int3>(d1, lam(d) => (i, d.0, d.1))
        in
          stream_vt_cons(d2, diag2(n, i + 1))
        end
    )
in
  $ldelay
  (
    case- !nats of
    | ~stream_vt_cons(n, nats) =>
        stream_vt_cons(stream_vt_concat<int3>(diag2(n, 0)), theNats3(nats))
        , ~nats
  )
end

implement
pythago(nats3) = let
  fun sum(n3: int3): int =
    n3.0 + n3.1 + n3.2
  
  fun test1(n3: int3): bool =
    n3.0 < n3.1 andalso n3.1 < n3.2
       
  fun test2(n3: int3): bool =
    (n3.0*n3.0) + (n3.1*n3.1) = (n3.2*n3.2)

  fun test3(n3: int3): bool =
    test1(n3) andalso test2(n3)
    
in
  case- !nats3 of
  | ~stream_vt_cons(n3, nats3) =>
      if sum(n3) < 1000 then pythago(nats3)
      else 
      (
        if sum(n3) > 1000 then (~nats3; println!("Not found"); (~1, ~1, ~1))
        else
        (
          if test3(n3) then (~nats3; n3)
          else pythago(nats3)
        )
      )
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val nats = theNats(0)
  val nats3 = stream_vt_concat<int3>(theNats3(nats))
  val n3 = pythago(nats3)
  val () = println!("(a, b, c) s.t a < b < c, a + b + c = 1000 and a^2 + b^2 = c^2 is (", n3.0, ", ", n3.1, ", ", n3.2, ")")
}

(* ****** ****** *)

(* end of [pytha.dats] *)