import socket
import re

MCAST_GRP = "10.1.3.58"
MCAST_PORT = 4445

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
sock.bind(("", MCAST_PORT))

membership = socket.inet_aton(MCAST_GRP) + socket.inet_aton("0.0.0.0")

sock.setsockopt(
    socket.IPPROTO_IP,
    socket.IP_ADD_MEMBERSHIP,
    membership
)

print("Scanning for Minecraft LAN worlds...\n")

seen = set()

while True:
    data, addr = sock.recvfrom(4096)
    message = data.decode("utf-8", errors="ignore")

    port = re.search(r"\[AD\](\d+)\[/AD\]", message)
    motd = re.search(r"\[MOTD\](.*?)\[/MOTD\]", message)

    if port:
        server = f"{addr[0]}:{port.group(1)}"

        if server not in seen:
            seen.add(server)

            print(f"[+] Minecraft LAN server found!")
            print(f"    IP: {addr[0]}")
            print(f"    Port: {port.group(1)}")
            print(f"    MOTD: {motd.group(1) if motd else 'Unknown'}")
            print(f"    Connect: {server}\n")