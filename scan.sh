#!/bin/bash

echo "Listening for Minecraft LAN worlds..."
echo "Press Ctrl+C to stop."
echo

python3 - <<'PY'
import socket
import re

GROUP = "224.0.2.60"
PORT = 4445

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
sock.bind(("", PORT))

mreq = socket.inet_aton(GROUP) + socket.inet_aton("0.0.0.0")
sock.setsockopt(socket.IPPROTO_IP, socket.IP_ADD_MEMBERSHIP, mreq)

seen = set()

while True:
    data, addr = sock.recvfrom(4096)
    msg = data.decode("utf-8", errors="ignore")

    port = re.search(r"\[AD\](\d+)\[/AD\]", msg)
    motd = re.search(r"\[MOTD\](.*?)\[/MOTD\]", msg)

    if port:
        server = f"{addr[0]}:{port.group(1)}"

        if server not in seen:
            seen.add(server)

            print("Minecraft LAN server found!")
            print(f"IP:   {addr[0]}")
            print(f"Port: {port.group(1)}")
            print(f"MOTD: {motd.group(1) if motd else 'Unknown'}")
            print(f"Join: {server}")
            print()
PY