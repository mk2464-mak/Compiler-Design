%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_WORDS 1000

char *words[MAX_WORDS];
int counts[MAX_WORDS];
int word_index = 0;

void add_word(char *word) {
    for (int i = 0; i < word_index; i++) {
        if (strcmp(words[i], word) == 0) {
            counts[i]++;
            return;
        }
    }
    words[word_index] = strdup(word);
    counts[word_index++] = 1;
}
%}

%%
[a-zA-Z]+    { add_word(yytext); }
[ \t\n]+     ;   // Ignore whitespace
.            ;   // Ignore other characters
%%

int main() {
    yylex();
    printf("\nHistogram of Words:\n");
    for (int i = 0; i < word_index; i++) {
        printf("%s: ", words[i]);
        for (int j = 0; j < counts[i]; j++) {
            printf("*");
        }
        printf(" (%d)\n", counts[i]);
    }
    return 0;
}

int yywrap() {
    return 1;
}
