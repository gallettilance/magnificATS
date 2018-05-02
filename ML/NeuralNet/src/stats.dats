(* ****** ****** *)
//
// LG - 03-06
//
(* ****** ****** *)

extern
fun
sigmoid(x: double): double

extern
fun
sigDiv(x: double): double

extern
fun
urand(): double = "mac#randZeroToOne"

extern
fun
fact
{n:nat| n > 0}
(n: int(n)): int

extern
fun
{a:t@ype}
pow
{n:nat | n > 0}
(x: a, n: int(n)): a

extern
fun
exponential(x: double): double = "mac#exponential"

(* ****** ****** *)

implement
sigmoid(x) = 1.0 / (1.0 + exponential(~x))

implement
sigDiv(x) = sigmoid(x) * (1.0 - sigmoid(x))

%{
double randZeroToOne()
{
    return rand() / (RAND_MAX + 1.);
}

double exponential(double x) {
  return exp(x);
}
%}

implement
{a}
pow(x, n) = let
  fun aux(res: a, i: int): a =
    if i = n
    then res
    else aux(gmul_val_val<a>(x, res), i + 1)
in
  aux(x, 1)
end

implement
fact(n) = let
  fun 
  aux0
  {n: nat | n > 0}
  (i: int(n), res: int): int =
    if i = 1
    then res
    else aux0(i - 1, res * i)
in
  aux0(n, 1)
end


(* ****** ****** *)

(* end of [stats.dats] *)
