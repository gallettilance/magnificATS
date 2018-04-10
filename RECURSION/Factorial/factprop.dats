(* ****** ****** *)
//
// LG 2018-03-30
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

dataprop
FACT(int, int) = 
  | FACT0(0, 1) of ()
  | {n:nat}{r:int}
    FACT1(n+1, (n+1)*r) of FACT(n, r)

(* ****** ****** *)

extern
fun
fact
{n:nat}
(n:int(n)): [r:int] (FACT(n, r) | int(r))

(* ****** ****** *)

implement
fact{n}(n) = let
  fun loop
    {i:nat|i <= n}{r:int} .<n-i>.
  (
    pf: FACT(i, r)
  | n: int(n), i: int(i), r: int(r)
  ) :<> [r:int] (FACT(n, r) | int r) =
    if n - i > 0 
    then loop(FACT1(pf) | n, i+1, (i + 1) * r) 
    else (pf | r)
in
  loop (FACT0() | n, 0, 1)
end // end of [ifact2]


(* ****** ****** *)

implement
main0() = ()
where
{
  val i = 5
  val (pf | facti) = fact(i)
  val () = println!("fact(", i, ") = ", facti)
  //val () = println!("Proof of fact(", i, ") = ", facti.0)
}

(* ****** ****** *)

(* end of [factpf.dats] *)