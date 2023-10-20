If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell    
}

cls
$siteUrl = "<Site URL>"
$sites = Get-SPSite $siteUrl 
$properties = @{status='';siteUrl='';webUrl='';ListTitle='';ItemID='';ItemTitle='';ItemUrl='';}; 
$Items = @();  

foreach ($web in $sites.AllWebs) 
{
    
    #Write-Host $web "-------------------------------------------------------"
        
    $webLists = $web.Lists

    for ($i = 0; $i -lt $webLists.Count; $i++)
    {
        $list = $web.Lists[$i];         

        if($list.Title -ne "Content and Structure Reports" -AND 
        $list.Title -ne "Master Page Gallery" -AND
        $list.Title -ne "Pages" -AND
        $list.Title -ne "Reusable Content" -AND
        $list.Title -ne "Site Assets" -AND
        $list.Title -ne "Site Collection Documents" -AND
        $list.Title -ne "Site Collection Images" -AND
        $list.Title -ne "Site Pages" -AND
        $list.Title -ne "Style Library" -AND
        $list.Title -ne "Web Part Gallery" -AND
        $list.Title -ne "Workflow Tasks" -AND
        $list.Title -ne "Composed Looks" -AND
        $list.Title -ne "appdata" -AND
        $list.Title -ne "Cache Profiles" -AND
        $list.Title -ne "Device Channels" -AND
        $list.Title -ne "List Template Gallery" -AND
        $list.Title -ne "Notification List" -AND
        $list.Title -ne "Project Policy Item List" -AND
        $list.Title -ne "Quick Deploy Items" -AND
        $list.Title -ne "Relationships List" -AND
        $list.Title -ne "Solution Gallery" -AND
        $list.Title -ne "TaxonomyHiddenList" -AND
        $list.Title -ne "Theme Gallery" -AND
        $list.Title -ne "Translation Packages" -AND
        $list.Title -ne "Translation Status" -AND
        $list.Title -ne "User Information List" -AND
        $list.Title -ne "Variation Labels" -AND
        $list.Title -ne "Web Part Gallery" -AND
        $list.Title -ne "wfpub" -and
        $list.Title -ne "Images" -and
        $list.Title -ne "Get Started with Microsoft SharePoint Foundation!" -and        
        $list.Title -ne "Get Started with Microsoft SharePoint Foundation!" -AND
        $list.Title -ne "Reporting Templates" -AND
        $list.Title -ne "Reporting Metadata" -AND
        $list.Title -ne "Workflows" -AND
        $list.Title -ne "Form Templates" -AND
        $list.Title -ne "Converted Forms" -AND
        $list.Title -ne "Publishing Images" -AND
        $list.Hidden -ne $true -and
        $list.BaseType -eq "DocumentLibrary"
        )
        {
        foreach ($item in $list.Items) {        
        if ($item.File.CheckOutStatus -ne "None") 
        {
            $details = New-Object -TypeName PSObject -Property $properties;  
            $details.status = "CheckedOut"
            $details.SiteUrl =$siteUrl;  
            $details.webUrl = $web.Url
            $details.ListTitle = $list.Title
            $details.ItemID = $item.ID
            $details.ItemTitle =  $item.Title 
            $details.ItemUrl = $item.Url
            $Items +=$details; 
        }
        if($item.Level -ne "Published")
        {  
            $details = New-Object -TypeName PSObject -Property $properties;  
            $details.status = "Draft"
            $details.SiteUrl =$siteUrl;  
            $details.webUrl = $web.Url
            $details.ListTitle = $list.Title
            $details.ItemID = $item.ID
            $details.ItemTitle =  $item.Title 
            $details.ItemUrl = $item.Url
            $Items +=$details; 
        }
        }
    }
  }
}
$Items | select status,SiteUrl,webUrl,ListTitle,ItemID,ItemTitle,ItemUrl | Export-csv "D:\Daily Reports\Unpublished_Items.csv" -NoTypeInformation;
