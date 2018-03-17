# Intro to ATS - or how to code productively

## Why you should care

![](https://i.imgur.com/HTisMpC.jpg)

If you have not already experienced this, the debugging process of programming can be traumatizing. Relentless as you may be, eventually, when something goes wrong and you seem to have tried everything, you will reach a point that makes you doubt your love for programming. If you go through this enough, the passion and excitement of coding get shadowed by fear, anxiety, and the perspective of a reliving the past trauma.

![](http://s2.quickmeme.com/img/80/80ff000de170d180836519b11ef29b7814dc5d5b5b24abed94f5c3828075e811.jpg)

The worst side-effect of this process is probably its impact on scalability, collaboration, and productivity. Imagine going through this process; your code finally works and passes all the tests.

![](https://s3.amazonaws.com/rails-camp-tutorials/blog/programming+memes/works-doesnt-work.jpg)

After a while of trying bug-fixes in vain, instinct kicks in and it is solely about survival - man vs machine. In this battle the means justify the ends and your code gets cluttered with hacks and other small patches that, accumulated, make your code unmaintainable. Neither you nor anyone else wants to examine or read through it. THEN, your manager, colleague or friend comes up to you and says "Hey, why don't we add feature x and change feature y".

![](https://appslifestyle.files.wordpress.com/2011/05/image.png)

You start thinking you will likely fix the door but break windows (pun somewhat intended). This makes it inflexible to scale because of this mental obstacle coders have to go through. 

![](http://s2.quickmeme.com/img/32/3231c171a34d1b88ab1768b1ba5ef9f0e9b035f523e197f2b99f83b7856826e3.jpg)

Look at Frodo - he never wants to go through this again. This is why this process dampens collaboration and productivity.

The goal of ATS is to restore your love of coding by reducing the need for debugging and testing.

## How it works

The most important question a coder must ask him/herself is "How do I know the code does what it is supposed to do?". The current mainstream view is that code passing all tests equates to correctness. From a mathematical and logical perspective, there is no way to cover an infinite set of paths with a finite set of tests. And, if you think of testing as evaluating a mathematical function, there is no guarantee that this function is bijective. Most of the time there is no way of identifying the origin of an error from the error itself.

![](https://i.imgur.com/e16qOEj.gif)

ATS uses types and theorem proving to flush out bugs statically. Type errors always point back to the origin of the error and force you to examine the logic of your code instead of finding hacks. The idea is that type specification can be so precise that passing typechecking equates to correctness.

The goal of this talk is to outline a methodology and list good practices, that, when combined with ATS, make for an extremely productive workflow. Giving time back to the programmer allows for better focus on quality.

![](http://www.cdotson.com/wp-content/uploads/2011/11/XKCD_The_General_Problem.jpg)

## Methodology

### The Typechecker

The ATS perspective is to start vague and refine. Start with simple types: the domain of ints maps to the domain of ints via a given function. The typechecker proves that if an int is provided as input then an int is produced as output. Now you can refine the input and output types to match the specification of your function. For example you can define the input to be only ints multiples of 2 and the output to be only ints less than 0. You can statically check whether an index is out of bounds, or whether matrix dimensionality matches for a given multiplication. The refinement is limitless.

(example coming soon)

### Top Down Approach

When coding large projects, a top down approach is extremely productive in ATS.

First, write the code for the function you need to implement. Do not disturb your workflow by implementing the helper functions on the fly. Once you have written your function and you are convinced the logic of your program is sound, simply declare the helper functions. At this point, typecheck your code, read the type errors closely, fix them, and typecheck again. Now that your code passes typechecking, use that same top down approach to tackle the helper functions that are declared but not implemented.

The reason this method is effective is because a trip to the debugger, print statements in your code, unit tests, all require more time than simply typechecking. They all break your workflow and require you to have runnable code at every stage. This forces you to adopt a bottom up approach with no guarantees that the code you write will be needed later on. 

(example coming soon)

## Good Practices

### Structure

Lots of functions with small bodies > less functions with large bodies

### Spacing

ATS needs space - accross files and folders.

### Stay vague until you need to be precise

(to be continued)