If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell
}

$site = Get-SPSite "<Site URL>"
$siteId = $site.Id
$siteDatabase = $site.ContentDatabase 

Remove-SPContentDatabase $siteDatabase