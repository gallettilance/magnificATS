(* ****** ****** *)
(*
** For testing stats-functions 
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#staload "./../SATS/stats.sats"

(* ****** ****** *)

val
ys_a =
g0ofg1
(
  $list{dbl}(1., 2., 3., 4., 5., 6.)
) (* end of [val] *)

val
xs_a =
g0ofg1
(
  $list{dbl}(1., 2., 3., 4., 5., 6.)
) (* end of [val] *)


(* ****** ****** *)

val avga = list0_mean(ys_a)
val vrna = list0_variance(ys_a)
val meda = list0_median(ys_a)
val absa = list0_absdev(ys_a)
val nora = list0_studentized(ys_a)
val scoa = list0_scores(ys_a, 3.5, 1.)
val freqa = list0_freq(ys_a)

(* ****** ****** *)

val coef = list0_lm_coef(ys_a, xs_a)

(* ****** ****** *)

implement main0 () = () where
{
val () = println! ("****** basic stats functions ******")
val () = println! ()
//
val () =
println!
("sqrt(4) = ", sqrtd(4.))
//
val () = println! ("ys_a = ", ys_a)
val () = println! ("mean(A) = ", avga)
val () = println! ("variance(A) = ", vrna)
val () = println! ("median(A) = ", meda)
val () = println! ("absdev(A) = ", absa)
val () = println! ("studentized(A) = ", nora)
val () = println! ("scores(A) = ", scoa)
val () = println! ("freq(A) = ")
val () =
(
  freqa.foreach()(lam(xy) => println! ("(", xy.0, ", ", xy.1, ") "))
)
//
val () = list0_summary(ys_a)
val () = println! ()
val () = println! ("****** lm functions ******")
val () = println! ()
val () = println! ("xs_a = ", xs_a)
val () = println! ("covariance(ys_a, xs_a) = ", list0_covariance(ys_a, xs_a))
val () = println! ("correlation(ys_a, xs_a) = ", list0_correlation(ys_a, xs_a))
val () = println! ("lm_coef(ys_a, xs_a) :")
val () = println! ("b0 = ", coef.0)
val () = println! ("b1 = ", coef.1)
val () = println! ()
val () = println! ("Yhat = ", list0_lm_pred(ys_a, list0_lm_coef(ys_a, xs_a)))
val () = println! ("lm_sse(ys_a, Yhat) = ", list0_lm_sse(ys_a, list0_lm_pred(ys_a, list0_lm_coef(ys_a, xs_a))))
val () = println! ("lm_mse(ys_a, Yhat) = ", list0_lm_mse(ys_a, list0_lm_pred(ys_a, list0_lm_coef(ys_a, xs_a))))
val () = println! ("lm_ssr(ys_a, xs_a) = ", list0_lm_ssr(ys_a, xs_a))
val () = println! ()
val () = list0_lm_summary(ys_a, xs_a)
}

(* end of [test01.dats] *)