
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

Start-AzContainerGroup -Name $aci -ResourceGroupName $rg

$vmList = Get-AzVM  -ResourceGroupName $rg -Status | Where-Object { $_.Tags['enabled'] -eq $true}

#VM running or VM deallocated
ForEach ($vm in $vmList){
	if ($vm.PowerState -eq "VM deallocated") {
		Start-AzVM -Name $vm.Name -ResourceGroupName $rg
	}
}