#ArchiveUser.ps1

Param([string]$user_id)

$url = 'https://api.10000ft.com/api/v1/users/'+$user_id

#API key - donnerk/trial
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("auth", 'SW9wWUtLTE5GbzN4QUVlUFJJN0RLTFJ5Y25DemRkV0UvK1I4Z2pVd2p3T1ljVUpIU3pSMEwwYTM3VnZwCmJySGM3QUlOYkFjVHV6YXhwYWJFNkJUeW5wbVpjaUpYRkl1N2YvWi9pMjBlMi9NQTYxVXVQWUpvZnIyQwprVzFaNHdQego=')

#REST call
$r=Invoke-WebRequest -Uri $url -Method PUT -Headers $headers -ContentType application/json -Body '{"archived":true}'

#$json_response = Get-Content C:\Temp\10kFT\Test_UsersData.json
#$json_response_obj = ConvertFrom-Json ($json_response -join "`n")
#$json_response_obj.data
