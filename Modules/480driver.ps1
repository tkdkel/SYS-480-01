Import-Module '480-utils' -Force
# Call Banner Function
480Banner
$conf=Get-480Config -config_path "/home/kel/SYS-480-01/Modules/480-utils/480.json"
Connect-480 -server 'vcenter.kel.local'

if ($global:DefaultVIServer){
    #Menu
    Write-Host -ForegroundColor Cyan "1. Clone a VM"
    Write-Host -ForegroundColor Red "2. Delete a VM"
    Write-Host -ForegroundColor Cyan "3. Switch A VM's Network"
    Write-Host -ForegroundColor Cyan "4. Edit Powerstate of a VM"
    Write-Host -ForegroundColor Red "5. Disconnect from the server"
    Write-Host -ForegroundColor Cyan "6. Create a Virtual Switch (To be implemented)"
    Write-Host -ForegroundColor Cyan "7. Check Network Information (To be implemented)"
    Write-Host -ForegroundColor DarkRed "8. Exit"

    $ans = Read-Host "Select an option:"

    if($ans -eq 1){
        CreateClone
    }
    if($ans -eq 2){
        Terminate-VM
    }
    if($ans -eq 3){
        changeNetwork
    }
    if($ans -eq 4){
        editPower
    }
    if($ans -eq 5){
        Disconnect-480
    }
    if($ans -eq 6){
        New-Network
    }
    if($ans -eq 7){
        Get-NetworkInfo
    }
    if($ans -eq "exit" -or $ans -eq "8"){
        exit
    }
    else{
        continue
    }

}
else {
    Write-Host -ForegroundColor Red "Not connected to a server"
    Read-Host "Would you like to connect to a server? (y/n)"
    if($ans -eq "y"){
        Connect-480 -server $conf.vcenter
    }
    else{
        exit
    }
}