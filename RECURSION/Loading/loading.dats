(* ****** ****** *)
//
// LG 2018-03-01
//
(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

%{
  #include <unistd.h>
%}

(* ****** ****** *)

extern
fun
loading(n: int): void

(* ****** ****** *)

implement
loading(n) = let
  fun loop(n: int): void =
    if n <= 0 then ()
    else let
      val () = fprint!(stdout_ref, '=')
      val _ = $extfcall(int, "usleep", 100000)
      val () = fileref_flush(stdout_ref)
    in
      loop(n - 1)
    end
in
  (print!("|"); loop(n) ; println!(">"))
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val () = loading(12)
}

(* ****** ****** *)

(* end of [loading.dats] *)