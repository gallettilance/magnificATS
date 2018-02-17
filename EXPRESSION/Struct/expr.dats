(* ****** ****** *)
//
// LG 2018-02-16
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
| Neg(e1) => let 
    val e1 = simplfy_expr(e1)
  in
    (
    case+ e1 of
    | Int(i) => Int(~i)
    | _ => Neg(e1)
    )
  end
//
| Mul(e1, e2) => let
    val e1 = simplfy_expr(e1)
    val e2 = simplfy_expr(e2)
  in
      (
      case+ (e1, e2) of
      | (Int(i), e2) => 
        (
        if i = 0 then e1
        else 
          (if i = 1 then e2 
            else
            (
            case+ e2 of
            | Mul(e3, e4) =>
                (
                case+ (e3, e4) of
                | (Int(j), e4) => Mul(Int(i * j), simplfy_expr(e4))
                | (e3, Int(j)) => Mul(Int(i * j), simplfy_expr(e3))
                | ( _, _ ) => Mul(e1, e2)
                )
            | Int(j) => Int(i * j)
            | _ => Mul( e1, e2 )
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
                | (Int(j), e4) => Mul(Int(i * j), simplfy_expr(e4)) 
                | (e3, Int(j)) => Mul(Int(i * j), simplfy_expr(e3)) 
                | ( _, _ ) => Mul(e1, e2)
                )
            | Int(j) => Int(i * j)
            | _ => Mul( e1, e2 )
            ) // end of [case]
          ) // end of [else]
        ) // end of [if]
      | (_, _) => Mul( e1, e2 )
      ) //end of case
  end
         
//
| Add(e1, e2) => let

    val e1 = simplfy_expr(e1)
    val e2 = simplfy_expr(e2)
    
    in
      (
      case+ (e1, e2) of
      | (Int(i), e2) => 
        (
        if i = 0 then e2
        else
          (
          case+ e2 of
          | Int(j) => Int(i + j)
          | _ => Add( e1, e2 )
          ) // end of [else]
        ) // end of [if]
      | (e1, Int(i)) =>
        (
        if i = 0 then simplfy_expr(e1)
        else
          (
          case+ e1 of
          | Int(j) => Int(i + j)
          | _ => Add( e1, e2 )
          ) // end of [else]
        ) // end of [if]
      | (_, _) => Add( e1, e2 )
      ) // end of [case]
    end
//
| Sub(e1, e2) => let
    
    val e1 = simplfy_expr(e1)
    val e2 = simplfy_expr(e2)
    
    in
      (
      case- (e1, e2) of
      | (Int(i), e2) => 
        (
        if i = 0 then simplfy_expr(Neg(e2))
        else
          (
          case+ e2 of
          | Int(j) => Int(i - j)
          | _ => Sub( e1, e2 )
          ) // end of [else]
        ) // end of [if]
      | (e1, Int(i)) =>
        (
        if i = 0 then e1
        else
          (
          case+ e1 of
          | Int(j) => Int(i - j)
          | _ => Sub( e1, e2 )
          ) // end of [else]
        ) // end of [if]
      | (_, _) => Sub( e1, e2 )
      )
    end
//
| Div(e1, e2) => let
    
    val e1 = simplfy_expr(e1)
    val e2 = simplfy_expr(e2)
    
    in
      (
      case- (e1, e2) of
      | (Int(i), e2) => 
        (
        if i = 0 then Int(0)
        else
          (
          case+ e2 of
          | Int(j) => Int(i / j)
          | _ =>  Div( e1, e2 )
          ) // end of [else]
        ) // end of [if]
      | (e1, Int(i)) =>
          (
          case+ e1 of
          | Int(j) => Int(i / j)
          | _ =>  Div( e1, e2 )
          ) // end of [else]
      | (_, _) => Div( e1, e2 )
      )
    end
)

(* ****** ****** *)

(* end of [expr.dats] *)