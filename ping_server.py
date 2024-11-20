import socket

def udp_ping_server(host='127.0.0.1', port=12345):
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    server_socket.bind((host, port))
    print(f"UDP server started on {host}:{port}.")

    while True:
        data, addr = server_socket.recvfrom(1024)  # Buffer size is 1024 bytes
        print(f"Received message from {addr}: {data.decode()}")
        
        # Echo the data back to the client
        server_socket.sendto(data, addr)

# Run the server
udp_ping_server()
