(* ****** ****** *)
//
// LG 2018-03-02
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

local

var Nvar : int = 0
val N = ref_make_viewptr (view@ Nvar | addr@ Nvar)

in // in of [local]

fun
N_get () : int = ref_get_elt (N)
fun
N_set (i: int): void = ref_set_elt (N, i)

end 

typedef board = list0(int)

(* ****** ****** *)

extern
fun
print_board(bd: board): void

extern
fun
get_queen(bd: board, i: int): int

extern
fun
set_queen(bd: board, i: int, j: int): board

extern
fun
is_valid_move(bd: board, i: int, j: int): bool

extern
fun
search(bd: board, i: int, j: int, nsol:int): int

(* ****** ****** *)

fun listN(n:int): list0(int) = let
  fun aux(n:int, xs:list0(int)): list0(int) =
    if n <= 0 then xs
    else aux(n - 1, cons0(0, xs))
in
  aux(n, list0_nil())
end

fun print_row(n: int, j: int): void = 
  if n + j = N_get() then (print!("Q "); print_row(n - 1, j))
  else
  (
    if n <= 0 then println!()
    else (print!(". "); print_row(n - 1, j))
  )

implement
print_board(bd) =
  case+ bd of
  | list0_nil() => println!()
  | list0_cons(b, bd) => 
      (print_row(N_get(), b); print_board(bd))

implement
get_queen(bd, i) = bd[i]

implement
set_queen(bd, i, j) = let
  fun aux(bd: board, i: int, res: board): board =
    case- bd of
    | list0_nil() => list0_reverse(res)
    | list0_cons(q, bd) => 
        if i = 0 then aux(bd, i - 1, cons0(j, res))
        else aux(bd, i - 1, cons0(q, res))
in
  aux(bd, i, list0_nil())
end

implement
is_valid_move(bd, i, j) = let
  fun test(i: int, j: int, i0: int, j0:int): bool =
    if i0 >= 0 then let
        val check = j != j0 andalso i - i0 != abs(j - j0)
      in
        if check 
        then
        ( 
          if i0 > 0 then test(i, j, i0- 1, bd[i0 - 1])
          else true
        )
        else false
      end
    else true
in
  if i = 0 
  then
  ( 
    if j < 0 orelse j > N_get() -1 then false
    else true
  )
  else
  (
    if j < 0 orelse j > N_get() -1 then false
    else test(i, j, i - 1, bd[i - 1])
  )
end

implement
search(bd, i, j, nsol) = 
if i > N_get() - 1
then let
  val () = println!("Solution = ", nsol)
  val () = print_board(bd)
  val prevj = get_queen(bd, i - 1)
  val nsol = nsol + 1
in
 search(bd, i - 1, prevj + 1, nsol)
end

else
(
  if i < 0 then (println!("Done"); nsol)
  else
  (
    let
      val valid = is_valid_move(bd, i, j)
    in
      if valid 
      then
      (
        let
          val bd = set_queen(bd, i, j)
        in
          search(bd, i + 1, 0, nsol)
        end
      )
      else
      (
        if j < N_get() - 1 then search(bd, i, j + 1, nsol)
        else
        (
          if i = 0 then (println!("Done"); nsol)
          else
          (
            let
              val prevj = get_queen(bd, i - 1)
            in
              search(bd, i - 1, prevj + 1, nsol)
            end
          )
        )
      )
    end
  )
)

(* ****** ****** *)

implement
main0(argc, argv) = let
  val input = (if (argc >= 2) then g0string2int_int(argv[1]) else 4): int
  val () = N_set(input)
  val () = println!("N = ", N_get())
  val bd = listN(N_get())
in
  println!(search(bd, 0, 0, 0))
end
  

(* ****** ****** *)

(* end of [nqueen.dats] *)