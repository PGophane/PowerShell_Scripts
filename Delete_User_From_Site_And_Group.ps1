If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell    
}
cls

$URL="<Site URL>"
$userAcc = "domain\U1234"


$site = Get-SPSite $URL

$web = $site.OpenWeb()
$groups = $web.sitegroups

[Microsoft.SharePoint.SPUser]$SPuser = $web.EnsureUser($userAcc)
write-host $SPuser

$ClaimsUserID = (New-SPClaimsPrincipal -identity $userAcc -identitytype 1).ToEncodedString()
#write-host $ClaimsUserID

Get-SPSite $URL | Get-SPWeb | Remove-SPUser $ClaimsUserID -confirm:$false 

foreach ($spgroup in $groups)
{
    write-host $spgroup.Name    
    $spgroup.RemoveUser($SPuser)   
    $spgroup.Update()
}