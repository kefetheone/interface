#UsersQuery.ps1

CLS

$url = 'https://api.10000ft.com/api/v1/users'
$response_file = 'c:\temp\Response_UsersQuery.json'

#API key - donnerk/trial
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("auth", 'SW9wWUtLTE5GbzN4QUVlUFJJN0RLTFJ5Y25DemRkV0UvK1I4Z2pVd2p3T1ljVUpIU3pSMEwwYTM3VnZwCmJySGM3QUlOYkFjVHV6YXhwYWJFNkJUeW5wbVpjaUpYRkl1N2YvWi9pMjBlMi9NQTYxVXVQWUpvZnIyQwprVzFaNHdQego=')

$body = @{
    "per_page" = 500
}
#    "fields" = "tags"

$r=Invoke-WebRequest -Uri $url -Method GET -Headers $headers -Body $body -OutFile $response_file

$json_response = Get-Content $response_file
$json_response_obj = ConvertFrom-Json ($json_response -join "`n")

foreach ($uid in $json_response_obj.data.id){
    if ($uid -ne 439288)
    {
        $url = 'https://api.10000ft.com/api/v1/users/'+$uid
        $url
        #$r=Invoke-WebRequest -Uri $url -Method PUT -Headers $headers -ContentType application/json -Body '{"archived":true}'
    }
    else
    {
    $uid
    }
}

echo '-- end --'