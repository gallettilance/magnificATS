(* ****** ****** *)
//
// LG 2018-02-17
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
            | _ => let 
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

(* end of [tree.dats] *)