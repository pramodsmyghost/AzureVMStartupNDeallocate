<#
    .SYNOPSIS
        This script will start the VMs.
    
    .DESCRIPTION
        This script is used in MI Subscription to start the VMs deployed in given resource groups.
     
    .NOTES
        File          :    InfraDeployment.ps1
        Author        :    P V Pramod Reddy
        Company       :    LTI
        Email         :    pramodreddy.p.v@lntinfotech.com
        Created       :    03-10-2018
        Last Updated  :    03-10-2018
        Version       :    1.0

    .INPUTS
        None
#>

Param(

    [Parameter(Mandatory= $true)]  
    [PSCredential]$AzureOrgIdCredential,

    [Parameter(Mandatory= $true)]
    [string]$SubcriptionID = "bb3d0ed0-bf9b-442d-83d5-3b059843dd52",

    [Parameter(Mandatory= $true)]
    [string[]]$ResourceGroups

)

$Null = Login-AzureRMAccount -Credential $AzureOrgIdCredential  
$Null = Get-AzureRmSubscription -SubscriptionID $SubcriptionID | Select-AzureRMSubscription

$ErrorActionPreference = "Continue"

$VMDetails = $Null

foreach ($RG in $ResourceGroups)
{
    $VMDetails += Get-AzureRmVM -ResourceGroupName $RG
}

foreach ($VM in $VMDetails)
{
    $Null = Start-AzureRmVM -Name $VM.Name -ResourceGroupName $VM.ResourceGroupName
    Write-Host "The VM $($VM.Name) has been started"
}