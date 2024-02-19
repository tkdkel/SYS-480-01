# Getting information to clone VM
Get-VM
$originalvm = Read-Host -prompt "Enter the name of the VM you want to clone."
$vm = Get-VM -Name $originalvm
$snapshot = Get-Snapshot -VM $vm -Name "base"
$hostserver = Read-Host -prompt "Enter the IP of your VM host server."
$vmhost = Get-VMHost -Name $hostserver
$dsname = Read-Host -prompt "Enter the name of the Datastore you want to use (ex. datastore-super#)."
$ds = Get-DataStore -Name $dsname
$linkedClone = "{0}.linked" -f $vm.name

# Creating linked clone
$linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $ds
$clonename = Read-Host -prompt "Enter the name for your cloned VM."
$newvm = New-VM -Name $clonename -VM $linkedvm -VMHost $vmhost -Datastore $ds

# Creating new snapshot and removing temp clone
$newvm | New-Snapshot -Name "base"
$linkedvm | Remove-VM
