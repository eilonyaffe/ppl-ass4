/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).

:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).


% Signature: path(Node1, Node2, Path)/3
% Purpose: Path is a path, denoted by a list of nodes, from Node1 to Node2.

path(Node1, Node2, [Node1, Node2]) :- edge(Node1, Node2).
path(Node1, Node2, [Node1 | Path]) :- edge(Node1, InterNode), path(InterNode, Node2, Path).


% Signature: cycle(Node, Cycle)/2
% Purpose: Cycle is a cyclic path, denoted a list of nodes, from Node1 to Node1.

cycle(Node, [Node, Node]) :- edge(Node, Node).
cycle(Node, [Node | Path]) :- edge(Node, InterNode), path(InterNode, Node, Path).


% Signature: reverse(Graph1,Graph2)/2
% Purpose: The edges in Graph1 are reversed in Graph2

reverse([], []).
reverse([[Node1, Node2] | Rest], [[Node2, Node1] | Reversed]) :- reverse(Rest, Reversed).


% Signature: degree(Node, Graph, Degree)/3
% Purpose: Degree is the degree of node Node, denoted by a Church number (as defined in class)

degree(Node, Graph, Degree) :- degree_helper(Node, Graph, zero, Degree).

degree_helper(Node, [[Node,_]|Rest], Acc, Degree) :- degree_helper(Node, Rest, s(Acc), Degree).
degree_helper(Node, [[_,_]|Rest], Acc, Degree) :- degree_helper(Node, Rest, Acc, Degree).
degree_helper(_, [], Acc, Acc).





