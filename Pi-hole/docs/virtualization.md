# Virtualization


## Virtualization Architecture

```mermaid
graph TB
    HyperV[Hyper-V Hypervisor]

    VSwitch[External Virtual Switch]

    VM[Virtual Machine: pihole-vm]

    subgraph VM_Resources["VM Resources"]
        vCPU[2 vCPU]
        RAM[2 GB RAM]
        Disk["32 GB Disk"]
        vNIC[Virtual NIC]
    end

    GuestOS[Ubuntu]
    PiHole[Pi-hole DNS Service]
    Network["Physical Network (LAN)"]

    HyperV --> VM
    VM --> VM_Resources
    VM_Resources --> GuestOS
    GuestOS --> PiHole

    vNIC --> VSwitch
    VSwitch --> Network
```

## Prerequisites

### Source
Requirements are based on the official [Pi-hole Documentation](https://docs.pi-hole.net/main/prerequisites/).

### Hardware Requirements
- **Disk Space**: Minimum 2GB, 4GB recommended
- **RAM**: Minimum 512MB
- **CPU**: Any modern processor (very lightweight)

*Note: These are the minimum requirements from Pi-hole. For our VM, we'll allocate more resources.*

## How to create VM and V-Switch
The Pi-hole virtual machine and the virtual switch are created using a PowerShell script.

- [Create External Virtual Switch](../scripts/create-v-switch.ps1)
- [Create Pi-hole Virtual Machine](../scripts/create-pihole-vm.ps1)

These scripts automate the Hyper-V configuration and ensure a consistent setup.

