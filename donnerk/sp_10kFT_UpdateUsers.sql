USE [interface]
GO
/****** Object:  StoredProcedure [dbo].[sp_10kFT_UpdateUsers]    Script Date: 2018. 04. 26. 11:31:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





ALTER procedure [dbo].[sp_10kFT_UpdateUsers]

as
DECLARE @myvar1 BIGINT
DECLARE @err_msg nvarchar(4000)
DECLARE @rec_cnt BIGINT
DECLARE @message nvarchar(255)
begin
SET NOCOUNT ON
	EXEC  @myvar1 =dbo.[sp_start_log] 'Update Users on 10kft'

BEGIN TRY 
SET @rec_cnt = (SELECT COUNT(1) FROM [interface].[dbo].[vw_UpdateUsersOn10kft])
IF @rec_cnt=0
	BEGIN
		/*skipping step, no new users*/
		EXEC [sp_msg_log]     @myvar1, 'I', 'No users to update. Skipping step.'
	END
	ELSE BEGIN
		SET @message = CONVERT(nvarchar,@rec_cnt)+' users updated on 10kft'
		/*upload via REST API*/
		EXEC xp_cmdshell 'powershell.exe -file C:\Users\interface\Documents\powershell\UpdateUsers.ps1'
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



