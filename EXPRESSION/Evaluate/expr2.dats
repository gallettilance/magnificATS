(* ****** ****** *)
//
// LG 2018-02-16
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"
#include "./../Struct/expr.dats"

(* ****** ****** *)

extern
fun
subst_expr(e0 : expr, x : int) : expr
//
extern
fun
eval_expr(e0 : expr) : int

(* ****** ****** *)

implement
subst_expr(e0, x) =
case+ e0 of
| Int(i) => e0
| X() => Int(x)
| Neg(e1) => Neg( subst_expr(e1, x) )
| Mul(e1, e2) => Mul( subst_expr(e1, x), subst_expr(e2, x) )
| Add(e1, e2) => Add( subst_expr(e1, x), subst_expr(e2, x) )
| Sub(e1, e2) => Sub( subst_expr(e1, x), subst_expr(e2, x) )
| Div(e1, e2) => Div( subst_expr(e1, x), subst_expr(e2, x) )

//

implement
eval_expr(e0) = 
case- e0 of
| Int(i) => i
| Neg(e1) => ~ eval_expr(e1)
| Mul(e1, e2) => eval_expr(e1) * eval_expr(e2)
| Add(e1, e2) => eval_expr(e1) + eval_expr(e2)
| Sub(e1, e2) => eval_expr(e1) - eval_expr(e2)
| Div(e1, e2) => eval_expr(e1) / eval_expr(e2)

(* ****** ****** *)

(* end of [expr2.dats] *)