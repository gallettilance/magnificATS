(* ****** ****** *)
//
// LG 2018-02-17
//
(* ****** ****** *)

#include "./tree.dats"

(* ****** ****** *)

extern
fun
bfs(t0: tree, n0: int): bool

(* ****** ****** *)

implement
bfs(t0, n0) = let 
  fun helper(lay: list0(tree), res: list0(tree)): bool = let
    
    fun get_children(t: tree): list0(tree) =
      (
      case+ t of
      | Nil() => nil0()
      | Cons(t1, i, t2) => cons0(t1, cons0(t2, nil0()))
      )
    
    fun scan_nodes(lay: list0(tree)) : bool =
      (
      case+ lay of
      | nil0() => false
      | cons0(t, lay) => 
          (
          case+ t of
          | Nil() => scan_nodes(lay)
          | Cons(t1, i, t2) => if i = n0 then true else scan_nodes(lay)
          )
      )
    
    in
      (
      case+ lay of
      | nil0() =>
            (
            case+ res of
            | nil0() => false
            | _ => if scan_nodes(res) then true else helper(res, nil0())
            )
      | cons0(t, lay) => helper(lay, list0_append(res, get_children(t)))
      )
    end
    
in
  case+ t0 of
  | Nil() => false
  | Cons(_, i, _) => if i = n0 then true else helper(cons0(t0, nil0()), nil0())
end

(* ****** ****** *)

implement 
main0(argc, argv) = let
//  
  val input = (if (argc >= 2) then g0string2int_int(argv[1]) else 10): int
  val t31 = Cons(Nil(), 31, Nil())
  val t30 = Cons(Nil(), 30, Nil())
  val t29 = Cons(Nil(), 29, Nil())
  val t28 = Cons(Nil(), 28, Nil())
  val t27 = Cons(Nil(), 27, Nil())
  val t26 = Cons(Nil(), 26, Nil())
  val t25 = Cons(Nil(), 25, Nil())
  val t24 = Cons(Nil(), 24, Nil())
  val t23 = Cons(Nil(), 23, Nil())
  val t22 = Cons(Nil(), 22, Nil())
  val t21 = Cons(Nil(), 21, Nil())
  val t20 = Cons(Nil(), 20, Nil())
  val t19 = Cons(Nil(), 19, Nil())
  val t18 = Cons(Nil(), 18, Nil())
  val t17 = Cons(Nil(), 17, Nil())
  val t16 = Cons(Nil(), 16, Nil())
  val t15 = Cons(t30, 15, t31)
  val t14 = Cons(t28, 14, t29)
  val t13 = Cons(t26, 13, t27)
  val t12 = Cons(t24, 12, t25)
  val t11 = Cons(t22, 11, t23)
  val t10 = Cons(t20, 10, t21)
  val t9 = Cons(t18, 9, t19)
  val t8 = Cons(t16, 8, t17)
  val t7 = Cons(t14, 7, t15)
  val t6 = Cons(t12, 6, t13)
  val t5 = Cons(t10, 5, t11)
  val t4 = Cons(t8, 4, t9)
  val t3 = Cons(t6, 3, t7)
  val t2 = Cons(t4, 2, t5)
  val t1 = Cons(t2, 1, t3)
  
  val () = println!("t1 =")
  val () = println!(t1)
//
in
//
  println!("Is ", input, " in t1? ", bfs(t1, input))
//
end

(* ****** ****** *)

(* end of [bfs.dats] *)

