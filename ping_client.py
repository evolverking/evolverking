import socket
import time

def udp_ping_client(host='127.0.0.1', port=12345, num_pings=4):
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    client_socket.settimeout(1)  # Set timeout to 1 second

    for i in range(1, num_pings + 1):
        message = f"Ping {i}".encode()
        start_time = time.time()
        
        try:
            # Send the ping
            client_socket.sendto(message, (host, port))
            print(f"Sent: {message.decode()}")

            # Receive the response
            data, server = client_socket.recvfrom(1024)
            end_time = time.time()
            rtt = (end_time - start_time) * 1000  # RTT in milliseconds

            print(f"Received: {data.decode()} | RTT: {rtt:.2f} ms")

        except socket.timeout:
            print(f"Request {i} timed out.")

    client_socket.close()

# Run the client
udp_ping_client()
