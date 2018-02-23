(* ****** ****** *)
//
// LG 2018-02-22
//
(* ****** ****** *)

#include "./print_term.dats"

(* ****** ****** *)

extern
fun
print_value(t0: value): void
extern
fun
fprint_value(out: FILEref, t0: value): void

overload print with print_value
overload fprint with fprint_value

(* ****** ****** *)

implement
fprint_val<value> = fprint_value

(* ****** ****** *)

implement
print_value
(t0) = fprint_value(stdout_ref, t0)

implement
fprint_value(out, t0) =
(
case+ t0 of
//
| VALint(i) => fprint!(out, "VALint(", i, ")")
| VALstr(s) => fprint!(out, "VALstr(", s, ")")
//
| VALtup(vs) => fprint!(out, "VALtup(", vs, ")")
//
| VALlam(_, _) => fprint!(out, "VALlam(_, _)")
| VALfix(_, _) => fprint!(out, "VALfix(_, _)")
//
| VALunit() => fprint!(out, "VALunit()")
)

(* ****** ****** *)

(* end of [print_val.dats] *)