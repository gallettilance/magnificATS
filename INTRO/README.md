# Intro to ATS - or how to code productively

## Why you should care

![](https://i.imgur.com/HTisMpC.jpg)

If you have not already experienced this, the debugging process of programming can be traumatizing. Relentless as you may be, eventually, when something goes wrong and you seem to have tried everything, you will reach a point that makes you doubt your love for programming. If you go through this enough, the passion and excitement of coding get shadowed by fear, anxiety, and the perspective of a reliving the past trauma.

![](http://s2.quickmeme.com/img/80/80ff000de170d180836519b11ef29b7814dc5d5b5b24abed94f5c3828075e811.jpg)

The worst side-effect of this process is probably its impact on scalability, collaboration, and productivity. Imagine spending days trying to fix bugs in your code. After a while of trying in vain, instinct kicks in and it is solely about survival - man vs machine. In this battle the means justify the ends and your code gets cluttered with hacks and other small patches that, accumulated, make your code unmaintainable. Neither you nor anyone else wants to examine or read through it.

![](https://s3.amazonaws.com/rails-camp-tutorials/blog/programming+memes/works-doesnt-work.jpg)

THEN, your manager, colleague or friend comes up to you and says "Hey, why don't we add feature x and change feature y".

![](https://vignette.wikia.nocookie.net/spongefan/images/2/23/Tulio_head_banging.gif/revision/latest?cb=20150612222916)

You start thinking you will likely fix the door but break windows (pun somewhat intended). This makes it inflexible to scale because of the mental obstacle coders have to go through. And in the end you've produced code that dampens collaboration and productivity. 

![](http://s2.quickmeme.com/img/32/3231c171a34d1b88ab1768b1ba5ef9f0e9b035f523e197f2b99f83b7856826e3.jpg)

Look at Frodo - he never wants to go through this again. As our lives start depending more and more on software, what we code should be just as important as how we code it. But with deadlines and other obstacles, how can we make this happen? One option is to sharpen the tools you use - means making smarter editors, more high level languages. This is an incredible push toward productivity. However I will argue that it is the methodology that accompanies each language that truely distinguishes its productivity. If, as a coder, your methodology does not change with the language you use, then you will likely be facing the debugger a lot. Ask yourself what methodology you use for each language you know. Does it work? If you are spending a lot of time debugging, the answer is probably no.

The goal of ATS is to restore your love of coding by providing you with interesting language features combined with a methodology for reducing debugging and testing.

## How it works

The most important question a coder must ask him/herself is "How do I know the code does what it is supposed to do?". The current mainstream view is that code passing all tests equates to correctness. From a mathematical and logical perspective, there is no way to cover an infinite set of paths with a finite set of tests. And, if you think of testing as evaluating a mathematical function, there is no guarantee that this function is bijective. Most of the time there is no way of identifying the origin of an error from the error itself.

![](https://i.imgur.com/e16qOEj.gif)

ATS uses types and theorem proving to flush out bugs statically. Type errors always point back to the origin of the error and force you to examine the logic of your code instead of finding hacks. The idea is that type specification can be so precise that passing typechecking equates to correctness.

The goal of this talk is to outline a methodology and list good practices, that, when combined with ATS, make for an extremely productive workflow. Giving time back to the programmer allows for better focus on quality.

![](http://www.cdotson.com/wp-content/uploads/2011/11/XKCD_The_General_Problem.jpg)


## Methodology

### Typechecking

The ATS perspective is to start vague and refine. Start with simple types: the domain of ints maps to the domain of ints via a given function. The typechecker proves that if an int is provided as input then an int is produced as output. Now you can refine the input and output types to match the specification of your function. For example you can define the input to be only ints multiples of 2 and the output to be only ints less than 0. You can statically check whether an index is out of bounds, or whether matrix dimensionality matches for a given multiplication. The refinement is limitless.

There are many excellent tutorials about getting started with ATS and its syntax. The goal of the following (albeit somewhat pendantic) example is simply to illustrate the concept mentioned above. Let's start with the factorial function.

Deciding what the input and output types of a function will be is a bit like writing the introduction of an essay: you should write it after you have determined the overall logic and structure of the body. Here, the factorial function we want to implement takes as input a positive integer n and outputs the product of all strictly positive integers less than or equal to n. As such, we can declare our function fact as:
  
```ats
extern
fun
fact(n : int) : int
```

And, we can implement it as such:

```ats
implement
fact(n) =
  if n = 1 then 1
  else n * fact(n - 1)
```

This factorial function works for strictly positive integers. However, when n = 0 our factorial function will keep decreasing n without ever hitting the base case. This will give a stack overflow because of the recursion. A naive fix for this solution is the following:

```ats
implement
fact(n) =
  if n <= 1 then 1
  else n * fact(n - 1)
```

This is incorrect because our factorial function should be undefined for values of n < 1. Outputting a default value as such is a hack and should be avoided as much as possible. When you test, later on, how your factorial function integrates with the rest of your code, if the overall output is a blue square instead of an orange circle, there is no way for you to know the cause was a negative value given to fact along the way. We want our program to stop the moment a negative value is given as input to fact. We can do the following:

```ats
implement
fact(n) = let
  val () = assertloc(n > 0)
in
  if n = 1 then 1
  else n * fact(n - 1)
end
```

The assertloc() function will raise an error if the statement n > 0 is false. At this point we have a working factorial function and we can start the refinement process.

- [tail-recursion](http://ats-lang.sourceforge.net/EXAMPLE/EFFECTIVATS/loop-as-tailrec/main.html)

- [dependent types](http://ats-lang.github.io/DOCUMENT/INT2PROGINATS/HTML/INT2PROGINATS-BOOK-onechunk.html#introduction-to-dependent-types)


### Top Down Approach

In general, but especially When coding large projects, a top down approach is extremely productive in ATS.

First, write the code for the function you need to implement. Do not disturb your workflow by implementing the helper functions on the fly. Once you have written your function and you are convinced the logic of your program is sound, simply declare the helper functions. At this point, typecheck your code, read the type errors closely, fix them, and typecheck again. Now that your code passes typechecking, use that same top down approach to tackle the helper functions that are declared but not implemented.

The reason this method is effective is because a trip to the debugger, print statements in your code, unit tests, all require more time than simply typechecking. They all break your workflow and require you to have runnable code at every stage. This forces you to adopt a bottom up approach with no guarantees that the code you write will be needed later on. 

#### Example using Combinators

ATS has a large combinator library that can make your code elegant and readable. Some of these combinators include

- [map](http://ats-lang.sourceforge.net/LIBRARY/libats/ML/SATS/DOCUGEN/HTML/list0.html#list0_map)
- [foldleft](http://ats-lang.sourceforge.net/LIBRARY/libats/ML/SATS/DOCUGEN/HTML/list0.html#list0_foldleft)
- [map2](http://ats-lang.sourceforge.net/LIBRARY/libats/ML/SATS/DOCUGEN/HTML/list0.html#list0_map2)
- [foldleft2](http://ats-lang.sourceforge.net/LIBRARY/libats/ML/SATS/DOCUGEN/HTML/list0.html#list0_foldleft2)

Please take the time to get familiar with these functions before moving along.

We will use these combinators to solve Project Euler's [problem 18](https://projecteuler.net/problem=18). A Brute Force algorithm for this will be to explore all possible paths and find the maximum. However, as indicated in the problem statement, we can do better. After a short review of [dynamic programming](https://en.wikipedia.org/wiki/Dynamic_programming), we notice we can fold the triangle onto itself in such a way to obtain a list of the max paths to each leaf node of the triangle. Then we need only find the maximum of that list. To illustrate this, let us take the smaller triangle from the problem's example:

3  
7 4  
2 4 6  
8 5 9 3  

The folding process will gives the following intermediate folded triangles:

first, we add 3 to 7 and 3 to 4.

10 7  
2 4 6  
8 5 9 3  

then we add 10 to 2 and 7 to 6. For 4, we can get to it from 10 and 7 so the max path to 4 will be max(10 + 4, 7 + 4) as such:

12 14 13  
8 5 9 3  

and finally we get the following list:

20 19 23 16  

Now that the triangle is fully folded, we simply take the max of the resulting list. In this case it's 23. Now that we are logically convinced of our methodology, let's write some code!

As before we need to think about how we will define our function. Here we want a function that takes in a triangle and returns an integer that represents the max path. As you may have guessed from the combinators above, we will represent a triangle as a list of lists. Our max_path function will have the following declaration:

```ats
extern
fun
max_path(triangle: list0(list0(int))): int
```

And the following implementation:

```ats
implement
max_path(triangle) =
  max
  (
    list0_foldleft<list0(int)>(triangle, nil0(), lam(res, line) => myfold(line, res))
  )
```

Now, in order to typecheck this function we need to declare our helper functions:

```ats
extern
fun
myfold(xs: list0(int), ys: list0(int)): list0(int)

extern
fun
max(xs: list0(int)): int 
```

Now that our function typechecks, we can implement our helper functions myfold() and max() as such:

```ats
implement
myfold(xs, ys) = let
  val f1 = list0_map2<int,int><int>(cons0(0, ys), xs, lam(y, x) => x + y)
  val f2 = list0_map2<int,int><int>(list0_append(ys, list0_sing(0)), xs, lam(y, x) => x + y)
in
  list0_map2<int, int><int>(f1, f2, lam(x, y) => if x > y then x else y)
end

implement
max(xs) = let
  val () = assertloc(list0_length(xs) > 0)

  fun aux(xs: list0(int), m:int): int =
    case+ xs of
    | nil0() => m
    | cons0(x, xs) => if x > m then aux(xs, x) else aux(xs, m)
in
  case- xs of
  | cons0(x, xs) => aux(xs, x)
end
```

Great! After typechecking, we can be fairly confident that this code does what we want it to do. If you would like to play with the code and/or test it out, you can do so online [here](http://www.ats-lang.org/SERVER/MYCODE/Patsoptaas_serve.php?mycode_url=https://pastebin.com/raw/AKv2zznT).

#### Another Example

(coming soon)



## Good Practices

### Structure

Here is an outline of the code templates I use to structure my ATS code.

- [Single File Template](./template.dats)

- [Folder Template](./TEMPLATE)

The goal is to generate "boring" code. The idea is if your code is boring, it is straightforward and consistent - two crucial premises to readable and maintainable code. Following a template and a style you can conform to makes it easier to write "boring" code.

### Functions and Combinators

Lots of functions with small bodies > less functions with large bodies

### Spacing

ATS needs space - accross files and folders.

### Stay vague until you need to be precise

(to be continued)

------

Read the book [Introduction to Programming in ATS](http://ats-lang.github.io/DOCUMENT/INT2PROGINATS/HTML/INT2PROGINATS-BOOK-onechunk.html)