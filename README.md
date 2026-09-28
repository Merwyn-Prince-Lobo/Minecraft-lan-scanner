# Minecraft LAN Scanner

## Windows — Python

```cmd
python minecraft-lan-scan.py
```

or:

```cmd
py minecraft-lan-scan.py
```

## Windows — Batch

```cmd
minecraft-lan-scan.bat
```

Or double-click the `.bat`.

## Ubuntu — Python

```bash
python3 minecraft-lan-scan.py
```

## Ubuntu — Shell

```bash
chmod +x minecraft-lan-scan.sh
./minecraft-lan-scan.sh
```

## Check Minecraft LAN Multicast

### Windows PowerShell

```powershell
Get-NetUDPEndpoint -LocalPort 4445
```

### Ubuntu

```bash
sudo tcpdump -ni any -A 'udp port 4445'
```



