CLS

#-- URL of the EndPoint --#
$url = 'https://api.10000ft.com/api/v1/users'

#API key - donnerk/trial
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("auth", 'SW9wWUtLTE5GbzN4QUVlUFJJN0RLTFJ5Y25DemRkV0UvK1I4Z2pVd2p3T1ljVUpIU3pSMEwwYTM3VnZwCmJySGM3QUlOYkFjVHV6YXhwYWJFNkJUeW5wbVpjaUpYRkl1N2YvWi9pMjBlMi9NQTYxVXVQWUpvZnIyQwprVzFaNHdQego=')

#$content = ([System.Text.Encoding]::UTF8.GetBytes($json_str))

#--Establishing connection to SQL Server --# 
$InstanceName = "192.168.224.6"
$connectionString = "Server=$InstanceName;Database=interface;Integrated Security=False;User ID=interface;Password=Int3rf4ce"
 
#--Main Query --# 
$query = "SELECT [10kft_id],[JSON_STR] FROM [interface].[dbo].[UserSkillsTo10kft_V] WHERE JSON_STR IS NOT NULL"
 
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
    $url = 'https://api.10000ft.com/api/v1/users/'+$row.Item(0)+'/tags'
    $body = $row.Item(1)
    #$content = ([System.Text.Encoding]::UTF8.GetBytes($row.Item(0)))
    $url
    $body
    #REST call
    $r=Invoke-RestMethod -Uri $url -Method POST -Headers $headers -ContentType application/json -Body $body
}
 
#--Close SQL Connection
$connection.Close()
