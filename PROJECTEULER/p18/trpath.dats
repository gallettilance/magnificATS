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
char2int(c: char): int

extern
fun
string2int(s: string): int

extern
fun
max(xs: list0(int)): int

extern
fun
myfold(xs: list0(int), ys: list0(int)): list0(int)

extern
fun
max_path(xss: list0(list0(int))): int

(* ****** ****** *)

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
| _ => (println!("not a valid char");  ~1)

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

implement
myfold(xs, ys) = let
  val f1 = list0_map2<int,int><int>(cons0(0, ys), xs, lam(y, x) => x + y)
  val f2 = list0_map2<int,int><int>(list0_append(ys, list0_sing(0)), xs, lam(y, x) => x + y)
in
  list0_map2<int, int><int>(f1, f2, lam(x, y) => if x > y then x else y)
end

implement
max(xs) = let
  val () = assertloc(list0_length(xs) > 0)

  fun aux(xs: list0(int), m:int): int =
      case+ xs of
      | nil0() => m
      | cons0(x, xs) => if x > m then aux(xs, x) else aux(xs, m)

in
  case- xs of
  | cons0(x, xs) => aux(xs, x)
end

implement
max_path(xss) =
max
(
  list0_foldleft<list0(int)>(xss, nil0(), lam(res, xs) => myfold(xs, res))
)


(* ****** ****** *)

implement
main0() = ()
where
{
  val input = g0ofg1($list(
    g0ofg1($list("75")),
    g0ofg1($list("95", "64")),
    g0ofg1($list("17", "47", "82")),
    g0ofg1($list("18", "35", "87", "10")),
    g0ofg1($list("20", "04", "82", "47", "65")),
    g0ofg1($list("19", "01", "23", "75", "03", "34")),
    g0ofg1($list("88", "02", "77", "73", "07", "63", "67")),
    g0ofg1($list("99", "65", "04", "28", "06", "16", "70", "92")),
    g0ofg1($list("41", "41", "26", "56", "83", "40", "80", "70", "33")),
    g0ofg1($list("41", "48", "72", "33", "47", "32", "37", "16", "94", "29")),
    g0ofg1($list("53", "71", "44", "65", "25", "43", "91", "52", "97", "51", "14")),
    g0ofg1($list("70", "11", "33", "28", "77", "73", "17", "78", "39", "68", "17", "57")),
    g0ofg1($list("91", "71", "52", "38", "17", "14", "91", "43", "58", "50", "27", "29", "48")),
    g0ofg1($list("63", "66", "04", "68", "89", "53", "67", "30", "73", "16", "69", "87", "40", "31")),
    g0ofg1($list("04", "62", "98", "27", "23", "09", "70", "98", "73", "93", "38", "53", "60", "04", "23"))
    ))

  val triangle = list0_map<list0(string)><list0(int)>(input, lam(inp) => list0_map<string><int>(inp, lam(i) => string2int(i)))
  val () = (triangle).foreach()(lam(t) => println!(t))
  val max = max_path(triangle)
  val () = println!("max path is ", max)
}

(* ****** ****** *)

(* end of [trpath.dats] *)