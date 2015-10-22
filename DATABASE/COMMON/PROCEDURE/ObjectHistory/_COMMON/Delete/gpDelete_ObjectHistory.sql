-- Function: gpDelete_ObjectHistory()

DROP FUNCTION IF EXISTS gpDelete_ObjectHistory (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpDelete_ObjectHistory(
    IN inId                  Integer   ,  -- ���� ������� 
    IN inSession             TVarChar     -- ������ ������������
)
  RETURNS VOID AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   vbUserId := lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_ObjectHistory_PriceListItem());

    
   PERFORM lpDelete_ObjectHistory (inId	      := inId
                                 , inUserId   := vbUserId
                                  );

   
END;$BODY$
  LANGUAGE plpgsql VOLATILE;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 21.08.15         *
*/

