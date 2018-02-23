(* ****** ****** *)
//
// LG 2018-02-17
//
(* ****** ****** *)

#include "./helper_subst.dats"

(* ****** ****** *)

val f = TMvar("f")
val l = TMvar("l")
val c = TMvar("c")
val n = TMvar("n")
val i = TMvar("i")

val loop = TMfix("l", "i", 
              TMifnz( TMgte(n, TMmul(i, i)), 
              TMifnz( TMgte(TMint(0), TMmod(n, i)),
                      TMint(0),
                      TMapp(l, TMadd(i, TMint(1))) ),
              TMint(1) )
           )

val IsPrime = TMlam("n",  TMifnz( TMgte(TMint(1), n), TMint(0), TMapp(loop, TMint(2))))

val count = TMfix("c", "i", 
              TMifnz( TMgte(n, i),
                      TMifnz( TMapp(IsPrime, i),
                              TMadd(TMint(1), TMapp(c, TMadd(i, TMint(1)))),
                              TMapp(c, TMadd(i, TMint(1)))
                            ),
                      TMint(0)
                    )       
             )

val NumberOfPrimes = TMlam("n",  TMapp(count, TMint(2)))

(* ****** ****** *)
//
// HX:
// The following testing code is provided:
//
implement
main0() =
{
//
val () =
println!
("IsPrime(73) = ", evaluate(TMapp(IsPrime, TMint(73))))
//
val () =
println!
("IsPrime(2) = ", evaluate(TMapp(IsPrime, TMint(2))))
//
val () =
println!
("IsPrime(10) = ", evaluate(TMapp(IsPrime, TMint(10))))
//
val () =
println!
("IsPrime(73^2) = ", evaluate(TMapp(IsPrime, TMint(73*73))))
//
val () =
println!
("IsPrime(25) = ", evaluate(TMapp(IsPrime, TMint(25))))
//
val () =
println!
("IsPrime(1) = ", evaluate(TMapp(IsPrime, TMint(1))))
//
val () =
println!
("NumberOfPrimes(100) = ", evaluate(TMapp(NumberOfPrimes, TMint(100))))
//
} (* end of [main0] *)

(* end of [prime.dats] *)