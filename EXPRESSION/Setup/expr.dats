(* ****** ****** *)
//
// LG 2018-02-15
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

datatype expr =
  | Int of (int)
  | X of ()
  | Neg of (expr)
  | Mul of (expr, expr)
  | Add of (expr, expr)
  | Sub of (expr, expr)
  | Div of (expr, expr)

(* ****** ****** *)

extern
fun
print_expr(e0: expr): void // stdout
and
prerr_expr(e0: expr): void // stderr

extern
fun
fprint_expr(out: FILEref, e0: expr): void

(* ****** ****** *)

overload print with print_expr
overload prerr with prerr_expr
overload fprint with fprint_expr

(* ****** ****** *)

implement
print_expr(e0) =
fprint_expr(stdout_ref, e0)
implement
prerr_expr(e0) =
fprint_expr(stderr_ref, e0)

(* ****** ****** *)

implement
fprint_expr(out, e0) =
(
case+ e0 of
//
| Int(i) =>
  fprint!(out, "Int(", i, ")")
//
| X() =>
  fprint!(out, "X")
//
| Neg(e1) =>
  fprint!(out, "Neg(", e1, ")")
//
| Mul(e1, e2) =>
  fprint!(out, "Mul(", e1, ", ", e2, ")")
//
| Add(e1, e2) =>
  fprint!(out, "Add(", e1, ", ", e2, ")")
//
| Sub(e1, e2) =>
  fprint!(out, "Sub(", e1, ", ", e2, ")")
//
| Div(e1, e2) =>
  fprint!(out, "Div(", e1, ", ", e2, ")")
)

(* ****** ****** *)

extern
fun
simplfy_expr(e0: expr) : expr

(* ****** ****** *)

implement
simplfy_expr(e0) =
(
case+ e0 of
| Int(i) => e0
//
| X() => e0
//
| Neg(e1) =>
    (
    case+ e1 of
    | Int(i) => Int(~i)
    | _ => Neg( simplfy_expr(e1) )
    )
//
| Mul(e1, e2) =>
      (
      case+ (e1, e2) of
      | (Int(i), e2) => 
        (
        if i = 0 then e1 
        else 
          (if i = 1 then simplfy_expr(e2) 
            else
            (
            case+ e2 of
            | Mul(e3, e4) =>
                ( 
                case+ (e3, e4) of
                | (Int(j), e4) => simplfy_expr( Mul(Int(i * j), simplfy_expr(e4)) )
                | (e3, Int(j)) => simplfy_expr( Mul(Int(i * j), simplfy_expr(e3)) )
                | ( _, _ ) => e0
                )
            | Int(j) => Int(i * j)
            | _ => e0
            ) // end of [case]
          ) // end of [else]
        ) // end of [if]
      | (e1, Int(i)) =>
        (
        if i = 0 then e1 
        else 
          (if i = 1 then simplfy_expr(e1) 
            else
            (
            case+ e1 of
            | Mul(e3, e4) =>
                ( 
                case+ (e3, e4) of
                | (Int(j), e4) => simplfy_expr( Mul(Int(i * j), simplfy_expr(e4)) )
                | (e3, Int(j)) => simplfy_expr( Mul(Int(i * j), simplfy_expr(e3)) )
                | ( _, _ ) => e0
                )
            | Int(j) => Int(i * j)
            | _ => e0
            ) // end of [case]
          ) // end of [else]
        ) // end of [if]
      | (_, _) => e0
      ) //end of case   
//
| Add(e1, e2) =>
      (
      case+ (e1, e2) of
      | (Int(i), e2) => 
        (
        if i = 0 then simplfy_expr(e2)
        else
          (
          case+ e2 of
          | Int(j) => Int(i + j)
          | _ => e0
          ) // end of [else]
        ) // end of [if]
      | (e1, Int(i)) =>
        (
        if i = 0 then simplfy_expr(e1)
        else
          (
          case+ e1 of
          | Int(j) => Int(i + j)
          | _ => e0
          ) // end of [else]
        ) // end of [if]
      | (_, _) => e0 
      ) // end of [case]
//
| Sub(e1, e2) =>
      (
      case- (e1, e2) of
      | (Int(i), e2) => 
        (
        if i = 0 then simplfy_expr(Neg(e2))
        else
          (
          case+ e2 of
          | Int(j) => Int(i - j)
          | _ => e0
          ) // end of [else]
        ) // end of [if]
      | (e1, Int(i)) =>
        (
        if i = 0 then simplfy_expr(e1)
        else
          (
          case+ e1 of
          | Int(j) => Int(i - j)
          | _ => e0
          ) // end of [else]
        ) // end of [if]
      | (_, _) => e0
      )
//
| Div(e1, e2) =>
      (
      case- (e1, e2) of
      | (Int(i), e2) => 
        (
        if i = 0 then Int(0)
        else
          (
          case+ e2 of
          | Int(j) => Int(i / j)
          | _ => e0
          ) // end of [else]
        ) // end of [if]
      | (e1, Int(i)) =>
          (
          case+ e1 of
          | Int(j) => Int(i / j)
          | _ => e0
          ) // end of [else]
      | (_, _) => e0
      )
)

(* ****** ****** *)

implement
main0() = ()
where
{
val x = X()
val e1 = Add(x, Int(0))
val e2 = Mul(Int(2), Mul(e1, Int(1)))
val e3 = Mul(Int(0), Div(e2, e1))
val e4 = Sub(e3, Int(0))
val e5 = Neg(e1)

val () = println!("x = ", x)
val () = println!("simplfy_expr(x) = ", simplfy_expr(x))
val () = println!()
//
val () = println!("e1 = ", e1)
val () = println!("simplfy_expr(e1) = ", simplfy_expr(e1))
val () = println!()
//
val () = println!("e2 = ", e2)
val () = println!("simplfy_expr(e2) = ", simplfy_expr(e2))
val () = println!()
//
val () = println!("e3 = ", e3)
val () = println!("simplfy_expr(e3) = ", simplfy_expr(e3))
val () = println!()
//
val () = println!("e4 = ", e4)
val () = println!("simplfy_expr(e4) = ", simplfy_expr(e4))
val () = println!()
//
val () = println!("e5 = ", e5)
val () = println!("simplfy_expr(e5) = ", simplfy_expr(e5))
}

(* ****** ****** *)

(* end of [expr.dats] *)