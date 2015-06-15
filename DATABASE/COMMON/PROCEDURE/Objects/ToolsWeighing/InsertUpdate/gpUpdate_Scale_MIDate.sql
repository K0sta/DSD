-- Function: gpUpdate_Scale_MIDate()

DROP FUNCTION IF EXISTS gpUpdate_Scale_MIDate (Integer, TVarChar, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdate_Scale_MIDate(
    IN inMovementItemId        Integer   , -- ���� ������� <������� ���������>
    IN inDescCode              TVarChar  , -- 
    IN inValueData             TDateTime  , -- 
    IN inSession               TVarChar    -- ������ ������������
)                              
RETURNS VOID
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := lpCheckRight (inSession, zc_Enum_Process_Update_Scale_MI_Erased());
     vbUserId:= lpGetUserBySession (inSession);


     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemDate (MovementItemDateDesc.Id, inMovementItemId, inValueData)
     FROM (SELECT inDescCode AS DescCode WHERE TRIM (inDescCode) <> '') AS tmp
          LEFT JOIN MovementItemDateDesc ON MovementItemDateDesc.Code = tmp.DescCode;


     -- ��������� �������� <����/�����>
     PERFORM lpInsertUpdate_MovementItemDate (zc_MIDate_Update(), inMovementItemId, CURRENT_TIMESTAMP);

     -- ��������� ��������
     PERFORM lpInsert_MovementItemProtocol (inMovementItemId, vbUserId, FALSE);


END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 17.05.15                                        *
*/

-- ����
-- SELECT * FROM gpUpdate_Scale_MIDate (inMovementItemId:= 0, inItemName:= 'zc_MIDate_BoxNumber', inValueData:= CURRENT_TIMESTAMP, inSession:= '5')
