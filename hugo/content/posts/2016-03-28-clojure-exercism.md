---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- programming
comments: true
date: "2016-03-28T00:00:00Z"
aliases:
- /clojure-exercism/
title: Clojure and Exercism
summary:
    I've been trying to learn Clojure through Exercism, a programming exercises tool.
    It took me an hour to get Hello, World! up and running, so I thought I'd document how it's done.
    I'm using Leiningen on Mac OS 10.11.4.
---

I've been trying to learn [Clojure] (a LISP) through [Exercism], a programming exercises tool.
It took me an hour to get Hello, World! up and running, so I thought I'd document how it's done.
I'm using [Leiningen] on Mac OS 10.11.4.

The [Installing Clojure page] on Exercism details how to install Leiningen; that part is easy.
Installing `exercism` is likewise easy, so we run `exercism fetch clojure hello-world`.

And then we enter a world of pain.

`exercism` downloads a project structure:

    hello-world/
    -- project.clj
    -- README.md
    -- test/
       -- hello_world_test.clj

The README helpfully tells us what Hello, World! is, and a specification for the answer.
How are we to come up with our answer?
`lein` gives access to a REPL we can use to write an answer, but there's no indication of
where to put our files so that `lein` can see them.

Let's run `lein test` to see what `lein` complains about.

    Exception in thread "main" java.io.FileNotFoundException:
    Could not locate hello_world__init.class or hello_world.clj on classpath.
    Please check that namespaces with dashes use underscores in the Clojure file name.,
    compiling:(hello_world_test.clj:1:1)

Fine. It's looking for `hello_world.clj`. Let's make one!

I've put the following in `hello-world/hello_world.clj`:

    (defn hello
     []
     "Hello, World!"
     [name]
     (str "Hello, " name "!"))

    (defn main- [& _] (println "Hello!"))

`lein test` fails again, with the same error.

Do we get any hints from the test file?
It starts with a namespace declaration:

    (ns hello-world-test
     (:require [clojure.test :refer [deftest is]]
               hello-world))

We're going to want a `hello-world` namespace, so let's put that at the top of our `hello_world.clj`.

    (ns hello-world)

Still fails with the same error.
OK, the thing that is telling `lein` what to do must be `project.clj`, and it turns out to contain the following:

    (defproject hello-world "0.1.0-SNAPSHOT"
     :description "hello-world exercise."
     :url "https://github.com/exercism/xclojure/tree/master/exercises/hello-world"
     :dependencies [[org.clojure/clojure "1.8.0"]])

None of that tells `lein` where to look for the source file.
If we make a new `lein` project somewhere, let's see what the project file is supposed to look like.

Go to a temporary directory and use `lein new app newproj`.
The source tree looks like:

    newproj/
    -- CHANGELOG.md
    -- LICENSE.md
    -- README.md
    -- doc/
       -- intro.md
    -- project.clj
    -- resources/
    -- src/
       -- newproj/
          -- core.clj
    -- test/
       -- newproj/
          -- core_test.clj

And `project.clj` looks like:

    (defproject newproj "0.1.0-SNAPSHOT"
     :description "FIXME: write description"
     :url "http://example.com/FIXME"
     :license {:name "Eclipse Public License"
               :url "http://www.eclipse.org/legal/epl-v10.html"}
     :dependencies [[org.clojure/clojure "1.8.0"]]
     :main ^:skip-aot newproj.core
     :target-path "target/%s"
     :profiles {:uberjar {:aot :all}})

The only interesting thing there seems to be `:main ^:skip-aot newproj.core`.
Let's try putting `:main ^:skip-aot hello-world` into our own `project.clj`.

`lein test` continues to fail with the same error.
Looking up `:skip-aot`, it just tells `lein` to skip Ahead-Of-Time compilation, which isn't what we want.

With a heavy heart, then, let's restructure `hello-world` so it looks exactly like `newproj`:

    hello-world/
    -- README.md
    -- project.clj
    -- src/
       -- hello_world/
          -- hello_world.clj
    -- test/
       -- hello_world/
          -- hello_world_test.clj

Miraculous! We have a different error!

    Exception in thread "main" java.io.FileNotFoundException:
    Could not locate hello_world_test__init.class or hello_world_test.clj on classpath.

I think this might be a back-step, because beforehand it was at least finding the test file.
I get the same error if I navigate into the test folder and run `lein test`.
And if we try `lein run`, we get the original error:

    Exception in thread "main" java.io.FileNotFoundException:
    Could not locate hello_world__init.class or hello_world.clj on classpath.

From the [Leiningen documentation]:

> The `src/my_stuff/core.clj` file corresponds to the `my-stuff.core` namespace.

That would imply that our source file corresponds to the `hello-world.hello-world` namespace.
Let's try flattening out the structure a bit, and returning the `hello_world_test.clj` to where at least
`lein` recognised it:

    hello-world/
    -- README.md
    -- project.clj
    -- src/
       -- hello_world.clj
    -- test/
       -- hello_world_test.clj

And it works! Woohoo!
(Well, the tests fail, but that's because I'm new to Clojure and missed out a bunch of parentheses.)

The final contents of `src/hello_world.clj`, causing the tests to pass, were:

    (ns hello-world)

    (defn hello
     ([] "Hello, World!")
     ([namevar] (str "Hello, " namevar "!")))

[Clojure]: https://clojure.org/
[Exercism]: https://exercism.io/
[Installing Clojure page]: https://exercism.io/languages/clojure
[Leiningen]: https://leiningen.org
[Leiningen documentation]: https://github.com/technomancy/leiningen/blob/stable/doc/TUTORIAL.md#creating-a-project
