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
