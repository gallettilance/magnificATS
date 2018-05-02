(* ****** ****** *)
//
// For testing 
// helper functions 
//
(* ****** ****** *)

#include "./../mylibies.dats"

(* ****** ****** *)

implement
main0() = ()
where
{
val () = println!("Hello from [test00]!")
val () = println!()
val () = println!(" --- matrix.dats ---")

val v1 = cons0(1.0, cons0(0.0, cons0(0.0, nil0())))
val v2 = cons0(0.0, cons0(1.0, cons0(0.0, nil0())))
val v3 = cons0(0.0, cons0(0.0, cons0(1.0, nil0())))

val w1 = cons0(1.0, cons0(2.0, cons0(3.0, nil0())))
val w2 = cons0(4.0, cons0(5.0, cons0(6.0, nil0())))
val w3 = cons0(7.0, cons0(8.0, cons0(9.0, nil0())))

val W = cons0(w1, cons0(w2, cons0(w3, nil0()))) : matrix double
val I = cons0(v1, cons0(v2, cons0(v3, nil0()))) : matrix double

val tI = matrix_transpose<double>(I)
val tW = matrix_transpose<double>(W)

val () = println!("Test 0 - Identity Matrix transpose ...")
val () = println!()
val () = println!("I = ")
val () = I.foreach()(lam(row) => println!("    ", row))
val () = println!("transpose(I) = ")
val () = tI.foreach()(lam(row) => println!("    ", row))
val () = println!()
val () = println!("W = ")
val () = W.foreach()(lam(row) => println!("    ", row))
val () = println!("transpose(W) = ")
val () = tW.foreach()(lam(row) => println!("    ", row))
val () = println!()

val II = dot_matrix_matrix(I, I)
val () = println!("Test 1 - Identity Matrix squared ...")
val () = println!("I * I = ")
val () = II.foreach()(lam(row) => println!("    ", row))
val () = println!()

val IW = dot_matrix_matrix(I, W)
val WI = dot_matrix_matrix(W, I)

val () = println!("Test 2 - matrix multiplication by Identity Matrix ...")
val () = println!("I * W = ")
val () = IW.foreach()(lam(row) => println!("    ", row))
val () = println!()
val () = println!("W * I = ")
val () = WI.foreach()(lam(row) => println!("    ", row))
val () = println!()

val Iw1 = dot_matrix_vector(I, w1)
val Iw2 = dot_matrix_vector(I, w2)
val Iw3 = dot_matrix_vector(I, w3)

val () = println!("Test 3 - vector multiplication by Identity Matrix ...")
val () = println!("I * w1 = ")
val () = Iw1.foreach()(lam(elm) => print!(elm, " "))
val () = println!()
val () = println!("I * w2 = ")
val () = Iw2.foreach()(lam(elm) => print!(elm, " "))
val () = println!()
val () = println!("I * w3 = ")
val () = Iw3.foreach()(lam(elm) => print!(elm, " "))
val () = println!()

val IW = matrix_matrix_pairwise_add<double>(I, W)
val WI = matrix_matrix_pairwise_add<double>(W, I)
val WW = matrix_matrix_pairwise_add<double>(W, W)

val () = println!("Test 4 - matrix_matrix_pairwise_add ...")
val () = println!("W = ")
val () = IW.foreach()(lam(row) => println!("    ", row))
val () = println!()
val () = println!("W = ")
val () = WI.foreach()(lam(row) => println!("    ", row))
val () = println!()
val () = println!("W = ")
val () = WW.foreach()(lam(row) => println!("    ", row))


val () = println!("Test 5 - dot_cvector_rvector ...")
val v = cons0(1.0, cons0(2.0, cons0(3.0, nil0()))) : vector double
val w = cons0(4.0, cons0(5.0, cons0(6.0, nil0()))) : vector double
val () = println!("v = ", v)
val () = println!()
val () = println!("w = ", w)
val () = println!()
val () = println!("v * w = ")
val vw = dot_cvector_rvector(v, w)
val () = (vw).foreach()(lam(row) => println!("    ", row))



val () = println!()
val () = println!(" --- stats.dats ---")

val x = 0.0
val y = 0.5
val z = ~0.5

val expx = exponential(x)
val expy = exponential(y)
val expz = exponential(z)

val () = println!("exp(", x, ") = ", expx)
val () = println!("exp(", y, ") = ", expy)
val () = println!("exp(", z, ") = ", expz)

val sigx = sigmoid(x)
val sigy = sigmoid(y)
val sigz = sigmoid(z)

val () = println!("sigmoid(", x, ") = ", sigx)
val () = println!("sigmoid(", y, ") = ", sigy)
val () = println!("sigmoid(", z, ") = ", sigz)

val Divx = sigDiv(x)
val Divy = sigDiv(y)
val Divz = sigDiv(z)

val () = println!("sigDiv(", x, ") = ", Divx)
val () = println!("sigDiv(", y, ") = ", Divy)
val () = println!("sigDiv(", z, ") = ", Divz)


} (* end of [main0] *)

(* ****** ****** *)

(* end of [test00.dats] *)