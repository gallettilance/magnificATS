(* ****** ****** *)
//
// LG 2018-03-30
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

datatype FACT(int, int) = 
  | FACT0(0, 1) of ()
  | {n:int | n >= 1}{r:int}
    FACT1(n, r * n) of (FACT(n - 1, r))

(* ****** ****** *)

extern
fun
print_FACT
{n,r: int}
(pf: FACT(n, r)): void

extern
fun
fprint_FACT
{n,r: int}
(out: FILEref, pf: FACT(n, r)): void

overload print with print_FACT
overload fprint with fprint_FACT

(* ****** ****** *)

implement
print_FACT(pf) = fprint_FACT(stdout_ref, pf)

implement
fprint_FACT(out, pf0) = 
(
case+ pf0 of
| FACT0() => fprint(out, "FACT0()")
| FACT1(pf1) => fprint!(out, "FACT2(", pf1, ")")
)

(* ****** ****** *)

extern
fun
fact
{n: int | n >= 0}  (* {} -> for all *)
(i: int(n)): [r: int] (* [] -> there exists *) (FACT(n, r) , int(r))

(* ****** ****** *)

implement
fact(i) = 
ifcase
| i = 0 => (FACT0() , 1)
| _ => let
    val prev = fact(i - 1)
  in
    (FACT1(prev.0) , i * prev.1)
  end

(* ****** ****** *)

implement
main0() = ()
where
{
  val i = 5
  val facti = fact(i)
  val () = println!("fact(", i, ") = ", facti.1)
  val () = println!("Proof of fact(", i, ") = ", facti.0)
}

(* ****** ****** *)

(* end of [factpf.dats] *)