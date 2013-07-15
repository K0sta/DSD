-- Function: gpInsertUpdate_Object_Unit()

-- DROP FUNCTION gpInsertUpdate_Object_Unit();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Unit(
 INOUT ioId                      Integer   ,   	-- ���� ������� <�������������>
    IN inCode                    Integer   ,    -- ��� ������� <�������������>
    IN inName                    TVarChar  ,    -- �������� ������� <�������������>
    IN inParentId                Integer   ,    -- ������ �� �������������
    IN inBranchId                Integer   ,    -- ������ �� ������
    IN inBusinessId              Integer   ,    -- ������ �� ������
    IN inJuridicalId             Integer   ,    -- ������ �� ����������� ����
    IN inAccountDirectionId      Integer   ,    -- ������ �� ��������� �������������� ������
    IN inProfitLossDirectionId   Integer   ,    -- ������ �� ��������� ������ ������ ���
    IN inSession                 TVarChar       -- ������ ������������
)
  RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode_calc Integer;  
   DECLARE vbOldId Integer;
   DECLARE vbOldParentId integer;
BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_Object_Unit());
   vbUserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1 (!!! ����� ���� ����� ��� �������� !!!)
   vbCode_calc := lfGet_ObjectCode (inCode, zc_Object_Unit());
   -- !!! IF COALESCE (inCode, 0) = 0  THEN vbCode_calc := NULL; ELSE vbCode_calc := inCode; END IF; -- !!! � ��� ������ !!!
   
   -- �������� ������������ <������������>
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Unit(), inName);
   -- �������� ������������ <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Unit(), vbCode_calc);

   -- �������� ���� � ������
   PERFORM lpCheck_Object_CycleLink(ioId, zc_ObjectLink_Unit_Parent(), inParentId);

   vbOldId := ioId;
   
   vbOldParentId := (SELECT ChildObjectId FROM ObjectLink WHERE DescId = zc_ObjectLink_Unit_Parent() AND ObjectId = ioId);

   -- ��������� ������
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Unit(), vbCode_calc, inName);
   -- ��������� ����� � <�������������>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_Parent(), ioId, inParentId);
   -- ��������� ����� � <�������>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_Branch(), ioId, inBranchId);
   -- ��������� ����� � <�������>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_Business(), ioId, inBusinessId);
   -- ��������� ����� � <����������� ����>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_Juridical(), ioId, inJuridicalId);
   -- ��������� ����� � <��������� �������������� ������ - �����������>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_AccountDirection(), ioId, inAccountDirectionId);
   -- ��������� ����� � <��������� ������ ������ � �������� � ������� - �����������>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_ProfitLossDirection(), ioId, inProfitLossDirectionId);

   -- ���� ��������� �������������
   IF vbOldId <> ioId THEN
      -- ���������� �������� ����\����� � ����
      PERFORM lpInsertUpdate_ObjectBoolean(zc_ObjectBoolean_isLeaf(), ioId, true);
   END IF;

   -- ����� ������ inParentId ���� ������ 
   IF COALESCE(inParentId, 0) <> 0 THEN
      PERFORM lpInsertUpdate_ObjectBoolean(zc_ObjectBoolean_isLeaf(), inParentId, false);
   END IF;

   IF COALESCE(vbOldParentId, 0) <> 0 THEN
      PERFORM lpUpdate_isLeaf(vbOldParentId, zc_ObjectLink_Unit_Parent());
   END IF;

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Unit(Integer, Integer, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer, tvarchar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 04.03.13          * vbCode_calc              
 13.05.13                                        * rem lpCheckUnique_Object_ValueData
 14.06.13          *              
 16.06.13                                        * COALESCE (MAX (ObjectCode), 0)

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Unit ()                            
