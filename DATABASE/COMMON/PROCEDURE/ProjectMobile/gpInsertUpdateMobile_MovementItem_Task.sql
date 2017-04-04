-- Function: gpInsertUpdateMobile_MovementItem_Task()

DROP FUNCTION IF EXISTS gpInsertUpdateMobile_MovementItem_Task (Integer, Integer, Boolean, TVarChar, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdateMobile_MovementItem_Task(
    IN inId         Integer   , -- ���������� ������������� ����������� � ������� ��, � ������������ ��� �������������
    IN inMovementId Integer   , -- ���������� ������������� ���������
    IN inClosed     Boolean   , -- ��������� (��/���)
    IN inComment    TVarChar  , -- ����������. ��������� ��������, ����� ����������/�� ���������� �������
    IN inUpdateDate TDateTime , -- ����/����� ����� �������� ������� ����������/�� ���������� �������
    IN inSession    TVarChar    -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbId Integer;
   DECLARE vbPartnerId Integer;
   DECLARE vbDescription TVarChar;
BEGIN
      -- �������� ���� ������������ �� ����� ���������
      -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_...());
      vbUserId:= lpGetUserBySession (inSession);

      SELECT MI_Task.Id
           , MI_Task.ObjectId AS PartnerId
           , MIString_Description.ValueData AS Description
      INTO vbId
         , vbPartnerId
         , vbDescription
      FROM Movement AS Movement_Task
           JOIN MovementItem AS MI_Task 
                             ON MI_Task.MovementId = Movement_Task.Id
                            AND MI_Task.DescId = zc_MI_Master() 
                            AND MI_Task.Id = inId
           LEFT JOIN MovementItemString AS MIString_Description
                                        ON MIString_Description.MovementItemId = MI_Task.Id
                                       AND MIString_Description.DescId = zc_MIString_Description() 
      WHERE Movement_Task.DescId = zc_Movement_Task()
        AND Movement_Task.Id = inMovementId;

      IF COALESCE (vbId, 0) = 0 
      THEN
           RAISE EXCEPTION '������. ������� �� ��������.';
      END IF; 

      vbId := lpInsertUpdate_MovementItem_Task (ioId:= inId
                                              , inMovementId:= inMovementId
                                              , inPartnerId:= vbPartnerId
                                              , inDescription:= vbDescription
                                              , inUserId:= vbUserId
                                               );

      -- ��������� �������� <��������� (��/���)>
      PERFORM lpInsertUpdate_MovementItemBoolean (zc_MIBoolean_Close(), vbId, inClosed);

      -- ��������� �������� <����������>
      PERFORM lpInsertUpdate_MovementItemString (zc_MIString_Comment(), vbId, inComment);

      -- ��������� �������� <����/����� ���������� �������>
      PERFORM lpInsertUpdate_MovementItemDate (zc_MIDate_UpdateMobile(), vbId, inUpdateDate);

      RETURN vbId;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   �������� �.�.
 03.04.17                                                         *
*/

-- ����
-- SELECT * FROM gpInsertUpdateMobile_MovementItem_Task (inId:= 71885005, inMovementId:= 5285630, inClosed:= true, inComment:= '� ������, �� ������', inUpdateDate:= CURRENT_TIMESTAMP, inSession:= zfCalc_UserAdmin())