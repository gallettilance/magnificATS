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

(* ****** ****** *)

implement
fprint_term(out, t0) =
(
case+ t0 of
//
| TMint(i) =>
  fprint!(out, "TMint(", i, ")")
//
| TMstr(s) =>
  fprint!(out, "TMstr(", s, ")")
//
| TMtup(xs) =>
  fprint!(out, "TMtup(", xs, ")")
//
| TMvar(x) =>
  fprint!(out, "TMvar(", x, ")")
//
| TMproj(x, i) =>
  fprint!(out, "TMproj(", x, ", ", i, ")")
| TMlam(x, t) =>
  fprint!(out, "TMlam(", x, "; ", t, ")")
| TMapp(t1, t2) =>
  fprint!(out, "TMapp(", t1, "; ", t2, ")")
//
| TMopr(opr, ts) =>
  fprint!(out, "TMopr(", opr, "; ", ts)
//
| TMfix(f, x, t) =>
  fprint!(out, "TMfix(", f, ", ", x, "; ", t, ")")
//
| TMifnz(t1, t2, t3) =>
  fprint!(out, "TMifnz(", t1, "; ", t2, "; ", t3, ")")
//
| TMseq(t1, t2) =>
  fprint!(out, "TMseq(", t1, "; ", t2, ")")
)

(* ****** ****** *)

(* end of [print_term.dats] *)