interpretpart(is,Variable1,Value1,Vars1,Vars2) :-
        getvalue(Value1,Value1A,Vars1),
	%%isvalstr(Value1),
	%%isvalstr(Value1A),
	expression(Value1A),
        %%val1emptyorvalsequal(Value1A,Value1),
	%%isval(Value2),
        putvalue(Variable1,Value1A,Vars1,Vars2),
		(debug(on)->(writeln([call,[variable,is,Value1A],"Press c."]),(not(get_single_char(97))->true;abort));true),
		(debug(on)->(writeln([exit,[Variable1,is,Value1A],"Press c."]),(not(get_single_char(97))->true;abort));true).
interpretpart(isplus,Variable1,Variable2,Variable3,Vars1,Vars2) :-
        getvalues(Variable1,Variable2,Variable3,Value1,Value2,Value3,Vars1),
        Value1A is Value2 + Value3,
        val1emptyorvalsequal(Value1,Value1A),
        putvalue(Variable1,Value1A,Vars1,Vars2),
        	(debug(on)->(writeln([call,[variable,is,Value2+Value3],"Press c."]),(not(get_single_char(97))->true;abort));true),
        	(debug(on)->(writeln([exit,[Value1A,is,Value2+Value3],"Press c."]),(not(get_single_char(97))->true;abort));true).
interpretpart(match,Variable1,Variable2,Variable3,Vars1,Vars2) :-
        getvalues(Variable1,Variable2,Variable3,Value1,Value2,Value3,Vars1),
        Value1 = [Value2A, Value3A],
        val1emptyorvalsequal(Value2,Value2A),
        val1emptyorvalsequal(Value3,Value3A),
        putvalue(Variable2,Value2A,Vars1,Vars3),
        putvalue(Variable3,Value3A,Vars3,Vars2),
        	(debug(on)->(writeln([call,[[Value2A, Value3A],=,[variable1,variable2]],"Press c."]),(not(get_single_char(97))->true;abort));true),        		(debug(on)->(writeln([exit,[[Value2A, Value3A],=,[Value2A, Value3A]],"Press c."]),(not(get_single_char(97))->true;abort));true).
interpretpart(match,Variable1,Variable2,Variable3,Vars1,Vars2) :-
        getvalues(Variable1,Variable2,Variable3,Value1,Value2,Value3,Vars1),
        Value1A = [Value2, Value3],
        val1emptyorvalsequal(Value1,Value1A),
        putvalue(Variable1,Value1A,Vars1,Vars2),
        	(debug(on)->(writeln([call,[variable,=,[Value2,Value3]],"Press c."]),(not(get_single_char(97))->true;abort));true),
        	(debug(on)->(writeln([exit,[[Value2,Value3],=,[Value2,Value3]],"Press c."]),(not(get_single_char(97))->true;abort));true).
interpretpart(bracket1,Variable1,Variable2,Vars1,Vars2) :-
        getvalues(Variable1,Variable2,Value1,Value2,Vars1),
	Value1A = [Value2],
        val1emptyorvalsequal(Value1,Value1A),
        %%val1emptyorvalsequal(Value1A,Value2),
        putvalue(Variable1,Value1A,Vars1,Vars2),
        	(debug(on)->(writeln([call,[variable,=,[Value2]],"Press c."]),(not(get_single_char(97))->true;abort));true),
        	(debug(on)->(writeln([exit,[Variable2,=,[Value2]],"Press c."]),(not(get_single_char(97))->true;abort));true).
interpretpart(bracket2,Variable1,Variable2,Vars1,Vars2) :-
        getvalues(Variable1,Variable2,Value1,Value2,Vars1),
        Value1A = Value2,
        val1emptyorvalsequal(Value1,Value1A),
        %%val1emptyorvalsequal(Value2A,Value1),
        putvalue(Variable1,Value1A,Vars1,Vars2),
        	(debug(on)->(writeln([call,[[variable],=,[Value2]],"Press c."]),(not(get_single_char(97))->true;abort));true),
        	(debug(on)->(writeln([exit,[[Value2],=,[Value2]],"Press c."]),(not(get_single_char(97))->true;abort));true).
interpretpart(head,Variable1,Variable2,Vars1,Vars2) :-
	getvalues(Variable1,Variable2,Value1,Value2,Vars1),
	Value1=[Value1A|_Rest],
        val1emptyorvalsequal(Value2,Value1A),
        putvalue(Variable2,Value1A,Vars1,Vars2),
        	(debug(on)->(writeln([call,[head,Value1,variable],"Press c."]),(not(get_single_char(97))->true;abort));true),
        	(debug(on)->(writeln([exit,[head,Value1,Value1A],"Press c."]),(not(get_single_char(97))->true;abort));true),	!.
interpretpart(tail,Variable1,Variable2,Vars1,Vars2) :-
        getvalues(Variable1,Variable2,Value1,Value2,Vars1),
        Value1=[_Head|Value1A],
	%%removebrackets(Value1A,Value1B), 
        val1emptyorvalsequal(Value2,Value1A),
        putvalue(Variable2,Value1A,Vars1,Vars2),
        	(debug(on)->(writeln([call,[tail,Value1,variable],"Press c."]),(not(get_single_char(97))->true;abort));true),
        	(debug(on)->(writeln([exit,[tail,Value1,Value1A],"Press c."]),(not(get_single_char(97))->true;abort));true).
interpretpart(member,Variable1,Variable2,Vars1,Vars2) :-
        getvalues(Variable1,Variable2,Value1,Value2,Vars1),
	(not(Value1=empty)->(member(Value1,Value2),Vars2=Vars1,
        	(debug(on)->(writeln([call,[member,Value1,Value2],"Press c."]),(not(get_single_char(97))->true;abort));true),
        	(debug(on)->(writeln([exit,[member,Value1,Value2],"Press c."]),(not(get_single_char(97))->true;abort));true));
	(member(Value3,Value2),
	putvalue(Variable1,Value3,Vars1,Vars2),
                (debug(on)->(writeln([call,[member,variable1,Value2],"Press c."]),(not(get_single_char(97))->true;abort));true),
                (debug(on)->(writeln([exit,[member,Value3,Value2],"Press c."]),(not(get_single_char(97))->true;abort));true))).

interpretpart(delete,Variable1,Variable2,Variable3,Vars1,Vars2) :-
        getvalues(Variable1,Variable2,Variable3,Value1,Value2,Value3,Vars1),
        delete(Value1,Value2,Value3A),
        val1emptyorvalsequal(Value3,Value3A),
        putvalue(Variable3,Value3A,Vars1,Vars2),
        	(debug(on)->(writeln([call,[delete,Value1,Value2,variable3],"Press c."]),(not(get_single_char(97))->true;abort));true),
        	(debug(on)->(writeln([exit,[delete,Value1,Value2,Value3A],"Press c."]),(not(get_single_char(97))->true;abort));true).


interpretpart(append,Variable1,Variable2,Variable3,Vars1,Vars2) :-
        getvalues(Variable1,Variable2,Variable3,Value1,Value2,Value3,Vars1),
        append1(Value1,Value2,Value3A),
        val1emptyorvalsequal(Value3,Value3A),
        putvalue(Variable3,Value3A,Vars1,Vars2),
        	(debug(on)->(writeln([call,[append,Value1,Value2,variable3],"Press c."]),(not(get_single_char(97))->true;abort));true),
        	(debug(on)->(writeln([exit,[append,Value1,Value2,Value3A],"Press c."]),(not(get_single_char(97))->true;abort));true).
getvalues(Variable1,Variable2,Value1,Value2,Vars) :-
        getvalue(Variable1,Value1,Vars),
        getvalue(Variable2,Value2,Vars).
getvalues(Variable1,Variable2,Variable3,Value1,Value2,Value3,Vars) :-
        getvalue(Variable1,Value1,Vars),
        getvalue(Variable2,Value2,Vars),
        getvalue(Variable3,Value3,Vars).
val1emptyorvalsequal(empty,Value) :-
	not(Value=empty).
val1emptyorvalsequal(Value,Value) :-
	not(Value=empty).
isop(is).
isop(=).
append1([],Item,Item) :-
	!.
append1(Item1,Item2,Item3) :-
	((isvalstr(Item1),Item1A=[Item1]);(not(isvalstr(Item1)),Item1A=Item1)),
        ((isvalstr(Item2),Item2A=[Item2]);(not(isvalstr(Item2)),Item2A=Item2)),
        %%((isvalstr(Item3),Item3A=[Item3]);(not(isvalstr(Item3)),Item3A=Item3)),
	append(Item1A,Item2A,Item3).
/**delete1(Item1,Item2,Item3) :-
	((isvalstr(Item1),Item1A=[Item1]);(not(isvalstr(Item1)),Item1A=Item1)),
        ((isvalstr(Item2),Item2A=[Item2]);(not(isvalstr(Item2)),Item2A=Item2)),
        %%((isvalstr(Item3),Item3A=[Item3]);(not(isvalstr(Item3)),Item3A=Item3)),
	delete(Item1A,Item2A,Item3).
**/

removebrackets([[Value]],Value) :-!.
removebrackets(Value,Value).
