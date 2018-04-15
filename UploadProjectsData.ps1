#--Exporting SQL Server table to JSON --#
 
cls
 
#--Establishing connection to SQL Server --# 
$InstanceName = "192.168.224.6"
$connectionString = "Server=$InstanceName;Database=interface;Integrated Security=False;User ID=interface;Password=Int3rf4ce"
 
#--Main Query --# 
$query = "SELECT * FROM NewProjectsTo10kFT_V"
 
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
 
$connection.Open()
$command = $connection.CreateCommand()
$command.CommandText = $query
 
$result = $command.ExecuteReader()
 
$table = new-object "System.Data.DataTable"
 
$table.Load($result)

#--Exporting data to the screen --# 
$table | select $table.Columns.ColumnName | ConvertTo-Json
#$table | format-table
#foreach ($row in $table) {$row}
 
$connection.Close()