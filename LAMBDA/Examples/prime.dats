(* ****** ****** *)
//
// LG 2018-02-17
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "./../mylibies.dats"

(* ****** ****** *)

val f = TMvar("f")
val l = TMvar("l")
val c = TMvar("c")
val n = TMvar("n")
val i = TMvar("i")

val loop = TMfix("l", "i", 
              TMifnz( n >= i * i, 
              TMifnz( TMint(0) >= n % i,
                      TMint(0),
                      TMapp(l, i + TMint(1)) ),
              TMint(1) )
           )

val IsPrime = TMlam("n",  TMifnz( TMint(1) >= n, TMint(0), TMapp(loop, TMint(2))))

val count = TMfix("c", "i", 
              TMifnz( n > i,
                      TMifnz( TMapp(IsPrime, i),
                              TMint(1) + TMapp(c, i + TMint(1)),
                              TMapp(c, i + TMint(1))
                            ),
                      TMint(0)
                    )       
             )

val NumberOfPrimes = TMlam("n",  TMapp(count, TMint(2)))

(* ****** ****** *)

implement
main0() = ()
where
{
  val out0 = fileref_open_exn("./isprime.txt", file_mode_a)
  val out1 = fileref_open_exn("./numprime.txt", file_mode_a)
  val () = fprint!(out0, TMapp(IsPrime, TMint(3)))
  val () = fprint!(out1, TMapp(NumberOfPrimes, TMint(100)))
}

(* ****** ****** *)

(* end of [prime.dats] *)