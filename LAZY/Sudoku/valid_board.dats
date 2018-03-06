(* ****** ****** *)
//
// LG 2018-02-22
//
(* ****** ****** *)

extern
fun
check_any_equal(row: int9, elm:int): bool

extern
fun
safety_test_row(bd: board, i: int, elm: int) : bool

extern
fun
safety_test_col(bd: board, i: int, elm: int) : bool

extern
fun
safety_test_box(bd: board, i: int, elm: int) : bool

extern
fun
is_valid_move(bd: board, i: int, elm: int): bool

extern
fun
is_legal_move(old: board, i: int): bool

(* ****** ****** *)

implement
check_any_equal(row, elm) = let
  val-(r0, r1, r2, r3, r4, r5, r6, r7, r8) = row
in
  if r0 = elm then false
  else if r1 = elm then false
  else if r2 = elm then false
  else if r3 = elm then false
  else if r4 = elm then false
  else if r5 = elm then false
  else if r6 = elm then false
  else if r7 = elm then false
  else if r8 = elm then false
  else true  
end

implement
is_legal_move(old, i) = 
get_elm(old, i) <= 0

implement
safety_test_row(bd, i, elm) = let
  val row_num = i / 9
  val row = get_row(bd, row_num)
in
  check_any_equal(row, elm)
end

implement
safety_test_col(bd, i, elm) = let
  val col_num = i % 9
  val col = get_col(bd, col_num)
in
  check_any_equal(col, elm)
end

implement
safety_test_box(bd, i, elm) = let
  val box_row = i / 27
  val box_col = (i % 9) / 3
  val box_num = (3 * box_row) + box_col
  val box = get_box(bd, box_num)
in
  check_any_equal(box, elm)
end

implement
is_valid_move(bd, i, elm) =
if elm > 9 orelse elm < 1 then false
else
((
safety_test_row(bd, i, elm) 
andalso
safety_test_box(bd, i, elm)
)
andalso
safety_test_col(bd, i, elm)
)

(* ****** ****** *)

(* end of [valid_board.dats] *)