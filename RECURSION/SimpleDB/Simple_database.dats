(* ****** ****** *)
//
// Title:
// Principles of
// Programming Languages
// Course: CAS CS 520
//
// Semester: Spring, 2018
//
// Classroom: MCS B25
// Class Time: TR 2:00-3:15
//
// Instructor: Hongwei Xi (hwxiATcsDOTbuDOTedu)
//
(* ****** ****** *)
//
// Due date: Tuesday, the 13th of March
//
(* ****** ****** *)

(*
//
// HX: 50 points
//
Please do this one for ATS:
http://rosettacode.org/wiki/Simple_database
//
For instance, please take a look at the Java implementation.
//
*)

(* ****** ****** *)

#include "share/atspre_staload.hats"
#include "share/atspre_staload_libats_ML.hats"

%{
  #include <time.h>
%}

(* ****** ****** *)

typedef string2 = (string, string)
typedef string3 = (string, string, string)

(* ****** ****** *)

extern
fun
get_time(): string = "mac#get_time"

extern
fun
add(e: string2, f:string): void

extern
fun
latest(lines: stream_vt(string), cat: string): void

extern
fun
all(lines: stream_vt(string)): void

extern
fun
get_cat(s: string): string

(* ****** ****** *)

%{
char *get_time() {
  time_t curtime;
  time(&curtime);
  char * s = ctime(&curtime);
  return s;
}
%}


implement
get_cat(s) = let
  
  val xs = string_explode(s)
  
  fun aux(xs: list0(char), ys: list0(char)): string =
    case+ xs of
    | nil0() => ""
    | cons0(x, xs) => 
        if x = ',' then aux(xs, nil0())
        else
        (
          if x = ' ' then string_make_rlist(g1ofg0(ys))
          else aux(xs, cons0(x, ys))
        )
in
  aux(xs, nil0())
end


fun parse(s: string): string = let
  val xs = string_explode(s)
  
  fun aux(xs: list0(char), ys: list0(char)): string =
    case+ xs of
    | list0_nil() => string_make_rlist(g1ofg0(ys))
    | list0_cons(x, xs) => 
        if x = ' ' then aux(xs, cons0('-', ys))
        else 
        (
          if x = '\n' then aux(xs, ys)
          else aux(xs, cons0(x, ys))
        )
in
  aux(xs, nil0())
end


implement
add(e, f) = let
  val out = fileref_open_exn(f, file_mode_a)
  val s = parse(get_time())
  val () = fprint_string(out, e.0 + "," + s + "," + e.1 + " \n")
  val () = fileref_close(out)
in
  ()
end


implement
latest(lines, cat) = let
  fun aux(prev0: string, prev1: string, lines: stream_vt(string)):<cloref1> void =
    if cat = "" then
      case+ !lines of
      | ~stream_vt_nil() => if prev0 = "" then println!(prev1) else println!(prev0)
      | ~stream_vt_cons(l, lines) => aux(prev1, l, lines)
    else
      case+ !lines of
      | ~stream_vt_nil() => println!(prev1)
      | ~stream_vt_cons(l, lines) => let
          val c = get_cat(l)
        in
          if c = cat then aux(prev0, l, lines)
          else aux(prev0, prev1, lines)
        end
in
  aux("", "", lines)
end


implement
all(lines) = let
  val-~stream_vt_cons(l, lines) = !lines
  
  fun aux(prev: string, lines: stream_vt(string)):<cloref1> void =
      case+ !lines of
      | ~stream_vt_nil() => ()
      | ~stream_vt_cons(l, lines) => (println!(prev); aux(l, lines))
in
  aux(l, lines)
end

(* ****** ****** *)

implement
main0(argc, argv) = let
  
  val input = (
      if (argc >= 4)
      then (argv[1], argv[2], argv[3]) 
      else
      (
        if (argc >= 3) 
        then (argv[1], argv[2], "")
        else
        (
          if (argc >= 2) 
          then (argv[1], "", "")
          else ("", "", "")
        )
      )): string3

in
  case- input.0 of
  | "add" => add((input.1, input.2), "./simpledb.txt")
  | "latest" => let
      val db = fileref_open_opt("./simpledb.txt", file_mode_r)
      val-~Some_vt(inp) = db
      val theLines = streamize_fileref_line(inp)
    in
      latest(theLines, input.1)
    end
  | "all" => let
      val db = fileref_open_opt("./simpledb.txt", file_mode_r)
      val-~Some_vt(inp) = db
      val theLines = streamize_fileref_line(inp)
    in
      all(theLines)
    end
  | _ => println!("Wrong command")
end

(* ****** ****** *)

(* end of [Simple_database.dats] *)

