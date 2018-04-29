(* ****** ****** *)
//
// LG 2018-04-05
//
(* ****** ****** *)
//
// proof that the 
// representations 
// of myarray1 and
// myarray2 are 
// equivalent
//
(* ****** ****** *)

viewdef at(a:t@ype, l:addr) = a@l

(* ****** ****** *)

dataview
myarray1(a:t@ype, addr, int) =
| {l:addr}
  myarray1_nil(a, l, 0) of ()
| {l:addr}{n:nat}
  myarray1_cons(a, l, n+1) of
  (a@l, myarray1(a, l+sizeof(a), n))

dataview
myarray2(a:t@ype, addr, int) =
| {l:addr}
  myarray2_nil(a, l, 0) of ()
| {l:addr}{n:nat}
  myarray2_cons(a, l, n+1) of
  (myarray2(a, l, n), at(a, l+n*sizeof(a)))

(* ****** ****** *)

extern
prfun
{a:t@ype}
from_myarray1_to_myarray2
  {l:addr}{n:nat}(pf: myarray1(a, l, n)): myarray2(a, l, n)

extern
prfun
{a:t@ype}
from_myarray2_to_myarray1
  {l:addr}{n:nat}(pf: myarray2(a, l, n)): myarray1(a, l, n)

(* ****** ****** *)

primplement
{a}
from_myarray1_to_myarray2
{l}{n}
(pf) = 
case+ pf of
| myarray1_nil() => myarray2_nil()
| myarray1_cons(pfat1, pfarr1) => 
  let
    prval arr2 = from_myarray1_to_myarray2(pfarr1) 
  in
    case+ arr2 of
    | myarray2_nil() => myarray2_cons(myarray2_nil(), pfat1)
    | myarray2_cons(pfarr2, pfat2) => 
      let
        prval arr1 = myarray1_cons(pfat1, from_myarray2_to_myarray1(pfarr2))
        prval pfarr = from_myarray1_to_myarray2(arr1)
      in
        myarray2_cons(pfarr, pfat2)
      end
  end
  

primplement
{a}
from_myarray2_to_myarray1
{l}{n}
(pf) = 
case+ pf of
| myarray2_nil() => myarray1_nil()
| myarray2_cons(pfarr2, pfat2) => 
  let
    prval arr1 = from_myarray2_to_myarray1(pfarr2) 
  in
    case+ arr1 of
    | myarray1_nil() => myarray1_cons(pfat2, myarray1_nil())
    | myarray1_cons(pfat1, pfarr1) => 
      let
        prval arr2 = myarray2_cons(from_myarray1_to_myarray2(pfarr1), pfat2)
        prval pfarr = from_myarray2_to_myarray1(arr2)
      in
        myarray1_cons(pfat1, pfarr)
      end
  end

