(* ****** ****** *)
//
// LG 2018-02-22
//
(* ****** ****** *)

extern
fun
print_row(bd: board, i: int) : void

extern
fun
print_col(bd: board, i: int) : void

extern
fun
print_box(bd: board, box_num: int) : void

extern
fun
print_board(bd: board) : void

(* ****** ****** *)

implement
print_row(bd, i) = 
if i >= 0 andalso i < 9
then
  let
    val row = get_row(bd, i)
  in
    (
    if row.0 = 0 then print!("* ") else print!( row.0, " ") ; if row.1 = 0 then print!("* ") else print!( row.1, " ") ; if row.2 = 0 then print!("* | ") else print!( row.2, " | ") ;
    if row.3 = 0 then print!("* ") else print!( row.3, " ") ; if row.4 = 0 then print!("* ") else print!( row.4, " ") ; if row.5 = 0 then print!("* | ") else print!( row.5, " | ") ;
    if row.6 = 0 then print!("* ") else print!( row.6, " ") ; if row.7 = 0 then print!("* ") else print!( row.7, " ") ; if row.8 = 0 then print!("* | ") else print!( row.8, " | ") ;
    print_newline()
    )  
  end
else ()

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

implement
print_board(bd) =
(
  print_row(bd, 0) ; print_row(bd, 1); print_row(bd, 2) ;
  println!("- - -   - - -   - - - ") ;
  print_row(bd, 3) ; print_row(bd, 4); print_row(bd, 5) ;
  println!("- - -   - - -   - - - ") ;
  print_row(bd, 6) ; print_row(bd, 7); print_row(bd, 8) ;
)

(* ****** ****** *)

(* end of [print_board.dats] *)