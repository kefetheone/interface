Function Add-APIData ($server, $database, $text)
{
   $scon = New-Object System.Data.SqlClient.SqlConnection
   $scon.ConnectionString = "SERVER=$server;DATABASE=$database;Integrated Security=true"

   $cmd = New-Object System.Data.SqlClient.SqlCommand
   $cmd.Connection = $scon
   $cmd.CommandText = $text
   $cmd.CommandTimeout = 0

   $scon.Open()
   $cmd.ExecuteNonQuery()
   $scon.Close()
   $cmd.Dispose()
   $scon.Dispose()
}


$url = 'https://api.10000ft.com/api/v1/users'


$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("auth", 'TzlBYmNCTG1idnkrRE11V1BLQVZjMnZpWkpLZTJVSkpIRjFxTXdNVFEwSklybVpGOHhiQ3dVMnZuOUtsClY5NmdZTklPbHVKaGxMQnNRc2NIMHJiUHJsaFZHSWFkR1hUbCtndVFtOVRJQWNJM1BiWmVKelExYUZmTgpzNDJ3c1p2ZAo=')

#REST hívás , válasz megy egy helyi fájlba
$r=Invoke-RestMethod -Uri $url -Method GET -Headers $headers -OutFile 'C:\teszt\response.json' -ContentType "application/json; charset=utf-8"

#válasz fájl beolvasás
$json_response = Get-Content C:\teszt\response.json -Encoding UTF8

$result = Convertfrom-json $json_response
$add = @()

foreach($b in $result.data)
{
$add += "INSERT INTO insertFromJson VALUES('"+$b.id +"','"+$b.first_name+"','"+$b.last_name+"')"+$nl
}
#$add

if ($b.value -ne ".")
{
$add += "INSERT INTO insertFromJson VALUES ('"+$b.id +"','"+$b.first_name+"','"+$b.last_name+"')" + $nl
}
$add


Add-APIData -server SQL2017DEV\SQL2017DEV -database "DevEnv" -text $add

#insertFromJson (id int, first_name varchar(90), last_name varchar(90))