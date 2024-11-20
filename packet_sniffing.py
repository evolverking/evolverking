from scapy.all import *

def packet_callback(packet):
    if packet.haslayer(IP):
        print(f"Source: {packet[IP].src} -> Destination: {packet[IP].dst}")
        if packet.haslayer(TCP):
            print(f"   TCP Packet: {packet[TCP].sport} -> {packet[TCP].dport}")
        elif packet.haslayer(UDP):
            print(f"   UDP Packet: {packet[UDP].sport} -> {packet[UDP].dport}")

# Sniff packets on the network
sniff(prn=packet_callback, store=0)
