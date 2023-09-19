#include <stdio.h>
#include <string.h>

void rstr_c(char *dst, char *src) {
    int src_len = strlen(src);
    int i, j;

    for (i = 0, j = src_len - 1; i < src_len; i++, j--) {
        dst[i] = src[j];
    }
    
    dst[src_len] = '\0';
}
