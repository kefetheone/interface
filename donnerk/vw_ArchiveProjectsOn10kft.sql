SELECT * FROM [dbo].[STG_10kFT_Projects] A
WHERE NOT EXISTS (SELECT 1 AS value FROM [Mac].[vw_All_ProjectsGeneral] AS B WHERE (project_code = JOBNUMBER COLLATE Hungarian_CI_AS))