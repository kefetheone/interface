/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	A.[NAME1] as "mac_name",
	A.[EMPLOYEENUMBER] as "mac_employeenumber",
	A.[ELECTRONICMAILADDRESS] as "mac_email",
	B.[id] as "10kft_id",
	B.[display_name] as "10kft.display_name",
	B.[email] as "10kft_email",
	B.[employee_number] as "10kft_employee_number",
	C.id as "star_id",
	C.email as "star_email"
  FROM [interface].[Mac].[Active_EmployeeGeneral] A
  LEFT JOIN [interface].[dbo].[STG_10kFT_Users] B ON A.EMPLOYEENUMBER COLLATE Hungarian_CI_AS =B.employee_number 
  LEFT JOIN [interface].[dbo].[starfinder_users] C ON A.ELECTRONICMAILADDRESS COLLATE Hungarian_CI_AS =C.email 
  WHERE A.ELECTRONICMAILADDRESS<>''