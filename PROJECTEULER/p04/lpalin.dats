(* ****** ****** *)
//
// LG 2018-03-11
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
is_palindrome(xs: list0(char)): bool

extern
fun
get_last(xs: list0(char)): char

extern
fun
remove_last(xs: list0(char)): list0(char)

extern
fun
int2string(i: int): string

extern
fun
lpalin(p: int): int

(* ****** ****** *)

implement
int2string(i) = let
  val b = 10
  
  fun int2str(i:int): string =    
    if i = 0 then "0"
    else if i = 1 then "1"
    else if i = 2 then "2"
    else if i = 3 then "3"
    else if i = 4 then "4"
    else if i = 5 then "5"
    else if i = 6 then "6"
    else if i = 7 then "7"
    else if i = 8 then "8"
    else if i = 9 then "9"
    else "" // can add A, B, C,...

  fun helper(i: int, res: string): string =
    if i > 0 then helper(i / b, int2str(i % b) + res)
    else res
in
  helper(i, "")
end

implement
get_last(inp) = let
  val xs = list0_reverse(inp)
  val-list0_cons(x, xs) = xs
in
  x
end

implement
remove_last(inp) = let
  val xs = list0_reverse(inp)
  val-list0_cons(x, xs0) = xs
in
  list0_reverse(xs0)
end

implement
is_palindrome(inp) =
case+ inp of
| list0_nil() => true
| list0_cons(c, inp) =>
  case+ inp of
  | list0_nil() => true
  | list0_cons(_, _) =>
    if c = get_last(inp)
    then let
      val inp = remove_last(inp)
    in
      is_palindrome(inp)
    end
    else false

implement
lpalin(p) = let
  val n = 9 * p + 1
  
  fun loop(j: int): int =
    if j = n then lpalin(p + 1)
    else
    (
      if n % j = 0
      then
      ( 
        let
          val a = 1001 - n / j
          val b = 1001 - 11 * j
          val test = int2string(a * b)
          val () = println!("test = ", test)
        in
          if is_palindrome(string_explode(test)) then a * b
          else loop(j + 1)
        end
      )
      else loop(j + 1)
    )

in
  if p < 9 then loop(1)
  else (println!("Not found"); ~1)
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val () = println!("Largest Palin3 = ", lpalin(1))
}

(* ****** ****** *)

(* end of [fibo.dats] *)