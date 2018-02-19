(* ****** ****** *)
//
// LG 2018-02-16
//
(* ****** ****** *)

#include "./equal.dats"

(* ****** ****** *)

implement
main0() = ()
where
{
val x = X()
val e0 = Mul(Int(2), Mul(Sub(Int(3), Int(1)), Int(1)))
val e1 = Add(x, Int(0))
val e2 = Mul(Int(2), Mul(e1, Int(1)))
val e3 = Mul(Int(0), Div(e2, Int(1)))
val e4 = Sub(e3, Int(0))
val e5 = Mul(Add(X(), Int(1)), Neg(Mul(e1, e1)))


val () = println!("x = ", x)
val () = println!("e0 = ", e0)
val () = println!("e5 = ", e1)
val () = println!("e1 = ", e2)
val () = println!("e2 = ", e3)
val () = println!("e3 = ", e4)
val () = println!("e4 = ", e5)

val () = println!()

val () = println!("degree of x = ", max_degree(x))
val () = println!("degree of e5 = ", max_degree(e0))
val () = println!("degree of e1 = ", max_degree(e1))
val () = println!("degree of e2 = ", max_degree(e2))
val () = println!("degree of e3 = ", max_degree(e3))
val () = println!("degree of e4 = ", max_degree(e4))
val () = println!("degree of e5 = ", max_degree(e5))

val () = println!()

val () = println!("x = x? ", equal_expr_expr(x, x))
val () = println!("e5 = x? ", equal_expr_expr(e5, x))
val () = println!("e1 = x? ", equal_expr_expr(e1, x))
val () = println!("e2 = e3? ", equal_expr_expr(e2, e3))
val () = println!("e3 = e4? ", equal_expr_expr(e3, e4))
val () = println!("e4 = e1? ", equal_expr_expr(e4, e1))
val () = println!("e5 = e0? ", equal_expr_expr(e5, e0))
}

(* ****** ****** *)

(* end of [tests.dats] *)