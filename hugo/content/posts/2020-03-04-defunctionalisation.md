---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- programming
- g-research
- hacker-news
comments: true
date: "2020-03-04T00:00:00Z"
aliases:
- /defunctionalisation/
title: Defunctionalisation
summary: "An underappreciated tool for writing good software."
---

# Defunctionalisation: an underappreciated tool for writing good software

*Cross-posted at the [G-Research official blog](https://www.gresearch.co.uk/article/defunctionalisation/); comments at [Hacker News](https://news.ycombinator.com/item?id=22525038).*

I work in an engineering team at G-Research dedicated to creating performant and correct libraries for our quant researchers to use. In the process of achieving this goal, we have settled on a number of patterns to make it easier to write code that is both correct and amenable to optimisation, and I’d like to explain one such pattern in this blog post. My personal motto distilled from these patterns is “load as much information as you can into the type system, so that the computer can tell you what to write”, and this post can be viewed as exploring an aspect of that philosophy.

We have talked about "initial algebras" [at some length](https://github.com/nickcowle/Talks/blob/3babf57d01db905ef057624250543753acfde4cb/Initial%20Algebras%20for%20the%20Uninitiated.pdf); this post is to discuss *defunctionalisation* as a complementary technique.
Defunctionalisation is a well-known technique among compiler writers, but I consider it to be under-appreciated as a tool for writing good software more generally.
It pairs up particularly well with the "initial algebra" pattern.

# What problem can defunctionalisation help to solve?

Recall that the initial algebra pattern, in a nutshell, is "don't manipulate *things*, but instead manipulate *descriptions of those things*".
An ideal program written using the initial algebra pattern is essentially a "compilation pipeline" of successive refinements to these descriptions, until finally the descriptions contain all the information required to produce a performant program; whereupon it is easy to construct that program.
More philosophically, "don't throw away information; instead, refine the information as much as possible, and only turn it into an actual program as late as possible".

This pattern, used correctly, has a number of advantages, all related to each other.

* The "compilation pipeline" of successively refined descriptions is very inspectable.
At any point during this "compilation", you can explore the current structure of the descriptions you have made so far.
* Keeping as much information as possible means you have more scope to optimise.
For example, if your library takes as input a description of what the user wants to do, you have complete freedom to notice any redundancy or inefficiency in the user's description before you ever start producing any concrete output.
* Such programs are very easy to test.
They are naturally modular in structure (as implied by the pipeline metaphor).

But while the initial algebra pattern helps a lot in writing correct software that can also be made performant, it is still very possible to write in such a way as to nullify the benefits above; and this is where defunctionalisation comes in.

In brief, "defunctionalisation" means "converting programs into specifications of programs, and only later on interpreting those specifications back into programs".
Defunctionalisation is to *program structure* as the initial algebra is to *datatype structure*; a defunctionalised program can be thought of as a program which first describes what it will do, and then does it.
This might seem like needless complexity, but in fact it can be extraordinarily helpful to separate the logic of your programs in this way.

## How could the initial algebra pattern be misused, and how does defunctionalisation help?

We will discuss the three benefits of the initial algebra pattern listed above, and we will indicate how these benefits can be subverted by careless design.
The first two benefits will use the same example; the third ("testability") is best demonstrated by adding a little more complexity, so will use a different example.

It's true that both these examples are somewhat contrived; they are designed to highlight specific principles without any of the distractions that might make the code a little more realistic.
Rest assured that the principles continue to hold in real code.

### Inspectability

The first of the benefits listed above was "inspectability".

For this section and the next, let us imagine the guts of a very basic calculator application written in F#, expressed in the initial algebra style.
Perhaps this calculator has a graphical user interface with a `+` button and a unary `-` button, and the GUI constructs an expression which represents the user's input before that input is handed off to a library for processing.
The library will take an `Expr` as its input, defined below, and it will interpret that input into an `int`, thereby performing the calculation specified.

```fsharp
type Expr =
  | Const of int
  | CustomOneArg of (int -> int) * Expr
  | CustomTwoArgs of (int -> int -> int) * Expr * Expr

module Expr =
  let rec interpret (e : Expr) : int =
    match e with
    | Const a -> a
    | CustomOneArg (f, a) -> f (interpret a)
    | CustomTwoArgs (f, a, b) -> f (interpret a) (interpret b)
```

So the `+` button on this calculator produces an `Expr` which looks like a `CustomTwoArgs ((+), a, b)`; the `-` button produces a `CustomOneArg ((fun x -> -x), a)`.

Now, what happens if you were to pause in the middle of execution, just after the user's input has been parsed into an `Expr` but before we go on to call `interpret`?
Well, in your hand, perhaps you have a `CustomTwoArgs (closure<49>, (Const 3), (CustomOneArg(closure<103>, Const 9)))`.
But has this actually helped you?

The resolution to this problem is very likely obvious.

```fsharp
type OneArgFunction =
  | Negate
  | Custom of (int -> int)

type TwoArgFunction =
  | Add
  | Subtract
  | Custom of (int -> int -> int)

type Expr =
  | Const of int
  | OneArg of OneArgFunction * Expr
  | TwoArg of TwoArgFunction * Expr * Expr

module OneArgFunction =
  let interpret (f : OneArgFunction) : int -> int =
    match f with
    | Negate -> (~-)
    | Custom f -> f

module TwoArgFunction =
  let interpret (f : TwoArgFunction) : int -> int -> int =
    match f with
    | Add -> (+)
    | Subtract -> (-)
    | Custom f -> f

module Expr =
  let rec interpret (e : Expr) : int =
    match e with
    | Const a -> a
    | OneArg (f, x) ->
      (OneArgFunction.interpret f) (interpret x)
    | TwoArg (f, x, y) ->
      (TwoArgFunction.interpret f) (interpret x) (interpret y)
```

Hook up the `+` button so that it produces the `Sum` union case, and the `-` button so that it produces the `Negate` union case.

Now it's very likely that the debugger tells you that we are currently processing a `Sum (Const 3, Negate (Const 9))`.
Much better than the previous `CustomTwoArgs` confusion!

The trick was to *describe what we wanted to do* wherever possible, and then implement that description.
Notice the kinship with the initial algebra pattern: in our first attempt, we were careful not to throw away the user's input (after all, we could have hooked it up so that `3+3` was directly `6`, rather than `CustomTwoArgs((+), Const 3, Const 3)`), but it was only when we defunctionalised the operations that the power of the initial algebra really came into its own.

Note further that there is no loss of flexibility - we've still retained the `CustomOneArg` and `CustomTwoArgs` cases.
(Perhaps we do need this: perhaps the calculator library needs to take arbitrary functions from its consumers, and we genuinely might not be able to describe in advance what the user wants to do.)
This goes to show that defunctionalisation can often be done incrementally - you can get significant benefits without completely rearchitecting your program.
If after several rounds of defunctionalisation it turns out that the `CustomOneArg` and `CustomTwoArgs` cases are no longer required, then we can simply delete them and end up with a fully defunctionalised datatype; but if they are required, we can just keep them around and still retain many of the benefits from the rest of the program's defunctionalisation.

Remember, this particular instance of the problem is small, contrived, and designed to be easy to understand.
The principle does still hold in real life, and indeed one of our most recent internal projects has seen great structural and performance improvements after a couple of rounds of defunctionalising its core in precisely the incremental "identify the things you want to use this library for, and special-case them with unique descriptions" way described above.

### Scope for optimisation

The second of the benefits listed above was "keeping as much information as possible, leaving scope to optimise".

Initial algebras naturally don't lose much information; but it's quite possible to lose the information you need very early in the refinement pipeline.
In the toy calculator example, the original attempt (without `Sum` or `Negate` as distinct cases) made certain optimisations completely impossible.

For example, it's true that `-(-a) = a` for every integer `a`, so we might wish to optimise `Negate (Negate e)` down to just `e` for any expression `e`.
But if all we have is `OneArgFunction.Custom (_, OneArgFunction.Custom (_, e))`, then we simply can't do it.
Despite the use of an initial algebra, we've still lost too much information because of being insufficiently defunctionalised.

### Testability

The third of the benefits was "testability".
This one is easiest to demonstrate, and it's probably the most tangible way I use these patterns day-to-day.

Consider a simple, contrived, F# program that has some validation requirements, and then does one of two different things depending on whether its input was negative.

```fsharp
let writeSmallOddToFile (input : int) : unit =
    if input % 2 = 0 then
        failwith "Input did not pass validation: input cannot be even."
    if input > 100 then
        failwith "Input did not pass validation: input cannot be over 100."

    if input < 0 then
        printfn "Number was negative: %i" input
    else
        System.IO.WriteToFile("output.txt", sprintf "%i" input)
```

What about when you want to test this?
It's easy: simply catch and handle the exception in your tests, and mock out the file system.
(Of course, the function signature will need to be altered to take a file system as input.)

But there is a dual approach: using defunctionalisation to push the work forward, into the future.
Instead of handing the file system dependency *down* into `writeSmallOddToFile` from its caller, we have `writeSmallOddToFile` hand its desired actions *up* into its caller.

The following example is written rather in longhand to demonstrate the general pattern.

```fsharp
type ValidationError =
  | Even of int
  | TooBig of int

[<RequireQualifiedAccess>]
module ValidationError =
  let toString (error : ValidationError) =
    match error with
    | Even i -> sprintf "Input did not pass validation: input cannot be even."
    | TooBig i -> sprintf "Input did not pass validation: input cannot be over 100."

type WriteInstruction =
  | Print of string
  | WriteFile of FilePath * string

[<RequireQualifiedAccess>]
module WriteInstruction =
  let execute (instruction : WriteInstruction) : unit =
    match instruction with
    | Print s -> printfn s
    | WriteFile (fp, s) -> System.IO.WriteToFile (fp, s)

let describe (input : int) : Result<WriteInstruction, ValidationError> =
  if input % 2 = 0 then
    Error (Even input)
  else if input > 100 then
    Error (TooBig input)
  else
    if input < 0 then
      Print (sprintf "Number was negative: %i" input)
    else
      WriteFile (System.IO.FilePath "output.txt", sprintf "%i" input)
    |> Ok

let writeSmallOddToFile (input : int) : unit =
  match describe input with
  | Error e -> failwith (ValidationError.toString e)
  | Ok instruction -> WriteInstruction.execute instruction
```

Now it is incredibly simple to test the logic of the `describe` function: there are no dependencies to mock, so we can simply call the function precisely as it will be called in production.
The `WriteInstruction.execute` function has similarly been stripped to the bare bones; to test this function, it will be necessary to mock out dependencies (though because the dependencies have been forced as far forward as possible, they are much easier to mock).
Succinctly: *the logic of deciding how to do things* is completely decoupled from *the logic of deciding what to do*, and this separation makes it easier both to test *what the program thinks it should do* and *how the program thinks it should do it*.

If a more end-to-end test is required, a function `WriteInstruction -> unit` could be injected into `writeSmallOddToFile`, to be used instead of `WriteInstruction.execute`.
Note that this looks very similar to the object-orientation-inspired idea of mocking out the filesystem; but mocking an entire filesystem is very much overkill here, giving the caller much less of an idea of how the filesystem dependency is going to be used.
By instead having `describe` pass its intended actions *up* to its caller, and separating the interpretation of those actions in `execute`, the requirements are made clear.

# How can you start defunctionalising your programs?

One of the great benefits of defunctionalisation is that it can be introduced gradually to an existing system.
When a data structure contains functions that you (the creator of a library) have put there, you can always pull off the following manoeuvre.

Imagine we have a discriminated union called `FunctionalType`, which expresses several possible ways of getting information from the outside world for use in subsequent processing.
One of these ways is an `InternetRequest`, which takes an integer (say, `3`), then requests `http://wellknown/3.txt` and checks if that page exists.

```fsharp
[<Obsolete "Use Defunctionalising instead.">]
type FunctionalType =
  /// Requests document '3.txt', say, under a well-known URL.
  /// Returns true if that document exists.
  | InternetRequest of (int -> bool)
  /// Some other possible things we might want to do
  | AnotherCase of (string -> float)
  | AThirdCase of (unit -> float)

type Defunctionalising =
  | InternetRequest of Uri
  | AnotherCase of (string -> float)
  | AThirdCase of (unit -> float)
```

Imagine the call site used to look like the following (where I have assumed access to some helper functions in a hypothetical `Uri` module, rather than writing out a complete implementation):

```fsharp
let makeFunctionalType () : FunctionalType =
  let remoteFileExists (i : int) =
    let document : string option =
      Uri.append (Uri.make "http://wellknown") (sprintf "%i.txt" i)
      |> Uri.fetch
    match document with
    | None -> false
    | Some _ -> true
  FunctionalType.InternetRequest remoteFileExists

let doStuff (f : FunctionalType) (i : int) =
  match f with
  | FunctionalType.InternetRequest (f : int -> bool) ->
    if f i then 0.0 else 1.0
  | AnotherCase (f : string -> float) ->
    f "hello!"
  | AThirdCase (f : unit -> float) ->
    f ()
```

Then in the new world, it could look like this:

```fsharp
let makeDefunctionalising () : Defunctionalising =
  Uri.make ("http://wellknown")
  |> Defunctionalising.InternetRequest

let doStuff (f : Defunctionalising) (i : int) =
  match f with
  | Defunctionalising.InternetRequest (u : Uri) ->
    let document =
      Uri.append u (sprintf "%i.txt" i)
      |> Uri.fetch
    match document with
    | None -> false
    | Some _ -> true
    |> fun result -> if result then 0.0 else 1.0
  | Defunctionalising.AnotherCase (f : string -> float) ->
    // This is unchanged: we haven't defunctionalised it yet
    f "hello!"
  | Defunctionalising.AThirdCase (f : unit -> float) ->
    f ()
```

This hasn't actually decreased the complexity: all the same code is present in the old world as in the new world, though some of it has shuffled around.
However, this new world enjoys some of the benefits discussed above, and without the need to make sweeping changes to the entire program: we have defunctionalised only one case where it seemed easy to do so.

Of course, if we would like to keep the `doStuff` function short, then we can extract the rearranged code out into its own “interpreting” function with type signature `Uri -> (int -> bool)`.

## What about more complex dependencies?

Sometimes there may be interdependencies knitted into the structure of your code, such that several DU cases have to be migrated together; but even this is not an insurmountable obstacle.
By creating a structure that holds the dependencies, you can make sure you have them whenever you need them; and once all the relevant DU cases have been "nearly defunctionalised" so that they consist of a description and a blob of dependencies, then you can start to move the dependencies out again.

```fsharp
type Dependencies = Dependencies of (int ref) * OtherThings

type Defunctionalising =
  /// The InternetRequest case is completely defunctionalised, as above.
  | InternetRequest of Uri
  /// The AnotherCase case is not completely defunctionalised, but is "nearly" so:
  /// it no longer contains a function string -> float, but instead a structure
  /// that contains all the information that would be required to create that function.
  | AnotherCase of Dependencies
  | AThirdCase of Dependencies * bool
```

Now, when we come to use the `Defunctionalising` type, we can recreate the functions that were previously contained within the `FunctionalType`'s cases, even if there was lots of information shared between those cases.
In this example, there is some shared mutable state (the `int ref` of the `Dependencies` object), which is why we didn't want to migrate the two cases independently.
But we can still move the construction of those functions forward, into the future, constructing them only at the point where they are needed and hence obtaining many of the benefits of defunctionalisation:

```fsharp
let doStuff (f : Defunctionalising) (i : int) =
  match f with
  | Defunctionalising.InternetRequest (u : Uri) ->
    // We already saw this defunctionalisation, so I won't repeat it
    failwith "etc."
  | Defunctionalising.AnotherCase (Dependencies (sharedState, otherThings)) ->
    let f (s : string) : float =
      sharedState := float (String.length s)
      sharedState
    f "hello!"
  | Defunctionalising.AThirdCase (Dependencies (sharedState, otherThings), b : bool) ->
    let f () : float =
      sharedState := sharedState + 1.
      sharedState
    f ()
```

The idea is that instead of having a function which [closes over] its dependencies implicitly, we bring those arguments out so they are explicitly represented in the defunctionalised data structure.
Then we can get rid of the function itself from our data type, and rehydrate the function later on.

Once we have manipulated the data structures into this more cleanly separated form (that is, "a blob of stuff the function needs" and "the input to the function"), we could simply stop and consider our job to be done.
It's almost certainly produced a more inspectable, more testable data structure, with nice handy labels for everything that the debugger would previously have had to its best at disentangling for us (in showing all the variables that had been closed over).
Or we could go on and see how far forward in the "compilation pipeline" we can push the computations that create the `Dependencies` object.

For example, we could discover that the `sharedState` was actually only ever mutated by the functions contained in these two discriminated-union cases, and that it was safe to create this dependency later, omitting it from the `Dependencies` object and therefore making the code simpler (since we can guarantee that nothing else is mutating that shared state):

```fsharp
type Defunctionalising =
  /// The InternetRequest case is completely defunctionalised, as above.
  | InternetRequest of Uri
  /// Even more "nearly" defunctionalised: we have successfully extracted the int ref
  /// from the `Dependencies` object that used to be part of these cases
  | AnotherCase of OtherThings
  | AThirdCase of OtherThings * bool

let doStuff (f : Defunctionalising) (i : int) =
  // Now it's only `doStuff` which can be mutating this state!
  let mutable sharedMutableState = 0.
  match f with
  | Defunctionalising.InternetRequest (u : Uri) ->
    // We already saw this defunctionalisation, so I won't repeat it
    failwith "etc."
  | Defunctionalising.AnotherCase (deps : OtherThings) ->
    let f (s : string) : float =
      sharedMutableState <- float (String.length s)
      sharedMutableState
    f "hello!"
  | Defunctionalising.AThirdCase (deps : OtherThings, b : bool) ->
    let f () : float =
      sharedMutableState <- sharedMutableState + 1.
      sharedMutableState
    f ()
```

It's entirely up to you to decide how far along the defunctionalisation path you wish to go.

# Conclusion

It really is very hard to express in words how beautiful a "compilation pipeline" of initial algebras can be.
Functional programming is in some sense "programming via data", and while the initial algebra pattern lets you see what you're going to do, it is only when you add in defunctionalisation to the "compilation pipeline" that the program can truly fall out into layer after layer of pure data transformations.

Defunctionalisation makes it easier to track the dependencies of your code, and it can simultaneously make your code more amenable to optimisation and more debuggable.
Indeed, internally we have used this extra power to help create visualisations of the various stages of "compilation" underlying a particular one of our projects (since at any stage of "compilation" of an initial algebra, you can always choose to interpret your data structure not as a specification of a computation, but as a specification of a visualisation!).
If you have never tried working while you have good visualisations of the internals of your programs, I strongly recommend giving it a try; it is mind-expanding.

Be on the lookout for opportunities to throw away less information, and the data structures will reward you.

[closes over]: https://en.wikipedia.org/wiki/Closure_(computer_programming)
