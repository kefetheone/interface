SELECT * FROM (
	SELECT
		id,
		employee_number,
		CASE WHEN
		[role]<>RTRIM([POSITION]) COLLATE Hungarian_CI_AS OR 
		[email]<>REPLACE([ELECTRONICMAILADDRESS],' ','') COLLATE Hungarian_CI_AS OR 
		[location] <> RTRIM([LOCATIONNAME]) COLLATE Hungarian_CI_AS
		THEN
		'{"role": "'+RTRIM([POSITION])+'",'+
		'"email": "'+REPLACE([ELECTRONICMAILADDRESS],' ','')+'",'+
		'"location": "'+RTRIM([LOCATIONNAME])+'"}' COLLATE Hungarian_CI_AS 
		ELSE NULL END as [JSON_STR_New]
	FROM [dbo].[STG_10kFT_Users] A
	INNER JOIN [Mac].[vw_Active_EmployeeGeneral] B ON A.[employee_number] = B.[EMPLOYEENUMBER] COLLATE Hungarian_CI_AS) T1
WHERE JSON_STR_New IS NOT NULL