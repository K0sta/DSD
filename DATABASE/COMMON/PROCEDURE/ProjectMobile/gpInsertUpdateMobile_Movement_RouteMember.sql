-- Function: gpInsertUpdateMobile_Movement_RouteMember()

DROP FUNCTION IF EXISTS gpInsertUpdateMobile_Movement_RouteMember (TVarChar, TVarChar, TDateTime, TFloat, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdateMobile_Movement_RouteMember (
    IN inGUID       TVarChar  , -- ���������� ���������� ������������� ��� ������������� � ���������� ������������
    IN inInvNumber  TVarChar  , -- ����� ���������
    IN inInsertDate TDateTime , -- ����/����� ��������
    IN inGPSN       TFloat    , -- GPS ���������� �������� (������)
    IN inGPSE       TFloat    , -- GPS ���������� �������� (�������)
    IN inSession    TVarChar    -- ������ ������������
)
RETURNS Integer 
AS
$BODY$
   DECLARE vbId Integer;
   DECLARE vbUserId Integer;
BEGIN
      -- �������� ���� ������������ �� ����� ���������
      -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_...());
      vbUserId:= lpGetUserBySession (inSession);

      -- �������� Id ��������� �� GUID
      SELECT MovementString_GUID.MovementId 
      INTO vbId 
      FROM MovementString AS MovementString_GUID
           JOIN Movement AS Movement_RouteMember
                         ON Movement_RouteMember.Id = MovementString_GUID.MovementId
                        AND Movement_RouteMember.DescId = zc_Movement_RouteMember()
      WHERE MovementString_GUID.DescId = zc_MovementString_GUID() 
        AND MovementString_GUID.ValueData = inGUID;

      vbId:= lpInsertUpdate_Movement_RouteMember (ioId:= vbId
                                                , inInvNumber:= inInvNumber
                                                , inOperDate:= DATE_TRUNC ('day', inInsertDate)
                                                , inGPSN:= inGPSN
                                                , inGPSE:= inGPSE
                                                , inUserId:= vbUserId
                                                 );

      -- ��������� �������� <����/����� �������� �� ��������� ����������>
      PERFORM lpInsertUpdate_MovementDate(zc_MovementDate_InsertMobile(), vbId, inInsertDate);

      -- ��������� �������� <���������� ���������� �������������>
      PERFORM lpInsertUpdate_MovementString (zc_MovementString_GUID(), vbId, inGUID);

      RETURN vbId;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   �������� �.�.
 04.04.17                                                        *                                          
*/

-- ����
-- SELECT * FROM gpInsertUpdateMobile_Movement_RouteMember (inGUID:= '{94774140-0FF6-4DC3-910C-5805989B6FC4}', inInvNumber:= '-9', inInsertDate:= CURRENT_TIMESTAMP, inGPSN:= 56, inGPSE:= 56, inSession:= zfCalc_UserAdmin());