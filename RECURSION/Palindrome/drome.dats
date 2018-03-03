(* ****** ****** *)
//
// LG 2018-03-02
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
{n: int}
str2list0(s: string(n)): list0(char)

extern
fun
get_last(inp: list0(char)): char

extern
fun
remove_last(inp: list0(char)): list0(char)

extern
fun
is_palindrome(inp: list0(char)): bool

(* ****** ****** *)

implement
{n}
str2list0(s) = let
  fun 
  {n:int}
  aux(s: string(n), res: list0(char)): list0(char) =
    if isneqz(s) then let
      val c = (g0ofg1)(string_head(s))
      val s = string_tail(s)
    in
      aux(s, cons0(c, res))
    end
    else res
in
  list0_reverse(aux(s, list0_nil()))
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

(* ****** ****** *)

implement
main0() = ()
where
{
  val str = str2list0("abba")
  val () = println!("Is ", str, " a palindrome? ", is_palindrome(str))
  val str = str2list0("a")
  val () = println!("Is ", str, " a palindrome? ", is_palindrome(str))
  val str = str2list0("abacacaba")
  val () = println!("Is ", str, " a palindrome? ", is_palindrome(str))
  val str = str2list0("hello")
  val () = println!("Is ", str, " a palindrome? ", is_palindrome(str))
  val str = str2list0("serres")
  val () = println!("Is ", str, " a palindrome? ", is_palindrome(str))
}

(* ****** ****** *)

(* end of [drome.dats] *)