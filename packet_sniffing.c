#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/ip.h>
#include <netinet/udp.h>
#include <netinet/tcp.h>
#include <netinet/in.h>

// Pseudo header needed for TCP checksum calculation
struct pseudo_header {
    u_int32_t source_address;
    u_int32_t dest_address;
    u_int8_t placeholder;
    u_int8_t protocol;
    u_int16_t tcp_length;
};

// IP Header structure
struct ip_header {
    u_int8_t  ip_vhl;       // Version and header length
    u_int8_t  ip_tos;       // Type of service
    u_int16_t ip_len;       // Total length
    u_int16_t ip_id;        // Identification
    u_int16_t ip_offset;    // Fragment offset field
    u_int8_t  ip_ttl;       // Time to live
    u_int8_t  ip_protocol;  // Protocol (TCP, UDP, etc.)
    u_int16_t ip_checksum;  // IP checksum
    u_int32_t ip_src;       // Source IP address
    u_int32_t ip_dst;       // Destination IP address
};

// TCP Header structure
struct tcp_header {
    u_int16_t th_sport;     // Source port
    u_int16_t th_dport;     // Destination port
    u_int32_t th_seq;       // Sequence number
    u_int32_t th_ack;       // Acknowledgment number
    u_int8_t  th_offx2;     // Data offset and reserved
    u_int8_t  th_flags;     // TCP flags
    u_int16_t th_win;       // Window size
    u_int16_t th_sum;       // Checksum
    u_int16_t th_urp;       // Urgent pointer
};

// UDP Header structure
struct udp_header {
    u_int16_t uh_sport;     // Source port
    u_int16_t uh_dport;     // Destination port
    u_int16_t uh_len;       // Length
    u_int16_t uh_sum;       // Checksum
};

void print_ip_header(const u_char *buffer) {
    struct ip_header *iph = (struct ip_header *)(buffer + 14);  // Skip Ethernet header (14 bytes)
    struct in_addr source, dest;
    source.s_addr = iph->ip_src;
    dest.s_addr = iph->ip_dst;
    
    printf("\n\nIP Header\n");
    printf("   |-IP Version      : %d\n", iph->ip_vhl >> 4);
    printf("   |-IP Header Length: %d DWORDS or %d Bytes\n", iph->ip_vhl & 0xF, (iph->ip_vhl & 0xF) * 4);
    printf("   |-IP Total Length : %d Bytes (Size of Packet)\n", ntohs(iph->ip_len));
    printf("   |-Protocol        : %d\n", iph->ip_protocol);
    printf("   |-Source IP       : %s\n", inet_ntoa(source));
    printf("   |-Destination IP  : %s\n", inet_ntoa(dest));
}

void print_tcp_header(const u_char *buffer) {
    struct ip_header *iph = (struct ip_header *)(buffer + 14);
    u_int16_t ip_header_len = (iph->ip_vhl & 0xF) * 4;
    struct tcp_header *tcph = (struct tcp_header *)(buffer + 14 + ip_header_len);
    
    printf("\n\nTCP Header\n");
    printf("   |-Source Port      : %u\n", ntohs(tcph->th_sport));
    printf("   |-Destination Port : %u\n", ntohs(tcph->th_dport));
    printf("   |-Sequence Number  : %u\n", ntohl(tcph->th_seq));
    printf("   |-Acknowledgment   : %u\n", ntohl(tcph->th_ack));
    printf("   |-TCP Header Length: %d DWORDS or %d Bytes\n", (tcph->th_offx2 >> 4), (tcph->th_offx2 >> 4) * 4);
}

void print_udp_header(const u_char *buffer) {
    struct ip_header *iph = (struct ip_header *)(buffer + 14);
    u_int16_t ip_header_len = (iph->ip_vhl & 0xF) * 4;
    struct udp_header *udph = (struct udp_header *)(buffer + 14 + ip_header_len);
    
    printf("\n\nUDP Header\n");
    printf("   |-Source Port      : %u\n", ntohs(udph->uh_sport));
    printf("   |-Destination Port : %u\n", ntohs(udph->uh_dport));
    printf("   |-UDP Length       : %u\n", ntohs(udph->uh_len));
}

int main() {
    int sock_raw;
    struct sockaddr saddr;
    u_char *buffer = (u_char *)malloc(65536);  // Buffer for raw data

    // Create a raw socket to capture all packets
    sock_raw = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
    if (sock_raw < 0) {
        perror("Socket creation failed");
        return 1;
    }
    
    while (1) {
        // Receive a packet
        ssize_t data_size = recvfrom(sock_raw, buffer, 65536, 0, &saddr, (socklen_t *)sizeof(saddr));
        if (data_size < 0) {
            perror("Error in receiving packet");
            return 1;
        }
        
        // Print IP Header
        print_ip_header(buffer);
        
        // Print TCP or UDP Header
        struct ip_header *iph = (struct ip_header *)(buffer + 14);
        switch (iph->ip_protocol) {
            case 6:  // TCP
                print_tcp_header(buffer);
                break;
            case 17: // UDP
                print_udp_header(buffer);
                break;
            default:
                printf("Other Protocol: %d\n", iph->ip_protocol);
        }
    }

    close(sock_raw);
    return 0;
}
