#UsersQuery.ps1

CLS

$url = 'https://api.10000ft.com/api/v1/projects'
$response_file = 'c:\temp\Response_UsersQuery.json'

#API key - donnerk/trial
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
#$headers.Add("auth", 'SW9wWUtLTE5GbzN4QUVlUFJJN0RLTFJ5Y25DemRkV0UvK1I4Z2pVd2p3T1ljVUpIU3pSMEwwYTM3VnZwCmJySGM3QUlOYkFjVHV6YXhwYWJFNkJUeW5wbVpjaUpYRkl1N2YvWi9pMjBlMi9NQTYxVXVQWUpvZnIyQwprVzFaNHdQego=')

#API key - kardosg/trial
$headers.Add("auth", 'bE5uUnB5ZzExTkhDM21oTXp0bjVVTmFpMlhpbVZMVmUxVWdhdWdRdHFFc094TTFVMnlTRm1IZkcyOE5QCmNwUStGTGE2eFhOM3hhbjZsb2hWU0QxU0lNWGNjQ0JURzVVemtjamhyOHdJRi9uaUlVNFBQbUE5VmQ5bwp0a2NMVmZLego=')


$body = @{
    "per_page" = 500
}
#    "fields" = "tags"

$r=Invoke-WebRequest -Uri $url -Method GET -Headers $headers -Body $body -OutFile $response_file

$json_response = Get-Content $response_file
$json_response_obj = ConvertFrom-Json ($json_response -join "`n")

foreach ($uid in $json_response_obj.data.id){
    $url = 'https://api.10000ft.com/api/v1/projects/'+$uid
    $url
    $r=Invoke-WebRequest -Uri $url -Method DELETE -Headers $headers
}

echo '-- end --'