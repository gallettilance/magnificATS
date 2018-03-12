(* ****** ****** *)
//
// LG 2018-03-12
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

typedef grid = list0(list0(string))

(* ****** ****** *)

extern
fun
grid(g: grid, n: int): int

extern
fun
char2int(c: char): int

extern
fun
string2int(s: string): int

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
grid(g, n) = let
  val gs = list0_map<list0(string)><list0(int)>(g, lam(xs) => list0_map<string><int>(xs, lam(s) => string2int(s)))
  
  fun get_at_col(xs: list0(int), j: int): int =
    case+ xs of
    | list0_nil() => 1 //mul indentity
    | list0_cons(x, xs) => 
        if j = 0 then x 
        else 
        (
          if j < 0 then get_at_col(nil0(), j)
          else get_at_col(xs, j - 1)
        )
        
  fun get_at_row(xss: list0(list0(int)), i: int): list0(int) =
    case+ xss of
    | list0_nil() => g0ofg1($list( 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
    | list0_cons(xs, xss) => 
          if i = 0 then xs 
          else 
          (
            if i < 0 then get_at_row(nil0(), i) 
            else get_at_row(xss, i - 1)
          )
    
  fun get_elem(xss: list0(list0(int)), i: int, j: int): int =
    case- xss of
    | list0_cons(_, _) => get_at_col(get_at_row(xss, i), j)
  
  fun get_next4_row(xss: list0(list0(int)), i: int, j: int): list0(int) = let
      val x1 = get_elem(xss, i, j)
      val x2 = get_elem(xss, i, j + 1)
      val x3 = get_elem(xss, i, j + 2)
      val x4 = get_elem(xss, i, j + 3)
    in
      cons0(x1, cons0(x2, cons0(x3, cons0(x4, nil0()))))
    end
  
  fun get_next4_col(xss: list0(list0(int)), i: int, j: int): list0(int) = let
      val x1 = get_elem(xss, i, j)
      val x2 = get_elem(xss, i + 1, j)
      val x3 = get_elem(xss, i + 2, j)
      val x4 = get_elem(xss, i + 3, j)
    in
      cons0(x1, cons0(x2, cons0(x3, cons0(x4, nil0()))))
    end

  fun get_next4_diag1(xss: list0(list0(int)), i: int, j: int): list0(int) = let
      val x1 = get_elem(xss, i, j)
      val x2 = get_elem(xss, i + 1, j + 1)
      val x3 = get_elem(xss, i + 2, j + 2)
      val x4 = get_elem(xss, i + 3, j + 3)
    in
      cons0(x1, cons0(x2, cons0(x3, cons0(x4, nil0()))))
    end

  fun get_next4_diag2(xss: list0(list0(int)), i: int, j: int): list0(int) = let
      val x1 = get_elem(xss, i, j)
      val x2 = get_elem(xss, i + 1, j - 1)
      val x3 = get_elem(xss, i + 2, j - 2)
      val x4 = get_elem(xss, i + 3, j - 3)
    in
      cons0(x1, cons0(x2, cons0(x3, cons0(x4, nil0()))))
    end

  fun aux(xss: list0(list0(int)), i: int, j: int, max: int): int =
    case+ xss of
    | nil0() => max
    | cons0(xs, xss1) =>
      ( 
        if j >= 20 then (println!("xs = ", xs); aux(xss1, i + 1, 0, max))
        else
        (
          let
            val r = list0_foldleft<int><int>(get_next4_row(xss, i, j), 1, lam(res, x) => x * res)
            val c = list0_foldleft<int><int>(get_next4_col(xss, i, j), 1, lam(res, x) => x * res)
            val d1 = list0_foldleft<int><int>(get_next4_diag1(xss, i, j), 1, lam(res, x) => x * res)
            val d2 = list0_foldleft<int><int>(get_next4_diag2(xss, i, j), 1, lam(res, x) => x * res)
            val () = println!("max = ", max)
          in
            ifcase
            | r > max => aux(xss, i, j + 1, r)
            | c > max => aux(xss, i, j + 1, c)
            | d1 > max => aux(xss, i, j + 1, d1)
            | d2 > max => aux(xss, i, j + 1, d2)
            | _ => aux(xss, i, j + 1, max)
          end
        )
      )
in
  aux(gs, 0, 0, 0)
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val g = g0ofg1($list(
 g0ofg1($list( "08", "02", "22", "97", "38", "15", "00", "40", "00", "75", "04", "05", "07", "78", "52", "12", "50", "77", "91", "08")),
 g0ofg1($list( "49", "49", "99", "40", "17", "81", "18", "57", "60", "87", "17", "40", "98", "43", "69", "48", "04", "56", "62", "00")),
 g0ofg1($list( "81", "49", "31", "73", "55", "79", "14", "29", "93", "71", "40", "67", "53", "88", "30", "03", "49", "13", "36", "65")),
 g0ofg1($list( "52", "70", "95", "23", "04", "60", "11", "42", "69", "24", "68", "56", "01", "32", "56", "71", "37", "02", "36", "91")),
 g0ofg1($list( "22", "31", "16", "71", "51", "67", "63", "89", "41", "92", "36", "54", "22", "40", "40", "28", "66", "33", "13", "80")),
 g0ofg1($list( "24", "47", "32", "60", "99", "03", "45", "02", "44", "75", "33", "53", "78", "36", "84", "20", "35", "17", "12", "50")),
 g0ofg1($list( "32", "98", "81", "28", "64", "23", "67", "10", "26", "38", "40", "67", "59", "54", "70", "66", "18", "38", "64", "70")),
 g0ofg1($list( "67", "26", "20", "68", "02", "62", "12", "20", "95", "63", "94", "39", "63", "08", "40", "91", "66", "49", "94", "21")),
 g0ofg1($list( "24", "55", "58", "05", "66", "73", "99", "26", "97", "17", "78", "78", "96", "83", "14", "88", "34", "89", "63", "72")),
 g0ofg1($list( "21", "36", "23", "09", "75", "00", "76", "44", "20", "45", "35", "14", "00", "61", "33", "97", "34", "31", "33", "95")),
 g0ofg1($list( "78", "17", "53", "28", "22", "75", "31", "67", "15", "94", "03", "80", "04", "62", "16", "14", "09", "53", "56", "92")),
 g0ofg1($list( "16", "39", "05", "42", "96", "35", "31", "47", "55", "58", "88", "24", "00", "17", "54", "24", "36", "29", "85", "57")),
 g0ofg1($list( "86", "56", "00", "48", "35", "71", "89", "07", "05", "44", "44", "37", "44", "60", "21", "58", "51", "54", "17", "58")),
 g0ofg1($list( "19", "80", "81", "68", "05", "94", "47", "69", "28", "73", "92", "13", "86", "52", "17", "77", "04", "89", "55", "40")),
 g0ofg1($list( "04", "52", "08", "83", "97", "35", "99", "16", "07", "97", "57", "32", "16", "26", "26", "79", "33", "27", "98", "66")),
 g0ofg1($list( "88", "36", "68", "87", "57", "62", "20", "72", "03", "46", "33", "67", "46", "55", "12", "32", "63", "93", "53", "69")),  
 g0ofg1($list( "04", "42", "16", "73", "38", "25", "39", "11", "24", "94", "72", "18", "08", "46", "29", "32", "40", "62", "76", "36")),
 g0ofg1($list( "20", "69", "36", "41", "72", "30", "23", "88", "34", "62", "99", "69", "82", "67", "59", "85", "74", "04", "36", "16")),
 g0ofg1($list( "20", "73", "35", "29", "78", "31", "90", "01", "74", "31", "49", "71", "48", "86", "81", "16", "23", "57", "05", "54")),
 g0ofg1($list( "01", "70", "54", "71", "83", "51", "54", "69", "16", "92", "33", "48", "61", "43", "52", "01", "89", "19", "67", "48"))
  ))
  val lp = grid(g, 4)
  val () = println!("Largest Product in the grid = ", lp)
}

(* ****** ****** *)

(* end of [pytha.dats] *)