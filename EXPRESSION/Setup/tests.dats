(* ****** ****** *)
//
// LG 2018-02-16
//
(* ****** ****** *)

#include "./expr.dats"

(* ****** ****** *)

implement
main0() = ()
where
{
val x = X()
val e1 = Add(x, Int(0))
val e2 = Mul(Int(2), Mul(e1, Int(1)))
val e3 = Mul(Int(0), Div(e2, e1))
val e4 = Sub(e3, Int(0))
val e5 = Neg(e1)

val () = println!("x = ", x)
val () = println!("simplfy_expr(x) = ", simplfy_expr(x))
val () = println!()
//
val () = println!("e1 = ", e1)
val () = println!("simplfy_expr(e1) = ", simplfy_expr(e1))
val () = println!()
//
val () = println!("e2 = ", e2)
val () = println!("simplfy_expr(e2) = ", simplfy_expr(e2))
val () = println!()
//
val () = println!("e3 = ", e3)
val () = println!("simplfy_expr(e3) = ", simplfy_expr(e3))
val () = println!()
//
val () = println!("e4 = ", e4)
val () = println!("simplfy_expr(e4) = ", simplfy_expr(e4))
val () = println!()
//
val () = println!("e5 = ", e5)
val () = println!("simplfy_expr(e5) = ", simplfy_expr(e5))
}

(* ****** ****** *)

(* end of [tests.dats] *)