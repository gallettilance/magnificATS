(* ****** ****** *)
//
// LG 2018-03-30
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

datatype FIB(int, int) = 
  | FIB0(0, 0) of ()
  | FIB1(1, 1) of ()
  | {n:int | n >= 2}{r1,r2:int}
    FIB2(n, r1 + r2) of (FIB(n - 1, r1), FIB(n - 2, r2))

(* ****** ****** *)

extern
fun
print_FIB
{n,r: int}
(pf: FIB(n, r)): void

extern
fun
fprint_FIB
{n,r: int}
(out: FILEref, pf: FIB(n, r)): void

overload print with print_FIB
overload fprint with fprint_FIB

(* ****** ****** *)

implement
print_FIB(pf) = fprint_FIB(stdout_ref, pf)

implement
fprint_FIB(out, pf0) = 
(
case+ pf0 of
| FIB0() => fprint(out, "FIB0()")
| FIB1() => fprint(out, "FIB1()")
| FIB2(pf1, pf2) => fprint!(out, "FIB2(", pf1, ", ", pf2, ")")
)

(* ****** ****** *)

extern
fun
fib
{n: int | n >= 0}  (* {} -> for all *)
(i: int(n)): [r: int] (* [] -> there exists *) (FIB(n, r) , int(r))

(* ****** ****** *)

implement
fib(i) = 
ifcase
| i = 0 => (FIB0() , 0)
| i = 1 => (FIB1() , 1)
| _ => let
    val res1 = fib(i - 1)
    val res2 = fib(i - 2)
  in
    (FIB2(res1.0, res2.0) , res1.1 + res2.1)
  end

(* ****** ****** *)

implement
main0() = ()
where
{
  val i = 5
  val fibi = fib(i)
  val () = println!("fib(", i, ") = ", fibi.1)
  val () = println!("Proof of fib(", i, ") = ", fibi.0)
}

(* ****** ****** *)

(* end of [fibopf.dats] *)