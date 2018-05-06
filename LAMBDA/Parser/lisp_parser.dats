(* ****** ****** *)
//
// LG 2018-04-03
//
(* ****** ****** *)

extern
fun
parse_TMint(xs: stream_vt(string)): int

extern
fun
parse_TMstr(xs: stream_vt(string)): string

extern
fun
parse_TMtup(xs: stream_vt(string)): termlst

extern
fun
parse_TMproj(xs: stream_vt(string)): (term, int)

extern
fun
parse_TMvar(xs: stream_vt(string)): string

extern
fun
parse_TMlam(xs: stream_vt(string)): (string, term)

extern
fun
parse_TMapp(xs: stream_vt(string)): (term, term)

extern
fun
parse_TMfix(xs: stream_vt(string)): (string, string, term)

extern
fun
parse_TMopr(xs: stream_vt(string)): (string, termlst)

extern
fun
parse_TMifnz(xs: stream_vt(string)): (term, term, term)

extern
fun
parse_TMseq(xs: stream_vt(string)): (term, term)

(* ****** ****** *)

extern
fun
tokenize(xs: stream_vt(char)): stream_vt(string)

extern
fun
parse_lisp(f: string): term

extern
fun
parse_tokens(xs: stream_vt(string)): Option(term)

extern
fun
get_args(xs: stream_vt(string)): list0(list0(string))

(* ****** ****** *)

implement
get_args(xs) = let
  fun aux(xs: stream_vt(string), cnt: int, arg: list0(string), res: list0(list0(string))): list0(list0(string)) =
    case- !xs of
    | ~stream_vt_nil() => list0_reverse(res)
    | ~stream_vt_cons(x, xs1) => 
          ifcase
          | x = "(" orelse x = " (" =>  
                    if cnt = 0 
                    then 
                    (
                      if list0_length(arg) > 0
                      then aux(xs1, 1, list0_sing(x), cons0(list0_reverse(arg), res))
                      else aux(xs1, 1, list0_sing(x), res)
                    )
                    else aux(xs1, cnt + 1, cons0(x, arg), res)
          | cnt = 0 andalso list0_length(arg) = 1 =>
                    ( 
                      let 
                        val-cons0(a, _) = arg 
                      in 
                        if a = "(" 
                        then aux(xs1, 1, arg, res) 
                        else aux(xs1, cnt, list0_sing(x), cons0(list0_reverse(arg), res)) 
                      end
                    ) 
          | cnt = 0 andalso list0_length(arg) > 1 => 
                    (
                      let 
                        val ys = $ldelay( stream_vt_cons(x, xs1), ~xs1) 
                      in 
                        aux(ys, cnt, nil0(), cons0(list0_reverse(arg), res)) 
                      end
                    )
          | x = ""  => aux(xs1, cnt, arg, res)
          | x = " "  => aux(xs1, cnt, arg, res)
          | x = ")" => aux(xs1, cnt - 1, cons0(x, arg), res)
          | _ => aux(xs1, cnt, cons0(x, arg), res)

in
  let 
    val-~stream_vt_cons(x, xs) = !xs
  in
    if x = "(" orelse x = " (" then aux(xs, 1, list0_sing(x), nil0())
    else aux(xs, 0, list0_sing(x), nil0())
  end
end

(* ****** ****** *)

implement
parse_lisp(f) = let
  val myfile = fileref_open_opt(f, file_mode_r)
in
  case- myfile of
  | ~Some_vt(code_ref) => let
      val code = streamize_fileref_char(code_ref)
      val alltokens = tokenize(code)
      val-Some(t) = parse_tokens(alltokens)
    in
      t
    end
end


(* ****** ****** *)


implement
parse_TMint(xs) = let
  val-~stream_vt_cons(x, xs) = !xs
in
  (~xs; string2int(x))
end


implement
parse_TMstr(xs) = let
  val-~stream_vt_cons(x, xs) = !xs
in
  (~xs; x)
end


implement
parse_TMtup(xs) = let
  val args = get_args(xs)
in
  list0_map<list0(string)><term>
  (
    list0_filter(args, lam(a) => list0_length(a) > 0)
    ,
    lam(a) => let val-Some(t) = parse_tokens(streamize_list_elt<string>(g1ofg0(a))) in t end
  )
end


implement
parse_TMproj(xs) = let
  val args = get_args(xs)
  val-cons0(xs, args) = args
  val-cons0(ys, _) = args
  val-Some(t0) = parse_tokens(streamize_list_elt<string>(g1ofg0(xs)))
  val-cons0(s, _) = ys
in
  (t0, string2int(s))
end


implement
parse_TMvar(xs) = let
  val-~stream_vt_cons(x, xs) = !xs
in
  (~xs; x)
end


implement
parse_TMlam(xs) = let
  val args = get_args(xs)
  val-cons0(xs, args) = args
  val-cons0(ys, _) = args
  val () = assertloc(list0_length(ys) > 0)
  val-Some(t1) = parse_tokens(streamize_list_elt<string>(g1ofg0(ys)))
  val-cons0(s, _) = xs
in
  (s, t1)
end


implement
parse_TMapp(xs) = let
  val args = get_args(xs)
  val-cons0(xs, args) = args
  val-cons0(ys, _) = args
  val () = assertloc(list0_length(xs) > 0)
  val () = assertloc(list0_length(ys) > 0)
  val-Some(t0) = parse_tokens(streamize_list_elt<string>(g1ofg0(xs)))
  val-Some(t1) = parse_tokens(streamize_list_elt<string>(g1ofg0(ys)))
in
  (t0, t1)
end


implement
parse_TMfix(xs) = let
  val args = get_args(xs)
  val-cons0(xs, args) = args
  val-cons0(ys,args) = args
  val-cons0(zs, _) = args
  val () = assertloc(list0_length(zs) > 0)
  val-Some(t2) = parse_tokens(streamize_list_elt<string>(g1ofg0(zs)))
  val-cons0(s0, _) = xs
  val-cons0(s1, _) = ys
in
  (s0, s1, t2)
end


implement
parse_TMopr(xs) = let
  val args = get_args(xs)
  val-cons0(s, args) = args
  val-cons0(s, _) = s
in
  ( 
  s
  ,
  list0_map<list0(string)><term>
  (
    list0_filter(args, lam(a) => list0_length(a) > 0)
    ,
    lam(a) => let val-Some(t) = parse_tokens(streamize_list_elt<string>(g1ofg0(a))) in t end
  )
  )
end


implement
parse_TMifnz(xs) = let
  val args = get_args(xs)
  val-cons0(xs, args) = args
  val-cons0(ys,args) = args
  val-cons0(zs, _) = args
  val () = assertloc(list0_length(xs) > 0)
  val () = assertloc(list0_length(ys) > 0)
  val () = assertloc(list0_length(zs) > 0)
  val-Some(t0) = parse_tokens(streamize_list_elt<string>(g1ofg0(xs)))
  val-Some(t1) = parse_tokens(streamize_list_elt<string>(g1ofg0(ys)))
  val-Some(t2) = parse_tokens(streamize_list_elt<string>(g1ofg0(zs)))
in
  (t0, t1, t2)
end


implement
parse_TMseq(xs) = let
  val args = get_args(xs)
  val-cons0(xs, args) = args
  val-cons0(ys,_) = args
  val () = assertloc(list0_length(xs) > 0)
  val () = assertloc(list0_length(ys) > 0)
  val-Some(t0) = parse_tokens(streamize_list_elt<string>(g1ofg0(xs)))
  val-Some(t1) = parse_tokens(streamize_list_elt<string>(g1ofg0(ys)))
in
  (t0, t1)
end


(* ****** ****** *)


implement
tokenize(xs) = let
  fun get_token(xs: stream_vt(char), s: string): (stream_vt(char), string) =
    case+ !xs of
    | ~stream_vt_nil() => ($ldelay(stream_vt_nil()), "")
    | ~stream_vt_cons(x, xs1) => 
        case+ x of
        | '\(' =>  (xs1, "(")
        | ' ' =>  (xs1, s)
        | ')' =>  if s = "" then (xs1, ")") else ($ldelay(stream_vt_cons(x, xs1), ~xs1), s)
        | _ =>  get_token(xs1, s + string_implode(list0_sing(x)))
in
    case+ !xs of
    | ~stream_vt_nil() => $ldelay( stream_vt_nil() )
    | ~stream_vt_cons(x, xs1) => let
          val ys = $ldelay( stream_vt_cons(x, xs1), ~xs1 )
          val (zs, tok) = get_token(ys, "")
        in
          $ldelay( stream_vt_cons(tok, tokenize(zs)), ~zs )
        end
end


implement
parse_tokens(xs) = 
  case+ !xs of
  | ~stream_vt_nil() => None()
  | ~stream_vt_cons(x, xs) => 
      case+ x of
      | "TMint"  =>  Some(TMint(parse_TMint(xs)))
      | "TMstr"  =>  Some(TMstr(parse_TMstr(xs)))
      | "TMtup"  =>  Some(TMtup(parse_TMtup(xs)))
      | "TMproj" =>  let val tup = parse_TMproj(xs) in Some(TMproj(tup.0, tup.1)) end
      | "TMvar"  =>  Some(TMvar(parse_TMvar(xs)))
      | "TMlam"  =>  let val lmd = parse_TMlam(xs)  in Some(TMlam(lmd.0, lmd.1)) end
      | "TMapp"  =>  let val app = parse_TMapp(xs)  in Some(TMapp(app.0, app.1)) end
      | "TMfix"  =>  let val fxp = parse_TMfix(xs)  in Some(TMfix(fxp.0, fxp.1, fxp.2)) end
      | "TMopr"  =>  let val opr = parse_TMopr(xs)  in Some(TMopr(opr.0, opr.1)) end
      | "TMifnz" =>  let val ifz = parse_TMifnz(xs) in Some(TMifnz(ifz.0, ifz.1, ifz.2)) end
      | "TMseq"  =>  let val seq = parse_TMseq(xs)  in Some(TMseq(seq.0, seq.1)) end
      | "(" => parse_tokens(xs)
      | ")" => parse_tokens(xs)
      | _ => (~xs; None())
    
(* ****** ****** *)

(* end of [lisp_parser.dats] *)