interpretstatement1(_F0,_Functions,[[not,Operator],[Variable1,Variable2]],Vars1,Vars2,true,nocut) :-
	isop(Operator),
	interpretpart(not_is,Variable1,Variable2,Vars1,Vars2),!.

interpretstatement1(_F0,_Functions,[[not,Operator],[Variable1,Variable2]],Vars1,Vars2,true,nocut) :-
	comparisonoperator(Operator),
%%writeln1(4),
        interpretpart(not_iscomparison,Operator,Variable1,Variable2,Vars1,Vars2).

interpretpart(not_is,Variable1,Variable2,Vars1,Vars1) :-
        getvalues(Variable1,Variable2,Value1,Value2,Vars1),
        	not(isempty(Value1)),
        	not(isempty(Value2)),
        %%writeln([call,[[not,=],[Value1,Value2]]]),
        ((not(Value1 = Value2)
		)->
      true%%writeln([exit,[[not,=],[Value1,Value2]]])
;     fail)%%writeln([fail,[[not,=],[Value1,Value2]]]))
,!.                        	

interpretpart(not_iscomparison,Operator,Variable1,Variable2,Vars1,Vars1) :-        getvalues(Variable1,Variable2,Value1,Value2,Vars1),
        %%writeln([call,[[not,=],[Value1,Value2]]]),
	((isval(Value1),
	isval(Value2),
	Expression=..[Operator,Value1,Value2],
        not(Expression))->
      true%%writeln([exit,[[not,=],[Value1,Value2]]])
;     fail)%%writeln([fail,[[not,=],[Value1,Value2]]]))
,!.                        	

isempty(N) :-
	N=empty.

comparisonoperator(>).
comparisonoperator(>=).
comparisonoperator(<).
comparisonoperator(=<).
%%comparisonoperator(=).
comparisonoperator(=\=).
