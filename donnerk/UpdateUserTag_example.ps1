CLS

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
# donnerk token
$headers.Add("auth", 'SW9wWUtLTE5GbzN4QUVlUFJJN0RLTFJ5Y25DemRkV0UvK1I4Z2pVd2p3T1ljVUpIU3pSMEwwYTM3VnZwCmJySGM3QUlOYkFjVHV6YXhwYWJFNkJUeW5wbVpjaUpYRkl1N2YvWi9pMjBlMi9NQTYxVXVQWUpvZnIyQwprVzFaNHdQego=')

$user_id = '439288'
$url = 'https://api.10000ft.com/api/v1/users/'+$user_id+'/tags'
$body = '{"value": "Stamina 42"}'

$url
$body

$r=Invoke-RestMethod -Uri $url -Method POST -Headers $headers -ContentType application/json -Body $body