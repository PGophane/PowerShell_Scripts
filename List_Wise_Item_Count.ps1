If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell    
}

cls
$siteUrl = "<Site URL>"
$sites = Get-SPSite $siteUrl 
$web = Get-SPWeb $siteUrl
$path = "D:\Daily Reports\Item Count\"+$web.Title+"_Item_Count.csv"
$Total_Item_Count = 0 

$properties = @{webUrl='';ListTitle='';Item_Count='';Total_Item_Count='';}; 
$Items = @();  

foreach ($SPWeb in $sites.AllWebs)
{    
    foreach ($list in $SPWeb.Lists)
    {      
        if($list.ItemCount -gt 0 -and $list.BaseType -ne "PictureLibrary" -and
        $list.Title -ne "Content and Structure Reports" -AND 
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
        $list.Hidden -ne $true 
        )
        {   $Total_Item_Count = $Total_Item_Count + $list.ItemCount
            $itemDetails = New-Object -TypeName PSObject -Property $properties;  
            #$itemDetails.webUrl = $SPWeb.URl;  
            #$itemDetails.ListTitle = $list.Title; 
            #$itemDetails.Item_Count = $list.ItemCount 
            $itemDetails.Total_Item_Count = $list.ItemCount 
            $Items +=$itemDetails; 
         }       
    }
    $SPWeb.dispose()     
}
write-host $Total_Item_Count
$sites.dispose()
$web.dispose() 

$Items|Select webUrl,ListTitle,Item_Count,Total_Item_Count | Export-csv $path -NoTypeInformation;
