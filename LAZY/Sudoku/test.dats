#include "./mylibies.dats"

fun
read_loop(xs: stream_vt(string), bd: stream_vt(board)): void =
case+ !xs of
| ~stream_vt_nil() => (stream_vt_free(bd); ())
| ~stream_vt_cons(x, xs) =>
    (
    case+ !bd of
    | ~stream_vt_nil() => (stream_vt_free(xs); ())
    | ~stream_vt_cons(b, bd) => (println!(b) ; read_loop(xs, bd))
    )
    
implement
main0() = ()
where
{

(*
val l0 = (6, 7, 5, 0, 1, 0, 0, 0, 0)
val l1 = (0, 0, 0, 0, 0, 0, 0, 3, 5)
val l2 = (1, 0, 0, 0, 0, 0, 0, 0, 0)
val l3 = (0, 0, 2, 0, 3, 9, 0, 0, 0)
val l4 = (0, 3, 4, 6, 0, 7, 2, 1, 0)
val l5 = (0, 0, 0, 2, 4, 0, 8, 0, 0)
val l6 = (0, 0, 0, 0, 0, 0, 0, 0, 2)
val l7 = (4, 8, 0, 0, 0, 0, 0, 0, 0)
val l8 = (0, 0, 0, 0, 5, 0, 7, 4, 8)

val board0 = (l0, l1, l2, l3, l4, l5, l6, l7, l8)
*)

val r0 = (8, 0, 0, 0, 0, 0, 0, 0, 0)
val r1 = (0, 0, 3, 6, 0, 0, 0, 0, 0)
val r2 = (0, 7, 0, 0, 9, 0, 2, 0, 0)
val r3 = (0, 5, 0, 0, 0, 7, 0, 0, 0)
val r4 = (0, 0, 0, 0, 4, 5, 7, 0, 0)
val r5 = (0, 0, 0, 1, 0, 0, 0, 3, 0)
val r6 = (0, 0, 1, 0, 0, 0, 0, 6, 8)
val r7 = (0, 0, 8, 5, 0, 0, 0, 1, 0)
val r8 = (0, 9, 0, 0, 0, 0, 4, 0, 0)

val board1 = (r0, r1, r2, r3, r4, r5, r6, r7, r8)

(*
val () = println!(" --- Test 1 --- ")
val () = println!("Original Board = ")
val () = println!()
val () = println!(board0)
val () = println!()
val s0 = search(board0, 0, board0, 1)
val () = read_loop(streamize_fileref_line(stdin_ref), s0)
val () = println!()
*)

// val () = println!(" --- Test 2 --- ")
val () = println!("Original Board = ")
val () = println!()
val () = println!(board1)
val () = println!()
val s1 = search(board1, 0, board1, 1)
val () = read_loop(streamize_fileref_line(stdin_ref), s1)
}