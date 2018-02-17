(* ****** ****** *)
//
// LG 2018-02-15
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

datatype tree =
| Nil of ()
| Cons of (tree, int, tree)

(* ****** ****** *)

extern
fun
print_tree(t0: tree): void // stdout
and
prerr_tree(t0: tree): void // stderr

extern
fun
fprint_tree(out: FILEref, t0: tree): void

(* ****** ****** *)

overload print with print_tree
overload prerr with prerr_tree
overload fprint with fprint_tree

(* ****** ****** *)

implement
print_tree(t0) =
fprint_tree(stdout_ref, t0)
implement
prerr_tree(t0) =
fprint_tree(stderr_ref, t0)

(* ****** ****** *)

implement
fprint_tree(out, t0) = let
  
  fun helper(out: FILEref, lay: list0(tree), res: list0(tree)): void = let
    
    fun get_children(t: tree): list0(tree) =
      (
      case+ t of
      | Nil() => nil0()
      | Cons(t1, i, t2) => cons0(t1, cons0(t2, nil0()))
      )
    fun print_nodes(lay: list0(tree)) : void =
      (
      case+ lay of
      | nil0() => println!()
      | cons0(t, lay) => 
          (
          case+ t of
          | Nil() => print_nodes(lay)
          | Cons(t1, i, t2) => let val () = fprint!(out, i, " ") in print_nodes(lay) end
          )
      )
    in
      (
      case+ lay of
      | nil0() =>
            (
            case+ res of
            | nil0() => ()
            | cons0(_, _) => let 
                val () = print_nodes(res) 
              in 
                helper(out, res, nil0()) 
              end
            )
      | cons0(t, lay) => helper(out, lay, list0_append(res, get_children(t)))
      )
    end

in
  case+ t0 of
  | Nil() => ()
  | Cons(t1, i, t2) => let
      val () = println!(i)
    in
      helper(out, cons0(t0, nil0()), nil0())    
    end
end

(* ****** ****** *)

implement
main0() = ()
where
{
val t15 = Cons(Nil(), 15, Nil())
val t14 = Cons(Nil(), 14, Nil())
val t13 = Cons(Nil(), 13, Nil())
val t12 = Cons(Nil(), 12, Nil())
val t11 = Cons(Nil(), 11, Nil())
val t10 = Cons(Nil(), 10, Nil())
val t9 = Cons(Nil(), 9, Nil())
val t8 = Cons(Nil(), 8, Nil())
val t7 = Cons(t14, 7, t15)
val t6 = Cons(t12, 6, t13)
val t5 = Cons(t10, 5, t11)
val t4 = Cons(t8, 4, t9)
val t3 = Cons(t6, 3, t7)
val t2 = Cons(t4, 2, t5)
val t1 = Cons(t2, 1, t3)

val () = println!("t1 =")
val () = println!(t1)
}

(* ****** ****** *)

(* end of [tree.dats] *)