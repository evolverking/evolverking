def calculate_parity_bits(m):
    # Calculate the number of parity bits needed
    r = 0
    while (2**r) < (m + r + 1):
        r += 1
    return r

def insert_parity_bits(data, r):
    n = len(data) + r
    hamming_code = ['P' if (i & (i + 1)) == 0 else 'D' for i in range(n)]

    # Fill data bits
    j = 0
    for i in range(n):
        if hamming_code[i] == 'D':
            hamming_code[i] = data[j]
            j += 1

    return hamming_code

def set_parity_bits(hamming_code):
    n = len(hamming_code)
    for i in range(n):
        if hamming_code[i] == 'P':
            parity_pos = i + 1
            count = 0
            for j in range(parity_pos - 1, n, 2 * parity_pos):
                count += sum(1 for bit in hamming_code[j:j + parity_pos] if bit == '1')
            hamming_code[i] = '0' if count % 2 == 0 else '1'
    return hamming_code

def generate_hamming_code(data):
    r = calculate_parity_bits(len(data))
    hamming_code = insert_parity_bits(data, r)
    hamming_code = set_parity_bits(hamming_code)
    return ''.join(hamming_code)

# Example: Data to encode (8 bits)
data = '10110011'
hamming_code = generate_hamming_code(data)
print("Generated Hamming Code for 8-bit input:", hamming_code)
