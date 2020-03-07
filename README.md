# Combination-Algorithm-Writer-Stable
Combination Algorithm Writer Stable

Please note: This works with the example below, which CAWMP doesn't.

Combination Algorithm Writer is a SWI-Prolog algorithm that finds combinations of given commands that satisfy the given input and output.

It verifies for no singletons.

Installation
Load all files in the form:
```
['listprologinterpreter1listrecursion4 copy 52'].
['listprologinterpreter3preds5 copy 52'].
['caw5 copy 11'].
```
Running

```
caw00(off,f,[[+,2,1]],4,8,[[a,1],[b,1],[c,2],[d,1]],[[e,5]],[[[f1,4,1],[a,b,c,d,e],":-",[[+,[a,b,f]],[+,[c,f,g]],[+,[d,g,h]],[=,[e,h]]]]],[],P),writeln(P).

[[f1,[a,b,c,d,e],:-,[[+,[a,b,f]],[+,[c,f,g]],[+,[d,g,h]],[=,[e,h]]]],[f,[a,b,c,d,e],:-,[[+,[a,b,f]],[+,[c,d,g]],[+,[f,g,h]],[=,[e,h]]]]]
.
.
.
```

Note:
Use (:-) instead of :-.
