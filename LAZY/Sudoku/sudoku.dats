(* ****** ****** *)
//
// LG 2018-02-22
//
(* ****** ****** *)

extern
fun
search(org_bd: board, i: int, res_bd: board, elm: int): stream_vt(board)

(* ****** ****** *)

implement
search(org_bd, i, res_bd, elm) = 
if i > 80 then (println!("Solution = \n"); $ldelay( stream_vt_nil() ))
else
(
  if i < 0 then (println!("No Solutions"); $ldelay( stream_vt_nil() ))
  else
  (
    let
      val legal = is_legal_move(org_bd, i)
    in
      if legal 
      then 
      (
        let
          val res_bd = set_elm(res_bd, i, 0)
          val valid = is_valid_move(res_bd, i, elm)
        in
          if valid 
          then
          (
            let
              val res_bd = set_elm(res_bd, i, elm)
            in
              $ldelay( stream_vt_cons(res_bd, search(org_bd, i + 1, res_bd, 1)) )
            end
          )
          else
          (
            if elm < 9 then search(org_bd, i, res_bd, elm + 1)
            else
            (
              let
                val prev_elm = get_elm(res_bd, i - 1)
              in
                search(org_bd, i - 1, res_bd, prev_elm + 1)
              end
            )
          )
        end
      )
      else
      (
        if elm = 1 then search(org_bd, i + 1, res_bd, 1)
        else 
        (
          let
            val prev_elm = get_elm(res_bd, i - 1)
          in
            search(org_bd, i - 1, res_bd, prev_elm + 1)
          end
        )
      )
    end
  )
)

(* ****** ****** *)

(* end of [sudoku.dats] *)