SELECT
	first_name,
	last_name,
	employee_number,
	role,
	email,
	discipline,
	hire_date,
	termination_date,
	location,
	billrate,
	'{"first_name": "'+first_name+'",'+
	'"last_name": "'+last_name+'",'+
	'"employee_number": "'+employee_number+'",'+
	'"role": "'+role+'",'+
	'"email": "'+email+'",'+
	'"discipline": "'+discipline+'",'+
	'"hire_date": "'+hire_date+'",'+
	'"termination_date": "'+RTRIM(termination_date)+'",'+
	'"location": "'+RTRIM(location)+'",'+
	'"billrate": "'+RTRIM(billrate)+'"'+
	'}' AS JSON_STR
FROM (
	SELECT 
		RTRiM(LTRIM(SUBSTRING([NAME1], CHARINDEX(' ', [NAME1]), LEN([NAME1])))) as first_name,
		RTRiM(LTRIM(SUBSTRING([NAME1], 1, CHARINDEX(' ', [NAME1])))) as last_name,
		[EMPLOYEENUMBER] as employee_number,
		[POSITION] as role,
		[ELECTRONICMAILADDRESS] as email,
		'' as discipline,
		CONVERT(nvarchar,[DATEEMPLOYED],121) as hire_date,
		CASE WHEN [DATEENDEMPLOYMENT] IS NULL THEN '' 
			ELSE CONVERT(nvarchar,[DATEENDEMPLOYMENT],121) 
			END as termination_date,
		CASE
			WHEN [REMARK2]='Billable' THEN 1
			ELSE 0
			END as billable,
		[LOCATIONNAME] as location,
		[COSTPRICE] as billrate,
		[EMPLOYEETYPE]
	FROM [Mac].[vw_Active_EmployeeGeneral] A
	WHERE ([DATEEMPLOYED] IS NOT NULL) AND (NOT EXISTS (SELECT 1 as value from [dbo].[STG_10kFT_Users] B WHERE employee_number=A.EMPLOYEENUMBER COLLATE Hungarian_CI_AS))
) T