import socket

def start_chat_client(host='127.0.0.1', port=12345):
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host, port))
    print(f"Connected to chat server at {host}:{port}.")

    try:
        while True:
            # Send message to server
            client_message = input("Client: ")
            client_socket.sendall(client_message.encode())

            # Receive response from server
            server_message = client_socket.recv(1024).decode()
            if not server_message:
                print("Server disconnected.")
                break
            print(f"Server: {server_message}")

    except KeyboardInterrupt:
        print("\nDisconnected from server.")
    finally:
        client_socket.close()

# Run the client
start_chat_client()
