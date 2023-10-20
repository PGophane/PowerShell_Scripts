If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell    
}

$web = Get-SPWeb <Site URL>
#Write-Host $web

$navigationNodes = $web.Navigation.QuickLaunch 

ForEach ($Node in $NavigationNodes) 
{ 

    if($node.Title -eq "Training") 
    { 
        #$childnode = $node.children | where {$_.Title -contains "DCBT"}             
        #Write-Host $childnode

        ForEach ($n1 in $node.children) 
        {   
            if($n1.Title -like '*DCBT*')
            {
                Write-Host $n1.Title       
                $n1.IsExternal = $true
                $n1.update()
            }
        }

        If($Childnode -eq ""){continue}     

        #[Microsoft.SharePoint.Publishing.Navigation.SPNavigationSiteMapNode]::UpdateSPNavigationNode($ChildNode, $PreviousChild, "Links", $NewURL, "", "", "", $true) 
        #$Childnode.Update();
        $web.web.update()     
    } 

} 

$web.Dispose() 