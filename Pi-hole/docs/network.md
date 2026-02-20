# Network

<div align="center">

<img src="NetworkDiagram.drawio.svg" alt="Network Diagram" width="500"/>

</div>

# Network Design and Configuration

This document describes the network topology, IP addressing, and key design decisions for the Pi-hole home lab. For a visual overview see the [network diagram](NetworkDiagram.drawio.svg).

---

## Topology

The router handles internet access only. Pi-hole acts as both the DNS server and DHCP server for all devices on the network — wired and wireless.

```
Internet
    |
  Router (D-Link) — gateway only
  192.168.0.1
    |
  Network Switch
    |
  Hyper-V Host
  192.168.0.100
    |
  Pi-hole VM — DNS + DHCP
  192.168.0.150
```

---

## IP Address Scheme

| Device | Role | IP Address |
|--------|------|------------|
| Router (D-Link) | Gateway / internet access | 192.168.0.1 |
| Hyper-V Host | Windows host machine | 192.168.0.100 |
| Pi-hole VM | DNS + DHCP server | 192.168.0.150 |
| Network devices | Assigned by Pi-hole | 192.168.0.x |

Pi-hole has a static IP. A DNS and DHCP server must always be reachable at the same address.

---

## Why Pi-hole Handles DHCP

The router normally handles DHCP and tells devices which DNS server to use. The D-Link router used in this lab has DNS handling issues that caused it to interfere with and bypass the Pi-hole configuration.

Moving DHCP to Pi-hole solves this cleanly — Pi-hole assigns IP addresses directly to devices and tells them to use itself as DNS. The router is no longer involved in DNS at any point.

The trade-off is that if the Pi-hole VM goes offline, devices cannot get an IP address and lose network access. This is acceptable in a lab environment.

---

## Upstream DNS

Allowed queries are forwarded to **Quad9 (9.9.9.9)**. Quad9 was chosen because it blocks known malicious domains at the resolver level, supports DNSSEC to protect against DNS spoofing, and does not log or sell query data — a good fit alongside Pi-hole's own blocklists.

---

## DNS Query Flow

1. Device sends a DNS query to Pi-hole (192.168.0.150)
2. Pi-hole checks the domain against its blocklists
3. **Blocked** — returns NXDOMAIN, no connection is made
4. **Allowed** — query forwarded to Quad9, real IP returned to device
5. Device connects and content loads

---

## Hyper-V Virtual Switch

The Pi-hole VM needs to be reachable by all devices on the physical network, not just the Hyper-V host. An external virtual switch in Hyper-V bridges the VM's network adapter to the host's physical adapter, making Pi-hole appear as a regular device on the network at 192.168.0.150.

See [virtualization.md](virtualization.md) for setup details.

---

## Planned Expansion

The next step is connecting physical wired devices through the switch to verify that DHCP leases are assigned correctly, DNS filtering works for wired clients, and per-device blocking rules behave as expected. New devices will appear automatically in the Pi-hole dashboard once connected.

---

## References

- [Pi-hole DHCP documentation](https://docs.pi-hole.net/guides/misc/dhcp/)
- [Quad9 DNS](https://www.quad9.net/)
- [Hyper-V virtual switch — Microsoft](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/get-started/create-a-virtual-switch-for-hyper-v-virtual-machines)
