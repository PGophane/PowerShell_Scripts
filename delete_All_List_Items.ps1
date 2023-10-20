If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell    
}
cls

$webSite =  Get-SPWeb "<Site URL>"
$spList = $webSite.Lists["<List Name>"] 

foreach ($item in $spList.items)
{
    $deaditem=$splist.GetItemById($item.ID)
    $deaditem.Delete()
}
write-host "DONE !!!"
