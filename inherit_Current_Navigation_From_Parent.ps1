if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
 {
     Add-PSSnapin Microsoft.SharePoint.PowerShell
 }
 
 $sites = Get-SPSite "<Site URL>"

foreach ($web in $sites.AllWebs) 
  {
    $web.AllowUnsafeUpdates = $true
    $puWeb = [Microsoft.SharePoint.Publishing.PublishingWeb]:: GetPublishingWeb($web);
    $puWeb.Navigation.InheritGlobal = $true
    $puWeb.Navigation.InheritCurrent = $true
    $puWeb.Update()    
    $web.Update()    
}
write-host 'DONE !!!!'