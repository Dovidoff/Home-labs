# 1) Find the physical network adapter name (pick the one connected to your LAN)
Get-NetAdapter 

# 2) Create an External vSwitch (replace "Ethernet" with your adapter name)
$SwitchName = "vSwitch-External"
$NetAdapterName = "Ethernet"

New-VMSwitch -Name $SwitchName -NetAdapterName $NetAdapterName -AllowManagementOS $true

# Verify
Get-VMSwitch 
