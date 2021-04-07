%{
  /*
   * This is the prologue.
   */
  int num_chars = 0;
  int num_words = 0;
  int num_lines = 0;

  void foo();
%}

DIGIT   [0-9]

%option yylineno
%option noyywrap

%%

%%
