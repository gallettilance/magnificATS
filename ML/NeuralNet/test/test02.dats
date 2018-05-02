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
  val (X, Y) = make_mnist("../data/mnist_chunkaa")
  //val () = println!("X = ")
  //val () = (X).foreach()(lam(x) => println!(x))
  //val () = println!()
  val () = println!("X.shape = (", matrix_get_row(X), ", ", matrix_get_col(X), ")")
  val () = println!()
  //val () = println!("Y = ", Y)
  val () = println!("Y.shape = (", matrix_get_row(Y), ", ", matrix_get_col(Y), ")")
  val () = println!()

  val (who, wih) = NN_mnist_sigmoid(X, Y, 200, 0.1, 10)
  val () = println!()
  val () = println!("done training")
  val predictions = query_mnist(X, wih, who)
  //val () = println!("predictions = ", predictions)
  val error = query_mnist_error(predictions, Y)
  val num_errors = list0_foldleft<double>(error, 0.0, lam(res, x) => if x != 0.0 then res + 1.0 else res)
  val error_rate = num_errors / list0_length(error)
  val () = println!()
  val () = println!("error rate = ", error_rate * 100, "%")
}
