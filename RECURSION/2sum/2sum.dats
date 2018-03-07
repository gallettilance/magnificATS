(* ****** ****** *)
//
// LG 2018-03-06
//
(* ****** ****** *)

typedef int2 = (int, int)

(* ****** ****** *)

extern
fun
search2(orig: list0(int), target: int, res: list0(int2)): list0(int2)

(* ****** ****** *)

implement
search2(orig, target, res) = let

  fun search1(orig: list0(int), target: int, res: list0(int)): list0(int) =
    case+ orig of
    | nil0() => res
    | cons0(num, orig) => 
        if num = target 
        then search1(orig, target, cons0(num, res)) 
        else search1(orig, target, res)
    
in
  case+ orig of
  | nil0() => res
  | cons0(num, orig) => 
      let
        val newtar = target - num
        val sings = search1(orig, newtar, nil0())
        val tups = list0_map<int><int2>(sings, lam(s) => (num, s))
      in
        search2(orig, target, list0_append(tups, res))
      end
end

(* ****** ****** *)

(* end of [2sum.dats] *)