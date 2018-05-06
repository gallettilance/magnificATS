(* ****** ****** *)
//
// LG 2018-02-22
//
(* ****** ****** *)

fun
sub_term_int
(t1: term, i2: int): term =
TMopr
( "-"
, list0_tuple(t1, TMint(i2)))

fun
sub_term_term
(t1: term, i2: term): term =
TMopr
( "-"
, list0_tuple(t1, i2))

fun
add_term_term
(t1: term, t2: term): term =
TMopr("+", list0_tuple(t1, t2))

fun
mul_term_term
(t1: term, t2: term): term =
TMopr("*", list0_tuple(t1, t2))

fun
div_term_term
(t1: term, t2: term): term =
TMopr("/", list0_tuple(t1, t2))

fun
gte_term_term
(t1: term, t2: term): term =
TMopr(">=", list0_tuple(t1, t2))

fun
gt_term_term
(t1: term, t2: term): term =
TMopr(">", list0_tuple(t1, t2))

fun
lte_term_term
(t1: term, t2: term): term =
TMopr("<=", list0_tuple(t1, t2))

fun
lt_term_term
(t1: term, t2: term): term =
TMopr("<", list0_tuple(t1, t2))

fun
eq_term_term
(t1: term, t2: term): term =
TMopr("=", list0_tuple(t1, t2))

fun
neq_term_term
(t1: term, t2: term): term =
TMopr("!=", list0_tuple(t1, t2))

fun
abs_term
(t1: term): term =
TMopr("abs", cons0(t1, nil0()))

overload - with sub_term_int
overload - with sub_term_term
overload + with add_term_term
overload * with mul_term_term
overload >= with gte_term_term
overload > with gt_term_term
overload <= with lte_term_term
overload < with lt_term_term
overload / with div_term_term
overload = with eq_term_term
overload != with neq_term_term

(* ****** ****** *)

(* end of [helper_interp.dats] *)