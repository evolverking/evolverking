import socket

def start_chat_server(host='127.0.0.1', port=12345):
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((host, port))
    server_socket.listen(1)
    print(f"Chat server started on {host}:{port}. Waiting for connections...")

    client_socket, client_address = server_socket.accept()
    print(f"Client connected from {client_address}.")

    while True:
        # Receive message from client
        client_message = client_socket.recv(1024).decode()
        if not client_message:
            print("Client disconnected.")
            break
        print(f"Client: {client_message}")

        # Send response to client
        server_message = input("Server: ")
        client_socket.sendall(server_message.encode())

    client_socket.close()
    server_socket.close()
    print("Server stopped.")

# Run the server
start_chat_server()
