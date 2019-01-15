#Requires –Modules ActiveDirectory
<#
.Synopsis
   Gets all servers
.DESCRIPTION
   Gets ADComputer object and returns anything that has "server" in its operating system property. Needs to be run on a domain controller 2008 and above.
.EXAMPLE
   get-Servers
#>
function Get-Servers
{
    $servers = Get-adcomputer -Filter {OperatingSystem -like "*Server*"}
    $liveServer = @()
    Foreach($serv in $servers){
        if(Test-Connection $serv.name -Count 2 -Quiet){
            $liveServer += $serv.name
        }
    }
    return $liveServer
}