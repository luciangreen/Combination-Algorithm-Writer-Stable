/**:- include('listprologinterpreter3preds5.pl').
:- include('lpiverify4.pl').
:- include('caw5 copy 11.pl').
**/
:- dynamic debug/1.

/** List Prolog Interpreter **/

interpret(Debug,Query,Functions,Result) :-
%%writeln([i1]),
	interpret1(Debug,Query,Functions,Functions,Result),
	!.
interpret1(Debug,Query,Functions1,Functions2,Result) :-
%%writeln([i11]),
	retractall(debug(_)),
    	assertz(debug(Debug)),
        retractall(cut(_)),
        assertz(cut(off)),
	member1(Query,Functions1,Functions2,Result).
%%member1([_,R],_,[],R).
%%member1(_,_,[],[]).
member1(_,_,[],_) :- fail.
member1(Query,Functions,Functions2,Vars8) :-
%%writeln([m1]),
	cut(off)->(
        (Query=[Function,Arguments1],
	(Functions2=[[Function,Arguments2,(:-),Body]|_Functions3]),
	length(Arguments1,Length),
	length(Arguments2,Length),
        checkarguments(Arguments1,Arguments2,[],Vars1,[],FirstArgs),!, %%->ca2 
%%writeln([checkarguments,"Arguments1",Arguments1,"Arguments2",Arguments2,"Vars1",Vars1,"FirstArgs",FirstArgs]),
                (debug(on)->(writeln([call,[Function,Arguments1],"Press c."]),(not(get_single_char(97))->true;abort));true),
	interpretbody(Functions,Functions2,Vars1,Vars2,Body,true),
	updatevars(FirstArgs,Vars2,[],Result),
        %%reverse(Result,[],Vars7),
	((not(Result=[])->
        %%Result=[Var71|Vars72],
        unique1(Result,[],Vars8),
%%writeln(["FirstArgs",FirstArgs,"Vars",Vars2,"Result",Result,"Vars7",Vars7,"Vars72",Vars72,"Var71",Var71,"Vars8",Vars8]),
%%writeln(["Vars8",Vars8]),
	findresult3(Arguments1,Vars8,[],Result2)
%%writeln([findresult3,"Arguments1",Arguments1,"Vars8",Vars8,"Result2",Result2])
	);(
%%writeln(here1),
	Vars8=[],Result2=[])),
%%writeln(["Arguments1",Arguments1,"Vars2",Vars2,"Result",Result]),
		(debug(on)->(writeln([exit,[Function,Result2],"Press c."]),(not(get_single_char(97))->true;abort));true))
	->true;
	(%%Query=[Function,_Arguments1],
	%%Functions2=[[Function,_Arguments2,(:-),_Body]|Functions3], %% make like previous trunk?
	member11(Query,Functions,Functions2,Vars8))
	);(turncut(off)%%,Result=[]
	).
member11(Query,Functions,Functions2,Result) :-
%%writeln([m11]),
%%writeln(["Query",Query,"Functions",Functions,"Functions2",Functions2,"Result",Result]),
	cut(off)->(
        (Query=[Function],
        (Functions2=[[Function,(:-),Body]|_Functions3]),
                (debug(on)->(writeln([call,[Function],"Press c."]),(not(get_single_char(97))->true;abort));true),
	Result=[],
        interpretbody(Functions,Functions2,[],_Vars2,Body,true),!,
        	(debug(on)->(writeln([exit,[Function],"Press c."]),(not(get_single_char(97))->true;abort));true)
	)->true;
	(%%Query=[Function],
	%%Functions2=[[Function]|Functions3],
	member12(Query,Functions,Functions2,Result))
	);(turncut(off)).
member12(Query,Functions,Functions2,Vars8) :-
%%writeln([m12]),
	cut(off)->(
        (Query=[Function,Arguments1],
        (Functions2=[[Function,Arguments2]|_Functions3]),
        length(Arguments1,Length),
        length(Arguments2,Length),
        checkarguments(Arguments1,Arguments2,[],Vars1,[],FirstArgs),!, %% ->ca2
%%writeln([checkarguments,"Arguments1",Arguments1,"Arguments2",Arguments2,"Vars1",Vars1,"FirstArgs",FirstArgs]),
	updatevars(FirstArgs,Vars1,[],Result),
        %%reverse(Result,[],Vars7),
        ((not(Result=[])->
        %%Result=[Var71|Vars72],
        unique1(Result,[],Vars8),
        findresult3(Arguments1,Vars8,[],Result2)
        );(
%%writeln(here2),
	Vars8=[],Result2=[])),
        	(debug(on)->(writeln([call,[Function,Arguments1],"Press c."]),(not(get_single_char(97))->true;abort));true),
        	(debug(on)->(writeln([exit,[Function,Result2],"Press c."]),(not(get_single_char(97))->true;abort));true)
	)->true;
	(%%Query=[Function,_Arguments1],
	%%Functions2=[[Function,_Arguments2]|Functions3],
	member13(Query,Functions,Functions2,Vars8))
	);(turncut(off)).
member13(Query,Functions,Functions2,Result) :-
%%writeln([m13]),
	cut(off)->(
        (Query=[Function],!,
        (Functions2=[[Function]|_Functions3]),
        	(debug(on)->(writeln([call,[Function],"Press c."]),(not(get_single_char(97))->true;abort));true),
	Result=[],
        %%interpretbody(Functions,[],_Vars2,Body,true),
        	(debug(on)->(writeln([exit,[Function],"Press c."]),(not(get_single_char(97))->true;abort));true)
	)->true;
	(%%Query=[Function],
	Functions2=[_Function|Functions3],
	member1(Query,Functions,Functions3,Result))
	);(turncut(off)).
interpret2(Query,Functions1,Functions2,Result) :-
%%writeln(i2),
%%writeln(["%%interpret2 Query",Query,"Functions1",Functions1,"Functions2",Functions2]),
        member2(Query,Functions1,Functions2,Result).
%%member2([_,R],_,[],R).
%%member2(_,_,[],[]).
member2(_,_,[],_) :- fail.
member2(Query,Functions,Functions2,Vars8) :-
%%writeln([m2]),
	cut(off)->(
        (Query=[Function,Arguments1],
        (Functions2=[[Function,Arguments2,(:-),Body]|_Functions3]),
        length(Arguments1,Length),
        length(Arguments2,Length),
        checkarguments(Arguments1,Arguments2,[],Vars1,[],FirstArgs),!,
%%writeln([checkarguments,"Arguments1",Arguments1,"Arguments2",Arguments2,"Vars1",Vars1,"FirstArgs",FirstArgs]),
                (debug(on)->(writeln([call,[Function,Arguments1],"Press c."]),(not(get_single_char(97))->true;abort));true),
        interpretbody(Functions,Functions2,Vars1,Vars2,Body,true), %%**arg2 change
%%writeln(["Functions",Functions,"Functions2",Functions2,"Vars1",Vars1,"Vars2",Vars2,"Body",Body]),
        updatevars(FirstArgs,Vars2,[],Result),
        %%reverse(Result,[],Vars7),
        ((not(Result=[])->
        %%Result=[Var71|Vars72],
        unique1(Result,[],Vars8),
        findresult3(Arguments1,Vars8,[],Result2)
%%writeln(["Vars2",Vars2,"Result",Result]),
        );(
	writeln(here3),
	Vars8=[],Result2=[])),
        	(debug(on)->(writeln([exit,[Function,Result2],"Press c."]),(not(get_single_char(97))->true;abort));true)
	)->true;
	(%%Query=[Function,_Arguments1],
	%%Functions2=[[Function,_Arguments2,(:-),_Body]|Functions3],
	member21(Query,Functions,Functions2,Vars8))
	);(turncut(off)).
member21(Query,Functions,Functions2,Result) :-
%%writeln([m21]),
	cut(off)->(
        (Query=[Function],
        (Functions2=[[Function,(:-),Body]|_Functions3]),
        Vars1=[],
                (debug(on)->(writeln([call,[Function],"Press c."]),(not(get_single_char(97))->true;abort));true),
        interpretbody(Functions,Functions2,Vars1,_Vars2,Body,true),!, %%**arg2 change
        	(debug(on)->(writeln([exit,[Function],"Press c."]),(not(get_single_char(97))->true;abort));true)
	)->true;
	(%%Query=[Function],
	%%Functions2=[[Function]|Functions3],
	member22(Query,Functions,Functions2,Result))
	);(turncut(off)).
member22(Query,Functions,Functions2,Vars8) :-
%%writeln([m22]),
	cut(off)->(
        (Query=[Function,Arguments1],
        (Functions2=[[Function,Arguments2]|_Functions3]),
        length(Arguments1,Length),
        length(Arguments2,Length),
        checkarguments(Arguments1,Arguments2,[],Vars1,[],FirstArgs),!,
%%writeln([checkarguments,"Arguments1",Arguments1,"Arguments2",Arguments2,"Vars1",Vars1,"FirstArgs",FirstArgs]),
        updatevars(FirstArgs,Vars1,[],Result),
        %%reverse(Result,[],Vars7),
        ((not(Result=[])->
        %%Result=[Var71|Vars72],
        unique1(Result,[],Vars8),
        findresult3(Arguments1,Vars8,[],Result2)
        );(
%%writeln(here4),
	Vars8=[],Result2=[])),
        	(debug(on)->(writeln([call,[Function,Arguments1],"Press c."]),(not(get_single_char(97))->true;abort));true),
        	(debug(on)->(writeln([exit,[Function,Result2],"Press c."]),(not(get_single_char(97))->true;abort));true)
	)->true;
	(%%Query=[Function,_Arguments1],
	%%Functions2=[[Function,_Arguments2]|Functions3],
	member23(Query,Functions,Functions2,Vars8))
	);(turncut(off)).
member23(Query,Functions,Functions2,Vars8) :-
%%writeln([m23]),
	cut(off)->(
        (Query=[Function],!,
        (Functions2=[[Function]|_Functions3]),
        	(debug(on)->(writeln([call,[Function],"Press c."]),(not(get_single_char(97))->true;abort));true),
	Vars8=[],
        	(debug(on)->(writeln([exit,[Function],"Press c."]),(not(get_single_char(97))->true;abort));true)
	)->true;
	(%%Query=[Function],
	Functions2=[_Function|Functions3],
	member2(Query,Functions,Functions3,Vars8))
	);(turncut(off)).
checkarguments([],[],Vars,Vars,FirstArgs,FirstArgs). 
checkarguments(Arguments1,Arguments2,Vars1,Vars2,FirstArgs1,FirstArgs2) :- %%
%%writeln(1),
	Arguments1=[Value|Arguments3], %% Value may be a number, string, list or tree
	expressionnotatom(Value),
	Arguments2=[Variable2|Arguments4],
	isvar(Variable2),
	putvalue(Variable2,Value,Vars1,Vars3),
	checkarguments(Arguments3,Arguments4,Vars3,Vars2,FirstArgs1,FirstArgs2).
checkarguments(Arguments1,Arguments2,Vars1,Vars2,FirstArgs1,FirstArgs2) :- %%A
%%writeln(2),
        Arguments1=[Variable|Arguments3], %% Value may be a number, string, list or tree
        isvar(Variable),
        Arguments2=[Value|Arguments4],
        expressionnotatom(Value),
        putvalue(Variable,Value,Vars1,Vars3),
	append(FirstArgs1,[[Variable,_]],FirstArgs3),
        checkarguments(Arguments3,Arguments4,Vars3,Vars2,FirstArgs3,FirstArgs2).
checkarguments(Arguments1,Arguments2,Vars1,Vars2,FirstArgs1,FirstArgs2) :-
%%writeln(3),
        Arguments1=[Variable1|Arguments3],
	isvar(Variable1),
        Arguments2=[Variable2|Arguments4],
	isvar(Variable2),
	(getvalue(Variable2,Value,Vars1)->true;Value=empty),
        putvalue(Variable2,Value,Vars1,Vars3),
        append(FirstArgs1,[[Variable1,Variable2]],FirstArgs3),
        checkarguments(Arguments3,Arguments4,Vars3,Vars2,FirstArgs3,FirstArgs2).
checkarguments(Arguments1,Arguments2,Vars1,Vars2,FirstArgs1,FirstArgs2) :-
%%writeln(4),
        Arguments1=[Value1|Arguments3],
        expressionnotatom(Value1),
        Arguments2=[Value1|Arguments4],
        expressionnotatom(Value1),
        checkarguments(Arguments3,Arguments4,Vars1,Vars2,FirstArgs1,FirstArgs2).

interpretbody(_Functions1,_Functions2,Vars,Vars,[],true) :- !.

interpretbody(Functions0,Functions,Vars1,Vars2,Body,Result1) :-
        Body=[Statements1|Statements2],
        interpretbody(Functions0,Functions,Vars1,Vars3,Statements1,Result2),
        interpretbody(Functions0,Functions,Vars3,Vars2,Statements2,Result3),
        %%((Result3=cut)->!;true),
        logicalconjunction(Result1,Result2,Result3),!.

interpretbody(Functions0,Functions,Vars1,Vars2,Body,Result1) :-
        Body=[[not,[Statements]]|Statements2],
	interpretbody(Functions0,Functions,Vars1,Vars3,Statements,Result2),
        %%((Result2=cut)->!;true),
        interpretbody(Functions0,Functions,Vars3,Vars2,Statements2,Result3),
        %%((Result3=cut)->!;true),
        logicalnot(Result2,Result4),
	(logicalconjunction(Result1,Result4,Result3)->true;(Result1=false)),!.
interpretbody(Functions0,Functions,Vars1,Vars2,Body,Result1) :-
        Body=[[Statements1],or,[Statements2]],
        (interpretbody(Functions0,Functions,Vars1,Vars2,Statements1,Result1);
	%%,((Value1=cut)->!;true));
        interpretbody(Functions0,Functions,Vars1,Vars2,Statements2,Result1)),!.
	%%,((Value=cut)->!;true)).
	%%(logicaldisjunction(Result1,Value1,Value2)->true;(Result1=false)).


interpretbody(Functions0,Functions,Vars1,Vars2,Body,Result1) :-
	Body=[Statement|Statements],
%%writeln(["Functions0",Functions0,"Functions",Functions,"Statement",Statement,"Vars1",Vars1,"Vars3",Vars3,"Result2",Result2,"Cut",Cut]),
	interpretstatement1(Functions0,Functions,Statement,Vars1,Vars3,Result2,Cut),
%%writeln(["here1"]),
	((not(Cut=cut))->(Functions2=Functions);(turncut(on))), %% cut to interpret1/2 (assertz)
%%writeln(["here3"]),
	interpretbody(Functions0,Functions2,Vars3,Vars2,Statements,Result3),
	%%((Result3=cut)->!;true),
%%writeln(["here4"]),
	logicalconjunction(Result1,Result2,Result3),!.
%%writeln([Result1,Result2,Result3]).
turncut(State1) :-
	cut(State2),
	retract(cut(State2)),
	assertz(cut(State1)).
logicaldisjunction(true,Result2,Result3) :-
        true(Result2);true(Result3).
logicalconjunction(true,Result2,Result3) :-
	true(Result2),true(Result3).
logicalnot(Result1,Result2) :-
	true(Result1),false(Result2).
logicalnot(Result1,Result2) :-
        false(Result1),true(Result2).
true(true).
false(false).

%%interpretstatement1(_F0,[],_,Vars,Vars,true,nocut) :- !
%%writeln("AND HERE!")
%%	.

interpretstatement1(_F0,_Functions,[cut,[]],Vars,Vars,true,cut) :- !.

interpretstatement1(_F0,_Functions,[atom,[Variable]],Vars,Vars,true,nocut) :-
	getvalue(Variable,Value,Vars),
                (debug(on)->(writeln([call,[atom,[Value]],"Press c."]),(not(get_single_char(97))->true;abort));true),
	atom(Value),
                (debug(on)->(writeln([exit,[atom,[Value]],"Press c."]),(not(get_single_char(97))->true;abort));true).

interpretstatement1(_F0,_Functions,[string,[Variable]],Vars,Vars,true,nocut) :-
        getvalue(Variable,Value,Vars),
                (debug(on)->(writeln([call,[string,[Value]],"Press c."]),(not(get_single_char(97))->true;abort));true),
        string(Value),
                (debug(on)->(writeln([exit,[string,[Value]],"Press c."]),(not(get_single_char(97))->true;abort));true).

interpretstatement1(_F0,_Functions,[number,[Variable]],Vars,Vars,true,nocut) :-
        getvalue(Variable,Value,Vars),
                (debug(on)->(writeln([call,[number,[Value]],"Press c."]),(not(get_single_char(97))->true;abort));true),
        number(Value),
                (debug(on)->(writeln([exit,[number,[Value]],"Press c."]),(not(get_single_char(97))->true;abort));true).

interpretstatement1(_F0,_Functions,[variable,[Variable]],Vars,Vars,true,nocut) :-
        var(Variable),
                (debug(on)->(writeln([call,[variable,[Variable]],"Press c."]),(not(get_single_char(97))->true;abort));true),
                (debug(on)->(writeln([exit,[variable,[Variable]],"Press c."]),(not(get_single_char(97))->true;abort));true).

interpretstatement1(_F0,_Functions,[Operator,[Variable1,Variable2]],Vars1,Vars2,true,nocut) :-
	isop(Operator),
	interpretpart(is,Variable1,Variable2,Vars1,Vars2).

interpretstatement1(_F0,_Functions,[Operator,[Variable1,Variable2]],Vars1,Vars2,true,nocut) :-
%%writeln(31),
        isop(Operator),
        interpretpart(is,Variable2,Variable1,Vars1,Vars2).
	
interpretstatement1(_F0,_Functions,[+,[Variable2,Variable3,Variable1]],Vars1,Vars2,true,nocut) :-
%%writeln(4),
        interpretpart(isplus,Variable1,Variable2,Variable3,Vars1,Vars2).

%%interpretstatement1(_F0,_Functions,[Variable2+Variable3,is,Variable1],Vars1,Vars2,true,nocut) :-
%%writeln(41),
        %%interpretpart(isplus,Variable1,Variable2,Variable3,Vars1,Vars2).

interpretstatement1(_F0,_Functions,[=,[Variable1,[Variable2,Variable3]]],Vars1,Vars2,true,nocut) :-
%%writeln(5),
        interpretpart(match,Variable1,Variable2,Variable3,Vars1,Vars2).

%%interpretstatement1(_F0,_Functions,[[Variable2,Variable3]=Variable1],Vars1,Vars2,true,nocut) :-
%%writeln(51),
%%        interpretpart(match,Variable1,Variable2,Variable3,Vars1,Vars2).

interpretstatement1(_F0,_Functions,[=,[Variable1,[Variable2]]],Vars1,Vars2,true,nocut) :-
%%writeln(52),
        interpretpart(bracket1,Variable1,Variable2,Vars1,Vars2).

interpretstatement1(_F0,_Functions,[=,[[Variable1],[Variable2]]],Vars1,Vars2,true,nocut) :-
%%writeln(53),
        interpretpart(bracket2,Variable1,Variable2,Vars1,Vars2).

interpretstatement1(_F0,_Functions,[head,[Variable1,Variable2]],Vars1,Vars2,true,nocut) :-
%%writeln(6),
        interpretpart(head,Variable1,Variable2,Vars1,Vars2).

interpretstatement1(_F0,_Functions,[tail,[Variable1,Variable2]],Vars1,Vars2,true,nocut) :-
%%writeln(61),
        interpretpart(tail,Variable1,Variable2,Vars1,Vars2).


interpretstatement1(_F0,_Functions,[member,[Variable1,Variable2]],Vars1,Vars2,true,nocut) :-
%%writeln(8),
        interpretpart(member,Variable1,Variable2,Vars1,Vars2).

interpretstatement1(_F0,_Functions,[delete,[Variable1,Variable2,Variable3]],Vars1,Vars2,true,nocut) :-
%%writeln(),
        interpretpart(delete,Variable1,Variable2,Variable3,Vars1,Vars2).
%%** all in form f,[1,1,etc], including + with 0,1

interpretstatement1(_F0,_Functions,[append,[Variable1,Variable2,Variable3]],Vars1,Vars2,true,nocut) :-
%%writeln(9),
        interpretpart(append,Variable1,Variable2,Variable3,Vars1,Vars2).

interpretstatement1(Functions0,_Functions,Query1,Vars1,Vars8,true,nocut) :-
%%writeln("h1/10"),
        Query1=[Function,Arguments],
%%writeln(["Arguments",Arguments,"Vars1",Vars1]),
        substitutevarsA1(Arguments,Vars1,[],Vars3,[],FirstArgs), %%% var to value, after updatevars:  more vars to values, and select argument vars from latest vars
%%writeln([substitutevarsA1,arguments,Arguments,vars1,Vars1,vars3,Vars3,firstargs,FirstArgs]),
        Query2=[Function,Vars3], %% Bodyvars2?
%%        	debug(on)->writeln([call,[Function,[Vars3]]]),
%%writeln(["Query2",Query2,"Functions0",Functions0]),
        interpret2(Query2,Functions0,Functions0,Result1), 
	updatevars2(FirstArgs,Result1,[],Vars5),
	updatevars3(Vars1,Vars5,Vars6),
	reverse(Vars6,[],Vars7),
	((not(Vars7=[])->
	%%Vars7=[Var71|Vars72],
	unique1(Vars7,[],Vars8)
);(
writeln(here1),
	Vars8=[])).
%%**** reverse and take first instance of each variable.
	%%findresult3(Arguments,Vars6,[],Result2)
%%writeln(["FirstArgs",FirstArgs,"Result1",Result1,"Vars5",Vars5,"Vars4",Vars4]),
%%writeln(["Vars1:",Vars1,"Vars4:",Vars4]),
%%		debug(on)->writeln([exit,[Function,[Result2]]]).
interpretstatement1(Functions0,_Functions,Query,Vars,Vars,true) :-
	Query=[_Function],
        	debug(on)->writeln([call,[Function]]),
        interpret2(Query,Functions0,Functions0,_Result1),
        	debug(on)->writeln([exit,[Function]]).


interpretstatement1(_Functions0, _Functions,_Query,_Vars1,_Vars2,false) :-
	writeln([false]).

interpretstatement2(Value,_Vars,Value) :-
	(number(Value);atom(Value)).
interpretstatement2(Variable,Vars1,Value) :-
	getvalue(Variable,Value,Vars1).
interpretstatement3(A + B,Vars,Value1) :-
        interpretstatement2(A,Vars,Value2),
        interpretstatement2(B,Vars,Value3),
        Value1 = Value2 + Value3.
interpretstatement3(Value,_Vars,Value) :-
	(number(Value);atom(Value)).
interpretstatement3(Variable,Vars,Value) :-
        getvalue(Variable,Value,Vars).
getvalue(Variable,Value,Vars) :-
        ((not(isvar(Variable)),isvalstrorundef(Value),Variable=Value);
        (isvar(Variable),isvalstrorundef(Value),getvar(Variable,Value,Vars))).
putvalue(Variable,Value,Vars1,Vars2) :-
        ((not(isvar(Variable)),isvalstrorundef(Value),Variable=Value);
        (isvar(Variable),isvalstrorundef(Value),updatevar(Variable,Value,Vars1,Vars2))),!. 
getvar(Variable,Value,Vars) :-
        member([Variable,Value],Vars),
	not(Value=empty).
getvar(undef,undef,_Vars) :-
	!.
getvar(Variable,empty,Vars) :-
        not(member([Variable,_Value],Vars));
	member([Variable,empty],Vars).
updatevar(undef,_Value,Vars,Vars) :-
	!.
updatevar(Variable,Value,Vars1,Vars2) :-
	((((member([Variable,empty],Vars1),
	delete(Vars1,[Variable,empty],Vars3),
	append(Vars3,[[Variable,Value]],Vars2));
	((not(member([Variable,Value1],Vars1)),
	((Value1=empty)->true;(Value1=Value)))),
        append(Vars1,[[Variable,Value]],Vars2));
	(member([Variable,Value],Vars1),Vars2=Vars1));
	(undef(Variable),
	append(Vars1,[[Variable,Value]],Vars2))).
updatevars(_FirstArgs,[],Vars,Vars).
updatevars(FirstArgs,Vars1,Vars2,Vars3) :-
        Vars1=[[Variable1,Value]|Vars4],
	((member([Variable2,Variable1],FirstArgs), %% removed brackets around firstargs here and 2 line below
	append(Vars2,[[Variable2,Value]],Vars5));
	(member([Variable1,_Variable2],FirstArgs),
	append(Vars2,[[Variable1,Value]],Vars5))),
	updatevars(FirstArgs,Vars4,Vars5,Vars3),
	!.
updatevars(FirstArgs,Vars1,Vars2,Vars3) :-
	Vars1=[_Vars4|Vars5],
	updatevars(FirstArgs,Vars5,Vars2,Vars3).
updatevars2(_FirstArgs,[],Vars,Vars).
updatevars2(FirstArgs,Vars1,Vars2,Vars3) :-
        Vars1=[[Variable,Value]|Vars4],
        (member(Variable,FirstArgs), %% removed brackets around firstargs here and 2 line below, ** vars1 into arg in (10), check cond
        append(Vars2,[[Variable,Value]],Vars5)),
        updatevars2(FirstArgs,Vars4,Vars5,Vars3).
updatevars3(Vars1,[],Vars1).
updatevars3(Vars1,Vars2,Vars4) :-
	Vars2=[[Variable,Value]|Vars5],
	delete(Vars1,[Variable,empty],Vars6),
	append(Vars6,[[Variable,Value]],Vars7),
	updatevars3(Vars7,Vars5,Vars4),
	!.
updatevars3(Vars1,Vars2,Vars4) :-
	Vars2=[[Variable,Value]|Vars5],
	append(Vars1,[[Variable,Value]],Vars6),
        updatevars3(Vars6,Vars5,Vars4).
reverse([],List,List).
reverse(List1,List2,List3) :-
	List1=[Head|Tail],
	append([Head],List2,List4),
	reverse(Tail,List4,List3).
unique1([],Items,Items).
unique1([Item|Items1],Items2,Items3) :-
	delete(Items1,Item,Items4),
	append(Items2,[Item],Items5),
	unique1(Items4,Items5,Items3).

isvar(Variable) :-
	atom(Variable).
isval(Value) :-
	number(Value).
isvalstr(N) :-
	isval(N);string(N).
/**isvalstrempty(N) :-
	isval(N);(string(N);N=empty).**/
isvalstrempty(N) :-
	isval(N),!.
isvalstrempty(N) :-
	string(N),!.
isvalstrempty(empty) :- !.
/**isvalstrempty(N) :-
	atom(N),fail,!.
**/
isvalstrorundef(N) :- 
	var(N);(not(var(N)),(isval(N);expression(N))).
undef(N) :-
	var(N).
/**
expression(N) :-
	isval(N);(string(N);atom(N)),!.
expression([]).
expression(empty).
expression([N]) :-
	expression(N).
expression([N|Ns]):-
	expression(N),expression(Ns).
**/

expression(empty) :-
	!.
expression(N) :-
	isval(N),!.
expression(N) :-
	string(N),!.
expression(N) :-
	atom(N),!.
expression([]) :-
	!.
expression(N) :-
%%	not(atom(N)),
	length(N,L),L>=2,
	expression2(N).
expression2([]).
expression2([N|Ns]) :-
	expression3(N),
	expression2(Ns).
expression3(N) :-
	isval(N),!.
expression3(N) :-
	string(N),!.
expression3(N) :-
	atom(N),!.

expressionnotatom(N) :-
	isvalstrempty(N),!.
expressionnotatom(N) :-
	not(atom(N)),
	length(N,L),L>=2,
	expressionnotatom2(N).
expressionnotatom2([]).
expressionnotatom2([N|Ns]) :-
	isvalstrempty(N),	
	expressionnotatom2(Ns).

substitutevarsA1(Arguments,Vars1,Vars2,Vars3,FirstArgs1,FirstArgs2) :-
	substitutevarsA2(Arguments,Vars1,Vars2,Vars3,FirstArgs1,FirstArgs2).
substitutevarsA2([],_Vars1,Vars2,Vars2,FirstArgs,FirstArgs).
substitutevarsA2(Arguments,Vars1,Vars2,Vars3,FirstArgs1,FirstArgs2) :-
	Arguments=[Variable|Variables],
	((getvalue(Variable,Value,Vars1),
	Value=empty)->
	((append(Vars2,[Variable],Vars4)),
	(isvar(Variable)->append(FirstArgs1,[Variable],
	FirstArgs3);FirstArgs3=FirstArgs1));
	(getvalue(Variable,Value,Vars1),
	append(Vars2,[Value],Vars4)),
	FirstArgs3=FirstArgs1),
        substitutevarsA2(Variables,Vars1,Vars4,Vars3,FirstArgs3,FirstArgs2).

findresult3([],_Result,Result2,Result2).
findresult3(Arguments1,Result1,Result2,Result3) :-
	Arguments1=[Value|Arguments2],
	expressionnotatom(Value),
	append(Result2,[Value],Result4),
        findresult3(Arguments2,Result1,Result4,Result3).
findresult3(Arguments1,Result1,Result2,Result3) :-
        Arguments1=[Variable|Arguments2],
        isvar(Variable),
	member([Variable,Value],Result1),
        append(Result2,[Value],Result4),
        findresult3(Arguments2,Result1,Result4,Result3).



