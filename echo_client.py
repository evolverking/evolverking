import socket

def start_echo_client(host='127.0.0.1', port=12345):
    # Create a socket object
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host, port))
    print(f"Connected to server at {host}:{port}")

    try:
        while True:
            message = input("Enter message to send (type 'exit' to quit): ")
            if message.lower() == 'exit':
                break
            client_socket.sendall(message.encode())
            response = client_socket.recv(1024)
            print(f"Echo from server: {response.decode()}")

    finally:
        client_socket.close()
        print("Disconnected from server.")

# Start the client
start_echo_client()
