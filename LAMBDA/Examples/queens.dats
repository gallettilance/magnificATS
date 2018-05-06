(* ****** ****** *)
//
// LG 2018-02-12
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "./../mylibies.dats"

(* ****** ****** *)

#define N TMint(8)

val t = TMvar("t")
val x = TMvar("x")
val f = TMvar("f")
val ij = TMvar("ij")
val bd = TMvar("bd")
val bdi = TMvar("bdi")
val bdij = TMvar("bdij")
val arg = TMvar("arg")
val args = TMvar("args")

val print_dots = 
TMfix("f", "t",
  TMifnz(t > TMint(0) ,
    TMseq( TMopr("print", list0_tuple(TMstr(". "))), TMapp(f, t - TMint(1)) ), TMopr("print", list0_sing(TMstr("")) )))

val print_row =
TMlam("t",
  TMseq(
    TMseq(
      TMapp(print_dots, t), 
      TMopr("print", list0_tuple(TMstr("Q ")))
    ),
    TMseq(
      TMapp(print_dots, N - t - TMint(1)),
      TMopr("println", list0_sing(TMstr("")) )
    )
  )
)

val print_board = 
TMlam("bd",
TMseq(  
  TMseq(
    TMseq(
      TMapp( print_row, TMproj(bd, 0)),
      TMapp( print_row, TMproj(bd, 1))
    ), 
    TMseq(
      TMapp( print_row, TMproj(bd, 2)),
      TMapp( print_row, TMproj(bd, 3))
  )),
  TMseq(
    TMseq(
      TMapp( print_row, TMproj(bd, 4)),
      TMapp( print_row, TMproj(bd, 5))
    ), 
    TMseq(
      TMapp( print_row, TMproj(bd, 6)),
      TMapp( print_row, TMproj(bd, 7))
  ))
))

val board_get =
TMlam("bdi",
  TMifnz( TMproj(bdi, 1) = TMint(0), TMproj(TMproj(bdi, 0), 0),
  TMifnz( TMproj(bdi, 1) = TMint(1), TMproj(TMproj(bdi, 0), 1),
  TMifnz( TMproj(bdi, 1) = TMint(2), TMproj(TMproj(bdi, 0), 2),
  TMifnz( TMproj(bdi, 1) = TMint(3), TMproj(TMproj(bdi, 0), 3),
  TMifnz( TMproj(bdi, 1) = TMint(4), TMproj(TMproj(bdi, 0), 4),
  TMifnz( TMproj(bdi, 1) = TMint(5), TMproj(TMproj(bdi, 0), 5),
  TMifnz( TMproj(bdi, 1) = TMint(6), TMproj(TMproj(bdi, 0), 6),
  TMifnz( TMproj(bdi, 1) = TMint(7), TMproj(TMproj(bdi, 0), 7),
  TMint(0)))))))))
)

val board_set =
TMlam("bdij",
  TMifnz( TMproj(bdij, 1) = TMint(0),
  
    TMtup(
      cons0(TMproj(bdij, 2), 
        cons0(TMproj(TMproj(bdij, 0), 1),
          cons0(TMproj(TMproj(bdij, 0), 2), 
            cons0(TMproj(TMproj(bdij, 0), 3), 
              cons0(TMproj(TMproj(bdij, 0), 4), 
                cons0(TMproj(TMproj(bdij, 0), 5), 
                  cons0(TMproj(TMproj(bdij, 0), 6), 
                    cons0(TMproj(TMproj(bdij, 0), 7), 
                    nil0())
     )))))))),  
  
  TMifnz( TMproj(bdij, 1) = TMint(1),
  
    TMtup(
      cons0( TMproj(TMproj(bdij, 0), 0), 
        cons0(TMproj(bdij, 2), 
          cons0(TMproj(TMproj(bdij, 0), 2), 
            cons0(TMproj(TMproj(bdij, 0), 3), 
              cons0(TMproj(TMproj(bdij, 0), 4), 
                cons0(TMproj(TMproj(bdij, 0), 5), 
                  cons0(TMproj(TMproj(bdij, 0), 6), 
                    cons0(TMproj(TMproj(bdij, 0), 7), 
                    nil0())
      )))))))),
          
  TMifnz( TMproj(bdij, 1) = TMint(2),
    
    TMtup(
      cons0( TMproj(TMproj(bdij, 0), 0), 
        cons0(TMproj(TMproj(bdij, 0), 1), 
          cons0(TMproj(bdij, 2), 
            cons0(TMproj(TMproj(bdij, 0), 3), 
              cons0(TMproj(TMproj(bdij, 0), 4), 
                cons0(TMproj(TMproj(bdij, 0), 5), 
                  cons0(TMproj(TMproj(bdij, 0), 6), 
                    cons0(TMproj(TMproj(bdij, 0), 7), 
                    nil0())
      )))))))),
          
  TMifnz( TMproj(bdij, 1) = TMint(3),
  
    TMtup(
      cons0( TMproj(TMproj(bdij, 0), 0), 
        cons0(TMproj(TMproj(bdij, 0), 1), 
          cons0(TMproj(TMproj(bdij, 0), 2), 
            cons0(TMproj(bdij, 2), 
              cons0(TMproj(TMproj(bdij, 0), 4), 
                cons0(TMproj(TMproj(bdij, 0), 5), 
                  cons0(TMproj(TMproj(bdij, 0), 6), 
                    cons0(TMproj(TMproj(bdij, 0), 7), 
                    nil0())
      )))))))),
          
  TMifnz( TMproj(bdij, 1) = TMint(4),
  
    TMtup(
      cons0( TMproj(TMproj(bdij, 0), 0), 
        cons0(TMproj(TMproj(bdij, 0), 1), 
          cons0(TMproj(TMproj(bdij, 0), 2), 
            cons0(TMproj(TMproj(bdij, 0), 3), 
              cons0(TMproj(bdij, 2), 
                cons0(TMproj(TMproj(bdij, 0), 5), 
                  cons0(TMproj(TMproj(bdij, 0), 6), 
                    cons0(TMproj(TMproj(bdij, 0), 7), 
                    nil0())
      )))))))),
          
  TMifnz( TMproj(bdij, 1) = TMint(5), 

    TMtup(
      cons0( TMproj(TMproj(bdij, 0), 0), 
        cons0(TMproj(TMproj(bdij, 0), 1), 
          cons0(TMproj(TMproj(bdij, 0), 2), 
            cons0(TMproj(TMproj(bdij, 0), 3), 
              cons0(TMproj(TMproj(bdij, 0), 4), 
                cons0(TMproj(bdij, 2), 
                  cons0(TMproj(TMproj(bdij, 0), 6), 
                    cons0(TMproj(TMproj(bdij, 0), 7), 
                    nil0())
      )))))))),
          
  TMifnz( TMproj(bdij, 1) = TMint(6),
    TMtup(
      cons0( TMproj(TMproj(bdij, 0), 0), 
        cons0(TMproj(TMproj(bdij, 0), 1), 
          cons0(TMproj(TMproj(bdij, 0), 2), 
            cons0(TMproj(TMproj(bdij, 0), 3), 
              cons0(TMproj(TMproj(bdij, 0), 4), 
                cons0(TMproj(TMproj(bdij, 0), 5), 
                  cons0(TMproj(bdij, 2), 
                    cons0(TMproj(TMproj(bdij, 0), 7), 
                    nil0())
               
      )))))))),          

  TMifnz( TMproj(bdij, 1) = TMint(7),

    TMtup(
      cons0( TMproj(TMproj(bdij, 0), 0), 
        cons0(TMproj(TMproj(bdij, 0), 1), 
          cons0(TMproj(TMproj(bdij, 0), 2), 
            cons0(TMproj(TMproj(bdij, 0), 3), 
              cons0(TMproj(TMproj(bdij, 0), 4), 
                cons0(TMproj(TMproj(bdij, 0), 5), 
                  cons0(TMproj(TMproj(bdij, 0), 6), 
                    cons0(TMproj(bdij, 2), 
                    nil0())
      )))))))),
          
 TMproj(bdij, 0)))))))))
)

val safety_test1 =
TMlam("ij",
  TMifnz( TMproj(ij, 1) != TMproj(ij, 3), 
      TMifnz( 
        abs_term(TMproj(ij, 0) - TMproj(ij, 2)) != abs_term(TMproj(ij, 1) - TMproj(ij, 3)), 
          TMint(1), 
          TMint(0)
      ), TMint(0)
   )
)

val safety_test2 =
TMfix("f", "arg",
  TMifnz( 
    TMproj(arg, 3) >= TMint(0),
      TMifnz( 
        TMapp(safety_test1, 
          TMtup( cons0( TMproj(arg, 0), cons0(TMproj(arg, 1), cons0( TMproj(arg, 3), 
                 cons0( TMapp(board_get,  TMtup(cons0(TMproj(arg, 2), cons0(TMproj(arg, 3), nil0())))), nil0())))))
          ),
          TMapp( f, TMtup(cons0(TMproj(arg, 0), cons0(TMproj(arg, 1), cons0(TMproj(arg, 2), cons0(sub_term_term(TMproj(arg, 3),  TMint(1)), nil0()))))) ), 
      TMint(0)),
  TMint(1))
)

val search =

TMfix("f", "args",

  TMifnz
  ( 
  TMproj(args, 2) < TMint(8),
  
      TMifnz
      ( 
      TMapp( safety_test2, TMtup(cons0(TMproj(args, 1), cons0(TMproj(args, 2), cons0(TMproj(args, 0), cons0(sub_term_term(TMproj(args, 1), TMint(1)), nil0())))))),
        
        TMifnz
        ( 
        TMproj(args, 1) = TMint(7), 
        
            TMseq
            ( 
                  TMopr( "println",  list0_tuple( TMproj(args, 3) + TMint(1)) ),
                  TMseq
                  (
                        TMapp(print_board, TMapp(board_set, TMtup(cons0(TMproj(args, 0), cons0(TMproj(args, 1), cons0(TMproj(args, 2), nil0()))))))
                        , 
                        TMapp(f, TMtup(cons0(TMproj(args, 0), cons0(TMproj(args, 1), cons0(TMproj(args, 2)+TMint(1), cons0(TMproj(args, 3)+TMint(1), nil0()))))))
                  )
            ), 
            
            TMapp
            ( 
            f,  TMtup(cons0( 
                            TMapp(board_set, TMtup(cons0(TMproj(args, 0), cons0(TMproj(args, 1), cons0(TMproj(args, 2), nil0())))))
                            , 
                            cons0(TMproj(args, 1)+TMint(1), cons0(TMint(0), cons0(TMproj(args, 3), nil0())))
                            )) 
            )
        ),
          
        TMapp( f, TMtup(cons0(TMproj(args, 0), cons0(TMproj(args, 1), cons0(TMproj(args, 2)+TMint(1), cons0(TMproj(args, 3), nil0()))))) )
      
      ),
  
      TMifnz
      ( 
        TMproj(args, 1) > TMint(0), 
        
          TMapp
          (
          f, TMtup
             (
             cons0( TMproj(args, 0), cons0(sub_term_term(TMproj(args, 1), TMint(1)), 
             cons0( TMapp(board_get, TMtup(cons0(TMproj(args, 0), cons0(sub_term_term(TMproj(args, 1),TMint(1)), nil0())))) + TMint(1), cons0(TMproj(args, 3), nil0()))))
             )
          ), 
          
          TMproj(args, 3) 
      )
  )
)

(* ****** ****** *)

implement
main0() = ()
where
{
val board = TMtup(cons0(TMint(0), cons0(TMint(0), cons0(TMint(0), cons0(TMint(0), cons0(TMint(0), cons0(TMint(0), cons0(TMint(0), cons0(TMint(0), nil0() )) )) )) )) )
val out = fileref_open_exn("./queens.txt", file_mode_a)
val () = fprint!(out, TMapp(search, TMtup(cons0(board, cons0(TMint(0), cons0(TMint(0), cons0(TMint(0), nil0()))))) ))
}

(* ****** ****** *)

(* end of [queens.dats] *)