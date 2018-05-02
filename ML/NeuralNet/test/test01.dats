(* ****** ****** *)
//
// For testing
// neural net
//
(* ****** ****** *)

#include "./../mylibies.dats"

(* ****** ****** *)

implement
main0() = ()
where
{
  val (X, Y) = make_iris("../data/iris.csv")
  val () = println!("X = ")
  val () = (X).foreach()(lam(x) => println!(x))
  val () = println!()
  val () = println!("X.shape = (", matrix_get_row(X), ", ", matrix_get_col(X), ")")
  val () = println!()
  val () = println!("Y = ", Y)
  val () = println!("Y.shape = (", list0_length(Y), ", ", 1, ")")
  val () = println!()

  val w = NN_iris_sigmoid(X, Y, 1000)
  val () = println!()
  val predictions = query_iris(X, w)
  val () = println!("predictions = ", predictions)
  val error = query_iris_error(predictions, Y)
  val () = println!()
  val () = println!("error = ", error)
}

(* ****** ****** *)

(* end of [test01.dats] *)