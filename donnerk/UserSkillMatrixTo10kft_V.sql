SELECT
	A.id, 
	A.email, 
	A.first_name, 
	A.last_name, 
	B.skill_set_id, 
	B.[level], 
	B.learn, 
	B.teach, 
	C.name, 
	C.main_category, 
	C.sub_category
FROM dbo.starfinder_users AS A 
	LEFT OUTER JOIN dbo.starfinder_skills AS B ON A.id = B.user_id 
	LEFT OUTER JOIN dbo.starfinder_skill_sets AS C ON B.skill_set_id = C.id