# Intro to ATS - or how to code productively

## Why you should care

![](https://i.imgur.com/HTisMpC.jpg)

If you have not already experienced this, the debugging process of programming can be traumatizing. Relentless as you may be, eventually, when something goes wrong and you seem to have tried everything, you will reach a point that makes you doubt your love for programming. If you go through this enough, the passion and excitement of coding get shadowed by fear, anxiety, and the perspective of a reliving the past trauma.

![](http://s2.quickmeme.com/img/80/80ff000de170d180836519b11ef29b7814dc5d5b5b24abed94f5c3828075e811.jpg)

Probably the worst side-effect of this process is its impact on scalability, collaboration, and productivity. Imagine going through this process. Your code finally works and passes all the tests; you are proud and satisfied of your achievement.

![](https://s3.amazonaws.com/rails-camp-tutorials/blog/programming+memes/works-doesnt-work.jpg)

Now say your manager, colleague or friend comes up to you and says "Hey, why don't we add feature x and change feature y". It is likely you are thinking about how you will likely fix the door but break windows (pun somewhat intended). This makes it inflexible to scale because of this mental obstacle coders have to go through. After a while of trying fixes in vain, instinct kicks in and it is solely about survival - man vs machine. In this battle the means justify the ends and your code gets cluttered with hacks and other small patches that, accumulated, make your code unmaintainable. Neither you nor anyone else wants to examine or read through it. 

![](http://s2.quickmeme.com/img/32/3231c171a34d1b88ab1768b1ba5ef9f0e9b035f523e197f2b99f83b7856826e3.jpg)

Look at Frodo - he never wants to go through this again. This is why this process dampens collaboration and productivity.

The goal of ATS is to restore your love of coding. My hope is that this talk/ repo will showcase how productive the ATS workflow can make you and why this methodology should be widely adopted. I hope it will inspire coders to try this methodology out for themselves and implement some of these features into mainstream languages.

## Typechecker + Abstraction = Efficiency

In traditional coding, the workflow is the following bottom up approach: write code -> test code -> enhance code -> test code ... etc. Although this process is certainly valid it provides the following issues:

- You cannot be sure that all paths of your code have been tested (Correctness + Efficiency)

- You may implement code you realize later is not needed (Productivity)

The proposed solution is the following top-down approach. Solve the problem at the algorithm level and write the pseudo code in ATS. Declare all needed functions, assign all types involved, etc so to pass typechecking. Then recurse down to the helper functions you declared but have not yet implemented. This clearly solves problem 2 above because we know we are implementing only functions that are necessary to our code. Problem 1 is tricky but I will argue that with the help of types many bugs will be flushed out statically which will increase productivity (especially when testing is expensive such as in fields like Machine Learning or Crypto Currency).
