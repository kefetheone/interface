SELECT
	project_code,
	name,
	client,
	starts_at,
	ends_at,
	description,
	'{'+
	'"name": "'+name+'",' +
	'"starts_at": "'+starts_at+'",' +
	'"ends_at": "'+ends_at+'",' +
	'"client": "'+client+'",' +
	'"project_code": '+project_code+','+
	'"description": "'+description+'",'+
	'"project_state": "'+'Confirmed'+'",'+
	'"timeentry_lockout": '+'-1'+''+
	'}'	AS JSON_STR
FROM (
	SELECT
		JOBNUMBER AS project_code, 
		REPLACE(JOBNAME,'"','') AS name, 
		NAME1 AS client,
		CASE WHEN STARTINGDATE IS NULL 
			THEN CASE WHEN EXPECTEDENDINGDATE IS NOT NULL THEN REPLACE(CONVERT(nvarchar,EXPECTEDENDINGDATE,102),'.','-') ELSE '' END
			ELSE REPLACE(CONVERT(nvarchar,STARTINGDATE,102),'.','-') END AS starts_at, 
		CASE WHEN EXPECTEDENDINGDATE IS NULL 
			THEN ''
			ELSE REPLACE(CONVERT(nvarchar,EXPECTEDENDINGDATE,102),'.','-') END AS ends_at, 
		CUSTOMERNUMBER AS description
	FROM Mac.vw_All_ProjectsGeneral AS A
	WHERE (LEFT(JOBNUMBER,2)<>'ZZ') AND (NOT EXISTS (SELECT 1 AS value FROM dbo.STG_10kFT_Projects AS B WHERE (project_code = JOBNUMBER COLLATE Hungarian_CI_AS)))) T