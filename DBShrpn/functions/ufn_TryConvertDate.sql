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
