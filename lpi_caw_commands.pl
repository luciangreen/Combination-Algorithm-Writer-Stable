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
        debug_call(Skip,[[not,=],[Value1,Value2]]),
        ((not(Value1 = Value2)
		)->
      debug_exit(Skip,[[not,=],[Value1,Value2]])
;     debug_fail(Skip,[[not,=],[Value1,Value2]])),!.                        	

interpretpart(not_iscomparison,Operator,Variable1,Variable2,Vars1,Vars1) :-        getvalues(Variable1,Variable2,Value1,Value2,Vars1),
        debug_call(Skip,[[not,Operator],[Value1,Value2]]),
	((isval(Value1),
	isval(Value2),
	Expression=..[Operator,Value1,Value2],
        not(Expression))->
      debug_exit(Skip,[[not,Operator],[Value1,Value2]])
;     debug_fail(Skip,[[not,Operator],[Value1,Value2]])),!.
