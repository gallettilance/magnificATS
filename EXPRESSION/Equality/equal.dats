(* ****** ****** *)
//
// LG 2018-02-17
//
(* ****** ****** *)

#include "./../Struct/expr.dats"
#include "./../Evaluate/expr2.dats"

(* ****** ****** *)

extern
fun
max_degree(t0: expr): int

extern
fun
equal_expr_expr(t1: expr, t2: expr): bool

(* ****** ****** *)

implement
max_degree(t0) =
case+ t0 of
| Int(_) => 0
| X() => 1
| Neg(t1) => max_degree(t1)
| Mul(t1, t2) => let
    val m1 = max_degree(t1)
    val m2 = max_degree(t2)
  in
    m1 + m2
  end
| Add(t1, t2) => let
    val m1 = max_degree(t1)
    val m2 = max_degree(t2)
  in
    if m1 > m2 then m1 else m2
  end
| Sub(t1, t2) => let
    val m1 = max_degree(t1)
    val m2 = max_degree(t2)
  in
    if m1 > m2 then m1 else m2
  end
| Div(t1, t2) => let
    val m1 = max_degree(t1)
    val m2 = max_degree(t2)
  in
    m1 - m2
  end

implement
equal_expr_expr(t1, t2) = let
  val d1 = max_degree(t1)
  val d2 = max_degree(t2)
  
  fun helper(t1: expr, t2:expr, i: int): bool =
    if i < 0 then true
    else 
    (
    let
      val e1 = eval_expr(subst_expr(t1, i))
      val e2 = eval_expr(subst_expr(t2, i)) 
    in
      if e1 = e2 then helper(t1, t2, i - 1) else false
    end
    )
in
  if d1 > d2 then helper(t1, t2, d1) else helper(t1, t2, d2)
end

(* ****** ****** *)

(* end of [equal.dats] *)