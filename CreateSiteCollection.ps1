If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell
}

$dbname = "Uat_sp2013_DBUAT"
$webapp = "<Web App URL>"
$site = "<Site URL to Create>"
$owner1 = "domain\t007228"
$owner2 = "domain\farmadminpro"
$template = "STS#0"
$managedPath = "center"
$siteName = "center"


 New-SPContentDatabase -name $dbname -WebApplication $webapp

 # New-SPManagedPath -RelativeURL $managedPath -WebApplication $webapp -Explicit

# New-SPManagedPath $managedPath -WebApplication $webapp

New-SPSite -URL $site -OwnerAlias $owner1 -SecondaryOwnerAlias $owner2 -ContentDatabase $dbname -Name $siteName -Template $template  | out-null

Get-SPContentDatabase -Site $site | Set-SPContentDatabase -MaxSiteCount 1 -WarningSiteCount 0

