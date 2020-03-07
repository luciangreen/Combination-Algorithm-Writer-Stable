:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).

% we need this module from the HTTP client library for http_read_data
:- use_module(library(http/http_client)).
:- http_handler('/', web_form, []).

:- include('Dropbox/GitHub/Combination-Algorithm-Writer-Stable/listprologinterpreter1listrecursion4copy52.pl').
:- include('Dropbox/GitHub/Combination-Algorithm-Writer-Stable/listprologinterpreter3preds5copy52.pl').
:- include('Dropbox/GitHub/Combination-Algorithm-Writer-Stable/caw5copy11.pl').
:- include('Dropbox/GitHub/Combination-Algorithm-Writer-Stable/lpi_caw_commands.pl').

server(Port) :-
        http_server(http_dispatch, [port(Port)]).

	/*
	browse http://127.0.0.1:8000/
	This demonstrates handling POST requests
	   */

	   web_form(_Request) :-
	   	reply_html_page(include('Combination Algorithm Writer Stable'),
	   	
			    	    [
				    	     form([action='/landing', method='POST'], [
				    	     /**
					     		p([], [
									  label([for=debug],'Debug (on/off):'),
									  		  input([name=debug, type=textarea])
											  		      ]),
											  		      **/
													      		p([], [
																	  label([for=predicatename],'Predicate Name (e.g. f):'),
																	  		  input([name=predicatename, type=textarea])
																			  		      ]),

													      		p([], [
																	  label([for=rules],'Rules to choose from (e.g. [[+,2,1]]):'),
																	  		  input([name=rules, type=textarea])
																			  		      ]),

															      		p([], [
																	  label([for=maxlength],'Max Length of Algorithm Body (e.g. 4):'),
																	  		  input([name=maxlength, type=textarea])
																			  		      ]),

																				      		p([], [
																	  label([for=totalvars],'Total Vars in Predicate (e.g. 8):'),
																	  		  input([name=totalvars, type=textarea])
																			  		      ]),
													      		p([], [
																	  label([for=inputvarlist],'InputVarList (e.g. [[a,1],[b,1],[c,2],[d,1]]):'),
																	  		  input([name=inputvarlist, type=textarea])
																			  		      ]),

													      		p([], [
																	  label([for=outputvarlist],'OutputVarList (e.g. [[e,5]]):'),
																	  		  input([name=outputvarlist, type=textarea])
																			  		      ]),

													      		p([], [
																	  label([for=algorithmlibrary],'Algorithm Library (e.g. [[[f1,4,1],[a,b,c,d,e],(:-),[[+,[a,b,f]],[+,[c,f,g]],[+,[d,g,h]],[=,[e,h]]]]], where 4 is the number of inputs and 1 is the number of outputs):'),
																	  		  input([name=algorithmlibrary, type=textarea])
																			  		      ]),

												      		p([], input([name=submit, type=submit, value='Submit'], []))
																								      ])]).

																								      :- http_handler('/landing', landing_pad, []).

																								      landing_pad(Request) :-
																								              member(method(post), Request), !,
																									              http_read_data(Request, Data, []),
																										              format('Content-type: text/html~n~n', []),
																											      	format('<p>', []),
																												        %%portray_clause(Data),
																												        
																												        %%term_to_atom(Term,Data),
									
										   	%% Predicatename,Rules,Maxlength,Totalvars,Inputvarlist,Outputvarlist,Algorithmlibrary
																															%%portray_clause(Data),
			
															        
Data=[%%debug='off',%%Debug1,
predicatename=Predicatename,rules=Rules,maxlength=Maxlength,totalvars=Totalvars,inputvarlist=Inputvarlist,outputvarlist=Outputvarlist,algorithmlibrary=Algorithmlibrary,submit=_],

term_to_atom(Debug1,'off'),
term_to_atom(Predicatename1,Predicatename),
term_to_atom(Rules1,Rules),
term_to_atom(Maxlength1,Maxlength),
term_to_atom(Totalvars1,Totalvars),
term_to_atom(Inputvarlist1,Inputvarlist),
term_to_atom(Outputvarlist1,Outputvarlist),
term_to_atom(Algorithmlibrary1,Algorithmlibrary),

caw00(Debug1,Predicatename1,Rules1,Maxlength1,Totalvars1,Inputvarlist1,Outputvarlist1,Algorithmlibrary1,[],Result),
																														%%format('</p><p>========~n', []),
																															portray_clause(Result),
																																																															%%writeln1(Data),

format('</p>').