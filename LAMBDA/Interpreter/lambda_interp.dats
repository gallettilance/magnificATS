(* ****** ****** *)
//
// LG 2018-02-12
//
(* ****** ****** *)

extern
fun
interp1 : term -> value
extern
fun
interp2 : (term, envir) -> value

overload interp with interp1
overload interp with interp2

(* ****** ****** *)

implement
interp1(src) =
interp2(src, list0_nil())

(* ****** ****** *)

extern
fun
envir_find :
(envir, string) -> value
implement
envir_find(env, x0) =
(
case- env of
| list0_cons(xv, env) =>
  if x0 = xv.0
    then xv.1 else envir_find(env, x0)
  // end of [if]
)

fun
interp2_list
(ts: termlst, env: envir): valuelst =
list0_map<term><value>(ts, lam(t) => interp2(t, env))

implement
interp2(t0, env) =
(
case t0 of
//
| TMint(i) => VALint(i)
| TMstr(s) => VALstr(s)
//
| TMvar(x) => envir_find(env, x)
//
| TMlam _ => VALlam(t0, env)
| TMfix _ => VALfix(t0, env)
//
| TMtup(ts) =>
  VALtup(interp2_list(ts, env))
//
| TMproj
    (t_tup, i) => let
    val v_tup = interp2(t_tup, env)
  in
    case- v_tup of
    | VALtup(vs) => vs[i] // = list0_get_at_exn(vs, i)
  end
//
| TMapp(t1, t2) => let
    val v1 = interp2(t1, env)
  in
    case- v1 of
    | VALlam
      (t_lam, env_lam) => let
        val v2 = interp2(t2, env)
        val-TMlam(x, t_body) = t_lam
        val env_lam = list0_cons($tup(x, v2), env_lam)
      in
        interp2(t_body, env_lam)
      end
    | VALfix
      (t_fix, env_fix) => let
        val v2 = interp2(t2, env)
        val-TMfix(f, x, t_body) = t_fix
        val env_fix = list0_cons($tup(x, v2), env_fix)
        val env_fix = list0_cons($tup(f, v1), env_fix)
      in
        interp2(t_body, env_fix)
      end
  end // end of [TMapp]
//

| TMopr _ => interp2_opr(t0, env)
//
| TMifnz
    (t1, t2, t3) => let
    val v1 = interp2(t1, env)
  in
    case- v1 of
    | VALint(i) =>
      interp2(if i != 0 then t2 else t3, env)
  end
| TMseq(t1, t2) => let val _ = interp2(t1, env) in interp2(t2, env) end
) where
{
//

fun
interp2_opr
( t0: term
, env: envir): value = let
//
#define :: list0_cons
#define nil list0_nil
//
val-TMopr(opr, ts) = t0
//
val vs =
list0_map<term><value>(ts, lam(t) => interp2(t, env))
//
in
case- opr of
| "+" =>
  (
    case- vs of
    | VALint(i1)::VALint(i2)::nil() => VALint(i1+i2)
  )
| "-" =>
  (
    case- vs of
    | VALint(i1)::VALint(i2)::nil() => VALint(i1-i2)
  )
| "*" =>
  (
    case- vs of
    | VALint(i1)::VALint(i2)::nil() => VALint(i1*i2)
  )
| "/" =>
  (
    case- vs of
    | VALint(i1)::VALint(i2)::nil() => VALint(i1/i2)
  )
| "~" =>
  (
    case- vs of VALint(i1)::nil() => VALint(~i1)
  )
| "abs" =>
  (
    case- vs of VALint(i1)::nil() => VALint(abs(i1))
  )
| ">=" =>
  (
    case- vs of
    | VALint(i1)::VALint(i2)::nil() => if i1 >= i2 then VALint(1) else VALint(0)
  )
| ">" =>
  (
    case- vs of
    | VALint(i1)::VALint(i2)::nil() => if i1 > i2 then VALint(1) else VALint(0)
  )
| "<=" =>
  (
    case- vs of
    | VALint(i1)::VALint(i2)::nil() => if i1 <= i2 then VALint(1) else VALint(0)
  )
| "<" =>
  (
    case- vs of
    | VALint(i1)::VALint(i2)::nil() => if i1 < i2 then VALint(1) else VALint(0)
  )
| "=" =>
  (
    case- vs of
    | VALint(i1)::VALint(i2)::nil() => if i1 = i2 then VALint(1) else VALint(0)
  )
| "!=" =>
  (
    case- vs of
    | VALint(i1)::VALint(i2)::nil() => if i1 != i2 then VALint(1) else VALint(0)
  )
| "print" =>
  (
    case- vs of v0::nil() =>
      (
      let val () =
        case+ v0 of
        | VALunit() => print("")
        | VALint(i) => print(i)
        | VALstr(s) => print(s)
        | VALtup(vs) => print("VALtup(...)")
        | VALlam(_,_) => print("VALlam(...)")
        | VALfix(_,_) => print("VALfix(...)")
      in
        VALunit()
      end
      )
  )
| "println" =>
  (
    case- vs of v0::nil() =>
      (
      let val () =
        case+ v0 of
        | VALunit() => println!("")
        | VALint(i) => println!(i)
        | VALstr(s) => println!(s)
        | VALtup(vs) => println!("VALtup(...)")
        | VALlam(_,_) => println!("VALlam(...)")
        | VALfix(_,_) => println!("VALfix(...)")
      in
        VALunit()
      end
      )
  )

end // end of [interp2_opr]

} (* end of [interp2] *)

(* ****** ****** *)

(* end of [interp.dats] *)