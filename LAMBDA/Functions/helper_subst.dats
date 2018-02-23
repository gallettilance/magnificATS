(* ****** ****** *)
//
// LG 2018-02-17
//
(* ****** ****** *)

#include "./../Struct/lambda_subst.dats"

(* ****** ****** *)

extern
fun
TMadd(t1: term, t2: term): term

extern
fun
TMsub(t1: term, t2: term): term

extern
fun
TMmul(t1: term, t2: term): term

extern
fun
TMdiv(t1: term, t2: term): term

extern
fun
TMmod(t1: term, t2: term): term

extern
fun
TMgte(t1: term, t2: term): term

extern
fun
TMlte(t1: term, t2: term): term

extern
fun
TMgt(t1: term, t2: term): term

extern
fun
TMlt(t1: term, t2: term): term

(* ****** ****** *)

implement
TMgte(t1: term, t2: term): term =
  TMopr(">=", list0_tuple(t1, t2))

implement
TMlte(t1: term, t2: term): term =
  TMopr("<=", list0_tuple(t1, t2))

implement
TMgt(t1: term, t2: term): term =
  TMopr(">", list0_tuple(t1, t2))

implement
TMlt(t1: term, t2: term): term =
  TMopr("<", list0_tuple(t1, t2))

implement
TMdiv(t1: term, t2: term): term =
  TMopr("/", list0_tuple(t1, t2))

implement
TMsub(t1: term, t2: term): term =
  TMopr("-", list0_tuple(t1, t2))
  
implement
TMadd(t1: term, t2: term): term =
  TMopr("+", list0_tuple(t1, t2))

implement
TMmul(t1: term, t2: term): term =
  TMopr("*", list0_tuple(t1, t2))
  
implement
TMmod(t1: term, t2: term): term =
  TMopr("%", list0_tuple(t1, t2))

(* ****** ****** *)

(* end of [helper.dats] *)