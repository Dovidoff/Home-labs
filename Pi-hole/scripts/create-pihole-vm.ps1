# ---------------------------------------------------------------
# -------- Create a Single Hyper-V Virtual Machine --------------
# ---------------------------------------------------------------

$VMName     = "pihole-vm"
$VMPath     = "D:\Hyper-V\VMs"
$ISOPath    = "D:\ISO\ubuntu-server.iso"
$SwitchName = "vSwitch-External"

$Memory     = 1GB
$CPUCount   = 1
$DiskSize   = 32GB

$VMPPath = Join-Path -Path $VMPath -ChildPath $VMName
New-Item -ItemType Directory -Path $VMPPath -Force | Out-Null

New-VM -Name $VMName `
       -Generation 2 `
       -MemoryStartupBytes $Memory `
       -NewVHDPath "$VMPPath\$VMName.vhdx" `
       -NewVHDSizeBytes $DiskSize `
       -Path $VMPPath `
       -SwitchName $SwitchName

Set-VMProcessor -VMName $VMName -Count $CPUCount

Add-VMDvdDrive -VMName $VMName -Path $ISOPath

$DvdDrive = Get-VMDvdDrive -VMName $VMName
Set-VMFirmware -VMName $VMName -FirstBootDevice $DvdDrive

Set-VMFirmware -VMName $VMName -EnableSecureBoot Off
