(* ****** ****** *)
//
// LG 2018-02-22
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

datatype term =
//
  | TMint of (int)
  | TMstr of string
//
  | TMtup of termlst
  | TMproj of (term, int)
//
  | TMvar of string
//
  | TMlam of (string, term(*body*))
  | TMapp of (term(*fun*), term(*arg*))
  | TMfix of (string(*f*), string(*x*), term)
//
  | TMopr of (string(*opr*), termlst)
  | TMifnz of (term(*test*), term(*then*), term(*else*))
  | TMseq of (term, term)
  
where termlst = list0(term)

(* ****** ****** *)

datatype value =
  | VALunit of ()
  | VALint of int
  | VALstr of string
  | VALtup of valuelst
  | VALfix of (term, envir)
  | VALlam of (term, envir)

where

envir =
list0($tup(string, value))

and valuelst = list0(value)

(* ****** ****** *)

(* end of [struct.dats] *)