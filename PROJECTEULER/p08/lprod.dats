(* ****** ****** *)
//
// LG 2018-03-11
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

#include
"$PATSHOMELOCS\
/atscntrb-hx-intinf/mylibies.hats"

#include
"$PATSHOMELOCS\
/atscntrb-hx-mytesting/mylibies.hats"

(* ****** ****** *)

typedef
intinf = $GINTINF_t.intinf

overload
print with $GINTINF_t.print_intinf

(* ****** ****** *)

val intinf = gnumber_int<intinf>

(* ****** ****** *)

val gadd = gadd_val_val<intinf>
val gsub = gsub_val_val<intinf>
val gmul = gmul_val_val<intinf>
val gdiv = gdiv_val_val<intinf>
val gcompare = gcompare_val_val<intinf>

overload * with gmul
overload + with gadd
overload / with gdiv
overload - with gsub
overload compare with gcompare

fun
gmod(x: intinf, y: intinf) = x - (x / y)  * y

overload % with gmod

(* ****** ****** *)

extern
fun
lprod(s: string, i: int): intinf

extern
fun 
char2int(c: char): intinf

(* ****** ****** *)

implement
char2int(c) =
case+ c of
| '0' => intinf(0)
| '1' => intinf(1)
| '2' => intinf(2)
| '3' => intinf(3)
| '4' => intinf(4)
| '5' => intinf(5)
| '6' => intinf(6)
| '7' => intinf(7)
| '8' => intinf(8)
| '9' => intinf(9)
| _ => (println!("not a valid char");  intinf(~1))

implement
lprod(s, i) = let
  val xs = list0_map<char><intinf>(string_explode(s), lam(c) => char2int(c))
  
  fun get_next(xs: list0(intinf), i: int, res: list0(intinf)): list0(intinf) =
    if i <= 0 then res
    else
    (
      case+ xs of
      | list0_nil() => res
      | list0_cons(x, xs) => get_next(xs, i - 1, cons0(x, res))
    )
  
  fun aux(xs: list0(intinf), max: intinf): intinf =
    case+ xs of
    | nil0() => max
    | cons0(x1, xs1) => let
          val ys = get_next(xs, i, nil0())
          val cand = list0_foldleft<intinf><intinf>(ys, intinf(1), lam(x, res) => x*res)
          val () = println!("cand = ", cand)
        in
          if compare(cand, max) > 0 then aux(xs1, cand) else aux(xs1, max)
        end
in
  aux(xs, intinf(0))
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val s = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"
  val () = println!("Largest Product of 13 adjacent digits is ", lprod(s, 13))
}

(* ****** ****** *)

(* end of [sieve.dats] *)