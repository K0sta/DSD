CREATE OR REPLACE FUNCTION zc_ObjectLink_RoleRight_Role()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 1;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION zc_ObjectLink_RoleRight_Role()
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION zc_ObjectLink_RoleRight_Process()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 2;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION zc_ObjectLink_RoleRight_Process()
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION zc_ObjectLink_UserRole_Role()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 3;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION zc_ObjectLink_UserRole_Role()
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION zc_ObjectLink_UserRole_User()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 4;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Cash_Currency()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 5;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Cash_PaidKind()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 6;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Cash_Branch()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 7;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_JuridicalGroup_Parent()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 8;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Juridical_JuridicalGroup()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 9;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Juridical_GoodsProperty()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 10;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Partner_Juridical()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 11;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Unit_Parent()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 13;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Unit_Branch()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 14;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Bank_Juridical()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 16;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_GoodsGroup_Parent()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 17;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Goods_Measure()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 19;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_BankAccount_Juridical()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 20;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_BankAccount_Bank()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 21;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_BankAccount_Currency()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 22;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Cash_Branch()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 23;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_GoodsPropertyValue_GoodsProperty()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 24;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_GoodsPropertyValue_Goods()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 25;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_GoodsPropertyValue_GoodsKind()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 26;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Account_AccountGroup()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 27;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Account_AccountDirection()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 28;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Account_InfoMoneyDestination()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 29;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_UserFormSettings_User()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 31;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_UserFormSettings_Form()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 32;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_PriceListItem_PriceList()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 33;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_PriceListItem_Goods()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 34;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Unit_Business()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 35;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Unit_Juridical()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 36;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Unit_AccountDirection()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 37;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Unit_ProfitLossDirection()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 38;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Car_CarModel()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 39;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Account_InfoMoney()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 42;
END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;


--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

CREATE OR REPLACE FUNCTION zc_ObjectLink_Goods_GoodsGroup() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Goods_GoodsGroup'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_Goods_InfoMoney() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Goods_InfoMoney'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- CREATE OR REPLACE FUNCTION zc_ObjectLink_UnitGroup_Parent() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_UnitGroup_Parent'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_InfoMoney_InfoMoneyGroup() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_InfoMoney_InfoMoneyGroup'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_InfoMoney_InfoMoneyDestination() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_InfoMoney_InfoMoneyDestination'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_ProfitLoss_ProfitLossGroup() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_ProfitLoss_ProfitLossGroup'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_ProfitLoss_ProfitLossDirection() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_ProfitLoss_ProfitLossDirection'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_ProfitLoss_InfoMoneyDestination() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_ProfitLoss_InfoMoneyDestination'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_ProfitLoss_InfoMoney() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_ProfitLoss_InfoMoney'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Personal_Member() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Personal_Member'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_Personal_Position() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Personal_Position'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_Personal_Unit() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Personal_Unit'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_Personal_Juridical() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Personal_Juridical'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_Personal_Business() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Personal_Business'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_AssetGroup_Parent() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_AssetGroup_Parent'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_Asset_AssetGroup() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Asset_AssetGroup'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_PartionGoods_Partner() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_PartionGoods_Partner'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_PartionGoods_Goods() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_PartionGoods_Goods'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_ObjectLink_Partner_Route() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Partner_Route'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_Partner_RouteSorting() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Partner_RouteSorting'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_Juridical_InfoMoney() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Juridical_InfoMoney'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_Goods_TradeMark() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Goods_TradeMark'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_ObjectLink_Account_AccountKind() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Account_AccountKind'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.06.13                                        * ����� �����
*/
