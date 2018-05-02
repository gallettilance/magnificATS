(* ****** ****** *)
//
// LG - 03-06
//
(* ****** ****** *)

extern
fun
NN_mnist_sigmoid
( 
  X : matrix double
, Y : matrix double
, hidden (* hidden layers *) : int
, lrate (* learning rate *)  : double
, epoch (* stop condition *) : int
) : (matrix double, matrix double)


extern
fun
query_mnist_one
( input: vector double
, wih: matrix double
, who: matrix double
): double


extern
fun
query_mnist
( X: matrix double
, wih: matrix double
, who: matrix double
): vector double


extern
fun
query_mnist_error_one
( p: double
, y: vector double
) : double


extern
fun
query_mnist_error
( pred: vector double
, Y: matrix double
) : vector double


extern
fun
digitize(y: vector double): double

(* ****** ****** *)

implement
digitize(y) = let
  
  val () = assertloc(list0_length(y) = 10)
  
  fun aux(xs: vector double, max: (double, int), currind: int): double =
    case+ xs of
    | nil0() => max.1 + 0.0
    | cons0(x, xs) => 
      if x > max.0 
      then aux(xs, (x, currind), currind + 1)
      else aux(xs, max, currind + 1)

in
  aux(y, (0.0, ~1), 0)
end


implement
NN_mnist_sigmoid(X, Y, hidden, lrate, epoch) = let  
  val () = println!("starting training...")
  val inodes = matrix_get_col(X)
  val hnodes = hidden
  val onodes = matrix_get_col(Y)
  val wih_r = matrix_rand(hnodes, inodes)
  val () = assertloc(matrix_get_col(wih_r) = hnodes)
  val () = assertloc(matrix_get_row(wih_r) = inodes)
  val wih = list0_map<list0(double)><list0(double)>(wih_r, lam(w) => list0_map<double><double>(w, lam(x) => 2.0 * x - 1.0))
  
  val who_r = matrix_rand(onodes, hnodes)
  val () = assertloc(matrix_get_col(who_r) = onodes)
  val () = assertloc(matrix_get_row(who_r) = hnodes)
  val who = list0_map<list0(double)><list0(double)>(who_r, lam(w) => list0_map<double><double>(w, lam(x) => 2.0 * x - 1.0))
  
  fun train
  ( input: vector double
  , target: vector double
  , wih: matrix double
  , who: matrix double
  ) : (matrix double, matrix double) = let
      val hidden_inputs = dot_matrix_vector(wih, input)
      val hidden_outputs = list0_map<double><double>(hidden_inputs, lam(hi) => sigmoid(hi))
    
      val final_inputs = dot_matrix_vector(who, hidden_outputs)
      val final_outputs = list0_map<double><double>(final_inputs, lam(fi) => sigmoid(fi))
    
      val output_error = list0_map2<double, double><double>(target, final_outputs, lam(x, y) => x - y)
      val whoT = matrix_transpose(who)
      val hidden_error = dot_matrix_vector(whoT, output_error)
    
      val final_delta = list0_map2<double, double><double>(output_error, final_outputs, lam(e, f) => e * sigDiv(f))
      val hidden_delta = list0_map2<double, double><double>(hidden_error, hidden_outputs, lam(e, f) => e * sigDiv(f))
      
      val who_new = dot_cvector_rvector(final_delta, hidden_outputs) : matrix double
      val wih_new = dot_cvector_rvector(hidden_delta, input) : matrix double
      
      val who = dot_scalar_matrix(lrate, who_new): matrix double
      val wih = dot_scalar_matrix(lrate, wih_new): matrix double
      
    in
      (who, wih)
    end

  fun
  step_one
  ( X: matrix double
  , Y: matrix double
  , wih: matrix double
  , who: matrix double
  ) : (matrix double, matrix double) = 
    case- (X, Y) of
    | (nil0(), nil0()) => (who, wih)
    | (cons0(input, X), cons0(target, Y)) => 
      let
        val (who_new, wih_new) = train(input, target, wih, who)
      in
        step_one(X, Y, wih_new, who_new)
      end

  fun
  aux
  ( wih: matrix double
  , who: matrix double
  , cntr: int
  ): (matrix double, matrix double) =
    if cntr = 0
    then (who, wih)
    else 
    (
      let
        val () = println!("epochs left = ", cntr)
        val (who_new, wih_new) = step_one(X, Y, wih, who)
      in
        aux(wih_new, who_new, cntr - 1)
      end
    )

in
  aux(wih, who, epoch)
end


implement
query_mnist_one(input, wih, who) = let
  val hidden_inputs = dot_matrix_vector(wih, input)
  val hidden_outputs = list0_map<double><double>(hidden_inputs, lam(hi) => sigmoid(hi))
 
  val final_inputs = dot_matrix_vector(who, hidden_outputs)
  val final_outputs = list0_map<double><double>(final_inputs, lam(fi) => sigmoid(fi))
in
  digitize(final_outputs)
end


implement
query_mnist(X, wih, who) = let
  fun aux(X: matrix double, res: vector double): vector double =
    case+ X of
    | nil0() => list0_reverse(res)
    | cons0(x, X) =>
      let
        val p = query_mnist_one(x, wih, who)
      in
        aux(X, cons0(p, res))
      end
in
  aux(X, nil0())
end


implement
query_mnist_error_one(p, y) = let
  val y_dig = digitize(y)
in
  if p = y_dig
  then 0.0
  else p - y_dig
end


implement
query_mnist_error(pred, Y) = let
  fun aux(pred: vector double, Y: matrix double, res: vector double): vector double =
    case- (pred, Y) of
    | (nil0(), nil0()) => list0_reverse(res)
    | (cons0(p, pred), cons0(y, Y)) => 
      let
        val err = query_mnist_error_one(p, y)
      in
        aux(pred, Y, cons0(err, res))
      end
in
  aux(pred, Y, nil0())
end

(* ****** ****** *)

(* end of [nnmnist.dats] *)
