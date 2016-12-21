-- Function: gpGet_Movement_Export_FileName(Integer, TVarChar)

DROP FUNCTION IF EXISTS gpGet_Movement_Export_FileName (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Movement_Export_FileName(
   OUT outFileNamePrefix      TVarChar  ,
   OUT outFileExt             TVarChar  ,
    IN inMovementId           Integer   ,
    IN inSession              TVarChar
)
  RETURNS RECORD
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Movement_XML_Mida());
     vbUserId:= lpGetUserBySession (inSession);


     -- ���������
     SELECT CASE WHEN ObjectLink_PersonalServiceList_Bank.ChildObjectId = 76968 -- ��� "���� ������"
                      THEN 'Vostok_'
                 WHEN ObjectLink_PersonalServiceList_Bank.ChildObjectId = 76970 -- ��� "��� ����"
                      THEN 'OTP_'
            END AS FileNamePrefix
          , CASE WHEN ObjectLink_PersonalServiceList_Bank.ChildObjectId = 76968 -- ��� "���� ������"
                      THEN '.txt'
                 WHEN ObjectLink_PersonalServiceList_Bank.ChildObjectId = 76970 -- ��� "��� ����"
                      THEN '.xml'
            END AS FileExt
            INTO outFileNamePrefix, outFileExt
     FROM Movement
           LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalServiceList
                                        ON MovementLinkObject_PersonalServiceList.MovementId = Movement.Id
                                       AND MovementLinkObject_PersonalServiceList.DescId = zc_MovementLinkObject_PersonalServiceList()
           LEFT JOIN ObjectLink AS ObjectLink_PersonalServiceList_Bank
                                ON ObjectLink_PersonalServiceList_Bank.ObjectId = MovementLinkObject_PersonalServiceList.ObjectId 
                               AND ObjectLink_PersonalServiceList_Bank.DescId = zc_ObjectLink_PersonalServiceList_Bank()
     WHERE Movement.Id = inMovementId
    ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 20.12.16                                        *
*/

-- ����
-- SELECT * FROM gpGet_Movement_Export_FileName (inMovementId:= 3376510, inSession:= zfCalc_UserAdmin()) -- zc_Enum_ExportKind_Mida35273055()
