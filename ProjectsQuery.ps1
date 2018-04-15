#ProjectsQuery.ps1

$url = 'https://api.10000ft.com/api/v1/projects'

#API key - donnerk/trial
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("auth", 'SW9wWUtLTE5GbzN4QUVlUFJJN0RLTFJ5Y25DemRkV0UvK1I4Z2pVd2p3T1ljVUpIU3pSMEwwYTM3VnZwCmJySGM3QUlOYkFjVHV6YXhwYWJFNkJUeW5wbVpjaUpYRkl1N2YvWi9pMjBlMi9NQTYxVXVQWUpvZnIyQwprVzFaNHdQego=')

#REST hívás , válasz megy egy helyi fájlba
$r=Invoke-WebRequest -Uri $url -Method GET -Headers $headers -OutFile 'C:\Users\donnerk\Documents\Project\Interface\PS-testing\Response_ProjectsQuery.json'