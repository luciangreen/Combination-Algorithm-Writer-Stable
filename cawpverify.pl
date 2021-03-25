%% cawptest(Debug[on/off],Total,Score).

cawptest(Debug,NTotal,Score) :- cawptest(Debug,0,NTotal,0,Score),!.
cawptest(_Debug,NTotal,NTotal,Score,Score) :- NTotal=1, !.
cawptest(Debug,NTotal1,NTotal2,Score1,Score2) :-
	NTotal3 is NTotal1+1,
	cawptest2(NTotal3,Function,Rules,MaxLength,TotalVars,Specifications,AlgDict,Program1),
	
	%%writeln([cawptest2(NTotal3,Specifications,Program1)]),
	(((%%writeln(caw00(Debug,function0,[],5,TotalVars,Specifications,[],Program1)),
	caw00(Debug,Function,Rules,MaxLength,TotalVars,Specifications,AlgDict,[],Program1)
	
	%%sort(Program1,ProgramA),
	%%sort(Program2,ProgramA)
	%%writeln1(Program1),writeln1(Program2)
	%%Program1=Program2
	))->(Score3 is Score1+1,writeln([cawptest,NTotal3,passed]));(Score3=Score1,writeln([cawptest,NTotal3,failed]))),
	writeln(""),
	cawptest(Debug,NTotal3,NTotal2,Score3,Score2),!.

%% Test individual cases, Debug=trace=on or off, N=case number, Passed=output=result

cawptest1(Debug,N,Passed) :-
	cawptest2(N,Function,Rules,MaxLength,TotalVars,InputVarList,OutputVarList,AlgDict,Program1),
	%%writeln1([cawptest2(N,Specifications,Program1)]),
	%%writeln1(caw00(Debug,Function,Rules,MaxLength,MaxPredicates,TotalVars,Numinputs, Numoutputs,Specifications,AlgDict,[],Program2)),

	(((caw00(Debug,Function,Rules,MaxLength,TotalVars,InputVarList,OutputVarList,AlgDict,[],Program2),
	%%sort(Program1,ProgramA),
	%%sort(Program2,ProgramA)
trace,
	writeln(Program1),
	writeln(Program2),Program1=Program2
	))->(Passed=passed,writeln([cawptest,N,passed]));(Passed=failed,writeln([cawptest,N,failed]))),!.

% ["Mind Reading","mr for time travel 3.txt",0,algorithms,"34. I mind read the correct universe containing all my collections of areas of study, then time travelled to it."]

% The area of study was +++.

cawptest2(1,f,[[+,2,1%% Modes=2 inputs, 1 output
]],4,
8,
    [[a,1],[b,1],[c,2],[d,1]],[[e,5]]
,
[
%[[f1,4,1],[a,b,c,d,e],(:-),[[+,[a,b,f]],[+,[c,f,g]],[+,[d,g,h]],[=,[e,h]]]]
], %% Algorithm dictionary
 %% Result
        %[f1,[a,b,c,d,e],:-,[[+,[a,b,f]],[+,[c,f,g]],[+,[d,g,h]],[=,[e,h]]]],
[[f,[a,b,c,d,e],:-,[[+,[a,b,f]],[+,[c,d,g]],[+,[f,g,h]],[=,[e,h]]]]]
).
