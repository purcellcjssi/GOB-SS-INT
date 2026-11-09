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
