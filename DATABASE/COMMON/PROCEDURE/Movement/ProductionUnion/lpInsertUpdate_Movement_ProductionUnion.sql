-- Function: lpInsertUpdate_Movement_ProductionUnion (Integer, TVarChar, TDateTime, Integer, Integer, Boolean, Integer)

DROP FUNCTION IF EXISTS lpInsertUpdate_Movement_ProductionUnion (Integer, TVarChar, TDateTime, Integer, Integer, Boolean, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_Movement_ProductionUnion(
 INOUT ioId                  Integer   , -- ���� ������� <��������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inOperDate            TDateTime , -- ���� ���������
    IN inFromId              Integer   , -- �� ���� (� ���������)
    IN inToId                Integer   , -- ���� (� ���������)
    IN inIsPeresort          Boolean   , -- ��������
    IN inUserId              Integer     -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbAccessKeyId Integer;
   DECLARE vbIsInsert Boolean;
BEGIN
   -- ���������� ���� �������
   vbAccessKeyId:= lpGetAccessKey (inUserId, zc_Enum_Process_InsertUpdate_Movement_ProductionUnion());

   -- ���������� ������� ��������/�������������
   vbIsInsert:= COALESCE (ioId, 0) = 0;

   -- ��������� <��������>
   ioId := lpInsertUpdate_Movement (ioId, zc_Movement_ProductionUnion(), inInvNumber, inOperDate, NULL, vbAccessKeyId);

   -- ��������� ����� � <�� ���� (� ���������)>
   PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_From(), ioId, inFromId);
   -- ��������� ����� � <���� (� ���������)>
   PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_To(), ioId, inToId);

   -- ��������� �������� <��������>
   PERFORM lpInsertUpdate_MovementBoolean (zc_MovementBoolean_Peresort(), ioId, inIsPeresort);


   -- ����������� �������� ����� �� ���������
   PERFORM lpInsertUpdate_MovementFloat_TotalSumm (ioId);

   -- ��������� ��������
   PERFORM lpInsert_MovementProtocol (ioId, inUserId, vbIsInsert);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 20.03.15                                        * set lp
 25.12.14                                        * add inIsPeresort
 03.06.14                                                        *
 30.06.13                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_Movement_ProductionUnion (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inFromId:= 1, inToId:= 2, inSession:= '2')
