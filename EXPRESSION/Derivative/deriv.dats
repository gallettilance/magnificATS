(* ****** ****** *)
//
// LG 2018-02-16
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

// a polynomial here
// only contains positive exponents
//
// we represent poly as 
// a list of coefficients
// where index is the degree

datatype 
poly = 
| Nil of ()
| Cons of (int, poly)

(* ****** ****** *)

extern
fun
get_deg_poly(p0: poly) : int

extern
fun
deriv(p0: poly) : poly

(* ****** ****** *)

extern
fun
print_poly(p0: poly): void // stdout
and
prerr_poly(p0: poly): void // stderr

extern
fun
fprint_poly(out: FILEref, p0: poly): void

(* ****** ****** *)

overload print with print_poly
overload prerr with prerr_poly
overload fprint with fprint_poly

(* ****** ****** *)

implement
print_poly(p0) =
fprint_poly(stdout_ref, p0)
implement
prerr_poly(p0) =
fprint_poly(stderr_ref, p0)

(* ****** ****** *)

implement
get_deg_poly(p0) = let
  fun helper(p0: poly, deg: int) : int =
    case+ p0 of
    | Nil() => deg
    | Cons(_, p0) => helper(p0, deg + 1)

in
  helper(p0, 0) - 1
end

(* ****** ****** *)

implement
fprint_poly(out, p0) = let
   
   val d = get_deg_poly(p0)
   
   fun helper(out: FILEref, p_tail: poly, deg: int) : void =
      case+ p_tail of
      | Nil() => ()
      | Cons(c1, p_tail) => 
          (
          case+ p_tail of
          | Nil() => fprint!(out, c1)
          | Cons(_, _) => let
                val () = fprint!(out, c1, "X^", deg, " + ")
              in
                helper(out, p_tail, deg - 1)
              end
          ) // end of [cons]
  
in
  helper(out, p0, d )
end

(* ****** ****** *)

implement
deriv(p0) = let
  val d = get_deg_poly(p0)
  
  fun helper(p: poly, deg: int, res: poly): poly =
    case+ p of
    | Nil() => res
    | Cons(c, p) => helper(p, deg - 1, Cons(deg * c, res))
 
  fun rev(p: poly, res: poly) : poly =
    case+ p of
    | Nil() => res
    | Cons(c, p) => rev(p, Cons(c, res))
in
  case+ p0 of
  | Nil() => Cons(0, Nil())
  | Cons(_, _) => let
      val-Cons(c, p) = helper(p0, d, Nil())
    in
      rev(p, Nil())
    end
end

(* ****** ****** *)

implement
main0() = ()
where
{
val p0 = Cons(1, Nil())
val p1 = Cons(1, p0)
val p2 = Cons(1, p1)
val p3 = Cons(1, p2)

val () = println!("p3 = ", p3)
val () = println!("deriv(p3) = ", deriv(p3))
}


(* ****** ****** *)

(* end of [deriv.dats] *)