%{
int num_lines = 0, num_chars = 0;
%}

%%
\n	++num_lines; ++num_chars;
.	++num_chars;
fim  return 0;
%%

int main(int argc, char *argv[])
{
  FILE *f_in;

  if (argc == 2)
  {
    if(f_in = fopen(argv[1],"r"))  yyin = f_in;
    else  perror(argv[0]);
  }
  else  yyin = stdin;

  yylex();
  return(0);
}