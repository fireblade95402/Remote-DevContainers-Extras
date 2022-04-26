
$rg = "<rg>"
$aci = "<aci>"

try
{
    "Logging in to Azure..."
    Connect-AzAccount -Identity
}
catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}


$vmList = Get-AzVM  -ResourceGroupName $rg -Status

#VM running or VM deallocated

ForEach ($vm in $vmList){
	if ($vm.PowerState -eq "VM running") {
		Stop-AzVM -Name $vm.Name -ResourceGroupName $rg -Force
	}
}
Stop-AzContainerGroup -Name $aci -ResourceGroupName $rg
