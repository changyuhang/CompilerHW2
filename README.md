#Homework 2#

###Due date: 2016-06-03###

----------
-  Implement a simple parser for a custom programming language using yacc and C/C++.  

  Yacc is a useful tool for implementing custom programming
language. In this homework, please use yacc and C/C++
language to implement a simple parser for a custom
programming language. In addition to parse the input source
code, your parser has to execute the program and output the
running results of the input source code.  
The custom programming language supports the following
features:
	1. Variable declaration: Variable declaration must be done
at the very beginning. The syntax is in the form of:  
    `var id1 [, id2 ...]`  
Please note that variable declaration must be placed at
the beginning of a source code. A variable must be
declared before it can be used. Please note that the
programming language supports double and string data
type. But the data type is detected when a variable is
being assigned. Also the data type of a variable can be
changed dynamically.
	2. Variable assignment: Assign values of a number, a string,
or an expression to an identifier. Data type of a variable
is determined by the data type of the right-hand-side
object. The assignment syntax is in the form of:  
    `id = ... ;`
	3. Output: Print out strings or numbers separated by
comma (,). The syntax is:  
    `print id | expr | string [ , id | expr | string ... ]`
	4. Input: Read a single string, or read a number of numbers.
We use two different keywords readn and reads to read
numbers and strings, respectively. The syntaxes are:  
    `readn id1 [, id2 ...]`  
    `reads id1`
	5. Arithmetic expressions: Support basic arithmetic
operations like  +, -, *, /, and power . Arithmetic
operations are only applicable to numbers or variables of
type number.  

> Each statement must be terminated with a semi-colon symbol (;).
> To simplify your implementation, we provide a sample grammar
> as follows. However, you can modify the grammar to fit your
> needs.  

    program : var_list stmt_list
     ;
    var_list: var_list var_def  
     | var_def 
     ;
    var_def : VAR id_list ';'
     ;
    id_list : id_list ',' ID
     | ID
     ;
    stmt_list: stmt_list stmt
     | stmt
     ;
    stmt : assign_stmt ';'
     | print_stmt ';'
     | read_stmt ';'
     | expr ';'
     ;
    assign_stmt: ID '=' expr
     | ID '=' ID
     | ID '=' STR
     ;
    print_stmt: PRINT print_list
     ;
    print_list: print_list ',' pitem
     | pitem
     ;
    pitem : expr
     | ID
     | STR
     ;
    read_stmt: READS ID
     | READN nid_list
     ;
    nid_list: nid_list ',' ID
     | ID
     ;
    expr : expr '+' expr
     | expr '-' expr
     | expr '*' expr
     | expr '/' expr
     | expr '^' expr
     | '-' expr
     | '+' expr
     | ID
     | NUMBER
     ;


- Sample Case: Introduction  

Suppose the program is named hw2. In each case, we have an
input source code and an output result. The output result is the
execution result of the source code. Your program has to read 
the source code, execute the statements, and output the
execution result.  


1. **Sample Case #1: Hello, World.**  

	   The input hello.test:  

    	var x; 
    	x = "hello, world.\n";
    	print x;  


  	Execution command and output:  

    	$ ./hw2 test/hello.text  
    	hello, world.  


2. **Sample Case #2: Compute Circle Area**  

	   The input area.test:  

    	var z, r, pi;  
    	pi = 3.1415926;  
    	r = 7;  
    	z = pi * r ^ 2;  
    	print r, " ", z, "\n";  

	Execution command and output:  

    	$ ./hw2 test/area.test
    	7.000000 153.938037
