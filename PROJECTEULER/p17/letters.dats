(* ****** ****** *)
//
// LG 2018-03-13
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
int2word(i: int): string

extern
fun
one_to_thous(): list0(string)

(* ****** ****** *)

implement
int2word(i) =
case i of
| 1 => "one"
| 2 => "two"
| 3 => "three"
| 4 => "four"
| 5 => "five"
| 6 => "six"
| 7 => "seven"
| 8 => "eight"
| 9 => "nine"
| 10 => "ten"
| 11 => "eleven"
| 12 => "twelve"
| 13 => "thirteen"
| 14 => int2word(i % 10) + "teen"
| 15 => "fifteen"
| 16 => int2word(i % 10) + "teen"
| 17 => int2word(i % 10) + "teen"
| 18 => "eighteen"
| 19 => int2word(i % 10) + "teen"
| 20 => "twenty"
| 30 => "thirty"
| 40 => "fourty"
| 50 => "fifty"
| 60 => "sixty"
| 70 => "seventy"
| 80 => "eighty"
| 90 => "ninety"
| 1000 => "onethousand"
| _ => 
    ifcase
    | i < 100 => int2word(i - (i % 10)) + int2word(i % 10)
    | i % 100 = 0 => int2word((i - (i % 100)) / 100) + "hundred"
    | _ => int2word((i - (i % 100)) / 100) + "hundredand" + int2word((i % 100))

implement
one_to_thous(): list0(string) = let
  fun aux(n: int, res: list0(string)): list0(string) =
    if n < 1 then res
    else aux(n - 1, cons0(int2word(n), res))
in
  aux(1000, nil0())
end
    
(* ****** ****** *)

implement
main0() = ()
where
{
  val () = println!("1-1000 = ")
  val xs = one_to_thous()
  val s = list0_foldleft<string>(xs, "", lam(res, x) => x + res)
  val n = list0_length(string_explode(s))
  //val () = (xs).foreach()(lam(x) => println!(x))
  val () = println!("Number of letters 1-1000 = ", n)
}

(* ****** ****** *)

(* end of [letters.dats] *)