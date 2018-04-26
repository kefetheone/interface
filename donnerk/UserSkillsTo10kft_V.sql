SELECT
	A.[id] AS star_id, 
	D.[10kft_id],
	A.[email], 
	C.[name], 
	B.[level], 
	'{'+'"value": "Skill: '+C.[name]+' ('+CONVERT(nvarchar,B.[level])+')"}' AS JSON_STR
FROM dbo.starfinder_users AS A 
	LEFT OUTER JOIN dbo.starfinder_skills AS B ON A.id = B.user_id 
	LEFT OUTER JOIN dbo.starfinder_skill_sets AS C ON B.skill_set_id = C.id
	LEFT OUTER JOIN [dbo].[UserKeyExchange_V] AS D ON A.id=D.star_id
WHERE D.[10kft_id] IS NOT NULL