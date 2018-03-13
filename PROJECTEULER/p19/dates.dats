(* ****** ****** *)
//
// LG 2018-03-13
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

typedef int3 = (int, int, int)

(* ****** ****** *)

extern
fun
next_date(day: int, month: int, year: int): int3

extern
fun
count(from: int3, to: int3, wkdy: int): int

(* ****** ****** *)

implement
next_date(day, month, year) = 
ifcase
| month = 4 orelse month = 6 orelse month = 9 orelse month = 11 =>
    if day = 30 then (1, month + 1, year)
    else (day + 1, month, year)
| month = 2 =>
    if day = 28 then 
    (
      if year % 4 = 0 orelse year % 400 = 0
      then 
      (
        if year % 100 = 0 
        then (1, month + 1, year)
        else 
        (
          if day = 29 then (1, month + 1, year)
          else (day + 1, month, year)
        )
      )
      else (1, month + 1, year)
    )
    else
    (
      if day = 29 then (1, month + 1, year)
      else (day + 1, month, year)
    )
| month = 12 => 
    if day = 31 then (1, 1, year + 1)
    else (day + 1, month, year)
| _ => 
    if day = 31 then (1, month + 1, year)
    else (day + 1, month, year)

implement
count(from, to, wkdy) = let
  fun equal(d1: int3, d2: int3): bool =
    (d1.0 = d2.0) andalso (d1.1 = d2.1) andalso (d1.2 = d2.2)

  fun aux(d1: int3, res: int, wkdy: int): int = let
      val () = println!("date = (", d1.0, ", ", d1.1, ", ", d1.2, ")")
    in
      if equal(d1, to) then res
      else 
      (
        if wkdy = 6 andalso d1.0 = 1 
        then 
        (
          if d1.2 < 1901
          then aux(next_date(d1.0, d1.1, d1.2), res, (wkdy + 1) % 7)
          else aux(next_date(d1.0, d1.1, d1.2), res + 1, (wkdy + 1) % 7)
        )
        else aux(next_date(d1.0, d1.1, d1.2), res, (wkdy + 1) % 7)
      )
    end
in
  aux(from, 0, wkdy)
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val () = println!("Number of Sundays that fall on the first of the month since 1/1/1901 are ", count((1, 1, 1900), (31, 12, 2000), 0))
}

(* ****** ****** *)

(* end of [dates.dats] *)