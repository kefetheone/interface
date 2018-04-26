DECLARE @myvar1 BIGINT
DECLARE @err_msg nvarchar(4000)
DECLARE @rec_cnt BIGINT
DECLARE @message nvarchar(255)
begin
SET NOCOUNT ON
	EXEC  @myvar1 =dbo.[sp_start_log] 'Archive Projects on 10kft'

BEGIN TRY 
SET @rec_cnt = (SELECT COUNT(1) FROM [interface].[dbo].[vw_ArchiveProjectsOn10kft])
IF @rec_cnt=0
	BEGIN
		/*skipping step, nothing to do*/
		EXEC [sp_msg_log]     @myvar1, 'I', 'No projects to achive. Skipping step.'
	END
	ELSE BEGIN
		SET @message = CONVERT(nvarchar,@rec_cnt)+' projects archived on 10kft'
		/*upload via REST API*/
		EXEC xp_cmdshell 'powershell.exe -file C:\Users\interface\Documents\powershell\ArchiveProjects.ps1'
		EXEC [sp_msg_log]     @myvar1, 'I', @message
	END

/*end logging*/
EXEC dbo.[sp_end_log] @myvar1

END TRY 

/*errror handling*/
BEGIN CATCH 
SELECT   @err_msg=ERROR_MESSAGE() 
EXEC [sp_msg_log]     @myvar1, 'E',  @err_msg
EXEC [sp_end_log]     @myvar1, 'E',  @err_msg
END CATCH ;

end