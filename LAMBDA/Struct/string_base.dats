(* ****** ****** *)
//
// LG 2018-04-03
//
(* ****** ****** *)

extern
fun
{a:t@ype}
pop_last(xs: list0(a)): list0(a)

(* ****** ****** *)

extern
fun
parse_args(s: string): list0(string)

extern
fun
parse_csv(s: string): list0(string)

(* ****** ****** *)

extern
fun
cget_time(): string = "mac#cget_time"

extern
fun
get_time(): string

extern
fun
get_date(): string

(* ****** ****** *)

extern
fun
int2string(i: int, b: int): string

extern
fun
int2str(n: int): string

extern
fun
char2int(c: char): int

extern
fun
string2int(s: string): int

(* ****** ****** *)

implement
int2string(i, b) = let

    val () = assertloc(i >= 0)

    fun dig2str(i:int): string =    
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
        else ""

    fun helper(i: int, res: string): string =
        if i > 0 then helper(i / b, dig2str(i % b) + res)
        else res
in
  if i = 0 then "0"
  else helper(i, "")
end

implement
int2str(n) = int2string(n, 10)

implement
char2int(c) =
case+ c of
| '0' => 0
| '1' => 1
| '2' => 2
| '3' => 3
| '4' => 4
| '5' => 5
| '6' => 6
| '7' => 7
| '8' => 8
| '9' => 9
| _ => ~1

implement
string2int(s) = let
  val xs = string_explode(s)
in
  list0_foldleft<int><int>
  (
  list0_map<char><int>(xs, lam(x) => char2int(x))
  , 0
  , lam(res, x) => x + (res * 10)
  )
end

(* ****** ****** *)

implement
{a}
pop_last(xs) = let
  fun 
  {a:t@ype}
  aux(xs: list0(a), res: list0(a)): list0(a) =
    case- xs of
    | cons0(x, xs) =>
      (
        case+ xs of
        | nil0() => list0_reverse(res)
        | cons0(_, _) => aux(xs, cons0(x, res))
      ) 
in
  aux(xs, nil0())
end

implement
parse_args(s) = let
  val xs = string_explode(s)
  
  fun aux(xs: list0(char), res: list0(string), s: string): list0(string) =
    case+ xs of
    | list0_nil() => list0_reverse(cons0(s, res))
    | list0_cons(x, xs) => 
          if x = ' ' 
          then aux(xs, cons0(s, res), "")
          else aux(xs, res, s + string_implode(list0_sing(x)))
in
  aux(xs, nil0(), "")
end


implement
parse_csv(s) = let
  fun aux(xs: list0(char), res: list0(string), s: string): list0(string) =
    case+ xs of
    | list0_nil() => list0_reverse(cons0(s, res))
    | list0_cons(x, xs) => 
            if x = ','
            then aux(xs, cons0(s, res), "")
            else aux(xs, res, s + string_implode(list0_sing(x)))
in
  aux(string_explode(s), nil0(), "")
end

(* ****** ****** *)

%{
#include <time.h>

char *cget_time() {
  time_t curtime;
  time(&curtime);
  char * s = ctime(&curtime);
  return s;
}
%}


implement
get_date() = let
  
  fun parse(s: string): string = let
    val xs = string_explode(s)
  
    fun aux(xs: list0(char), ys: list0(char)): string =
      case+ xs of
      | list0_nil() => string_make_rlist(g1ofg0(ys))
      | list0_cons(x, xs) => 
        if x = ' ' then aux(xs, cons0('-', ys))
        else 
        (
          if x = '\n' then aux(xs, ys)
          else aux(xs, cons0(x, ys))
        )
  in
    aux(xs, nil0())
  end

in
  parse(cget_time())
end


implement
get_time() = let
  
  fun parse(s: string): string = let
    val xs = string_explode(s)
  
    fun aux(xs: list0(char), ys: list0(char), i: int): string =
      case+ xs of
      | list0_nil() => string_make_rlist(g1ofg0(ys))
      | list0_cons(x, xs) => 
        if x = ' '
        then 
        (
          if i <= 3
          then aux(xs, ys, i + 1)
          else aux(xs, cons0('-', ys), i)
        )
        else 
        (
          if x = '\n' then aux(xs, ys, i)
          else 
          (
            if i >= 3
            then aux(xs, cons0(x, ys), i)
            else aux(xs, ys, i)
          )
        )
  in
    aux(xs, nil0(), 0)
  end

in
  parse(cget_time())
end

(* ****** ****** *)

(* end of [string_base.dats] *)