(* ****** ****** *)
//
// LG 2018-03-12
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

#include
"$PATSHOMELOCS\
/atscntrb-hx-intinf/mylibies.hats"

#include
"$PATSHOMELOCS\
/atscntrb-hx-mytesting/mylibies.hats"

(* ****** ****** *)

typedef
intinf = $GINTINF_t.intinf

overload
print with $GINTINF_t.print_intinf

(* ****** ****** *)

val intinf = gnumber_int<intinf>

(* ****** ****** *)

val gadd = gadd_val_val<intinf>
val gsub = gsub_val_val<intinf>
val gmul = gmul_val_val<intinf>
val gdiv = gdiv_val_val<intinf>
val gcompare = gcompare_val_val<intinf>

overload * with gmul
overload + with gadd
overload / with gdiv
overload - with gsub
overload compare with gcompare

fun
gmod(x: intinf, y: intinf) = x - (x / y)  * y

overload % with gmod

(* ****** ****** *)

extern
fun
read_loop(lines: stream_vt(string)): intinf

extern
fun
char2intinf(c: char): intinf

extern
fun
string2intinf(s: string): intinf

(* ****** ****** *)

implement
char2intinf(c) =
case+ c of
| '0' => intinf(0)
| '1' => intinf(1)
| '2' => intinf(2)
| '3' => intinf(3)
| '4' => intinf(4)
| '5' => intinf(5)
| '6' => intinf(6)
| '7' => intinf(7)
| '8' => intinf(8)
| '9' => intinf(9)
| _ => (println!("not a valid char");  intinf(~1))

implement
string2intinf(s) = let
  val xs = string_explode(s)
in
  list0_foldleft<intinf><intinf>
  (
  list0_map<char><intinf>(xs, lam(x) => char2intinf(x))
  , intinf(0)
  , lam(res, x) => x + (res * intinf(10))
  )
end

implement
read_loop(lines) = let
  fun aux(ls: stream_vt(string), res: intinf): intinf =
    case+ !ls of
    | ~stream_vt_nil() => res
    | ~stream_vt_cons(l, ls) => aux(ls, string2intinf(l) + res)
in
  aux(lines, intinf(0))
end

(* ****** ****** *)

implement
main0() = ()
where
{

  val db = fileref_open_opt("./intinf.txt", file_mode_r)
  val-~Some_vt(inp) = db
  val theLines = streamize_fileref_line(inp)
  val sum = read_loop(theLines)
  val () = println!("Sum of the lines is ", sum)
}

(* ****** ****** *)

(* end of [intinf.dats] *)