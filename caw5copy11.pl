:- dynamic debug/1.
:- dynamic totalvars/1.
:- dynamic outputvars/1.

caw00(Debug,PredicateName,Rules1,MaxLength,TotalVars,InputVarList,OutputVarList,Predicates1,Program1,Program2) :-
	split3(Predicates1,[],Rules2),
	split2(Predicates1,[],Predicates),
	%%writeln([Rules2,Predicates]),
	append(Rules1,Rules2,Rules3),

	retractall(debug(_)),
    	assertz(debug(Debug)),
	retractall(totalvars(_)),
    	assertz(totalvars(TotalVars)),
	caw0(Predicates,PredicateName,Rules3,MaxLength,InputVarList,OutputVarList,Program1,Program2).

caw0(Predicates,PredicateName,Rules,MaxLength,InputVarList,OutputVarList,Program1,Program2) :-
	varnames(InputVarList,[],InputVars,[],InputValues),
	varnames(OutputVarList,[],OutputVars,[],_OutputValues),
	retractall(outputvars(_)),
    	assertz(outputvars(OutputVars)),
append(InputVars,OutputVars,Vars11),
%%Vars11=InputVars,
%%Vars12=InputVars,
	append(InputValues,OutputVars,Vars2),
	%%append(InputValues,OutputValues,Values),
	Query=[PredicateName,Vars2],
	caw(Predicates,Query,PredicateName,Rules,MaxLength,Vars11,InputVars,InputVars,_,OutputVarList,OutputVars,Program1,Program2).
caw(_,_,_,_,0,_,_,_,_,_,_,_) :- fail, !.
caw(Predicates,Query,PredicateName,_,_,_VarList,InputVars1,InputVars2,_,OutputVarList,OutputVars,Program1,Program2) :-
	addrules(InputVars2,OutputVars,OutputVars,[],PenultimateVars,[],Program3),
%%writeln([addrules(InputVars2,OutputVars,OutputVars,[],PenultimateVars,[],Program3)]),	
	%%optimise(Program1,InputVars1,InputVars3,PenultimateVars,Program4), %% IV2->3
%%writeln([optimise(Program1,InputVars1,InputVars3,PenultimateVars,Program4)]),
	append(Program1,Program3,Program5),
	append(InputVars1,OutputVars,Vars2),
	Program22=[
        [PredicateName,Vars2,(:-),
                Program5
        ]
        ],
        
        	append(Predicates,Program22,Program2),

        (debug(on)->Debug=on;Debug=off),
%%writeln([interpret(Debug,Query,Program2,OutputVarList)]),
%%writeln(""),
	catch(call_with_time_limit(0.05, 
		interpret(Debug,Query,Program2,OutputVarList)),
      time_limit_exceeded,
      fail),
	no_singletons(Vars2,Program5),!.
caw(Predicates,Query,PredicateName,Rules,MaxLength,VarList,InputVars1,InputVars2,InputVars3,OutputVarList,OutputVars,Program1,Program4) :-
%%writeln([caw(Query,PredicateName,Rules,MaxLength,VarList,InputVars1,InputVars2,OutputVarList,OutputVars,Program1,Program4)]),
	MaxLength2 is MaxLength - 1,
%%writeln(["ml",MaxLength2]),
	member([RuleName,NumInputs,NumOutputs],Rules),
%%writeln([member([RuleName,NumInputs,NumOutputs],Rules)]),
%%writeln([rule(RuleName,NumInputs,NumOutputs,VarList,VarList2,Rule)]),
	rule(RuleName,NumInputs,NumOutputs,InputVars2,InputVars4,VarList,VarList2,Rule),
%%writeln([rule(RuleName,NumInputs,NumOutputs,InputVars1,InputVars3,VarList,VarList2,Rule)]),
	append(Program1,[Rule],Program3),
%%writeln([inputVars3,InputVars3]),
%%InputVars2=InputVars3,
%%writeln([program4,Program4]),
	caw(Predicates,Query,PredicateName,Rules,MaxLength2,VarList2,InputVars1,InputVars4,InputVars3,OutputVarList,OutputVars,Program3,Program4).

varnames([],Vars,Vars,Values,Values) :- !.
varnames(VarList,Vars1,Vars2,Values1,Values2) :-
	VarList=[Var|Vars3],
	Var=[VarName,Value],
	append(Vars1,[VarName],Vars4),
	append(Values1,[Value],Values3),
	varnames(Vars3,Vars4,Vars2,Values3,Values2),!.

addrules(_,_,[],PV,PV,Program,Program) :- !.
addrules(VarList,OutputVars1,OutputVars2,PenultimateVars1,PenultimateVars2,Program1,Program2) :-
	OutputVars2=[OutputVar|OutputVars3],
	member(Var,VarList),
	member(OutputVar,OutputVars1),
	append(Program1,[[=,[OutputVar,Var]]],Program3),
	append(PenultimateVars1,[Var],PenultimateVars3),
	addrules(VarList,OutputVars1,OutputVars3,PenultimateVars3,PenultimateVars2,Program3,Program2).

%% optimise([[append,[a,a,d]],[append,[a,a,e]],[append,[a,a,f]],[append,[a,b,g]]],[g],P).

optimise(Program1,InputVars1,InputVars2,PenultimateVars,Program2) :-
	findrulesflowingtopv1(Program1,InputVars1,InputVars2,PenultimateVars,[],Rules,true),
	%%findrulesflowingtopv1a(Program1,_Program32,InputVars1,InputVars2,PenultimateVars,[],_Rules1),
	intersection(Program1,Rules,Program3),
	unique1(Program3,[],Program2).
findrulesflowingtopv1(_,_,_,[],Rules,Rules,false).
findrulesflowingtopv1(Program0,InputVars1,InputVars2,Var,Rules1,Rules2,IV1Flag1) :-
	(atom(Var);length(Var,1)),
	findrulesflowingtopv20(Program0,Program0,InputVars1,InputVars2,Var,Rules1,Rules2,IV1Flag1).
findrulesflowingtopv1(Program0,InputVars1,InputVars2,Vars1,Rules1,Rules2,IV1Flag1) :-
	Vars1=[Var|Vars2],
	findrulesflowingtopv20(Program0,Program0,InputVars1,InputVars2,Var,Rules1,Rules3,IV1Flag2), 
	findrulesflowingtopv1(Program0,InputVars1,InputVars2,Vars2,Rules3,Rules2,IV1Flag3),
	iv1flagdisjunction(IV1Flag2,IV1Flag3,IV1Flag1).

%%findrulesflowingtopv2([],Program,Program,_,_,Rules,Rules).
findrulesflowingtopv20(_,[],_InputVars1,_InputVars2,_Var,Rules,Rules,false).
findrulesflowingtopv20(Program0,Rules4,InputVars1,InputVars2,Var,Rules1,Rules2,IV1Flag1) :-
	Rules4=[Rule|Rules],
	(findrulesflowingtopv2(Program0,Rule,InputVars1,InputVars2,Var,Rules1,Rules3,IV1Flag2)->true;(Rules3=Rules1,IV1Flag2=false)),
	%%delete(Program0,Rule,Program1),
	findrulesflowingtopv20(Program0,Rules,InputVars1,InputVars2,Var,Rules3,Rules2,IV1Flag3),%%p1->0
	iv1flagdisjunction(IV1Flag2,IV1Flag3,IV1Flag1).
%%findrulesflowingtopv2(_,[],[],_,_,_,Rules,Rules).
findrulesflowingtopv2(Program0,Rule,InputVars1,InputVars2,Var,Rules1,Rules2,IV1Flag1) :-
	Rule=[_PredicateName,Vars],
	restlast(Vars,[],Rest,Var),
	%%delete(Program1,[PredicateName,Vars],Program2),
	%%Program2=Program1,
	%%(not(intersection(Rulesx,Rules1))-> x
	%% append, append, unique1
	%%append(Rules1,[Rule],Rules3);Rules3=Rules1),

	%%member(Var2,Rest),
	%%member(Var2,InputVars1),

	length(Rest,Length1), Length1>=1,
	subtract(Rest,InputVars1,IV3s),
	length(IV3s,Length3),
	subtract(Rest,IV3s,IV1s),
	length(IV1s,Length2), Length2>=1,
	subtract(IV3s,InputVars2,[]),

	IV1Flag2=true,

	%%delete(Program0,Rule,Program1),

	%%(delete(Program0,Rule,Program3),
	%%iv3s1(IV3s,Program3,IV3s,[]),
	(Length3>=1->
	(findrulesflowingtopv1(Program0,InputVars1,InputVars2,IV3s,[],Rules5,IV1Flag3),not(Rules5=[]));
	(Rules5=[],IV1Flag3=false)),
	iv1flagdisjunction(IV1Flag2,IV1Flag3,IV1Flag4),
	%%->true; Rules5=[],IV1Flag1=IV1Flag4),
	
	((findrulesflowingtopv1(Program0,InputVars1,InputVars2,IV1s,[],Rules6,IV1Flag5), %%iv1s->rest, etc
	iv1flagdisjunction(IV1Flag4,IV1Flag5,IV1Flag1))->true;(Rules6=[],IV1Flag1=IV1Flag4)),

	append([Rule],Rules1,Rules9),
	append(Rules9,Rules5,Rules7),
	append(Rules7,Rules6,Rules8),
	unique1(Rules8,[],Rules2).

/**
findrulesflowingtopv2(_Program0,Rule,InputVars1,InputVars2,Var,Rules1,Rules2,IV1Flag1) :-
	Rule=[_PredicateName,Vars],
	restlast(Vars,[],Rest,Var),
	%%delete(Program1,[PredicateName,Vars],Program2),
	%%Program2=Program1,
	(not(member(Rule,Rules1))->
	append(Rules1,[Rule],Rules2);Rules2=Rules1),
	subset(Rest,InputVars2),
	intersection(Rest,InputVars1,Intersection),
	length(Intersection,0),
%%	not((member(Var2,Rest),
%%	member(Var2,InputVars1))),
	IV1Flag1=false.
**/
/**
findrulesflowingtopv2(Program0,Rule,InputVars1,InputVars2,Var,Rules1,Rules2,IV1Flag1) :-
	Rule=[_PredicateName,Vars],
	restlast(Vars,[],Rest,Var),	
	%%delete(Program1,[PredicateName,Vars],Program3),
	%%Program3=Program1,
	%%append(Rules1,[Rule],Rules3),
	subset(Rest,InputVars2),
	
	intersection(Rest,InputVars1,Intersection),
	length(Intersection,0),
%%	not((member(Var2,Rest),
%%	member(Var2,InputVars1))),
%%	delete(Program0,Rule,Program1),
	IV1Flag2=false,
	findrulesflowingtopv1(Program0,InputVars1,InputVars2,Rest,[],Rules4,IV1Flag3),
	%%not(Rules4=[]),
	iv1flagdisjunction(IV1Flag2,IV1Flag3,IV1Flag1),
	append(Rules1,[Rule],Rules7),
	append(Rules7,Rules4,Rules8),
	unique1(Rules8,[],Rules2).
**/
/**
%%->true;(Program2=Program1,Rules2=Rules1)).
findrulesflowingtopv2(Rule,Program0,Program1,_Program2,InputVars1,InputVars,Var,Rules1,Rules2,IV1Flag1) :-
	Rule=[PredicateName,Vars],
	restlast(Vars,[],Rest,Var),
	%%delete(Program1,[PredicateName,Vars],Program4),
	%%Program4=Program1,
	append(Rules1,[[PredicateName,Vars]],Rules3),
	findrulesflowingtopv1(Program0,Program1,_Program2,InputVars1,InputVars,Rest,Rules3,Rules2,IV1Flag3),
	iv1flagdisjunction(IV1Flag2,IV1Flag3,IV1Flag1).
	%%findrulesflowingtopv2(Program5,Program2,Rest,Rules3,Rules2).
**/
iv1flagdisjunction(A,B,true) :-
	(A=true); (B=true).
iv1flagdisjunction(_,_,false).
/**
iv3s0([],_,IV3s1,IV3s2).
iv3s0(IV3s,Program0,IV3s1,IV3s2).
	IV3s=[IV3|IV3s3],
	iv3s1(IV3,Program0,IV3s1,IV3s4),
	iv3s0(IV3s3,Program0,IV3s4,IV3s2).
iv3s1(_,[],IV3s,IV3s).	
iv3s1(IV3,Program0,IV3s1,IV3s2) :-
	Program0=[Rule|Rules],
	iv3s2(IV3,Rule,IV3s1,IV3s3),
	iv3s1(IV3,Rules,IV3s3,IV3s2).
iv3s2(IV3,Rule,IV3s,IV3s1,IV3s2).
	Rule=[_PredicateName,Vars],
	restlast(Vars,[],_Rest,IV3),	
	delete(IV3s1,IV3,IV3s2).
findrulesflowingtopv1a(_,_,_,_,[],Rules,Rules).
findrulesflowingtopv1a(Program1,Program2,InputVars1,InputVars2,Var,Rules1,Rules2) :-
	atom(Var),
	findrulesflowingtopv2a(Program1,Program2,InputVars1,InputVars2,Var,Rules1,Rules2).
findrulesflowingtopv1a(Program1,Program2,InputVars1,InputVars2,Vars1,Rules1,Rules2) :-
	Vars1=[Var|Vars2],
	findrulesflowingtopv2(Program1,Program3,InputVars1,InputVars2,Var,Rules1,Rules3),
	findrulesflowingtopv1a(Program3,Program2,InputVars1,InputVars2,Vars2,Rules3,Rules2).
%%findrulesflowingtopv2([],Program,Program,_,_,Rules,Rules).
findrulesflowingtopv2a([],[],_,_,_,Rules,Rules).
findrulesflowingtopv2a(Program1,Program2,_InputVars1,InputVars2,Var,Rules1,Rules2) :-
	member([PredicateName,Vars],Program1),
	restlast(Vars,[],Rest,Var),
	(
%%delete(Program1,[PredicateName,Vars],Program2),
Program2=Program1,
	append(Rules1,[[PredicateName,Vars]],Rules2),
	subset(Rest,InputVars2)).
findrulesflowingtopv2a(Program1,Program2,InputVars1,InputVars2,Var,Rules1,Rules2) :-
	member([PredicateName,Vars],Program1),
	restlast(Vars,[],Rest,Var),
	(
%%delete(Program1,[PredicateName,Vars],Program3),
Program3=Program1,
	append(Rules1,[[PredicateName,Vars]],Rules3),
	subset(Rest,InputVars2)),
	findrulesflowingtopv1a(Program3,Program2,InputVars1,InputVars2,Rest,Rules3,Rules2).
%%->true;(Program2=Program1,Rules2=Rules1)).
findrulesflowingtopv2a(Program1,Program2,InputVars1,InputVars,Var,Rules1,Rules2) :-
	member([PredicateName,Vars],Program1),
	restlast(Vars,[],Rest,Var),
	%%delete(Program1,[PredicateName,Vars],Program4),
	Program4=Program1,
	append(Rules1,[[PredicateName,Vars]],Rules3),
	findrulesflowingtopv1a(Program4,Program2,InputVars1,InputVars,Rest,Rules3,Rules2).
	%%findrulesflowingtopv2(Program5,Program2,Rest,Rules3,Rules2).
	**/

restlast([],_,_,_) :- fail, !.	
restlast([Last],Rest,Rest,Last) :-
	atom(Last),!.
restlast(Last,Rest,Rest,Last) :-
	length(Last,1),!.
restlast(Vars1,Rest1,Rest2,Last) :-
	Vars1=[Var|Vars2],
	append(Rest1,[Var],Rest3),
	restlast(Vars2,Rest3,Rest2,Last),!.

	


rule(RuleName,1,1,InputVars1,InputVars2,VarList,VarList2,Rule) :-
	member(Var,InputVars1),
	rule2(RuleName,Var,VarList,VarList2,Rule,Var1),
	append(InputVars1,[Var1],InputVars2).
rule2(RuleName,Var,VarList,VarList2,Rule,Var1) :-
	var(VarList,Var1,VarList2),
	Rule=[RuleName,[Var,Var1]],!.

rule(RuleName,1,2,InputVars1,InputVars2,VarList,VarList2,Rule) :-
        member(Var,InputVars1),
        rule3(RuleName,Var,VarList,VarList2,Rule,Vars),
	append(InputVars1,Vars,InputVars2).
rule3(RuleName,Var,VarList,VarList3,Rule,[Var1,Var2]) :-
        var(VarList,Var1,VarList2),
        var(VarList2,Var2,VarList3),
        Rule=[RuleName,[Var,Var1,Var2]],!.

rule(RuleName,2,1,InputVars1,InputVars2,VarList,VarList2,Rule) :-
        member(Var,InputVars1),
        member(Vara,InputVars1),
        rule4(RuleName,Var,Vara,VarList,VarList2,Rule,Var1),
	append(InputVars1,[Var1],InputVars2).
rule4(RuleName,Var,Vara,VarList,VarList2,Rule,Var1) :-
        var(VarList,Var1,VarList2),
        Rule=[RuleName,[Var,Vara,Var1]],!.

rule(RuleName,2,2,InputVars1,InputVars2,VarList,VarList2,Rule) :-
        member(Var,InputVars),
        member(Vara,InputVars),
        rule5(RuleName,Var,Vara,VarList,VarList2,Rule,Vars),
	append(InputVars1,Vars,InputVars2).
rule5(RuleName,Var,Vara,VarList,VarList3,Rule,[Var1,Var2]) :-
        var(VarList,Var1,VarList2),
        var(VarList2,Var2,VarList3),
        Rule=[RuleName,[Var,Vara,Var1,Var2]],!.

%%var(Item,Var,Vars,Vars) :-
%%	member([Item,Var],Vars).
var(Vars1,Var1,Vars2) :-
	length(Vars1,Vars1Length1),
	Vars1Length2 is Vars1Length1-1,
	length(Vars3,Vars1Length2),
	append(Vars3,[Var2],Vars1),
	char_code(Var2,Var2Code1),
	Var2Code2 is Var2Code1 + 1,
	var2(Var2Code2,Var1),
	append(Vars1,[Var1],Vars2),!.

var2(Code,Var1) :-
	outputvars(OutputVars),
	totalvars(TotalVars),
	Code2 is 96+TotalVars,
	Code =< Code2, %% 122
	char_code(Var1,Code),
	not(member(Var1,OutputVars)),!.
var2(Var2Code,Code3) :-
	Var2Code2 is Var2Code + 1,	
	totalvars(TotalVars),
	Code2 is 96+TotalVars,
	Var2Code2 =< Code2,
	var2(Var2Code2,Code3),!.


no_singletons(Vars1,Program):-
	findall(DA,(member(C,Program),C=[_E,D],member(DA,D)),Vars2),
	%%append_list(Vars2,Vars2A),
	append(Vars1,Vars2,Vars3),
	findall(Count1,(member(Item,Vars3),aggregate_all(count,(member(Item,Vars3)),Count1),
	Count1=1),G),G=[].

	split3([],List,List) :- !.
split3(Predicates1,List1,List2) :-
	Predicates1=[Item1|List4],
	Item1=	[[Name,In,Out]|_Rest],
	append(List1,[[Name,In,Out]],List6),
	split3(List4,List6,List2),!.
	
split2([],List,List) :- !.
split2(Predicates1,List1,List2) :-
	Predicates1=[Item1|List4],
	Item1=	[[Name,_In,_Out]|Rest],
	append(List1,[[Name|Rest]],List6),
	split2(List4,List6,List2),!.

