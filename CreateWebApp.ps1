If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell
}
cls

$ap = New-SPAuthenticationProvider -UseWindowsIntegratedAuthentication -DisableKerberos 

$dbName = "Uat_sp2013"
$WebAppURL = "<Web App URL>"
$NewAppPoolName = "nat.domain.com"
$NewAppPoolUserName = "domain\farmadminuat"

$Farm = Get-SPFarm
$Service = $Farm.Services | where {$_.TypeName -eq "Microsoft SharePoint Foundation Web Application"}
$Password = "<password>"
$NewAppPool = New-Object Microsoft.SharePoint.Administration.SPApplicationPool($NewAppPoolName,$Service)
$NewAppPool.CurrentIdentityType = "SpecificUser"
$NewAppPool.Username = $NewAppPoolUserName
$NewAppPool.SetPassword($Password)
$NewAppPool.Provision()
$NewAppPool.Update($true)


New-SPWebApplication -Name $NewAppPoolName -ApplicationPool $NewAppPoolName -HostHeader $NewAppPoolName -Port 80 -Url $WebAppURL -AuthenticationMethod NTLM -AuthenticationProvider $ap -DatabaseName $dbName

Get-SPContentDatabase -WebApplication $WebAppURL | Set-SPContentDatabase -MaxSiteCount 1 -WarningSiteCount 0
