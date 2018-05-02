(* ****** ****** *)
//
// LG - 03-06
//
(* ****** ****** *)

typedef matrix(a) = list0(list0(a))
typedef vector(a) = list0(a)

(* ****** ****** *)

extern
fun
vector_rand
( sze: int ) : vector double

extern
fun
matrix_rand
( row: int, col: int ) : matrix double

(* ****** ****** *)

extern
fun
{b:t@ype}
matrix_get_col
( A: matrix b ) : int

extern
fun
{b:t@ype}
matrix_get_row
( A: matrix b ) : int

extern
fun
{b:t@ype}
matrix_transpose
( A: matrix b ) : matrix b

(* ****** ****** *)

extern
fun
dot_matrix_matrix
( A: matrix double
, B: matrix double ) : matrix double


extern
fun
dot_matrix_vector
( A: matrix double
, v: vector double ) : vector double


extern
fun
dot_vector_vector
( v: vector double
, w: vector double ) : double

extern
fun
dot_cvector_rvector
( v: vector double
, w: vector double ) : matrix double


extern
fun
dot_scalar_vector
( a: double
, v: vector double ) : vector double


extern
fun
dot_scalar_matrix
( a: double
, A: matrix double ) : matrix double

(* ****** ****** *)

extern
fun
{b:t@ype}
matrix_matrix_pairwise_add
( A: matrix b
, B: matrix b ) : matrix b


extern
fun
{b:t@ype}
scalar_matrix_pairwise_add
( a: b
, A: matrix b ) : matrix b


extern
fun
{b:t@ype}
vector_vector_pairwise_add
( v: vector b
, w: vector b ) : vector b


extern
fun
{b:t@ype}
scalar_vector_pairwise_add
( a: b
, v: vector b ) : vector b

(* ****** ****** *)

implement
vector_rand(sze) = let
  val () = assertloc(sze > 0)
  
  fun
  aux(v: vector double, n: int): vector double =
    if n <= 0 then v
    else aux(cons0(urand(), v), n - 1)

in
  aux(nil0(), sze)
end


implement
matrix_rand(row, col) = let
  val () = assertloc(row > 0)
  val () = assertloc(col > 0)
  
  fun
  aux(m: matrix double, c: int): matrix double =
    if c <= 0 then m
    else aux(cons0(vector_rand(row), m), c - 1)

in
  aux(nil0(), col)
end

(* ****** ****** *)


implement
{a}
matrix_get_col(A) = 
case+ A of
| nil0() => 0
| cons0(row, _) => list0_length(row)


implement
{a}
matrix_get_row(A) = list0_length(A)


implement
{a}
matrix_transpose(A) = let

  val row = matrix_get_row(A)
  val col = matrix_get_col(A)
  val () = assertloc(row > 0 andalso col > 0)

  fun get_col
  (i: int): vector a = let
      val () = assertloc(i >= 0 andalso i < col)
    in
      list0_map(A, lam(row) => row[i])
    end
    
  fun aux(i: int, res: matrix a): matrix a =
    if i < 0 then res
    else aux(i - 1, cons0(get_col(i), res))

in
  aux(col - 1, nil0())
end


implement
dot_matrix_matrix(A, B) = let
  
  val rowA = list0_length(A)
  val rowB = list0_length(B)
  val-cons0(a, _) = A
  val-cons0(b, _) = B
  val colA = list0_length(a)
  val colB = list0_length(b)
  
  val () = assertloc(colA = rowB)
  val () = assertloc(rowA > 0 andalso colA > 0)
  val () = assertloc(rowB > 0 andalso colB > 0)

  fun dot(v: vector double, w: vector double): double =
    list0_foldleft2<double>(v, w, 0.0, lam(res, v, w) => res + v*w)
  
  fun mat_mul(A: matrix double, B: matrix double, C: matrix double): matrix double =
    case+ A of
    | nil0() => list0_reverse(C)
    | cons0(a, A) => 
        mat_mul
        (A, B
        , cons0(list0_reverse
          ( list0_foldleft( B, nil0(), 
            lam(res, b) => cons0(dot(a, b), res))
          )
        , C))
in
  mat_mul(A, matrix_transpose<double>(B), nil0())
end


implement
dot_scalar_matrix(a, A) = list0_map(A, lam(row) => list0_map(row, lam(elm) => elm * a))


implement
dot_scalar_vector(a, v) = list0_map(v, lam(elm) => elm * a)


implement
dot_matrix_vector(A, v) = list0_map(A, lam(row) => dot_vector_vector(row, v))


implement
dot_vector_vector(v, w) = list0_foldleft2<double>(v, w, 0.0, lam(res, x, y) => res + (x * y))

implement
dot_cvector_rvector(v, w) = list0_reverse(list0_foldleft(v, nil0(), lam(res, x) => cons0(dot_scalar_vector(x, w), res)))

(* ****** ****** *)

implement
{a}
matrix_matrix_pairwise_add(A, B) = 
list0_map2(A, B, lam(v, w) => vector_vector_pairwise_add<a>(v, w))


implement
{a}
scalar_matrix_pairwise_add(a, A) = 
list0_map(A, lam(row) => list0_map(row, lam(elm) => gadd_val_val<a>(a, elm)))


implement
{a}
vector_vector_pairwise_add(v, w) =
list0_map2(v, w, lam(x, y) => gadd_val_val<a>(x, y))


implement
{a}
scalar_vector_pairwise_add(a, v) =
list0_map(v, lam(x) => gadd_val_val<a>(a, x))


(* ****** ****** *)

(* end of [matrix.dats] *)
