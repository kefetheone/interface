# Version    Modified_by      Date
#   0.1      donnerk       2018-04-24

# Description: This script will archive the 10kft projects listed in [interface].[dbo].[vw_ArchiveProjectsOn10kft] view

CLS

#-- URL of the EndPoint --#
$url = 'https://api.10000ft.com/api/v1/projects/'

#API key - donnerk/trial
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("auth", 'SW9wWUtLTE5GbzN4QUVlUFJJN0RLTFJ5Y25DemRkV0UvK1I4Z2pVd2p3T1ljVUpIU3pSMEwwYTM3VnZwCmJySGM3QUlOYkFjVHV6YXhwYWJFNkJUeW5wbVpjaUpYRkl1N2YvWi9pMjBlMi9NQTYxVXVQWUpvZnIyQwprVzFaNHdQego=')

#--Establishing connection to SQL Server --# 
$InstanceName = "192.168.224.6"
$connectionString = "Server=$InstanceName;Database=interface;Integrated Security=False;User ID=interface;Password=Int3rf4ce"
 
#--Main Query --# 
$query = "SELECT [id] FROM [interface].[dbo].[vw_ArchiveProjectsOn10kft]"
 
#--Connect SQL Server --#
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$connection.Open()

#--Execute SQL Query --#
$command = $connection.CreateCommand()
$command.CommandText = $query
$result = $command.ExecuteReader()

#--Play with the data --#
$table = new-object "System.Data.DataTable"
$table.Load($result)

#--API REST call for each row in the table --#
foreach ($row in $table) {
    $project_id=$row.Item(0)|ConvertFrom-Json
    $url = 'https://api.10000ft.com/api/v1/projects/'+$project_id
    #REST call
    $url
    $r=Invoke-WebRequest -Uri $url -Method PUT -Headers $headers -ContentType application/json -Body '{"archived":true}'
}
 
#--Close SQL Connection
$connection.Close()