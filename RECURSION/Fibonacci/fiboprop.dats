(* ****** ****** *)
//
// LG 2018-03-30
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

dataprop FIB(int, int) = 
  | FIB0(0, 0) of ()
  | FIB1(1, 1) of ()
  | {n:int | n >= 2}{r1,r2:int}
    FIB2(n, r1 + r2) of (FIB(n - 1, r1), FIB(n - 2, r2))

(* ****** ****** *)

extern
fun
fib
{n: int | n >= 0}
(i: int(n)): [r: int] (FIB(n, r) | int(r))

(* ****** ****** *)

implement
fib{n}(i) = let

  fun aux
  {x:nat | x <= n}
  {r1,r2:int} 
  ( pf1: FIB(x + 1, r1)
  , pf2: FIB(x + 0, r2)
  | j: int(x), f1: int(r1), f2: int(r2)
  ) : [r: int] (FIB(n, r) | int(r)) =

    if j < i 
    then aux(FIB2(pf1, pf2), pf1 | j + 1, f1 + f2, f1)
    else (pf2 | f2)

in
  aux(FIB1(), FIB0() | 0, 1, 0)
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val i = 5
  val fibi = fib(i)
  val () = println!("fib(", i, ") = ", fibi.1)
}

(* ****** ****** *)

(* end of [fiboprop.dats] *)