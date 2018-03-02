(* ****** ****** *)
//
// LG 2018-03-01
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

datatype rom =
| I of () // 1
| V of () // 5
| X of () // 10
| L of () // 50
| C of () // 100
| D of () // 500
| M of () // 1000

typedef numeral = list0(rom)

(* ****** ****** *)

extern
fun
rom_eval(r: rom): int

extern
fun
numeral_eval(rn: numeral): int

(* ****** ****** *)

implement
rom_eval(r) =
case+ r of
| I() => 1
| V() => 5
| X() => 10
| L() => 50
| C() => 100
| D() => 500
| M() => 1000

implement
numeral_eval(rn) = let
  fun helper(rn: numeral, prev: int, res: int): int =
    case+ rn of
    | list0_nil() => res
    | list0_cons(r, rn) => 
        let 
          val er = rom_eval(r)
        in
          if er < prev
          then helper(rn, er, res - er)
          else helper(rn, er, res + er)
        end
 
 in
  helper( list0_reverse(rn), 0, 0 )
 end

(* ****** ****** *)

implement
main0() = ()
where
{
  val r1774 = g0ofg1($list(M(), D(), C(), C(), L(), X(), X(), V(), I()))
  val r1954 = g0ofg1($list(M(), C(), M(), L(), I(), V()))
  val r1990 = g0ofg1($list(M(), C(), M(), X(), C()))
  val r2014 = g0ofg1($list(M(), M(), X(), I(), V()))
  
  val () = println!("r1774 = ", numeral_eval(r1774))
  val () = println!("r1954 = ", numeral_eval(r1954))
  val () = println!("r1990 = ", numeral_eval(r1990))
  val () = println!("r2014 = ", numeral_eval(r2014))
  
}

(* ****** ****** *)

(* end of [rnumerals.dats] *)