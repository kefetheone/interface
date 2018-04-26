SELECT
	A.[id],
	A.[allocation_mode],
	A.[hours_per_day],
	A.[ends_at],
	A.[starts_at],
	A.[bill_rate],
	A.[all_day_assignment],
	A.[status],
	B.[display_name],
	B.[employee_number],
	B.[billrate],
	B.[role],
	B.[location],
	C.[name],
	C.[project_code],
	C.[end_at],
	C.[starts_at],
	C.[client],
	C.[project_state]
FROM [interface].[dbo].[STG_10kFT_AssignmentsProject] A
LEFT JOIN [dbo].[STG_10kFT_Users] B ON A.user_id = B.id
LEFT JOIN [dbo].[STG_10kFT_Projects] C ON A.assignable_id = C.id