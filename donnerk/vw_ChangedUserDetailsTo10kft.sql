/****** Compare Maconomy User details against 10kft User details ******/
SELECT
	[id],[employee_number],
	CASE WHEN [first_name] <> [mac_first_name] THEN '' ELSE '"first_name": "'+[mac_first_name]+'",' END AS first_name,
	CASE WHEN [last_name] <> [mac_last_name] THEN '' ELSE '"last_name": "'+[mac_last_name]+'",' END AS last_name,
	CASE WHEN [email] <> [ELECTRONICMAILADDRESS] THEN '' ELSE '"email": "'+[ELECTRONICMAILADDRESS]+'",' END AS email,
	CASE WHEN [billable] <> [REMARK2] THEN '' ELSE '"billable": "'+CONVERT(nvarchar,[REMARK2])+'",' END AS billable,
	CASE WHEN [hire_date] <> [DATEEMPLOYED] THEN '' ELSE '"hire_date": "'+DATEEMPLOYED+'",' END AS hire_date,
	CASE WHEN [termination_date] <> [DATEENDEMPLOYMENT] THEN '' ELSE '"termination_date": "'+[DATEENDEMPLOYMENT]+'",' END AS termination_date,
	CASE WHEN [role] <> [POSITION] THEN '' ELSE '"role": "'+[POSITION]+'",' END AS role,
	CASE WHEN [location] <> [LOCATIONNAME] THEN '' ELSE '"location": "'+[LOCATIONNAME]+'"' END AS location
FROM (
	SELECT
		A.id, 
		A.first_name,
		A.last_name,
		A.email,
		A.billable,
		A.hire_date,
		A.termination_date,
		A.mobile_phone,
		A.office_phone,
		A.employee_number,
		A.billability_target,
		A.billrate,
		A.role,
		A.discipline,
		A.location,
		B.NAME1,
		RTRiM(LTRIM(SUBSTRING([NAME1], CHARINDEX(' ', [NAME1]), LEN([NAME1])))) COLLATE Hungarian_CI_AS as mac_first_name,
		RTRiM(LTRIM(SUBSTRING([NAME1], 1, CHARINDEX(' ', [NAME1])))) COLLATE Hungarian_CI_AS as mac_last_name,
		B.ELECTRONICMAILADDRESS COLLATE Hungarian_CI_AS as ELECTRONICMAILADDRESS,
		CASE WHEN B.REMARK2='Billable' THEN 1 ELSE 0 END AS REMARK2,
		REPLACE(CONVERT(nvarchar,B.[DATEEMPLOYED],102),'.','-') AS DATEEMPLOYED,
		CASE WHEN B.[DATEENDEMPLOYMENT] IS NULL THEN '' 
			ELSE REPLACE(CONVERT(nvarchar,[DATEENDEMPLOYMENT],102),'.','-') 
			END as DATEENDEMPLOYMENT,
		'' as PH_mobile_phone,
		'' as PH_office_phone,
		B.EMPLOYEENUMBER,
		'100' as PH_billability_target,
		B.COSTPRICE,
		B.POSITION COLLATE Hungarian_CI_AS AS POSITION,
		'' as PH_discipline,
		B.LOCATIONNAME COLLATE Hungarian_CI_AS AS LOCATIONNAME
		FROM [interface].[dbo].[STG_10kFT_Users] A
		LEFT JOIN [Mac].[vw_Active_EmployeeGeneral] B ON A.employee_number=B.EMPLOYEENUMBER COLLATE Hungarian_CI_AS) T1