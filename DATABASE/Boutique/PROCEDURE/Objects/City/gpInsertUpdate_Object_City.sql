-- Function: gpInsertUpdate_Object_City (Integer, Integer,  TVarChar, TVarChar)

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_City (Integer, Integer, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_City(
 INOUT ioId           Integer,       -- ���� ������� <���������� �����>
 INOUT ioCode         Integer,       -- ��� ������� <���������� �����>     
    IN inName         TVarChar,      -- �������� ������� <���������� �����>
    IN inSession      TVarChar       -- ������ ������������
)
RETURNS record 
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_City());
   vbUserId:= lpGetUserBySession (inSession);

   -- ����� ������- ��� ����� ����� � ioCode -> ioCode
   IF COALESCE (ioId, 0) = 0 AND COALESCE (ioCode,0) <> 0 THEN  ioCode := NEXTVAL ('Object_City_seq'); 
   END IF; 

   -- ����� ��� �������� �� Sybase �.�. ��� ��� = 0 
   IF COALESCE (ioId, 0) = 0 AND COALESCE (ioCode,0) = 0  THEN  ioCode := NEXTVAL ('Object_City_seq'); 
   ELSEIF ioCode = 0
         THEN ioCode := COALESCE ((SELECT ObjectCode FROM Object WHERE Id = ioId),0);
   END IF; 

   -- �������� ������������ ��� �������� <������������ ���������� �����>
   PERFORM lpCheckUnique_Object_ValueData (ioId, zc_Object_City(), inName);
   -- �������� ������������ ��� �������� <��� ���������� �����>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_City(), ioCode);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_City(), ioCode, inName);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$

LANGUAGE plpgsql VOLATILE;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ��������� �.�.
13.05.17                                                          *
06.03.2017                                                        *
28.02.2017                                                        *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_City()
