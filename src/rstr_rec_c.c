#include <stdio.h>
#include <string.h>


void rstr_rec_func_c(char *dst, int dst_idx, char *src, int src_idx) {
    if (src[src_idx] == '\0') {
        dst[dst_idx] = '\0';
        return;
    }

    // Copy the current character from the end of src to the start of dst
    dst[dst_idx] = src[src_idx];

    rstr_rec_func_c(dst, dst_idx + 1, src, src_idx - 1);
}

void rstr_rec_c(char *dst, char *src) {
    int src_len = strlen(src);
    rstr_rec_func_c(dst, 0, src, src_len - 1);
}
