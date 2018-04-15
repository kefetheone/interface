#UsersQuery.ps1

$url = 'https://api.10000ft.com/api/v1/users'

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("auth", 'SW9wWUtLTE5GbzN4QUVlUFJJN0RLTFJ5Y25DemRkV0UvK1I4Z2pVd2p3T1ljVUpIU3pSMEwwYTM3VnZwCmJySGM3QUlOYkFjVHV6YXhwYWJFNkJUeW5wbVpjaUpYRkl1N2YvWi9pMjBlMi9NQTYxVXVQWUpvZnIyQwprVzFaNHdQego=')

$body = @{
    "per_page" = 500
}
#    "fields" = "tags"

$r=Invoke-WebRequest -Uri $url -Method GET -Headers $headers -Body $body -OutFile 'c:\temp\Response_UsersQuery.json'

