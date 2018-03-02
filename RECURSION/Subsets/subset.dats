(* ****** ****** *)
//
// LG 2018-03-02
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

extern
fun
subset(xs: list0(int)): list0(list0(int))

(* ****** ****** *)

implement
subset(xs) = let
  
  fun helper
  (xs: list0(int), 
  res: list0(list0(int))): list0(list0(int)) =
    
    case+ xs of
    | list0_nil() => res
    | list0_cons(x, xs) => let
        val res2 = list0_map<list0(int)><list0(int)>(res, lam(rs) => cons0(x, rs))      
      in
        list0_append(helper(xs, res), helper(xs, res2))
      end

in
  let val res = list0_sing(list0_nil()) in helper(xs, res) end
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val xs = g0ofg1($list(1, 2, 3, 4, 5))
  val xss = subset(xs)
  val () = println!("number of subsets = ", list0_length(xss))
  val () = (xss).foreach()(lam(x) => println!(x))
}

(* ****** ****** *)

(* end of [subset.dats] *)