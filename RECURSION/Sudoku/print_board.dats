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
    print!( row.0, " ") ; print!( row.1, " ") ; print!( row.2, " | ") ;
    print!( row.3, " ") ; print!( row.4, " ") ; print!( row.5, " | ") ;
    print!( row.6, " ") ; print!( row.7, " ") ; print!( row.8, " ") ;
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
    println!( col.0, " ") ; println!( col.1, " ") ; println!( col.2, " ") ;
    println!( col.3, " ") ; println!( col.4, " ") ; println!( col.5, " ") ;
    println!( col.6, " ") ; println!( col.7, " ") ; println!( col.8, " ") ;
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
    print!( row.0, " ") ; print!( row.1, " ") ; println!( row.2, " | ") ;
    print!( row.3, " ") ; print!( row.4, " ") ; println!( row.5, " | ") ;
    print!( row.6, " ") ; print!( row.7, " ") ; println!( row.8, " | ") ;
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