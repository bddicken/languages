#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <immintrin.h>
#include <string.h>

// Fast division parameters
__m256i m1;
__m256i d1;
uint32_t shf1;
uint32_t shf2;

static inline uint32_t bit_scan_reverse(uint32_t a) {
    uint32_t r;
    __asm("bsrl %1, %0" : "=r"(r) : "r"(a) : );
    return r;
}

void init_divisor(uint32_t d) {
    uint32_t L, L2, sh1, sh2, m;
    
    if (d <= 2) {
        m = 1; sh1 = (d == 2); sh2 = 0;
    } else {
        L = bit_scan_reverse(d-1) + 1;
        L2 = L < 32 ? 1 << L : 0;
        m = 1 + (uint32_t)(((uint64_t)(L2 - d) << 32) / d);
        sh1 = 1;
        sh2 = L - 1;
    }
    m1 = _mm256_set1_epi32(m);
    d1 = _mm256_set1_epi32(d);
    shf1 = sh1;
    shf2 = sh2;
}

static inline __m256i fast_mod_avx2(__m256i a) {
    __m256i t1 = _mm256_mul_epu32(a, m1);
    __m256i t2 = _mm256_srli_epi64(t1, 32);
    __m256i t3 = _mm256_srli_epi64(a, 32);
    __m256i t4 = _mm256_mul_epu32(t3, m1);
    __m256i t5 = _mm256_set_epi32(-1,0,-1,0,-1,0,-1,0);
    __m256i t7 = _mm256_blendv_epi8(t2, t4, t5);
    __m256i t8 = _mm256_sub_epi32(a, t7);
    __m256i t9 = _mm256_srli_epi32(t8, shf1);
    __m256i t10 = _mm256_add_epi32(t7, t9);
    __m256i t11 = _mm256_srli_epi32(t10, shf2);
    __m256i t12 = _mm256_mullo_epi32(t11, d1);
    return _mm256_sub_epi32(a, t12);
}

int main(int argc, char** argv) {
    int u = atoi(argv[1]);
    int r = rand() % 10000;
    int32_t* a = (int32_t*)aligned_alloc(32, 10000 * sizeof(int32_t));
    memset(a, 0, 10000 * sizeof(int32_t));
    
    init_divisor(u);

    for (int i = 0; i < 10000; i++) {
        __m256i sum = _mm256_setzero_si256();
        for (int j = 0; j < 100000; j += 8) {
            __m256i j_vec = _mm256_set_epi32(j+7, j+6, j+5, j+4, j+3, j+2, j+1, j);
            sum = _mm256_add_epi32(sum, fast_mod_avx2(j_vec));
        }
        
        int32_t temp[8];
        _mm256_storeu_si256((__m256i*)temp, sum);
        a[i] = temp[0] + temp[1] + temp[2] + temp[3] + 
               temp[4] + temp[5] + temp[6] + temp[7] + r;
    }

    printf("%d\n", a[r]);
    free(a);
    return 0;
}
