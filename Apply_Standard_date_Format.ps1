If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell    
}
cls
$sites = Get-SPSite "<Site URL>"
$created = "Created"
$modified = "Modified"

#Write-Host $sites.AllWebs.Count

  foreach ($web in $sites.AllWebs) 
  {
      Write-Host $web
    $webLists = $web.Lists

    for ($i = 0; $i -lt $webLists.Count; $i++)
    {
        $list = $web.Lists[$i];  
        
        $column = $list.Fields[$created]
        $column.FriendlyDisplayFormat = "1"
        $column.Update()

        $column = $list.Fields[$modified]
        $column.FriendlyDisplayFormat = "1"
        $column.Update() 
    }     
  }
 Write-Host "DONE...."
