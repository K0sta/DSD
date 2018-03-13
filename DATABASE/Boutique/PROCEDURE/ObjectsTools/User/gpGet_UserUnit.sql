-- Function: gpGet_UserUnit()

DROP FUNCTION IF EXISTS gpGet_UserUnit (TVarChar);

CREATE OR REPLACE FUNCTION gpGet_UserUnit(
    IN inSession       TVarChar    -- ������ ������������
)
RETURNS TABLE(UnitId integer, UnitName TVarChar)
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbUnitId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_Income());
     vbUserId:= lpGetUserBySession (inSession);

     vbUnitId := COALESCE ((SELECT ObjectLink_User_Unit.ChildObjectId AS UnitId
                            FROM ObjectLink AS ObjectLink_User_Unit
                            WHERE ObjectLink_User_Unit.DescId = zc_ObjectLink_User_Unit()
                              AND ObjectLink_User_Unit.ObjectId = vbUserId)
                           , 0) ::Integer;

     RETURN QUERY
     SELECT Id, ValueData FROM Object WHERE Id = vbUnitId;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpGet_UserUnit (TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 19.02.18         *

*/

-- ����
-- SELECT * FROM gpGet_UserUnit (inSession:= zfCalc_UserAdmin())
