(* ::Package:: *)

BeginPackage["Z3Interop`"]


Assertion::usage="Assertion[condition] is a symbolic representation of the assertion that the given condition holds.";
Declare::usage="Declare[var_Symbol, Integer] is a symbolic representation of the integer variable named var.";
CheckSat::usage="CheckSat is a symbolic representation of the command to check satisfiability at the current point in the model specification.";
GetModel::usage="GetModel is a symbolic representation of the command to print out a satisfying model.";

getDefinitions::usage="getDefinitions extracts the integer variables from a Z3 output and converts them into Wolfram Language expressions."
toString::usage="toString[symbols_, expr] converts a line of Z3 program (given as a specification either as a Wolfram Language expression or in terms of Z3Interop primitives) into a string.";


Begin["`Private`"]


toString[symbols_, Equal[i_,j_]]:=StringJoin["(= ",toString[symbols, i]," ",toString[symbols,j],")"]
toString[symbols_, Greater[i_,j_]]:=StringJoin["(> ",toString[symbols,i]," ",toString[symbols,j],")"]
toString[symbols_, Less[i_,j_]]:=StringJoin["(< ",toString[symbols,i]," ",toString[symbols,j],")"]
toString[symbols_, GreaterEqual[i_,j_]]:=StringJoin["(>= ",toString[symbols,i]," ",toString[symbols,j],")"]
toString[symbols_, LessEqual[i_,j_]]:=StringJoin["(<= ",toString[symbols,i]," ",toString[symbols,j],")"]
toString[symbols_, Or[a_,b_]]:=StringJoin["(or ",toString[symbols,a]," ",toString[symbols,b],")"]
toString[symbols_, Xor[a_,b_]]:=StringJoin["(xor ",toString[symbols,a]," ",toString[symbols,b],")"]
toString[symbols_, And[a_,b_]]:=StringJoin["(and ",toString[symbols,a]," ",toString[symbols,b],")"]
toString[symbols_, Not[a_]]:=StringJoin["(not ", toString[symbols,a], ")"]
toString[symbols_, Unequal[a_, b_]]:=StringJoin["(not ",toString[symbols,a==b],")"]
toString[symbols_, i_Integer]:=ToString[i]
toString[symbols_, a_+b_]:=StringJoin["(+ ",toString[a]," ",toString[b],")"]
toString[symbols_, Integer]="Int";
toString[symbols_, Declare[var_,type_]]:=StringJoin["(declare-fun ",toString[symbols,var]," () ",toString[symbols,type],")"]
toString[symbols_, Assertion[expr_]]:=StringJoin["(assert ",toString[symbols,expr],")"]
toString[symbols_, CheckSat]:="(check-sat)"
toString[symbols_, GetModel]:="(get-model)"
toString[symbols_, h_[tail___]] /; MemberQ[First/@symbols,h]:=StringJoin[h/.symbols, "_", Riffle[toString[symbols, #]&/@{tail},"_"]]


r=RegularExpression["\\(define-fun (.+?) \\(\\) Int\\s+([0-9]*)\\)"];
getDefinitions[symbols_, output_]:=(First[#][Sequence@@(FromDigits[#,10]&/@Most[Rest[#]])]->FromDigits@Last[#])&/@(MapAt[#/.(Reverse/@symbols)&,StringSplit[#,"_"],1]&/@StringCases[StringReplace[output,"\n"->""],r->"$1_$2"]);


End[]


Protect[Assertion];
Protect[Declare];
Protect[CheckSat];
Protect[GetModel];


Begin["`Nonogram`"]


gapsToConstraints::usage="gapsToConstraints[column_List, columnIndex_Integer, totalNumberOfRows_Integer, variableHead_Symbol] converts the data from the given column (which is column number `columnIndex`) into a set of constraints on that column (without reference to any rows). The same is true interchanging the notion of 'row' and 'column'.";
constrainedCells::usage="constrainedCells[rowGap_Symbol, colGap_Symbol, cellVariable_Symbol, rows_, cols_, constraintsFromRows_, constraintsFromCols_,colourMapping_] uses the data from `gapsToConstraints` applied to the rows and columns, and produces the additional constraint which tie the rows and columns together. The output omits the original input constraints. `rows` and `cols` should be the actual data of the shape {{{index, colour}, {index, colour}}}.";


Begin["`Private`"]


Z3Interop`Nonogram`gapsToConstraints[column_,colNum_Integer,totalRows_Integer,variable_Symbol]:=
With[{lhs=MapIndexed[variable[colNum,First@#2]+First@#1&,column]},
With[{rhs=Append[variable[colNum,#+1]&/@Most@Range[Length@lhs],totalRows+1]},
With[{operations=Append[If[#[[1]]===#[[2]],Less,LessEqual]&/@Partition[Last/@column,2,1],LessEqual]},
With[{middle=#[[1]][#[[2]],#[[3]]]&/@Transpose[{operations,lhs,rhs}]},
Join[{1<=variable[colNum,1]},middle]]]]]


Z3Interop`Nonogram`constrainedCells[rowGap_Symbol, colGap_Symbol, cell_Symbol, rowsIn_, colsIn_, constrainedRows_, constrainedColumns_,mapping_] :=
Join[
(* Constraints on the rows *)
Flatten[Table[
Xor@@Prepend[
(rowGap[row,#]<=col&&col<rowGap[row,#]+rowsIn[[row,#,1]] && cell[row,col]==rowsIn[[row,#,2]])&/@Range[Length@constrainedRows[[row]]-1],
And@@Prepend[rowGap[row,#]>col||col>=rowGap[row,#]+rowsIn[[row,#,1]] &/@Range[Length@constrainedRows[[row]]-1],cell[row,col]==White]
],
{row,1,Length@rowsIn},{col,1,Length@colsIn}],1],
(* Constraints on the columns *)
Flatten[Table[
Xor@@Prepend[
(colGap[col,#]<=row&&row<colGap[col,#]+colsIn[[col,#,1]] && cell[row,col]==colsIn[[col,#,2]])&/@Range[Length@constrainedColumns[[col]]-1],
And@@Prepend[colGap[col,#]>row||row>=colGap[col,#]+colsIn[[col,#,1]] &/@Range[Length@constrainedColumns[[col]]-1],cell[row,col]==White]
],
{row,1,Length@rowsIn},{col,1,Length@colsIn}],1]
]/.mapping;


End[]


Protect[gapsToConstraints];
Protect[constrainedCells];


End[]


EndPackage[]
