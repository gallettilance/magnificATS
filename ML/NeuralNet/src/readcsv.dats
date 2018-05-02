(* ****** ****** *)
//
// LG - 03-06
//
(* ****** ****** *)

extern
fun
char2int(c: char): int

extern
fun
string2int(s: string): int

extern
fun
string2double(s: string): double

(* ****** ****** *)

extern
fun
parse_csv(s: string): vector string

extern
fun
csv_to_matrix_str(f (* file path *): string): matrix string

extern
fun
make_iris(f: string): (matrix double, vector double)

extern
fun
make_mnist(f: string): (matrix double, matrix double)

(* ****** ****** *)

implement
char2int(c) =
case+ c of
| '0' => 0
| '1' => 1
| '2' => 2
| '3' => 3
| '4' => 4
| '5' => 5
| '6' => 6
| '7' => 7
| '8' => 8
| '9' => 9
| _ => (println!("Error: invalid char", c); ~1)


implement
string2int(s) = let
  val xs = string_explode(s)
in
  list0_foldleft<int><int>
  (
  list0_map<char><int>(xs, lam(x) => char2int(x))
  , 0
  , lam(res, x) => x + (res * 10)
  )
end


implement
string2double(s) = let
  val xs = string_explode(s)
  
  fun aux(xs: list0(char), hd: list0(char)): double =
    case+ xs of
    | nil0() => string2int(string_implode(list0_reverse(hd))) + 0.0
    | cons0(x, xs) => 
      if x = '.'
      then 
      (
        let 
          val n = list0_length(xs)
          val () = assertloc(n > 0)
          val ipart = string2int(string_implode(list0_reverse(hd)))
          val dpart = string2int(string_implode(xs))
        in
          ipart + (dpart / pow<double>(10.0, n))
        end
      )
      else aux(xs, cons0(x, hd))
in
  aux(xs, nil0())
end


(* ****** ****** *)

implement
parse_csv(s) = let
  fun aux(xs: list0(char), res: list0(string), s: string): list0(string) =
    case+ xs of
    | list0_nil() => list0_reverse(cons0(s, res))
    | list0_cons(x, xs) => 
            if x = ','
            then aux(xs, cons0(s, res), "")
            else aux(xs, res, s + string_implode(list0_sing(x)))
in
  aux(string_explode(s), nil0(), "")
end


implement
csv_to_matrix_str(f) = let
  val ft = fileref_open_opt(f, file_mode_r)

  fun 
  aux
  ( sxs: stream_vt(string)
  , X: matrix string
  ): matrix string =
    case+ !sxs of
    | ~stream_vt_nil() => list0_reverse(X)
    | ~stream_vt_cons(s, sxs) =>
      let
        val x = parse_csv(s)
      in
        aux(sxs, cons0(x, X))
      end

in
  case- ft of
  | ~None_vt() => nil0()
  | ~Some_vt(content) => let
      val theLines = streamize_fileref_line(content)
    in
      aux(theLines, nil0())
    end
end


implement
make_iris(f) = let
  val data = csv_to_matrix_str(f)
  
  fun iris2double(s: string): double =
    case- s of
    | "Iris-setosa" => 0.0
    | "Iris-versicolor" => 1.0
    | _ => ~1.0 // invalid iris
  
  fun 
  aux
  ( data: matrix string
  , X: matrix double
  , Y: vector double
  ): (matrix double, vector double) =
    case+ data of
    | nil0() => (list0_reverse(X), list0_reverse(Y))
    | cons0(line, data) => 
      let
        val-cons0(y_str, x_str) = list0_reverse(line)
        val y = iris2double(y_str)
        val x = list0_map(x_str, lam(x) => string2double(x))
      in
        if y < 0.0
        then aux(data, X, Y)
        else aux(data, cons0(x, X), cons0(y, Y))
      end
    
in
  aux(data, nil0(), nil0())
end


implement
make_mnist(f) = let
  val data = csv_to_matrix_str(f)

  fun vectorize(dig: double): vector double = let
    fun helper(d: double, res: vector double, cnt: double): vector double = 
      if cnt = d then helper(d, cons0(0.99, res), cnt - 1)
      else 
      ( 
        if cnt < 0.0 
        then res
        else helper(d, cons0(0.01, res), cnt - 1)
      )
    in
      helper(dig, nil0(), 9.0)
    end
    
  fun 
  aux
  ( data: matrix string
  , X: matrix double
  , Y: matrix double
  ): (matrix double, matrix double) =
    case+ data of
    | nil0() => (list0_reverse(X), list0_reverse(Y))
    | cons0(line, data) => 
      let
        val-cons0(y_str, x_str) = line
        val y = string2int(y_str) + 0.0
        val x = list0_map(x_str, lam(x) => string2int(x) + 0.0)
      in
        if y < 0.0
        then aux(data, X, Y)
        else aux(data, cons0(x, X), cons0(vectorize(y), Y))
      end
    
in
  aux(data, nil0(), nil0())
end


(* ****** ****** *)

(* end of [readcsv.dats] *)
