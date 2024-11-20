#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <time.h>

#define PORT 12345
#define BUFFER_SIZE 1024

int main() {
    int client_socket;
    struct sockaddr_in server_addr;
    char buffer[BUFFER_SIZE];
    socklen_t addr_len = sizeof(server_addr);

    // Create UDP socket
    client_socket = socket(AF_INET, SOCK_DGRAM, 0);
    if (client_socket < 0) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    // Set up server address
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);
    server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");

    for (int i = 1; i <= 4; i++) {
        snprintf(buffer, BUFFER_SIZE, "Ping %d", i);
        clock_t start_time = clock();

        // Send the message
        sendto(client_socket, buffer, strlen(buffer), 0, (struct sockaddr*)&server_addr, addr_len);
        printf("Sent: %s\n", buffer);

        // Receive the response
        struct timeval timeout = {1, 0}; // 1-second timeout
        setsockopt(client_socket, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout));

        int bytes_received = recvfrom(client_socket, buffer, BUFFER_SIZE, 0, (struct sockaddr*)&server_addr, &addr_len);
        if (bytes_received > 0) {
            clock_t end_time = clock();
            double rtt = ((double)(end_time - start_time)) / CLOCKS_PER_SEC * 1000; // RTT in milliseconds
            buffer[bytes_received] = '\0';
            printf("Received: %s | RTT: %.2f ms\n", buffer, rtt);
        } else {
            printf("Request %d timed out.\n", i);
        }
    }

    close(client_socket);
    return 0;
}
