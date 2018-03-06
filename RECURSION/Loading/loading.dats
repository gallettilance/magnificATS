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

extern
fun
waiting(n: int): void

extern
fun
count_down(n: int): void

extern
fun
dots(n: int): void

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
  (print!("Loading   |"); loop(n) ; println!(">"))
end

implement
waiting(n) = let
  fun turn(n: int): void =
    ifcase
    | n = 0 => fprint(stdout_ref, "waiting   |  ")
    | n = 1 => fprint(stdout_ref, "waiting   /  ")
    | n = 2 => fprint(stdout_ref, "waiting   -  ")
    | n = 3 => fprint(stdout_ref, "waiting   \\  ")
    | n = 4 => fprint(stdout_ref, "waiting   |  ")
    | n = 5 => fprint(stdout_ref, "waiting   /  ")
    | n = 6 => fprint(stdout_ref, "waiting   -  ")
    | _ => fprint(stdout_ref, "waiting   \\  ")
  
  fun loop(n: int): void =
    if n <= 0 then ()
    else let
      val () = fprint!(stdout_ref, '\r')
      val () = fileref_flush(stdout_ref)
      val () = turn(n % 8)
      val _ = $extfcall(int, "usleep", 500000)
      val () = fileref_flush(stdout_ref)
    in
      loop(n - 1)
    end
in
  (println!(); loop(n); println!())
end

implement
count_down(n) = let
  fun loop(n: int): void =
    if n < 0 then ()
    else let
      val () = fprint!(stdout_ref, '\r')
      val () = fileref_flush(stdout_ref)
      val () = fprint!(stdout_ref, " ", n, " ")
      val _ = $extfcall(int, "usleep", 500000)
      val () = fileref_flush(stdout_ref)
    in
      loop(n - 1)
    end
in
  (println!(); loop(n); println!())
end

implement
dots(n) = let
  fun myfunc(i: int): void =
    case- i of
    | 0 => fprint!(stdout_ref, "dots      ")
    | 1 => fprint!(stdout_ref, "dots  .   ")
    | 2 => fprint!(stdout_ref, "dots  ..  ")
    | 3 => fprint!(stdout_ref, "dots  ... ")
    | 4 => fprint!(stdout_ref, "dots   .. ")
    | 5 => fprint!(stdout_ref, "dots    . ")
    
  fun loop(i: int): void =
    if i >= n then ()
    else let
      val () = myfunc(i % 6)
      val () = fileref_flush(stdout_ref)
      val _ = $extfcall(int, "usleep", 500000)
      val () = fprint!(stdout_ref, '\r')
      val () = fileref_flush(stdout_ref)
    in
      loop(i + 1)
    end
in
  (println!(); loop(0); println!())
end

(* ****** ****** *)

implement
main0() = ()
where
{
  val () = loading(12)
  val () = waiting(8)
  val () = count_down(5)
  val () = dots(15)
}

(* ****** ****** *)

(* end of [loading.dats] *)