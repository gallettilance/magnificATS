(* ****** ****** *)
//
// LG 2018-03-07
//
(* ****** ****** *)
(*
  Based on: https://projecteuler.net/problem=621
*)
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

#include
"$PATSHOMELOCS\
/atscntrb-hx-intinf/mylibies.hats"

#include
"$PATSHOMELOCS\
/atscntrb-hx-mytesting/mylibies.hats"

(* ****** ****** *)

typedef
intinf = $GINTINF_t.intinf

overload
print with $GINTINF_t.print_intinf

(* ****** ****** *)

val intinf = gnumber_int<intinf>

(* ****** ****** *)

val gadd = gadd_val_val<intinf>
val gsub = gsub_val_val<intinf>
val gmul = gmul_val_val<intinf>
val gdiv = gdiv_val_val<intinf>
val gcompare = gcompare_val_val<intinf>

overload * with gmul
overload + with gadd
overload / with gdiv
overload - with gsub
overload compare with gcompare

typedef intinf3 = (intinf, intinf, intinf)
typedef intinf2 = (intinf, intinf)

(* ****** ****** *)

extern
fun
search2(orig: list0(intinf), target: intinf): list0(intinf2)

extern
fun
search3(orig: list0(intinf), target: intinf): list0(intinf3)

extern
fun
nats(n: intinf): stream(intinf)

extern
fun
triangulars(n: stream(intinf)): stream(intinf)

extern
fun
list0_triangs(triangs: stream(intinf), max: intinf, res: list0(intinf)): list0(intinf)

extern
fun
triang_repr(triangs: list0(intinf), target: intinf): list0(intinf3)

(* ****** ****** *)

implement
search2(orig, target) = let

  fun search1(opt: list0(intinf), target: intinf, res: list0(intinf)):<cloref1> list0(intinf) =
    case+ opt of
    | nil0() => res
    | cons0(num, opt) => 
        if compare(num, target) = 0
        then search1(opt, target, cons0(num, res))
        else search1(opt, target, res) 
        
  fun aux(opt: list0(intinf), target: intinf, res: list0(intinf2)):<cloref1> list0(intinf2) =
    case+ opt of
    | nil0() => res
    | cons0(num, opt) => 
      let
        val newtar = target - num
        val sings = search1(orig, newtar, nil0())
        val tups = list0_map<intinf><intinf2>(sings, lam(s) => (num, s))
      in
        aux(opt, target, list0_append(tups, res))
      end
in
  aux(orig, target, nil0())
end

implement
search3(orig, target) = let

  fun aux(opt: list0(intinf), target: intinf, res: list0(intinf3)):<cloref1> list0(intinf3) =
    case+ opt of
    | nil0() => res
    | cons0(num, opt) => let
        val newtar = target - num
        val tups = search2(orig, newtar)
        val trips = list0_map<intinf2><intinf3>(tups, lam(tup) => (num, tup.0, tup.1))
      in
        aux(opt, target, list0_append(res, trips))
      end
in
  aux(orig, target, nil0())
end

(* ****** ****** *)

implement
list0_triangs(triangs, max, res) =
case- !triangs of
| stream_cons(t, triangs) => 
    if compare(t, max) > 0 then res
    else list0_triangs(triangs, max, cons0(t, res))

implement
nats(n) = $delay
(
  stream_cons(n, nats(n + intinf(1)))
)

implement
triangulars(nats) = 
case- !nats of
| stream_cons(n, nats) => 
      $delay(stream_cons(n*(n + intinf(1)) / intinf(2), triangulars(nats)))

implement
triang_repr(triangs, target) = search3(triangs, target)

(* ****** ****** *)

fun pow10(num: intinf, pow: int): intinf = 
  if pow <= 0 then num 
  else pow10(intinf(10) * num, pow - 1)

implement
main0() = ()
where
{
  val theNats = nats(intinf(0))
  val triangs = triangulars(theNats)
  
  val x = pow10(intinf(1), 5)
  val () = println!("x = ", x)
  
  val ts = list0_triangs(triangs, x, nil0)
  
  val () = println!("triang_repr(", x ,") = ")
  val tr = triang_repr(ts, x)
  val () = (tr).foreach()(lam(xs) => println!("(", xs.0, ", ", xs.1, ", ", xs.2, ")"))
  val () = println!()
  val () = println!("Number of ways = ", list0_length(tr))
}

(* ****** ****** *)

(* end of [triangular.dats] *)