(* ****** ****** *)
//
//  For various
//  statistical
//  functions
//
(* ****** ****** *)
//
#staload
"libats/ML/SATS/basis.sats"
//
(* ****** ****** *)
//
exception Empty
exception Negative
exception Index
//
(* ****** ****** *)
//
typedef dbl = double
typedef dblist0 = list0(dbl)
//
(* ****** ****** *)
//
typedef
cmpfun(a:t@ype) = (a,a) -<fun1> int
typedef
cmpcfun(a:t@ype) = (a,a) -<cloref1> int
//
(* ****** ****** *)

fun
sqrtd: dbl -> dbl

(* ****** ****** *)
//
fun
{a:t@ype}
list0_merge
(xs: list0 (a), ys: list0 (a)) : list0 (a)
//
fun
{a:t@ype}
list0_mergesort(xs: list0 a) : list0 a
//
(* ****** ****** *)

fun
list0_mean(A: list0(dbl)) : dbl

fun
list0_variance(A: list0(dbl)) : dbl

fun
list0_absdev(A: list0(dbl)): dbl

fun
list0_quantile(A: list0(dbl) , q:dbl): dbl
//gives the element s.t. q fraction of A is less than or equal

fun
list0_freq(C: list0(dbl) ) : list0($tup(dbl, int))
//print the freq of each element in A - could make into template later

fun
list0_maxcount(C: list0 ($tup(dbl, int))): list0(dbl)
//could make into a template later

fun
list0_summary(A: list0(dbl) ) : void
//print a combination of the above functions

fun
list0_studentized(A: list0(dbl) ) : list0(dbl)

fun
list0_scores(A: list0(dbl), mu (* true mean *): dbl, sd (* true stdev *): dbl ) : list0(dbl)

(* ****** ****** *)

fun
list0_stdev(A: list0(dbl) ) : dbl

fun
list0_median(A: list0(dbl) ) : dbl

fun
list0_mode(A:list0(dbl)): list0(dbl)

(* ****** ****** *)

fun
list0_correlation(Y:list0(dbl), X:list0(dbl)): dbl

fun
list0_covariance(Y:list0(dbl), X:list0(dbl)): dbl

fun
list0_lm_coef(Y:list0(dbl), X:list0(dbl)): $tup(dbl (*beta0*), dbl(*beta1*))

fun
list0_lm_pred(x:list0(dbl), coef:$tup(dbl, dbl)): list0(dbl) (*yhat*)

fun
list0_lm_mse(Y:list0(dbl), Yhat:list0(dbl)): dbl

fun
list0_lm_mad(Y:list0(dbl), Yhat:list0(dbl)): dbl

fun
list0_lm_sse(Y:list0(dbl), Yhat:list0(dbl)): dbl

fun
list0_lm_ssr(Y:list0(dbl), X:list0(dbl)): dbl

fun
list0_lm_sst(Y:list0(dbl)): dbl

fun
list0_lm_df(Y:list0(dbl), X:list0(dbl)): dbl

fun
list0_lm_sxx(X:list0(dbl)): dbl

fun
list0_lm_syy(Y:list0(dbl)): dbl

fun
list0_lm_sxy(Y:list0(dbl), X:list0(dbl)): dbl

fun
list0_lm_r2(Y:list0(dbl), X:list0(dbl)): dbl

fun
list0_lm_coef_se(Y:list0(dbl), X:list0(dbl)): $tup(dbl, dbl)

fun
list0_lm_summary(Y:list0(dbl), X:list0(dbl)):void

(* ****** ****** *)

fun
matrix0_correlation(Y:list0(dbl), X:matrix0(dbl)): matrix0(dbl)

fun
matrix0_covariance(Y:list0(dbl), X:matrix0(dbl)): matrix0(dbl)

fun
matrix0_lm_coef(Y:list0(dbl), X:matrix0(dbl)): list0 (dbl)

fun
matrix0_lm_pred(X:matrix0(dbl), coef:$tup(dbl, dbl)): list0(dbl) (*yhat*)

fun
matrix0_lm_df(Y:list0(dbl), X:matrix0(dbl)): dbl

fun
matrix0_lm_r2(Y:list0(dbl), X:matrix0(dbl)): dbl

fun
matrix0_lm_coef_se(Y:list0(dbl), X:matrix0(dbl)): list0(dbl)

fun
matrix0_lm_summary(Y:list0(dbl), X:matrix0(dbl)):void

(* ****** ****** *)

(* end of [stats.sats] *)