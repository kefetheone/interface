# Version    Modified_by      Date
#   0.1      donnerk       2018-04-26

# Description: This script will update the 10kft users' details from [interface].[dbo].[vw_UpdateUsersOn10kft] view

CLS

#-- URL of the EndPoint --#
$url = 'https://api.10000ft.com/api/v1/users'

#API key - donnerk/trial
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("auth", 'SW9wWUtLTE5GbzN4QUVlUFJJN0RLTFJ5Y25DemRkV0UvK1I4Z2pVd2p3T1ljVUpIU3pSMEwwYTM3VnZwCmJySGM3QUlOYkFjVHV6YXhwYWJFNkJUeW5wbVpjaUpYRkl1N2YvWi9pMjBlMi9NQTYxVXVQWUpvZnIyQwprVzFaNHdQego=')

#--Establishing connection to SQL Server --# 
$InstanceName = "192.168.224.6"
$connectionString = "Server=$InstanceName;Database=interface;Integrated Security=False;User ID=interface;Password=Int3rf4ce"
 
#--Main Query --# 
$query = "SELECT * FROM [interface].[dbo].[vw_UpdateUsersOn10kft]"
 
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
    $user_id=$row.Item(0)
    $body=$row.Item(2)
    $url = 'https://api.10000ft.com/api/v1/users/'+$user_id
    #REST call
    $url+' '+$body
    $r=Invoke-WebRequest -Uri $url -Method PUT -Headers $headers -UseBasicParsing -ContentType application/json -Body $body
}
 
#--Close SQL Connection
$connection.Close()