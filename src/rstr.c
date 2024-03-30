#include <stdio.h>
#include <string.h>

void rstr_c(char *dst, char *src);
void rstr_s(char *dst, char *src);

int main(int argc, char **argv) {
    char *str = argv[1];
    char str1[1024];
    char str2[1024];


    rstr_c(str1, argv[1]);
    printf("C: %s\n", str1);

    rstr_s(str2, argv[1]);
    printf("Asm: %s\n", str2);

    return 0;
}
