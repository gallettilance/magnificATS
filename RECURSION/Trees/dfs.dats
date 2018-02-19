(* ****** ****** *)
//
// LG 2018-02-17
//
(* ****** ****** *)

#include "./tree.dats"

(* ****** ****** *)

extern
fun
dfs(t0: tree, n0: int): bool

(* ****** ****** *)

implement
dfs(t0, n0) = let
  fun helper(q: list0(tree)) : bool =
    case+ q of
    | nil0() => false
    | cons0(t1, q) => 
        (
        case+ t1 of
        | Nil() => helper(q)
        | Cons(t1, i, t2) => 
            if i = n0 then true
            else helper(cons0(t1, cons0(t2, q))) //let val () = println!(i) in helper(cons0(t1, cons0(t2, q))) end
        )
in
  helper(cons0(t0, nil0()))
end
(* ****** ****** *)

implement 
main0(argc, argv) = let
//  
  val input = (if (argc >= 2) then g0string2int_int(argv[1]) else 10): int
  val t31 = Cons(Nil(), 31, Nil())
  val t30 = Cons(Nil(), 30, Nil())
  val t29 = Cons(Nil(), 28, Nil())
  val t28 = Cons(Nil(), 27, Nil())
  val t27 = Cons(Nil(), 24, Nil())
  val t26 = Cons(Nil(), 23, Nil())
  val t25 = Cons(Nil(), 21, Nil())
  val t24 = Cons(Nil(), 20, Nil())
  val t23 = Cons(Nil(), 16, Nil())
  val t22 = Cons(Nil(), 15, Nil())
  val t21 = Cons(Nil(), 13, Nil())
  val t20 = Cons(Nil(), 12, Nil())
  val t19 = Cons(Nil(), 9, Nil())
  val t18 = Cons(Nil(), 8, Nil())
  val t17 = Cons(Nil(), 6, Nil())
  val t16 = Cons(Nil(), 5, Nil())
  val t15 = Cons(t30, 29, t31)
  val t14 = Cons(t28, 26, t29)
  val t13 = Cons(t26, 22, t27)
  val t12 = Cons(t24, 19, t25)
  val t11 = Cons(t22, 14, t23)
  val t10 = Cons(t20, 11, t21)
  val t9 = Cons(t18, 7, t19)
  val t8 = Cons(t16, 4, t17)
  val t7 = Cons(t14, 25, t15)
  val t6 = Cons(t12, 18, t13)
  val t5 = Cons(t10, 10, t11)
  val t4 = Cons(t8, 3, t9)
  val t3 = Cons(t6, 17, t7)
  val t2 = Cons(t4, 2, t5)
  val t1 = Cons(t2, 1, t3)
  
  val () = println!("t1 =")
  val () = println!(t1)
//
in
//
  println!("Is ", input, " in t1? ", dfs(t1, input))
//
end

(* ****** ****** *)

(* end of [dfs.dats] *)