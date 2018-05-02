(* ****** ****** *)
//
// LG - 03-06
//
(* ****** ****** *)

extern
fun
NN_iris_sigmoid
( 
  X : matrix double
, Y : vector double
, epoch (* stop condition *): int
(*, lrate (* learning rate *) : double *)
(* , hidden (* hidden layers *) : int *)
(*, epoch (* times viewed dataset *) : int *)
) : vector double


extern
fun
query_iris
( x: matrix double
, w: vector double
) : vector double


extern
fun
query_iris_error
( pred: vector double
, Y: vector double
) : vector double


(* ****** ****** *)


implement
query_iris(X, w) = let
  val Xdotw = dot_matrix_vector(X, w)
  val pred = list0_map(Xdotw, lam(x) => sigmoid(x))
in
  pred
end        


implement
query_iris_error(pred, Y) = let
  val error = list0_map2<double,double><double>(Y, pred, lam(y, p) => y - p)
in
  error
end


implement
NN_iris_sigmoid(X, Y, epoch) = let

  val cols = matrix_get_col(X)
  val rows = matrix_get_row(X)
  val () = assertloc(cols = 4)
  val () = assertloc(rows = 100)
  val w_r = vector_rand(cols)
  val w = list0_map<double><double>(w_r, lam(x) => 2.0 * x - 1.0)
  val () = println!("initial w = ", w)
  
  fun aux(cntr: int, w: vector double): vector double =
    if cntr = 0
    then w
    else
    (
      let
        val () = println!("w = ", w)
        val Xdotw = dot_matrix_vector(X, w)
        val () = assertloc(list0_length(Xdotw) = 100)
        val pred = list0_map(Xdotw, lam(x) => sigmoid(x))
        val error = list0_map2<double,double><double>(Y, pred, lam(y, p) => y - p)
        val werr = list0_map2(error, pred, lam(e, p) => e * sigDiv(p))
        val XT = matrix_transpose(X)
        val () = assertloc(matrix_get_col(XT) = 100)
        val () = assertloc(matrix_get_row(XT) = 4)
        val diff = dot_matrix_vector(XT, werr)
        val () = assertloc(list0_length(diff) = 4)
        val w_new = list0_map2(w, diff, lam(x, d) => x + d)
      in
        aux(cntr - 1, w_new)
      end
    )

in
  aux(epoch, w)
end


(* ****** ****** *)

(* end of [nniris.dats] *)
