(* ****** ****** *)
//
// LG 2018-02-22
//
(* ****** ****** *)

extern
fun
print_row(row: int9): void // stdout
and
prerr_row(row: int9): void // stderr

extern
fun
print_board(bd: board): void // stdout
and
prerr_board(bd: board): void // stderr

extern
fun
fprint_row(out: FILEref, row: int9): void

extern
fun
fprint_board(out: FILEref, bd: board): void

(* ****** ****** *)

overload print with print_row
overload print with print_board
overload prerr with prerr_row
overload prerr with prerr_board
overload fprint with fprint_row
overload fprint with fprint_board

(* ****** ****** *)

implement
print_row(row) = fprint_row(stdout_ref, row)
implement
prerr_row(row) = fprint_row(stderr_ref, row)

implement
print_board(board) = fprint_board(stdout_ref, board)
implement
prerr_board(board) = fprint_board(stderr_ref, board)

(* ****** ****** *)

implement
fprint_row
(out, row) =
(
    if row.0 = 0 then fprint!(out, "* ") else fprint!(out,  row.0, " ") ; if row.1 = 0 then fprint!(out, "* ") else fprint!(out,  row.1, " ") ; if row.2 = 0 then fprint!(out, "* | ") else fprint!(out,  row.2, " | ") ;
    if row.3 = 0 then fprint!(out, "* ") else fprint!(out,  row.3, " ") ; if row.4 = 0 then fprint!(out, "* ") else fprint!(out,  row.4, " ") ; if row.5 = 0 then fprint!(out, "* | ") else fprint!(out,  row.5, " | ") ;
    if row.6 = 0 then fprint!(out, "* ") else fprint!(out,  row.6, " ") ; if row.7 = 0 then fprint!(out, "* ") else fprint!(out,  row.7, " ") ; if row.8 = 0 then fprint!(out, "* | ") else fprint!(out, row.8, " | ") ;
    fprint!(out, "\n")
)  

implement
fprint_board(out, bd) = let
  val-(r0, r1, r2, r3, r4, r5, r6, r7, r8) = bd
in
(
  fprint!(out, r0) ; fprint!(out, r1); fprint!(out, r2) ;
  fprint!(stdout_ref, "- - -   - - -   - - - \n") ;
  fprint!(out, r3) ; fprint!(out, r4); fprint!(out, r5) ;
  fprint!(stdout_ref, "- - -   - - -   - - - \n") ;
  fprint!(out, r6) ; fprint!(out, r7); fprint!(out, r8) ;
)
end

(* ****** ****** *)

extern
fun
print_col(bd: board, i: int) : void

extern
fun
print_box(bd: board, box_num: int) : void

(* ****** ****** *)

implement
print_col(bd, i) = 
if i >= 0 andalso i < 9
then
  let
    val col = get_col(bd, i)
  in
    (
    if col.0 = 0 then println!("* ") else println!( col.0, " ") ; if col.1 = 0 then println!("* ") else println!( col.1, " ") ; if col.2 = 0 then println!("* ") else println!( col.2, " ") ;
    if col.3 = 0 then println!("* ") else println!( col.3, " ") ; if col.4 = 0 then println!("* ") else println!( col.4, " ") ; if col.5 = 0 then println!("* ") else println!( col.5, " ") ;
    if col.6 = 0 then println!("* ") else println!( col.6, " ") ; if col.7 = 0 then println!("* ") else println!( col.7, " ") ; if col.8 = 0 then println!("* ") else println!( col.8, " ") ;
    print_newline()
    )  
  end
else ()

implement
print_box(bd, box_num) =
if box_num >= 0 andalso box_num < 9
then
  let
    val row = get_box(bd, box_num)
  in
    (
    if row.0 = 0 then print!("* ") else print!( row.0, " ") ; if row.1 = 0 then print!("* ") else print!( row.1, " ") ; if row.2 = 0 then println!("* | ") else println!( row.2, " | ") ;
    if row.3 = 0 then print!("* ") else print!( row.3, " ") ; if row.4 = 0 then print!("* ") else print!( row.4, " ") ; if row.5 = 0 then println!("* | ") else println!( row.5, " | ") ;
    if row.6 = 0 then print!("* ") else print!( row.6, " ") ; if row.7 = 0 then print!("* ") else print!( row.7, " ") ; if row.8 = 0 then println!("* | ") else println!( row.8, " | ") ;
    print_newline()
    )
  end
else ()

(* ****** ****** *)

(* end of [print_board.dats] *)