
(* ****** ****** *)
//
// LG 2018-02-22
//
(* ****** ****** *)

extern
fun
set_row(bd: board, row_num: int, row: int9) : board

extern
fun
set_elm(bd: board, elm_num: int, elm: int) : board

(* ****** ****** *)

implement
set_row(bd, row_num, row) = let
  val-(r0, r1, r2, r3, r4, r5, r6, r7, r8) = bd
in
  if row_num = 0 then let val r0 = row in (r0, r1, r2, r3, r4, r5, r6, r7, r8) end
  else if row_num = 1 then let val r1 = row in (r0, r1, r2, r3, r4, r5, r6, r7, r8) end
  else if row_num = 2 then let val r2 = row in (r0, r1, r2, r3, r4, r5, r6, r7, r8) end
  else if row_num = 3 then let val r3 = row in (r0, r1, r2, r3, r4, r5, r6, r7, r8) end
  else if row_num = 4 then let val r4 = row in (r0, r1, r2, r3, r4, r5, r6, r7, r8) end
  else if row_num = 5 then let val r5 = row in (r0, r1, r2, r3, r4, r5, r6, r7, r8) end
  else if row_num = 6 then let val r6 = row in (r0, r1, r2, r3, r4, r5, r6, r7, r8) end
  else if row_num = 7 then let val r7 = row in (r0, r1, r2, r3, r4, r5, r6, r7, r8) end
  else if row_num = 8 then let val r8 = row in (r0, r1, r2, r3, r4, r5, r6, r7, r8) end
  else bd
end

implement
set_elm(bd, elm_num, elm) = 
let
  val row_num = elm_num / 9
  val elm_num = elm_num % 9
  val-(r0, r1, r2, r3, r4, r5, r6, r7, r8) = get_row(bd, row_num)
in
  if elm_num= 0 then let val r0 = elm in set_row(bd, row_num, (r0, r1, r2, r3, r4, r5, r6, r7, r8)) end
  else if elm_num= 1 then let val r1 = elm in set_row(bd, row_num, (r0, r1, r2, r3, r4, r5, r6, r7, r8)) end
  else if elm_num= 2 then let val r2 = elm in set_row(bd, row_num, (r0, r1, r2, r3, r4, r5, r6, r7, r8)) end
  else if elm_num= 3 then let val r3 = elm in set_row(bd, row_num, (r0, r1, r2, r3, r4, r5, r6, r7, r8)) end
  else if elm_num= 4 then let val r4 = elm in set_row(bd, row_num, (r0, r1, r2, r3, r4, r5, r6, r7, r8)) end
  else if elm_num= 5 then let val r5 = elm in set_row(bd, row_num, (r0, r1, r2, r3, r4, r5, r6, r7, r8)) end
  else if elm_num= 6 then let val r6 = elm in set_row(bd, row_num, (r0, r1, r2, r3, r4, r5, r6, r7, r8)) end
  else if elm_num= 7 then let val r7 = elm in set_row(bd, row_num, (r0, r1, r2, r3, r4, r5, r6, r7, r8)) end
  else if elm_num= 8 then let val r8 = elm in set_row(bd, row_num, (r0, r1, r2, r3, r4, r5, r6, r7, r8)) end
  else bd
end

(* ****** ****** *)

(* end of [set_board.dats] *)