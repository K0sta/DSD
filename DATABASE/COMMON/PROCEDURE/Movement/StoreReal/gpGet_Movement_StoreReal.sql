-- Function: gpGet_Movement_StoreReal()

DROP FUNCTION IF EXISTS gpGet_Movement_StoreReal(Integer, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Movement_StoreReal (
    IN inMovementId Integer  , -- ���� ���������
    IN inOperDate   TDateTime, -- ���� ���������
    IN inSession    TVarChar   -- ������ ������������
)
RETURNS TABLE (Id Integer
             , InvNumber TVarChar
             , OperDate TDateTime
             , StatusCode Integer
             , StatusName TVarChar
             , GUID TVarChar
             , InsertDate TDateTime
             , InsertName TVarChar
             , PartnerId Integer
             , PartnerName TVarChar
              )
AS
$BODY$
   DECLARE vbUserId   Integer;
   DECLARE vbUserName TVarChar;
BEGIN
      -- �������� ���� ������������ �� ����� ���������
      -- vbUserId := PERFORM lpCheckRight (inSession, zc_Enum_Process_Get_Movement_StoreReal());
      vbUserId:= lpGetUserBySession (inSession);
      vbUserName:= (SELECT Object.ValueData FROM Object WHERE Object.Id = vbUserId);

      IF COALESCE(inMovementId, 0) = 0 
      THEN
           RETURN QUERY
             SELECT 0                                                    AS Id
                  , CAST (NEXTVAL('movement_storereal_seq') AS TVarChar) AS InvNumber
                  , CURRENT_DATE :: TDateTime                            AS OperDate
                  , Object_Status.Code                                   AS StatusCode
                  , Object_Status.Name                                   AS StatusName
                  , CAST('' AS TVarChar)                                 AS GUID
                  , CURRENT_TIMESTAMP :: TDateTime                       AS InsertDate
                  , vbUserName                                           AS InserName 
                  , CAST(0  AS Integer)                                  AS PartnerId
                  , CAST('' AS TVarChar)                                 AS PartnerName
             FROM lfGet_Object_Status(zc_Enum_Status_UnComplete()) AS Object_Status;
      ELSE
           RETURN QUERY
             SELECT Movement.Id                                AS Id
                  , Movement.InvNumber                         AS InvNumber
                  , Movement.OperDate                          AS OperDate
                  , Object_Status.ObjectCode                   AS StatusCode
                  , Object_Status.ValueData                    AS StatusName
                  , MovementString_GUID.ValueData              AS GUID
                  , MovementDate_Insert.ValueData              AS InsertDate 
                  , Object_User.ValueData                      AS InsertName
                  , Object_Partner.id                          AS PartnerId
                  , Object_Partner.ValueData                   AS PartnerName
             FROM Movement
                  LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement.StatusId

                  LEFT JOIN MovementString AS MovementString_GUID 
                                           ON MovementString_GUID.MovementId = Movement.Id
                                          AND MovementString_GUID.DescId = zc_MovementString_GUID()

                  LEFT JOIN MovementDate AS MovementDate_Insert 
                                         ON MovementDate_Insert.MovementId = Movement.Id
                                        AND MovementDate_Insert.DescId = zc_MovementDate_Insert()

                  LEFT JOIN MovementLinkObject AS MovementLinkObject_Insert 
                                               ON MovementLinkObject_Insert.MovementId = Movement.Id
                                              AND MovementLinkObject_Insert.DescId = zc_MovementLinkObject_Insert()
                  LEFT JOIN Object AS Object_User ON Object_User.Id = MovementLinkObject_Insert.ObjectId

                  LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                               ON MovementLinkObject_Partner.MovementId = Movement.Id
                                              AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
                  LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = MovementLinkObject_Partner.ObjectId
             WHERE Movement.Id =  inMovementId
               AND Movement.DescId = zc_Movement_StoreReal();
      END IF;
END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

ALTER FUNCTION gpGet_Movement_StoreReal (Integer, TDateTime, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   �������� �.�.
 15.02.17                                                        *
*/

-- ����
-- SELECT * FROM gpGet_Movement_StoreReal (inMovementId := 1, inOperDate := CURRENT_TIMESTAMP, inSession := '9818')
