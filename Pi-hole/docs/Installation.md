# Installation Guide

This guide walks through the full setup from a fresh Windows host to a running Pi-hole instance. It covers Ubuntu Server installation, static IP configuration, Pi-hole installation, and DHCP setup.

Follow the steps in order. For context on why things are configured this way see [pihole.md](pihole.md) and [network.md](network.md).

---

## Prerequisites

- Windows 10/11 with Hyper-V enabled
- PowerShell running as Administrator
- [Ubuntu Server 24.04 ISO](https://ubuntu.com/download/server) downloaded

---

## Step 1 - Create the Virtual Switch

The virtual switch connects the Pi-hole VM to the physical network. Run this first before creating the VM.

```powershell
.\scripts\create-v-switch.ps1
```

See [virtualization.md](virtualization.md) for details on what this script does.

---

## Step 2 - Create the Pi-hole VM

```powershell
.\scripts\create-pihole-vm.ps1
```

This creates a new Hyper-V VM and attaches it to the virtual switch created in Step 1.

---

## Step 3 - Install Ubuntu Server 24.04

Boot the VM from the Ubuntu Server ISO and follow the installer. Key choices during setup:

- **Language and keyboard** - set to your preference
- **Network** - leave as DHCP for now, static IP is configured after install
- **Storage** - use the entire disk, no LVM required for this lab
- **Profile setup** - set a username and password, note them down
- **SSH** - enable OpenSSH server when prompted, this allows you to manage the VM remotely from the Windows host
- **Featured snaps** - skip, none are needed

The installer will complete and prompt you to reboot. Remove the ISO before rebooting.

---

## Step 4 - Configure a Static IP

Pi-hole must have a static IP so devices always know where to find it. Ubuntu Server 24.04 uses **Netplan** for network configuration.

Find the name of your network interface:

```bash
ip a
```

It will be something like `eth0` or `ens3`. Then edit the Netplan config file:

```bash
sudo nano /etc/netplan/00-installer-config.yaml
```

Replace the contents with the following, substituting your interface name:

```yaml
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.0.150/24
      routes:
        - to: default
          via: 192.168.0.1
      nameservers:
        addresses:
          - 9.9.9.9
```

Apply the changes:

```bash
sudo netplan apply
```

Verify the static IP was applied:

```bash
ip a
```

You should see `192.168.0.150` assigned to your interface.

---

## Step 5 - Install Pi-hole

Run the official Pi-hole installer:

```bash
curl -sSL https://install.pi-hole.net | bash
```

The installer will open a dialog-based setup. Make the following selections:

| Prompt | Selection |
|--------|-----------|
| Network interface | Select your interface (e.g. eth0) |
| Upstream DNS provider | Quad9 (filtered, DNSSEC) |
| Blocklists | Keep the default StevenBlack list enabled |
| Admin web interface | Yes |
| Web server (lighttpd) | Yes |
| Query logging | Yes |
| Privacy mode | Show everything |

At the end of the install the terminal will display your Pi-hole admin password. **Save this immediately** — it is only shown once. If you lose it you can reset it with:

```bash
pihole -a -p
```

---

## Step 6 - Verify the Web Interface

From any browser on your network open:

```
http://192.168.0.150/admin
```

Log in with the password shown at the end of the installer. You should see the Pi-hole dashboard with the query graph and statistics.

---

## Step 7 - Enable Pi-hole DHCP

Since the D-Link router has DNS handling issues, Pi-hole manages DHCP instead. This ensures every device on the network automatically uses Pi-hole for DNS without any manual configuration.

**First, disable DHCP on your router:**

Log into the D-Link router at `http://192.168.0.1` and disable the DHCP server in the network settings. The exact location varies by model but is usually under Setup > Network Settings.

**Then enable DHCP in Pi-hole:**

In the Pi-hole admin dashboard go to **Settings > DHCP** and:

- Enable the DHCP server
- Set the IP range (for example `192.168.0.10` to `192.168.0.200`)
- Set the router gateway to `192.168.0.1`
- Save settings

After this, devices that reconnect to the network will receive their IP address and DNS configuration directly from Pi-hole.

---

## Step 8 - Test That Blocking Works

From any device on the network open a browser and visit:

```
http://pi.hole/admin
```

If that loads, DNS is working. To verify blocking is active you can visit a known ad-heavy site and check the Pi-hole dashboard query log to see blocked domains appearing in red.

You can also run a quick DNS test from the command line on any machine:

```bash
nslookup doubleclick.net 192.168.0.150
```

A blocked domain should return `0.0.0.0` or NXDOMAIN. An allowed domain should return a real IP address.

---

## Common Issues

**Pi-hole dashboard not loading**
Check that the lighttpd web server is running:
```bash
sudo systemctl status lighttpd
```
If it is stopped, start it with `sudo systemctl start lighttpd`.

**Devices not getting IP addresses after enabling Pi-hole DHCP**
Make sure the router's DHCP server is fully disabled before enabling Pi-hole's. Having two DHCP servers on the same network causes conflicts. Reconnect devices or renew their DHCP lease after the change.

**Pi-hole blocking something it should not**
Log into the admin dashboard, find the blocked domain in the query log, and add it to the whitelist under **Whitelist** in the sidebar.

**Static IP not applying after netplan apply**
Double-check the YAML indentation — Netplan is sensitive to spacing. Each level must use exactly 2 spaces. Tabs are not allowed.

**Lost the admin password**
Reset it from the terminal:
```bash
pihole -a -p
```

---

## References

- [Ubuntu Server 24.04 Download](https://ubuntu.com/download/server)
- [Pi-hole Installation Documentation](https://docs.pi-hole.net/main/basic-install/)
- [Pi-hole DHCP Setup](https://docs.pi-hole.net/guides/misc/dhcp/)
- [Netplan Documentation](https://netplan.io/reference)
