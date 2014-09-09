-- �������� <������>
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_TrasportAll() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_TrasportAll' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_TrasportDnepr() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_TrasportDnepr' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_TrasportKiev() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_TrasportKiev' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_TrasportKrRog() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_TrasportKrRog' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_TrasportNikolaev() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_TrasportNikolaev' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_TrasportKharkov() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_TrasportKharkov' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_TrasportCherkassi() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_TrasportCherkassi' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_TrasportDoneck() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_TrasportDoneck' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_GuideAll() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_GuideAll' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_GuideDnepr() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_GuideDnepr' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_GuideKiev() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_GuideKiev' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_GuideKrRog() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_GuideKrRog' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_GuideNikolaev() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_GuideNikolaev' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_GuideKharkov() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_GuideKharkov' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_GuideCherkassi() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_GuideCherkassi' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_GuideDoneck() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_GuideDoneck' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_CashDnepr() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_CashDnepr' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_CashKiev() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_CashKiev' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_ServiceDnepr() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_ServiceDnepr' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_ServiceKiev() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_ServiceKiev' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_DocumentDnepr() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_DocumentDnepr' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_DocumentKiev() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_DocumentKiev' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_AccessKey_DocumentBread() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_AccessKey_DocumentBread' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;

DO $$
BEGIN

 -- zc_Object_Goods, ��� ���������� �������������� ���������� �������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_TrasportAll()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 1
                                   , inName:= '��������� ��� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_TrasportAll');

 -- zc_Object_Branch, �� ������� �������������� ��������� � ����������� ��� ����������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_TrasportDnepr()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 2
                                   , inName:= '��������� ����� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_TrasportDnepr');

 -- zc_Object_Branch, �� ������� �������������� ��������� � ����������� ��� ����������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_TrasportKiev()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 3
                                   , inName:= '��������� ���� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_TrasportKiev');

 -- ������ ���, ����������� � ������������ - ���������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_TrasportKrRog()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 4
                                   , inName:= '��������� ������ ��� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_TrasportKrRog');
 -- ��������, ����������� � ������������ - ���������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_TrasportNikolaev()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 5
                                   , inName:= '��������� �������� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_TrasportNikolaev');
 -- �������, ����������� � ������������ - ���������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_TrasportKharkov()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 6
                                   , inName:= '��������� ������� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_TrasportKharkov');
 -- ��������, ����������� � ������������ - ���������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_TrasportCherkassi()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 7
                                   , inName:= '��������� �������� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_TrasportCherkassi');
                                   
 -- ������, ����������� � ������������ - ���������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_TrasportDoneck()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 8
                                   , inName:= '��������� ������ (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_TrasportDoneck');



 -- �� ������� �������������� ��������� ��� �����
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_CashDnepr()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 21
                                   , inName:= '����� ����� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_CashDnepr');

 -- �� ������� �������������� ��������� ��� �����
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_CashKiev()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 22
                                   , inName:= '����� ���� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_CashKiev');


                                   
 -- �� ������� �������������� ��������� ��� �����
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_ServiceDnepr()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 31
                                   , inName:= '������ ����� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_ServiceDnepr');

 -- �� ������� �������������� ��������� ��� �����
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_ServiceKiev()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 32
                                   , inName:= '������ ���� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_ServiceKiev');


                                   
 -- �� ������� �������������� ��������� ��� �������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_DocumentDnepr()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 41
                                   , inName:= '��������� �������� ����� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_DocumentDnepr');

 -- �� ������� �������������� ��������� ��� �������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_DocumentBread()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 42
                                   , inName:= '��������� �������� ���� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_DocumentBread');
                                   
 -- �� ������� �������������� ��������� ��� �������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_DocumentKiev()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 43
                                   , inName:= '��������� �������� ���� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_DocumentKiev');



 -- ALL, ��� ����������� � ������������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_GuideAll()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 101
                                   , inName:= '����������� ��� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_GuideAll');

 -- �����, ����������� � ������������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_GuideDnepr()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 102
                                   , inName:= '����������� ����� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_GuideDnepr');
 -- ����, ����������� � ������������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_GuideKiev()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 103
                                   , inName:= '����������� ���� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_GuideKiev');
 -- ������ ���, ����������� � ������������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_GuideKrRog()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 104
                                   , inName:= '����������� ������ ��� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_GuideKrRog');
 -- ��������, ����������� � ������������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_GuideNikolaev()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 105
                                   , inName:= '����������� �������� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_GuideNikolaev');
 -- �������, ����������� � ������������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_GuideKharkov()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 106
                                   , inName:= '����������� ������� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_GuideKharkov');
 -- ��������, ����������� � ������������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_GuideCherkassi()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 107
                                   , inName:= '����������� �������� (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_GuideCherkassi');

 -- ������, ����������� � ������������
 PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_AccessKey_GuideDoneck()
                                   , inDescId:= zc_Object_Process()
                                   , inCode:= 108
                                   , inName:= '����������� ������ (������ ���������)'
                                   , inEnumName:= 'zc_Enum_Process_AccessKey_GuideDoneck');

/*
 -- ������� ���� 
 PERFORM gpInsertUpdate_Object_RoleProcess2 (ioId        := tmpData.RoleRightId
                                           , inRoleId    := tmpRole.RoleId
                                           , inProcessId := tmpProcess.ProcessId
                                           , inSession   := zfCalc_UserAdmin())
 -- AccessKey  tmpData.RoleRightId, tmpRole.RoleId, tmpProcess.ProcessId
 FROM (SELECT Id AS RoleId FROM Object WHERE DescId = zc_Object_Role() AND ObjectCode in (-1)) AS tmpRole
      JOIN (SELECT zc_Enum_Process_Right_Branch_Dnepr() AS ProcessId
           ) AS tmpProcess ON 1=1
      -- ������� ��� ������������ �����
      LEFT JOIN (SELECT ObjectLink_RoleRight_Role.ObjectId         AS RoleRightId
                      , ObjectLink_RoleRight_Role.ChildObjectId    AS RoleId
                      , ObjectLink_RoleRight_Process.ChildObjectId AS ProcessId
                 FROM ObjectLink AS ObjectLink_RoleRight_Role
                      JOIN ObjectLink AS ObjectLink_RoleRight_Process ON ObjectLink_RoleRight_Process.ObjectId = ObjectLink_RoleRight_Role.ObjectId
                                                                     AND ObjectLink_RoleRight_Process.DescId = zc_ObjectLink_RoleRight_Process()
                 WHERE ObjectLink_RoleRight_Role.DescId = zc_ObjectLink_RoleRight_Role()
                ) AS tmpData ON tmpData.RoleId    = tmpRole.RoleId
                            AND tmpData.ProcessId = tmpProcess.ProcessId
 WHERE tmpData.RoleId IS NULL
 ;
*/
 
END $$;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 08.09.14                                        * add zc_Enum_Process_AccessKey_Guide...
 07.04.14                                        * add zc_Enum_Process_AccessKey_DocumentBread
 10.02.14                                        * add zc_Enum_Process_AccessKey_Document...
 28.12.13                                        * add zc_Enum_Process_AccessKey_Service...
 26.12.13                                        * add zc_Enum_Process_AccessKey_Cash...
 14.12.13                                        * add zc_Enum_Process_AccessKey_GuideAll
 07.12.13                                        *
*/
