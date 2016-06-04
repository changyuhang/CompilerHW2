%{
    #include <iostream>
    #include <string.h>
    #include <stdio.h>
    #include <map>
    #include <cmath>
    void yyerror(char *);
    extern int yylex();
    extern int yyparse();
    struct dataType{
      //bool INTEGER;
      bool FLOAT;
      //int num;
      double flo_num;
      std::string *str;
    };
    static std::map<std::string,dataType> vars;
    void string_out(std::string in1){
      std::string strTemp(in1);
      char charTemp[(in1).length()];
      strcpy(charTemp, strTemp.c_str());

      char *pch = strtok(charTemp,"\\");
      if(charTemp[0]=='\\'&&charTemp[1]=='n'){
        printf("\n");
        pch=&pch[1];
      }
      while(pch!=NULL){
        printf("%s",pch);
        pch=strtok(NULL,"\\");
        if(pch!=NULL){
          if(pch[0]=='n'){
            printf("\n");
          }
          pch=&pch[1];
        }
      }
    }
%}
%union{ int i; std::string *s; double f;}
%token<f> NUMBER
%token<f> FLOAT_NUMBER
%token<s> ID
%token<s> STR
%token PRINT VAR
%type<f> expr
%right '='
%left '+' '-'
%left '*' '/'
%%
program :   var_list stmt_list
        |   stmt_list
        ;
var_list:   var_list var_def
        |   var_def
        ;
var_def:    VAR id_list ';'
        ;
id_list :   id_list ',' ID      {vars[*$3].flo_num=0.0; delete $3;}
        |   ID                  {vars[*$1].flo_num=0.0; delete $1;}
        ;
stmt_list:  stmt_list stmt
        |   stmt
        ;
stmt :      assign_stmt ';'
        |   print_stmt ';'
//        |   read_stmt ';'
        |   expr ';'
        ;
assign_stmt:    ID '=' expr             {
                                          /*vars[*$1].INTEGER=true;*/
                                          /*vars[*$1].num = $3;*/
                                          vars[*$1].flo_num = $3;
                                          vars[*$1].FLOAT=true;
                                        }
        |       ID '=' ID               {vars[*$1].flo_num=vars[*$3].flo_num;}
        |       ID '=' NUMBER           {
                                          /*vars[*$1].INTEGER=true;*/
                                          vars[*$1].FLOAT=true;
                                          //vars[*$1].num = $3;
                                          vars[*$1].flo_num = $3;
                                        }
        |       ID '=' FLOAT_NUMBER     {
                                          /*vars[*$1].INTEGER=true;*/
                                          vars[*$1].FLOAT=true;
                                          vars[*$1].flo_num = $3;
                                          //vars[*$1].num = $3;
                                        }
        |       ID '=' STR              {
                                          /*vars[*$1].INTEGER=false;*/
                                          vars[*$1].FLOAT=false;
                                          vars[*$1].str=$3;
                                        }
;
print_stmt:     PRINT print_list
        ;
print_list:     print_list ',' pitem
        |       pitem
        ;
pitem :         FLOAT_NUMBER    {printf("%.6lf",$1);}
        |       NUMBER          {printf("%.6lf",$1);}
        |       ID              {
                                  if(vars[*$1].FLOAT){
                                    printf("%.6lf",vars[*$1].flo_num);
                                  }else{
                                    string_out(*vars[*$1].str);
                                    delete $1;
                                  //std::cout<<(*vars[*$1].str)<<std::endl;
                                  }

                            }
          |       STR          {string_out(*$1);}
          |       expr         {printf("%.6lf",$1);}
;
/*read_stmt:      READS ID
 |       READN nid_list
 ;
 nid_list:       nid_list ',' ID
 |       ID
 ;*/
expr :          expr '+' expr   {$$=$1+$3;}
        |       expr '-' expr   {$$=$1-$3;}
        |       expr '*' expr   {$$=$1*$3;}
        |       expr '/' expr   {$$=$1/$3;}
        |       expr '^' expr   {$$=pow($1,int($3));}
        |       ID              {$$=vars[*$1].flo_num;}
        |       NUMBER          {}
;
%%
void yyerror(char *s) {
    std::cout << s << std::endl;
}
extern FILE* yyin;
int main(int argc, char** argv){
     if(argc==2){
         yyin = fopen(argv[1], "r");
         if(!yyin){
             fprintf(stderr, "can't read file %s\n", argv[1]);
             return 1;
         }
     }
     yyparse();
}
