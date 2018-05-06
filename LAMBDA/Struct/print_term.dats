(* ****** ****** *)
//
// LG 2018-02-12
//
(* ****** ****** *)

#include "./struct.dats"

(* ****** ****** *)

extern
fun
print_term(t0: term): void // stdout
and
prerr_term(t0: term): void // stderr

extern
fun
fprint_term(out: FILEref, t0: term): void

extern
fun
myprint(out: FILEref, xs: list0(term)): void

(* ****** ****** *)

overload print with print_term
overload prerr with prerr_term
overload fprint with fprint_term

(* ****** ****** *)

implement
print_term(t0) =
fprint_term(stdout_ref, t0)
implement
prerr_term(t0) =
fprint_term(stderr_ref, t0)

(* ****** ****** *)

implement
fprint_val<term> = fprint_term

implement
myprint(out, xs) = 
case+ xs of
| nil0() => ()
| cons0(x, xs) =>
  case+ xs of
  | nil0() => (fprint!(out, x); myprint(out, xs))
  | cons0(_, _) => (fprint!(out, x, " "); myprint(out, xs))

(* ****** ****** *)

implement
fprint_term(out, t0) =
(
case+ t0 of
//
| TMint(i) =>
  fprint!(out, "(TMint ", i, ")")
//
| TMstr(s) =>
  fprint!(out, "(TMstr ", s, ")")
//
| TMtup(xs) =>
  (fprint!(out, "(TMtup "); myprint(out, xs); fprint!(out, ")"))
//
| TMvar(x) =>
  fprint!(out, "(TMvar ", x, ")")
//
| TMproj(x, i) =>
  fprint!(out, "(TMproj ", x, " ", i, ")")
| TMlam(x, t) =>
  fprint!(out, "(TMlam ", x, " ", t, ")")
| TMapp(t1, t2) =>
  fprint!(out, "(TMapp ", t1, " ", t2, ")")
//
| TMopr(opr, ts) =>
  (fprint!(out, "(TMopr ", opr, " "); myprint(out, ts); fprint!(out, ")"))
//
| TMfix(f, x, t) =>
  fprint!(out, "(TMfix ", f, " ", x, " ", t, ")")
//
| TMifnz(t1, t2, t3) =>
  fprint!(out, "(TMifnz ", t1, " ", t2, " ", t3, ")")
//
| TMseq(t1, t2) =>
  fprint!(out, "(TMseq ", t1, " ", t2, ")")
)

(* ****** ****** *)

(* end of [print_term.dats] *)