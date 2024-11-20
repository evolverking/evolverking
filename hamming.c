#include <stdio.h>
#include <string.h>
#include <math.h>

int calculate_parity_bits(int m) {
    int r = 0;
    while ((1 << r) < (m + r + 1)) {
        r++;
    }
    return r;
}

void insert_parity_bits(char *data, int r, char *hamming_code) {
    int n = strlen(data) + r;
    int data_index = 0;

    for (int i = 0; i < n; i++) {
        if ((i & (i + 1)) == 0) {
            hamming_code[i] = 'P'; // Placeholder for parity bits
        } else {
            hamming_code[i] = data[data_index++];
        }
    }
}

void set_parity_bits(char *hamming_code, int n) {
    for (int i = 0; i < n; i++) {
        if (hamming_code[i] == 'P') {
            int parity_pos = i + 1;
            int count = 0;
            for (int j = parity_pos - 1; j < n; j += 2 * parity_pos) {
                for (int k = j; k < j + parity_pos && k < n; k++) {
                    if (hamming_code[k] == '1') {
                        count++;
                    }
                }
            }
            hamming_code[i] = (count % 2 == 0) ? '0' : '1';
        }
    }
}

void generate_hamming_code(char *data) {
    int r = calculate_parity_bits(strlen(data));
    int n = strlen(data) + r;
    char hamming_code[n + 1];
    hamming_code[n] = '\0';

    insert_parity_bits(data, r, hamming_code);
    set_parity_bits(hamming_code, n);

    printf("Generated Hamming Code: %s\n", hamming_code);
}

int main() {
    char data[] = "10110011"; // Example 8-bit data
    generate_hamming_code(data);
    return 0;
}
