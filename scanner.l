%{
  #include <iostream>
  #include <vector>
  #include <set>

  struct word {
    std::string category;
    std::string lexeme;
  };

  std::vector<struct word> words;
  std::set<std::string> identifiers;
  bool error = false;

  void save_word(std::string lexeme, std::string category) {
    struct word word = { .lexeme = lexeme, .category = category };
    words.push_back(word);
  }
%}

%option yylineno
%option noyywrap

%%

%{
  // Goes at the top of yylex()
  /* words.push_back(); */
%}

[ \t\n]* {
  /* Ignore whitespace. */
}

[a-z][0-9]? {
  save_word(yytext, "IDENTIFIER");
  identifiers.insert(yytext);
}

[0-9]+("."[0-9]+)? {
  save_word(yytext, "NUMBER");
}

"=" {
  save_word(yytext, "EQUALS");
}

"+" {
  save_word(yytext, "PLUS");
}

"-" {
  save_word(yytext, "MINUS");
}

"*" {
  save_word(yytext, "TIMES");
}

"/" {
  save_word(yytext, "DIVIDEDBY");
}

";" {
  save_word(yytext, "SEMICOLON");
}

"(" {
  save_word(yytext, "LPAREN");
}

")" {
  save_word(yytext, "RPAREN");
}

. {
  std::cerr << "Invalid symbol on line " << yylineno << ": " << yytext
    << std::endl;
  error = true;
}

<<EOF>> {
  if (error) {
    return 1;
  }
  return 0;
}

%%

int main() {
  if (!yylex()) {
    for (int i = 0; i < words.size(); i++) {
      std::cout << words[i].category << "\t\t" << words[i].lexeme << std::endl;
    }
  }
}
