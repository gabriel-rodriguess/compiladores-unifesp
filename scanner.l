%{
/*
 * Definitions
 */
#include <stdlib.h>
#include <stdio.h>

enum lex{
  ELSE, IF, INT, RETURN,
  VOID, WHILE, ASSIGN, EQ, NUM,
  LT, GT, LTE, GTE, NE, ID, COMMA,
  LBRACKET, RBRACKET, LKEYS, END,
  RKEYS, PLUS, MINUS, TIMES, ICOMMENT,
  OVER, LPAREN, RPAREN, SEMI, FCOMMENT
};

void printToken(FILE *out, char stringToken[]){
  fprintf(out, "%s", stringToken);
}

void identifyToken(FILE *out, int token){
  switch (token){
    case ELSE: printToken(out, "ELSE"); break;
    case IF: printToken(out, "IF"); break;
    case INT: printToken(out, "INT"); break;
    case RETURN: printToken(out, "RETURN"); break;
    case VOID: printToken(out, "VOID"); break;
    case WHILE: printToken(out, "WHILE"); break;
    case ASSIGN: printToken(out, "ASSIGN"); break;
    case EQ: printToken(out, "EQ"); break;
    case NUM: printToken(out, "NUM"); break;
    case LT: printToken(out, "LT"); break;
    case GT: printToken(out, "GT"); break;
    case LTE: printToken(out, "LTE"); break;
    case NE: printToken(out, "NE"); break;
    case ID: printToken(out, "ID"); break;
    case COMMA: printToken(out, "COMMA"); break;
    case LBRACKET: printToken(out, "LBRACKET"); break;
    case RBRACKET: printToken(out, "RBRACKET"); break;
    case LKEYS: printToken(out, "LKEYS"); break;
    case END: printToken(out, "END"); break;
    case RKEYS: printToken(out, "RKEYS"); break;
    case PLUS: printToken(out, "PLUS"); break;
    case MINUS: printToken(out, "MINUS"); break;
    case TIMES: printToken(out, "TIMES"); break;
    case OVER: printToken(out, "OVER"); break;
    case LPAREN: printToken(out, "LPAREN"); break;
    case RPAREN: printToken(out, "RPAREN"); break;
    case SEMI: printToken(out, "SEMI"); break;
    case ICOMMENT: printToken(out, "ICOMMENT"); break;
    case FCOMMENT: printToken(out, "FCOMMENT"); break;
    default: fprintf(out, "%s", yytext);
  }
}

%}

/*
 * Rules
 */
digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
identifier  {letter}+

%%

"if"            {return IF;}
"else"          {return ELSE;}
"int"		        {return INT;}
"return"	      {return RETURN;}
"void"		      {return VOID;}
"while"		      {return WHILE;}
"="             {return ASSIGN;}
"=="            {return EQ;}
"<"             {return LT;}
">"		          {return GT;}
"<="		        {return LTE;}
">="		        {return GTE;}
"!="	       	  {return NE;}
"["		          {return LBRACKET;}
"]"		          {return RBRACKET;}
"{"		          {return LKEYS;}
"}"		          {return RKEYS;}
"+"             {return PLUS;}
"-"             {return MINUS;}
"/*"            {return ICOMMENT;}
"*/"            {return FCOMMENT;}
"*"             {return TIMES;}
"/"             {return OVER;}
"("             {return LPAREN;}
")"             {return RPAREN;}
";"             {return SEMI;}
","		          {return COMMA;}
{number}        {return NUM;}
{identifier}    {return ID;}
<<EOF>>         {return END;}

%%

/*
 * User Code
 */
int main(int argc, char *argv[]){
  FILE *f_in, *f_out;
  int token;

  if(argc > 2){
    printf("too may arguments");
    return -1;
  }else if(argc == 2){
    if((f_in = fopen(argv[1], "r"))){
      yyin = f_in;
    } else{ 
      perror(argv[0]);
      return -1;
    }
  }

  f_out = fopen("out.txt", "w");
  yyout = f_out;

  while((token = yylex()) != END){
    identifyToken(yyout, token);
  }

  return 0;
}