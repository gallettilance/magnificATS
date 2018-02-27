(* ****** ****** *)
//
// LG 2018-02-22
//
(* ****** ****** *)

extern
fun
get_row(bd: board, i: int) : int9

extern
fun
get_col(bd: board, i: int) : int9

extern
fun
get_box(bd: board, box_num: int) : int9

extern
fun
get_elm(bd: board, elm_num: int) : int

(* ****** ****** *)

implement
get_box(bd, i) = let
  val (x0, x1, x2, x3, x4, x5, x6, x7, x8) = bd
in
  if i = 0 then      (x0.0, x0.1, x0.2, x1.0, x1.1, x1.2, x2.0, x2.1, x2.2)
  else if i = 1 then (x0.3, x0.4, x0.5, x1.3, x1.4, x1.5, x2.3, x2.4, x2.5)
  else if i = 2 then (x0.6, x0.7, x0.8, x1.6, x1.7, x1.8, x2.6, x2.7, x2.8)
  else if i = 3 then (x3.0, x3.1, x3.2, x4.0, x4.1, x4.2, x5.0, x5.1, x5.2)
  else if i = 4 then (x3.3, x3.4, x3.5, x4.3, x4.4, x4.5, x5.3, x5.4, x5.5)
  else if i = 5 then (x3.6, x3.7, x3.8, x4.6, x4.7, x4.8, x5.6, x5.7, x5.8)
  else if i = 6 then (x6.0, x6.1, x6.2, x7.0, x7.1, x7.2, x8.0, x8.1, x8.2)
  else if i = 7 then (x6.3, x6.4, x6.5, x7.3, x7.4, x7.5, x8.3, x8.4, x8.5)
  else if i = 8 then (x6.6, x6.7, x6.8, x7.6, x7.7, x7.8, x8.6, x8.7, x8.8)
  else               (~3, ~3, ~3, ~3, ~3, ~3, ~3, ~3, ~3)
end

implement
get_col(bd, i) = let
  val (x0, x1, x2, x3, x4, x5, x6, x7, x8) = bd
in
  if i = 0 then      (x0.0, x1.0, x2.0, x3.0, x4.0, x5.0, x6.0, x7.0, x8.0)
  else if i = 1 then (x0.1, x1.1, x2.1, x3.1, x4.1, x5.1, x6.1, x7.1, x8.1)
  else if i = 2 then (x0.2, x1.2, x2.2, x3.2, x4.2, x5.2, x6.2, x7.2, x8.2)
  else if i = 3 then (x0.3, x1.3, x2.3, x3.3, x4.3, x5.3, x6.3, x7.3, x8.3)
  else if i = 4 then (x0.4, x1.4, x2.4, x3.4, x4.4, x5.4, x6.4, x7.4, x8.4)
  else if i = 5 then (x0.5, x1.5, x2.5, x3.5, x4.5, x5.5, x6.5, x7.5, x8.5)
  else if i = 6 then (x0.6, x1.6, x2.6, x3.6, x4.6, x5.6, x6.6, x7.6, x8.6)
  else if i = 7 then (x0.7, x1.7, x2.7, x3.7, x4.7, x5.7, x6.7, x7.7, x8.7)
  else if i = 8 then (x0.8, x1.8, x2.8, x3.8, x4.8, x5.8, x6.8, x7.8, x8.8)
  else               (~3, ~3, ~3, ~3, ~3, ~3, ~3, ~3, ~3)
end

implement
get_row(bd, row_num) = 
if row_num = 0 then bd.0
else if row_num = 1 then bd.1
else if row_num = 2 then bd.2
else if row_num = 3 then bd.3
else if row_num = 4 then bd.4
else if row_num = 5 then bd.5
else if row_num = 6 then bd.6
else if row_num = 7 then bd.7
else if row_num = 8 then bd.8
else (~3, ~3, ~3, ~3, ~3, ~3, ~3, ~3, ~3)

implement
get_elm(bd, elm_num) = let
  val row = get_row(bd, elm_num / 9)
  val elm = elm_num - (9 * (elm_num / 9))
in
  if elm = 0 then row.0
  else if elm = 1 then row.1
  else if elm = 2 then row.2
  else if elm = 3 then row.3
  else if elm = 4 then row.4
  else if elm = 5 then row.5
  else if elm = 6 then row.6
  else if elm = 7 then row.7
  else if elm = 8 then row.8
  else ~2
end

(* ****** ****** *)

(* end of [get_board.dats] *)