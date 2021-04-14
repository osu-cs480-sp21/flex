%{
  /*
   * This is the prologue.
   */

  #include <iostream>

  int num_chars = 0;
  int num_words = 0;
  int num_lines = 0;

  void foo();
%}

DIGIT [0-9]

%option yylineno
%option noyywrap

%%

a {
  std::cout << "Recognized an 'a'" << std::endl;
}

ca {
  std::cout << "Recognized a 'ca'" << std::endl;
}

cat|dog {
  /* cat or dog*/
}

ca*t {
  /* caaaaaaaaat, or ct, or cat, etc. */
  /* char* yytext; */
  std::cout << "Recognized: " << yytext << std::endl;
  std::cout << "  # of characters recognized: " << yyleng << std::endl;
}

ca+t {
  /* caaaaaaaaat, or cat, etc. */
}

ca?t {
  /* cat or ct */
}

c.t {
  /* cat, or cbt, or cct, or cdt, etc. */
}

c\.t {
  /* c.t */
}

c"."t {
  /* c.t */
}

\n {
  /* newline */
}

" " {

}

[ ] {

}

[ \t\n] {
  /* one space, or one tab, or one newline */
}

[^dog] {
  /* any character except 'd', 'o', or 'g' */
}

[a-zA-Z0-9] {
  /* Any lowercase letter, any uppercase letter, or any digit */
}

{DIGIT}+\.{DIGIT}+ {
  /* simple floating point number */
}

^cat {
  /* 'cat' only at the beginning of a line */
}

cat$ {
  /* 'cat' only at the end of a line */
}

(cat|dog)* {
  /* catdogcatcatdogcatdogdog */
}

<<EOF>> {
  /* end of file */
}

. {
  std::cerr << "Invalid character encountered (line " << yylineno << "): " << yytext << std::endl;
  /* yyterminate(); */
}

%%

void foo() {
  std::cout << "foo()" << std::endl;
}

int main() {
  return yylex();
}
