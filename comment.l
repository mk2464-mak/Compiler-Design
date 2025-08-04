%{
#include <stdio.h>
%}

%%
"//".*               { printf("Single-line comment: %s\n", yytext); }
"/*"([^*]|\*+[^*/])*\*+"/" {
                        printf("Multi-line comment: %s\n", yytext);
                    }
.|\n                ; // Ignore everything else
%%

int main() {
    printf("Extracting comments from C code:\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
