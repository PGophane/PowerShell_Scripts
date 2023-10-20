if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
 {
     Add-PSSnapin Microsoft.SharePoint.PowerShell
 }
 cls
 $sitelogo="/_layouts/15/Images/logo.png"

$Site="<Site URL>"

$Sites=new-object Microsoft.SharePoint.SPSite($Site)

foreach($web in $Sites.Allwebs) 
{
    Write-Host $web.Title
    $web.SiteLogoUrl=$sitelogo
    $web.Update()
}

$Sites.Dispose()
write-host "DONE !!!"
