SELECT 
	A.[UserFullname],A.[UserEmail],A.[UserSkill],A.[UserLevel],B.[id] as [10kft_id],
	'{'+'"value": "'+A.[UserSkill]+' ('+CONVERT(nvarchar,A.[UserLevel])+')"}' AS JSON_STR
FROM [interface].[dbo].[vw_Starfinder_PersonSkill] A
LEFT JOIN [dbo].[STG_10kFT_Users] B ON A.UserEmail COLLATE Hungarian_CI_AS = B.email
WHERE B.id IS NOT NULL