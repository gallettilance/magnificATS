(* ****** ****** *)
//
// LG 2018-03-12
//
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

fun
gmod(x: intinf, y: intinf) = x - (x / y)  * y

overload % with gmod

(* ****** ****** *)

extern
fun 
get_at_col(xs: list0(intinf), j: int): intinf

extern
fun 
get_at_row(xss: list0(list0(intinf)), i: int): list0(intinf)

extern
fun 
get_elem(xss: list0(list0(intinf)), i: int, j: int): intinf

extern
fun 
set_col(xs: list0(intinf), j: int, elm: intinf): list0(intinf)

extern
fun 
set_row(xss: list0(list0(intinf)), i: int, elm: list0(intinf)): list0(list0(intinf))

extern
fun
set_elem(xss: list0(list0(intinf)), i: int, j: int, elm: intinf): list0(list0(intinf))

extern
fun
grid_build(xss: list0(list0(intinf))): list0(list0(intinf))

(* ****** ****** *)

implement
get_at_col(xs, j) =
case+ xs of
| list0_nil() => intinf(0) // additive identity
| list0_cons(x, xs) => 
     if j = 0 then x 
     else 
     (
       if j < 0 then get_at_col(nil0(), j)
       else get_at_col(xs, j - 1)
     )
        
implement
get_at_row(xss, i) =
case+ xss of
| list0_nil() => g0ofg1($list( intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0), intinf(0)))
| list0_cons(xs, xss) => 
    if i = 0 then xs 
    else 
    (
      if i < 0 then get_at_row(nil0(), i) 
      else get_at_row(xss, i - 1)
    )
    
implement
get_elem(xss, i, j) = get_at_col(get_at_row(xss, i), j)

implement
set_col(xs, j, elm) = let
  fun aux(xs: list0(intinf), j: int, res: list0(intinf)): list0(intinf) =
    case+ xs of
    | nil0() => list0_reverse(res)
    | cons0(x, xs) => 
        if j = 0 then aux(xs, j - 1, cons0(elm, res))
        else aux(xs, j - 1, cons0(x, res))
in
  aux(xs, j, nil0())
end

implement
set_row(xss, i, elm) = let
  fun aux(xss: list0(list0(intinf)), i: int, res: list0(list0(intinf))): list0(list0(intinf)) =
    case+ xss of
    | nil0() => list0_reverse(res)
    | cons0(xs, xss) => 
        if i = 0 then aux(xss, i - 1, cons0(elm, res))
        else aux(xss, i - 1, cons0(xs, res))
in
  aux(xss, i, nil0())
end

implement
set_elem(xss, i, j, elm) = set_row(xss, i, set_col(get_at_row(xss, i), j, elm))

implement
grid_build(xss) = let
  val xss = set_elem(xss, 0, 0, intinf(1))

  fun aux(xss: list0(list0(intinf)), i: int, j: int): list0(list0(intinf)) = let
      val elm = get_elem(xss, i - 1, j) + get_elem(xss, i, j - 1)
      val yss = set_elem(xss, i, j, elm)
    in
      if i > 20 then xss
      else
      (
        if j > 20 then aux(xss, i + 1, 0)
        else aux(yss, i, j + 1)
      )
    end
in
  aux(xss, 0, 1)
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val grid = g0ofg1($list(
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
  g0ofg1($list( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
  ))
  
  val grid = list0_map<list0(int)><list0(intinf)>(grid, lam(gs) => list0_map<int><intinf>(gs, lam(g) => intinf(g)))
  
  val newgrid = grid_build(grid)
  val numways = get_elem(newgrid, 20, 20)
  val () = println!("Number of Ways for 20 x 20 grid = ", numways)
}

(* ****** ****** *)

(* end of [paths.dats] *)