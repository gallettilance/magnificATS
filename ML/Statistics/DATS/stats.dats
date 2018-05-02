(* ****** ****** *)
//
//  For various
//  Statistical
//  Functions
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
staload M =
"libats/libc/SATS/math.sats"
staload _ =
"libats/libc/DATS/math.dats"
//
(* ****** ****** *)
//
staload "./../SATS/stats.sats"
//
(* ****** ****** *)

implement
sqrtd(x) = $M.sqrt(x) //end of [sqrtd]

(* ****** ****** *)

implement
list0_mean(A) = let
  val n0 = length(A)
  val () = assertloc(n0 >= 1)
in
  list0_foldleft<dbl>(A, 0.0, lam (res, x) => res+x)/n0
end //end of [list0_mean]

(* ****** ****** *)

implement
list0_variance(A) = let
val n0 = list0_length(A)
val () = assertloc(n0 >= 1)
val avg = list0_mean(A)
in
  list0_foldleft<dbl>(A, 0.0, lam (res, x) => res + (x-avg)*(x-avg))/n0
end //end of [list0_variance]

(* ****** ****** *)

implement
list0_stdev(A) = sqrtd(list0_variance(A)) //end of [list0_stdev]

(* ****** ****** *)

implement
list0_absdev(A) = let
val n0 = list0_length(A)
val () = assertloc(n0 >= 1)
val avg = list0_mean(A)
in
  list0_foldleft<dbl>(A, 0.0, lam (res, x) => if x>avg then x-avg else avg-x)/n0
end //end of [list0_absdev]

(* ****** ****** *)

implement
{a}
list0_merge
(
  xs, ys
) = merge(xs, ys) where
{
//
fun
merge
(xs: list0 a,
 ys: list0 a): list0(a)  =
(
case+ xs of
| cons0 (x, xs1) => 
(
case+ ys of
| cons0 (y, ys1) => let
    val sgn = gcompare_val_val<a>(x, y)
  in
    if sgn <= 0
      then cons0{a}(x, merge(xs1, ys))
      else cons0{a}(y, merge(xs, ys1))
    // end of [if]
  end // end of [cons0]
| nil0 () => xs
) // end of [cons0]
| nil0 () => ys
)
} (* end of [list0_merge] *)

(* ****** ****** *)

implement
{a}
list0_mergesort (xs: list0 a) = let
//
val n = list0_length<a> (xs)
//
fun msort
(
xs: list0 a, n: int
) : list0 a =
if n >= 2 then split (xs, n, n/2, nil0) else xs
//
and split
(
xs: list0 a, n: int, i: int, xsf: list0 a
) : list0 a =
if i > 0 then let
  val-cons0 (x, xs) = xs
  in
  split (xs, n, i-1, cons0{a}(x, xsf))
  end else let
    val xsf = list0_reverse<a> (xsf) // make sorting stable!
    val xsf = msort (xsf, n/2) and xs = msort (xs, n-n/2)
  in
    list0_merge<a>(xsf, xs)
  end // end of [if]
//
in
msort (xs, n)
end // end of [list0_mergesort]

(* ****** ****** *)

implement
list0_quantile(A, q) = let
//
val n = list0_length(A)
val Asort = list0_mergesort<double>(A)
val ind = q*(n-1) :double
val find = $M.floor(ind) :double
//
in
  if ind = find then Asort[g0float2int(find)]
  else (Asort[g0float2int(find)] + Asort[g0float2int(find)+1])/2.0
end // end of [list0_quantile]

(* ****** ****** *)

implement
list0_median(A) =
list0_quantile(A, .5)

(* ****** ****** *)

implement
list0_freq(A) = let
//
val Asort = list0_mergesort<dbl>(A)
val () = assertloc(list0_length(Asort) = list0_length(A))
//
fun
aux
(
A: list0(dbl), C: list0( $tup(dbl, int) ), cnt:int
) : list0 ( $tup(dbl, int) ) =
case+ A of
|list0_nil() => C
|list0_cons(a0, A0) =>
    case+ A0 of
    |list0_nil() => aux(A0, list0_cons($tup(a0, cnt), C), 1)
    |list0_cons(a1, A1) =>
          if a0 = a1 then aux(A0, C, cnt+1)
          else aux(A0, list0_cons($tup(a0, cnt), C), 1)
//
in
  aux(Asort, list0_nil(), 1)
end //end of [list0_freq]

(* ****** ****** *)

implement
list0_maxcount(C) = let
//
fun max(C: list0 $tup(dbl, int), c:int): int =
case+ C of
|list0_nil() => c
|list0_cons(c0, C) => if c0.1 < c then max(C, c) else max(C, c0.1)
//
fun count(C: list0 $tup(dbl, int), c:int, res:list0(dbl)):list0(dbl) =
case+ C of
|list0_nil() => res
|list0_cons(c0, C) => if c0.1 = c then count(C, c, list0_cons(c0.0, res)) else count(C, c, res)
//
in
  let val-list0_cons(c0, C1) = C in count(C, max(C1, c0.1), list0_nil()) end
end //end of [list0_maxcount]

(* ****** ****** *)

implement
list0_mode(A) = list0_maxcount(list0_freq(A))

(* ****** ****** *)

implement
list0_summary(A) = () where
{
val () = println!("Summary of your list")
val () = println!()
val () = println!("mean : ", list0_mean(A))
//
val () = println!("mode : ", list0_mode(A))
//
val () = println!("stdev : ", list0_stdev(A))
val () = println!()
val () = println!("min : ", list0_quantile(A, 0.))
val () = println!("25th quantile : ", list0_quantile(A, .25))
val () = println!("median : ", list0_median(A))
val () = println!("75th quantile : ", list0_quantile(A, .75))
val () = println!("max : ", list0_quantile(A, 1.))
}

(* ****** ****** *)

implement
list0_studentized(A) = list0_map<dbl>(A, lam x => let val mu = list0_mean(A) val sd = list0_stdev(A) val () = assertloc(sd > 0.0) in (x-mu)/sd end)

(* ****** ****** *)

implement
list0_scores(A, mu, sd) = list0_map<dbl>(A, lam x => let val () = assertloc(sd > 0.0) in (x-mu)/sd end)

(* ****** ****** *)

implement
list0_lm_coef(Y, X) = let
val xbar = list0_mean(X)
val ybar = list0_mean(Y)
val nx = list0_length(X)
val sx = list0_lm_sxx(X)
val () = assertloc(sx > 0.0)
in
  let val b = list0_covariance(Y, X)/(sx/nx)
  in
    $tup(ybar - b*xbar, b)
  end
end //end of [list0_lm_coef]

(* ****** ****** *)

implement
list0_lm_sxx(X) = list0_length(X)*list0_variance(X)

(* ****** ****** *)

implement
list0_lm_syy(Y) = list0_length(Y)*list0_variance(Y)

(* ****** ****** *)

implement
list0_lm_sxy(Y, X) = let
//
val ny = list0_length(Y)
val nx = list0_length(X)
//
val () = assertloc(nx = ny)
//
val xbar = list0_mean(X)
val ybar = list0_mean(Y)
//
in
  list0_foldleft2<dbl><dbl,dbl>(Y, X, 0.0, lam(res, x, y) => res + ((x-xbar) * (y-ybar)))
end //end of [list0_lm_sxy]

(* ****** ****** *)

implement
list0_lm_mse(Y,Yhat) = let
val n = list0_length(Y)
in
  list0_lm_sse(Y, Yhat)/(n-2)
end //end of [list0_lm_mse]

(* ****** ****** *)

implement
list0_lm_sse(Y,Yhat) = list0_foldleft2<dbl><dbl,dbl>(Y, Yhat, 0.0, lam (res, y, yh) => res + (y-yh)*(y-yh))

(* ****** ****** *)

implement
list0_lm_sst(Y) = let val n = list0_length(Y) in n*list0_variance(Y) end

(* ****** ****** *)

implement
list0_lm_ssr(Y, X) = list0_lm_sxy(Y,X)/list0_lm_sxx(X)

(* ****** ****** *)

implement
list0_lm_r2(Y,X) = 1.0 - (list0_lm_sse(Y,X)/list0_lm_sst(Y))

(* ****** ****** *)

implement
list0_lm_pred(X, coef) = list0_map(X, lam x => coef.0 + x*coef.1)

(* ****** ****** *)

implement
list0_covariance(Y, X) = let
val ny = list0_length(Y) 
val nx = list0_length(X) 
val () = assertloc(ny = nx)
in
  list0_lm_sxy(Y, X)/ny
end //end of [list0_covariance]

(* ****** ****** *)

implement
list0_correlation(Y, X) = let
val sdx = list0_stdev(Y)
val sdy = list0_stdev(X)
val () = assertloc( sdx*sdy > 0.0 )
in
  list0_covariance(Y,X)/(sdx*sdy)
end //end of [list0_correlation]

(* ****** ****** *)

implement
list0_lm_coef_se(Y,X) = let
//
val Yhat = list0_lm_pred(Y, list0_lm_coef(Y, X))
val sxx = list0_lm_sxx(X)
val sx2 = list0_foldleft<dbl>(X, 0.0, lam (res, x) => res + x*x)
val n = list0_length(Y)
val () = assertloc(n*sxx > 0.0)
val () = assertloc(sxx > 0.0)
//
in
  $tup(sqrtd((list0_lm_mse(Y, Yhat)*sx2)/(n*sxx)) ,sqrtd(list0_lm_mse(Y, Yhat)/sxx))
end //end of [list0_lm_coef_se]

(* ****** ****** *)

implement
list0_lm_summary(Y, X) =
let
//
val coef = list0_lm_coef(Y,X)
val se = list0_lm_coef_se(Y,X)
val r2 = list0_lm_r2(Y,X)
//
in
  () where {
  val () = println! ("******* LINEAR REGRESSION SUMMARY *******")
  val () = println! ()
  val () = println! ("b0 = ", coef.0, " ****** ****** ", "standard error = ", se.0)
  val () = println! ("b1 = ", coef.1, " ****** ****** ", "standard error = ", se.1)
  val () = println! ()
  val () = println! ("R-squared = ", r2)
  val () = println! ()
  val () = println! ("****** ****** ****** ****** ****** ******")
  }
end //end of [list0_lm_summary]

(* ****** ****** *)

(* end of [stats.dats] *)