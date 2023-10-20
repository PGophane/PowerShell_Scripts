If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell    
}
cls
$sites = Get-SPSite "<Site URL>"
foreach ($spWeb in $sites.AllWebs) 
{
    Write-Host $spWeb
    #$webLists = $web.Lists

    foreach ($list in ($spWeb.Lists | ? {$_ -is [Microsoft.SharePoint.SPDocumentLibrary]})) {
        Write-Host "Scanning List: $($list.RootFolder.ServerRelativeUrl)"
        foreach ($item in $list.CheckedOutFiles) {
            if (!$item.Url.EndsWith(".aspx")) { continue }
            $writeTable = @{
            "URL"=$spWeb.Site.MakeFullUrl("$($spWeb.ServerRelativeUrl.TrimEnd('/'))/$($item.Url)");
            "Checked Out By"=$item.CheckedOutBy;
	    "Author"=$item.File.CheckedOutByUser.Name;
            "Checked Out Since"=$item.CheckedOutDate.ToString();	    
	    "Email"=$item.File.CheckedOutByUser.Email;
            }
            New-Object PSObject -Property $writeTable
        }
        foreach ($item in $list.Items) {
            if ($item.File.CheckOutStatus -ne "None") {
                if (($list.CheckedOutFiles | where {$_.ListItemId -eq $item.ID}) -ne $null) { continue }
                $writeTable = @{
                    "URL"=$spWeb.Site.MakeFullUrl("$($spWeb.ServerRelativeUrl.TrimEnd('/'))/$($item.Url)");
                    "Checked Out By"=$item.File.CheckedOutByUser.LoginName;
                    "Author"=$item.File.CheckedOutByUser.Name;
                    "Checked Out Since"=$item.File.CheckedOutDate.ToString();                    
                    "Email"=$item.File.CheckedOutByUser.Email;
                }
                New-Object PSObject -Property $writeTable
            }
        }
    }
    }
    $writeTable |Select URL,'Checked Out By',Author, 'Checked Out Since' | Export-csv "D:\Daily Reports\checkedOutItems.csv" -NoTypeInformation;
   