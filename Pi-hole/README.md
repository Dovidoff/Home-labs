
# Pi-hole Home Lab

Homelab project to learn and test Pi-hole, a network wide ad blocker that uses the DNS based blocking technique. Rather than the usual Raspberry Pi setup, we’re running Pi-hole in a virtual machine on a Windows VM host via Hyper-V.

The aim of this exercise is to explore the principles of DNS filtering, learn how to introduce a virtualised network environment and manage Pi-hole in a controlled laboratory. This guide is based on and refers to the [official Pi-hole documentation](https://docs.pi-hole.net/).

---

## Why Pi-hole?

Pi-hole is a DNS sinkhole that protects devices on your network from unwanted content, without having to install any software directly on them.

What makes it useful:

- Blocks ads and trackers before they load, also makes browsing feel faster through DNS caching.
- Compatible with all web browsers, smart TVs, mobile phones and tablets as well as game consoles.
- Works as a DHCP server. Every device on your network receives protection (so all of those mobile devices and laptops are already being checked for harmful websites).
- Periodic auto-updates receive these directly from our servers in the cloud.
- Provides complete visibility of DNS traffic via a web dashboard.
- It should be fast: being lightweight enough to run on a Raspberry Pi and able to handle hundreds of millions of Queries Per Second (QPS) on modest server hardware.
- Supports both IPv4 and IPv6.
- Free and open source.

---

## Project Structure

```
Pi-hole/
├── docs/
│   ├── Installation.md            # Step-by-step installation guide
│   ├── pihole.md                  # How Pi-hole works; DNS, sinkholes, blocklists
│   ├── network.md                 # Network design and topology
│   ├── virtualization.md          # Hyper-V VM setup
│   └── NetworkDiagram.drawio.svg  # Visual network diagram
├── scripts/
│   ├── create-pihole-vm.ps1       # Creates the Pi-hole VM in Hyper-V
│   └── create-v-switch.ps1        # Creates the Hyper-V virtual switch
└── README.md
```

---

## Quick Start

**Prerequisites:** Windows 10/11 with Hyper-V enabled, PowerShell as Administrator, Ubuntu Server ISO.

```powershell
# 1. Create the virtual switch
.\scripts\create-v-switch.ps1

# 2. Create the VM
.\scripts\create-pihole-vm.ps1
```

Then after booting the VM and setting up Linux, install Pi-hole:

```bash
curl -sSL https://install.pi-hole.net | bash
```

See [docs/Installation.md](docs/Installation.md) for the full walkthrough.

---

## Documentation

| Document | Description |
|----------|-------------|
| [Installation.md](docs/Installation.md) | Full installation walkthrough |
| [pihole.md](docs/pihole.md) | How Pi-hole works; DNS, sinkholes, blocklists explained |
| [network.md](docs/network.md) | Network design, topology, and configuration |
| [virtualization.md](docs/virtualization.md) | Hyper-V VM setup and configuration |

---

## Lab Environment

| Component | Details |
|-----------|---------|
| Hypervisor | Microsoft Hyper-V |
| Guest OS | Ubuntu Server |
| Purpose | Learning and testing |

---

## References

- [Pi-hole Official Website](https://pi-hole.net/)
- [Pi-hole Documentation](https://docs.pi-hole.net/)
- [Pi-hole Community](https://discourse.pi-hole.net/)
- [Pi-hole GitHub](https://github.com/pi-hole/pi-hole)

---

*This project is for educational and home lab purposes only.*
