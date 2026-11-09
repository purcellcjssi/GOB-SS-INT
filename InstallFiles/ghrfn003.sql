USE DBShrpn
GO

IF OBJECT_ID('dbo.ufn_ret_ganymede_to_hcm_emp_id') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.ufn_ret_ganymede_to_hcm_emp_id
    IF OBJECT_ID('dbo.ufn_ret_ganymede_to_hcm_emp_id') IS NOT NULL
        PRINT '<<< FAILED DROPPING FUNCTION dbo.ufn_ret_ganymede_to_hcm_emp_id >>>'
    ELSE
        PRINT '<<< DROPPED FUNCTION dbo.ufn_ret_ganymede_to_hcm_emp_id >>>'
END
GO

/****************************************************************************************

  Function:     ufn_ret_ganymede_to_hcm_emp_id
  Author:       Chris Purcell

  Description:  Converts ganymede employee id to HCM employee id
                Ganymede employee ids are prefixed with 'D'
                where they are prefixed with '4'

  Parameters:   @p_file_source = 'SS VENUS' or 'SS GANYMEDE'
                @p_emp_id      = Employee ID


   Example:
      SELECT dbo.ufn_ret_ganymede_to_hcm_emp_id ('SS GANYMEDE','D3929')

   Revision history:
      version  date        developer   SCR      description
      -------  ----------  ---------   -----    ------------------------------------
      1.0.00   10/13/2025  CJP                  - Created function

****************************************************************************************/


CREATE FUNCTION dbo.ufn_ret_ganymede_to_hcm_emp_id
(
  @p_file_source    varchar(50)
, @p_emp_id         char(15)
)

RETURNS char(15)
AS
BEGIN

    DECLARE @v_emp_id  char(15) = ''

    IF (@p_file_source = 'SS GANYMEDE')
        IF (CHARINDEX('D', @p_emp_id, 1) = 1)
            SET @v_emp_id = STUFF(@p_emp_id, 1, 1, '4')
        ELSE
            SET @v_emp_id = @p_emp_id
    ELSE
        SET @v_emp_id = @p_emp_id


    RETURN @v_emp_id

END
GO

ALTER AUTHORIZATION ON dbo.ufn_ret_ganymede_to_hcm_emp_id TO  SCHEMA OWNER
GO

GRANT  REFERENCES ,  EXECUTE  ON dbo.ufn_ret_ganymede_to_hcm_emp_id  TO [public];
GO

IF OBJECT_ID('dbo.ufn_ret_ganymede_to_hcm_emp_id') IS NOT NULL
    PRINT '<<< CREATED FUNCTION dbo.ufn_ret_ganymede_to_hcm_emp_id >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION dbo.ufn_ret_ganymede_to_hcm_emp_id >>>'
GO
;
USE DBShrpn
GO

IF OBJECT_ID('dbo.ufn_ret_job_or_pos_id') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.ufn_ret_job_or_pos_id
    IF OBJECT_ID('dbo.ufn_ret_job_or_pos_id') IS NOT NULL
        PRINT '<<< FAILED DROPPING FUNCTION dbo.ufn_ret_job_or_pos_id >>>'
    ELSE
        PRINT '<<< DROPPED FUNCTION dbo.ufn_ret_job_or_pos_id >>>'
END
GO

/****************************************************************************************

  Function:     ufn_ret_job_or_pos_id
  Author:       Chris Purcell
  Date:         9/15/2025

  Description:  Returns the job_or_pos_id based on file_source and associates employer id.

  Parameters:   @p_file_source  = 'SS VENUS' or 'SS GANYMEDE'
                @p_emp_id       = Ganymede Employee ID


   Example:
      SELECT dbo.ufn_ret_job_or_pos_id ('SS VENUS','WNE-00012')

   Revision history:
      version  date        developer   SCR      description
      -------  ----------  ---------   -----    ------------------------------------
      1.0.00   09/15/2025  CJP                  - Created function

****************************************************************************************/


CREATE FUNCTION dbo.ufn_ret_job_or_pos_id
(
  @p_file_source    varchar(50)
, @p_empl_id        char(10)
)

RETURNS char(10)
AS
BEGIN

    DECLARE @v_job_or_pos_id  char(10) = ''

    IF (@p_file_source = 'SS VENUS')
        IF (CHARINDEX('PEN', UPPER(@p_empl_id), 1) = 1)
            SET @v_job_or_pos_id = '99PEN-001'--'PEN-0001'
        ELSE
            SET @v_job_or_pos_id = '99GEN-001'--'GEN-0001'
    ELSE   -- Ganymede FORTHCM
        IF (@p_file_source = 'SS GANYMEDE')
            SET @v_job_or_pos_id = 'FORT001'


    RETURN @v_job_or_pos_id

END
GO

ALTER AUTHORIZATION ON dbo.ufn_ret_job_or_pos_id TO  SCHEMA OWNER
GO

GRANT  REFERENCES ,  EXECUTE  ON dbo.ufn_ret_job_or_pos_id  TO [public];
GO

IF OBJECT_ID('dbo.ufn_ret_job_or_pos_id') IS NOT NULL
    PRINT '<<< CREATED FUNCTION dbo.ufn_ret_job_or_pos_id >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION dbo.ufn_ret_job_or_pos_id >>>'
GO
;
USE DBShrpn
GO

IF OBJECT_ID('dbo.ufn_TryConvertDate') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.ufn_TryConvertDate
    IF OBJECT_ID('dbo.ufn_TryConvertDate') IS NOT NULL
        PRINT '<<< FAILED DROPPING FUNCTION dbo.ufn_TryConvertDate >>>'
    ELSE
        PRINT '<<< DROPPED FUNCTION dbo.ufn_TryConvertDate >>>'
END
GO

/****************************************************************************************

  Function:     ufn_TryConvertDate
  Author:       Chris Purcell
  Date:         11/05/2026

  Description:
  Converts parameter value to date otherwise NULL is returned.
  This function was required for GOB since function TRY_CONVERT() is not available on SQL Server 2008R2.

  Parameters:
  @value  = The value to convert to a date



   Example:
      SELECT dbo.ufn_TryConvertDate ('12/31/2999')


   Revision history:
      version  date        developer   SCR      description
      -------  ----------  ---------   -----    ------------------------------------
      1.0.00   11/05/2026  CJP                  - Created function

****************************************************************************************/

CREATE FUNCTION dbo.ufn_TryConvertDate
(
    @value nvarchar(4000)
)
RETURNS datetime
AS
BEGIN
    RETURN (SELECT CONVERT(datetime, CASE
        WHEN ISDATE(@value) = 1 THEN @value
    END));
END
GO

ALTER AUTHORIZATION ON dbo.ufn_TryConvertDate TO  SCHEMA OWNER
GO

GRANT  REFERENCES ,  EXECUTE  ON dbo.ufn_TryConvertDate  TO [public];
GO

IF OBJECT_ID('dbo.ufn_TryConvertDate') IS NOT NULL
    PRINT '<<< CREATED FUNCTION dbo.ufn_TryConvertDate >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION dbo.ufn_TryConvertDate >>>'
GO
;
USE DBShrpn
GO

IF OBJECT_ID('dbo.ufn_TryConvertDecimal') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.ufn_TryConvertDecimal
    IF OBJECT_ID('dbo.ufn_TryConvertDecimal') IS NOT NULL
        PRINT '<<< FAILED DROPPING FUNCTION dbo.ufn_TryConvertDecimal >>>'
    ELSE
        PRINT '<<< DROPPED FUNCTION dbo.ufn_TryConvertDecimal >>>'
END
GO

/****************************************************************************************

  Function:     ufn_TryConvertDecimal
  Author:       Chris Purcell
  Date:         11/05/2026

  Description:
  Function attempts to convert parameter value to a decimal otherwise NULL is returned.

  Note: This function was required for GOB since function TRY_CONVERT() is not available on SQL Server 2008R2.

  Parameters:
  @value  = The value to convert to a date



   Example:
      SELECT dbo.ufn_TryConvertDecimal ('12/31/2999')


   Revision history:
      version  date        developer   SCR      description
      -------  ----------  ---------   -----    ------------------------------------
      1.0.00   11/05/2026  CJP                  - Created function

****************************************************************************************/

CREATE FUNCTION dbo.ufn_TryConvertDecimal
(
    @value nvarchar(4000)
)
RETURNS decimal
AS
BEGIN
    -- e0 is a floating point number
    -- If you add e0 to the value and run ISNUMERIC on it, ISNUMERIC will return 0 for values that are not valid decimal numbers.
    IF ISNUMERIC(@value + 'e0') = 1
        RETURN CONVERT(decimal, @value)
    RETURN NULL
END
GO

ALTER AUTHORIZATION ON dbo.ufn_TryConvertDecimal TO  SCHEMA OWNER
GO

GRANT  REFERENCES ,  EXECUTE  ON dbo.ufn_TryConvertDecimal  TO [public];
GO

IF OBJECT_ID('dbo.ufn_TryConvertDecimal') IS NOT NULL
    PRINT '<<< CREATED FUNCTION dbo.ufn_TryConvertDecimal >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION dbo.ufn_TryConvertDecimal >>>'
GO
;
USE DBShrpn
GO

IF OBJECT_ID('dbo.ufn_TryConvertInt') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.ufn_TryConvertInt
    IF OBJECT_ID('dbo.ufn_TryConvertInt') IS NOT NULL
        PRINT '<<< FAILED DROPPING FUNCTION dbo.ufn_TryConvertInt >>>'
    ELSE
        PRINT '<<< DROPPED FUNCTION dbo.ufn_TryConvertInt >>>'
END
GO

/****************************************************************************************

  Function:     ufn_TryConvertInt
  Author:       Chris Purcell
  Date:         11/05/2026

  Description:
  Converts parameter value to integer otherwise NULL is returned.
  This function was required for GOB since function TRY_CONVERT() is not available on SQL Server 2008R2.

  Parameters:
  @value  = The value to convert to an integer



   Example:
      SELECT dbo.ufn_TryConvertInt ('12345')


   Revision history:
      version  date        developer   SCR      description
      -------  ----------  ---------   -----    ------------------------------------
      1.0.00   11/05/2026  CJP                  - Created function

****************************************************************************************/

CREATE FUNCTION dbo.ufn_TryConvertInt
(
    @value nvarchar(4000)
)
RETURNS int
AS
BEGIN
    RETURN (SELECT CONVERT(int,
        CASE WHEN LEN(@value) <= 11 THEN
            CASE WHEN @value NOT LIKE N'%[^-0-9]%' THEN
                CASE WHEN CONVERT(bigint, @value) BETWEEN -2147483648 AND 2147483647
                    THEN @value
                END
            END
        END));
END
GO


ALTER AUTHORIZATION ON dbo.ufn_TryConvertInt TO  SCHEMA OWNER
GO

GRANT  REFERENCES ,  EXECUTE  ON dbo.ufn_TryConvertInt  TO [public];
GO

IF OBJECT_ID('dbo.ufn_TryConvertInt') IS NOT NULL
    PRINT '<<< CREATED FUNCTION dbo.ufn_TryConvertInt >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION dbo.ufn_TryConvertInt >>>'
GO
;
