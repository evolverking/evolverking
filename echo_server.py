import socket

def start_echo_server(host='127.0.0.1', port=12345):
    # Create a socket object
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((host, port))
    server_socket.listen(1)
    print(f"Server started. Listening on {host}:{port}...")

    while True:
        client_socket, client_address = server_socket.accept()
        print(f"Connection from {client_address} established.")

        while True:
            data = client_socket.recv(1024)
            if not data:
                break  # Break the loop if client disconnects
            print(f"Received from client: {data.decode()}")
            client_socket.sendall(data)  # Echo the received data back

        client_socket.close()
        print(f"Connection from {client_address} closed.")

# Start the server
start_echo_server()
