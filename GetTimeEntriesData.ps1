#GetTimeEntriesData

$url = 'https://api.10000ft.com/api/v1/time_entries'

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("auth", 'TzlBYmNCTG1idnkrRE11V1BLQVZjMnZpWkpLZTJVSkpIRjFxTXdNVFEwSklybVpGOHhiQ3dVMnZuOUtsClY5NmdZTklPbHVKaGxMQnNRc2NIMHJiUHJsaFZHSWFkR1hUbCtndVFtOVRJQWNJM1BiWmVKelExYUZmTgpzNDJ3c1p2ZAo=')

#REST hívás , válasz megy egy helyi fájlba
$r=Invoke-WebRequest -Uri $url -Method GET -Headers $headers -OutFile 'C:\Temp\10kFT\TimeEntriesData.json'

#válasz fájl beolvasás
$json_response = Get-Content C:\Temp\10kFT\TimeEntriesData.json

$json_response_obj= ConvertFrom-Json ($json_response -join "`n")
$json_response_obj.data
