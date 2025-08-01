# Combination-Algorithm-Writer-Stable
Combination Algorithm Writer with Predicates Stable (CAWPS)

Please note: This works with the example below, which the CAWMP repository doesn't.

Combination Algorithm Writer is a SWI-Prolog algorithm that finds combinations of given commands that satisfy the given input and output.

It verifies for no singletons.

# Prerequisites

* Use a search engine to find the Homebrew (or other) Terminal install command for your platform and install it, and search for the Terminal command to install swipl using Homebrew and install it or download and install SWI-Prolog for your machine at <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a>.

# Mac, Linux and Windows (with Linux commands installed): Prepare to run swipl

* In Terminal settings (Mac), make Bash the default shell:

```
/bin/bash
```

* In Terminal, edit the text file `~/.bashrc` using the text editor Nano:

```
nano ~/.bashrc
```

* Add the following to the file `~/.bashrc`:

```
export PATH="$PATH:/opt/homebrew/bin/"
```

* Check if `usr/local/bin` exists

```
ls -ld /usr/local/bin
```

* Create the directory if missing

```
sudo mkdir -p /usr/local/bin
```

* Link to swipl in Terminal

```
sudo ln -s /opt/homebrew/bin/swipl /usr/local/bin/swipl
```

# 1. Install manually

Download <a href="http://github.com/luciangreen/Combination-Algorithm-Writer-Stable/">this repository</a>.

# 2. Or Install from List Prolog Package Manager (LPPM)

* Download the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>:

```
mkdir GitHub
cd GitHub/
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
swipl
['lppm'].
lppm_install("luciangreen","Combination-Algorithm-Writer-Stable").
../
halt.
```

# Running

* In Shell:
`cd Combination-Algorithm-Writer-Stable`
`swipl`

* Load all files in the form:
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
