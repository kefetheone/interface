CLS

#-- URL of the EndPoint --#
$url = 'https://api.10000ft.com/api/v1/users'

#API key - donnerk/trial
#$token = (Invoke-Expression -Command "C:\Users\interface\Documents\powershell\Get_Token.ps1").paramvalue

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("auth", "bE5uUnB5ZzExTkhDM21oTXp0bjVVTmFpMlhpbVZMVmUxVWdhdWdRdHFFc094TTFVMnlTRm1IZkcyOE5QCmNwUStGTGE2eFhOM3hhbjZsb2hWU0QxU0lNWGNjQ0JURzVVemtjamhyOHdJRi9uaUlVNFBQbUE5VmQ5bwp0a2NMVmZLego=")

#$content = ([System.Text.Encoding]::UTF8.GetBytes($json_str))

#--Establishing connection to SQL Server --# 
$InstanceName = "192.168.224.6"
$connectionString = "Server=$InstanceName;Database=interface;Integrated Security=False;User ID=interface;Password=Int3rf4ce"
 
#--Main Query --# 
$query = "SELECT [10kft_id],[JSON_STR] FROM [interface].[dbo].[vw_UserSkillsTo10kft] WHERE JSON_STR IS NOT NULL"
 
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
