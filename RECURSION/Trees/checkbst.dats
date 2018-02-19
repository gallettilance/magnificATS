(* ****** ****** *)
//
// LG 2018-02-18
//
(* ****** ****** *)

#include "./tree.dats"

(* ****** ****** *)

extern
fun
check_bst(t0: tree): bool

extern
fun
tree_max(t0: tree): int

extern
fun
tree_min(t0: tree): int

(* ****** ****** *)

implement
tree_max(t0) = let
  fun helper(curr: int, lay: list0(tree)): int =
    case+ lay of
    | nil0() => curr
    | cons0(t, lay) => 
      case+ t of
      | Nil() => helper(curr, lay)
      | Cons(t1, i, t2) => let
            val lay = cons0(t1, cons0(t2, lay))
          in
            if i > curr then helper(i, lay) 
            else helper(curr, lay)
          end

in
  case- t0 of
  | Cons(t1, i, t2) => helper(i, cons0(t1, cons0(t2, nil0())))
end


implement
tree_min(t0) = let
  fun helper(curr: int, lay: list0(tree)): int =
    case+ lay of
    | nil0() => curr
    | cons0(t, lay) => 
      case+ t of
      | Nil() => helper(curr, lay)
      | Cons(t1, i, t2) => let
            val lay = cons0(t1, cons0(t2, lay))
          in
            if i < curr then helper(i, lay) 
            else helper(curr, lay)
          end

in
  case- t0 of
  | Cons(t1, i, t2) => helper(i, cons0(t1, cons0(t2, nil0())))
end


implement
check_bst(t0) = let
  
  val t0_max = tree_max(t0)
  val t0_min = tree_min(t0)
  
  fun helper(t: tree, min: int, max: int): bool =
    case+ t of
    | Nil() => true
    | Cons(t1, i, t2) => 
      if i >= min andalso i <= max then helper(t1, min, i) andalso helper(t2, i, max)
      else false

in
  helper(t0, t0_min, t0_max)
end

(* ****** ****** *)

implement 
main0() = ()
where
{
//
  val t15 = Cons(Nil(), 14, Nil())
  val t14 = Cons(Nil(), 12, Nil())
  val t13 = Cons(Nil(), 10, Nil())
  val t12 = Cons(Nil(), 8, Nil())
  val t11 = Cons(Nil(), 6, Nil())
  val t10 = Cons(Nil(), 4, Nil())
  val t9 = Cons(Nil(), 2, Nil())
  val t8 = Cons(Nil(), 0, Nil())
  val t7 = Cons(t14, 13, t15)
  val t6 = Cons(t12, 9, t13)
  val t5 = Cons(t10, 5, t11)
  val t4 = Cons(t8, 1, t9)
  val t3 = Cons(t6, 11, t7)
  val t2 = Cons(t4, 3, t5)
  val t1 = Cons(t2, 7, t3)
  
  val () = println!("t1 =")
  val () = println!(t1)
//
  val () = println!("Is t1 a Binary Search Tree? ", check_bst(t1))
//
}

(* ****** ****** *)

(* end of [checkbst.dats] *)