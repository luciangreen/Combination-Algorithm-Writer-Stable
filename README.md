# Combination-Algorithm-Writer-Stable
Combination Algorithm Writer with Predicates Stable (CAWPS)

Please note: This works with the example below, which CAWMP doesn't.

Combination Algorithm Writer is a SWI-Prolog algorithm that finds combinations of given commands that satisfy the given input and output.

It verifies for no singletons.

# Installation from List Prolog Package Manager (LPPM)

* Optionally, you can install from LPPM by installing <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a> for your machine, downloading the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>,
```
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
```
loading LPPM with `['lppm'].` then installing the package by running `lppm_install("luciangreen","Combination-Algorithm-Writer-Stable").`.

Installation
Load all files in the form:
```
['lpi_caw_commands.pl'].
['listprologinterpreter1listrecursion4copy52'].
['listprologinterpreter3preds5copy52'].
['caw5copy11'].
```
Running

```
caw00(off,f,[[+,2,1]],4,8,[[a,1],[b,1],[c,2],[d,1]],[[e,5]],[[[f1,4,1],[a,b,c,d,e],(:-),[[+,[a,b,f]],[+,[c,f,g]],[+,[d,g,h]],[=,[e,h]]]]],[],P),writeln(P).

[[f1,[a,b,c,d,e],:-,[[+,[a,b,f]],[+,[c,f,g]],[+,[d,g,h]],[=,[e,h]]]],[f,[a,b,c,d,e],:-,[[+,[a,b,f]],[+,[c,d,g]],[+,[f,g,h]],[=,[e,h]]]]]
.
.
.
```

```
caw00(off,reverse,[[head,1,1],[tail,1,1],[wrap,1,1],[append,2,1],[reverse,2,1]],6,8,[[a,[1,2,3]],[b,[]]],[[c,[3,2,1]]],[[[reverse,2,1],[[],a,a]]],[],P),writeln(P).

not finished
```

Note: Use (:-) instead of :-.

# CAWPS API

* To run CAWPS on a Prolog server:
* Move `cawps-api.pl` to the root (`/username/` or `~` on a server) of your machine.
* Re-enter the paths to your Prolog files in it.
* Enter `[cawps-api.pl]` in SWI-Prolog and `server(8000).`.
* On a local host access the algorithm at `http://127.0.0.1:8000` and replace 127.0.0.1 with your server address on a server.
