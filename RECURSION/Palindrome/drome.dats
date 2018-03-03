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
str2list0(s: string): list0(char)

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

(* end of [drome.dats] *)