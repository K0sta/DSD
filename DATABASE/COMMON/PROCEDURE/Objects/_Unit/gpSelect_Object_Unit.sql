-- Function: gpSelect_Object_Unit()

DROP FUNCTION IF EXISTS gpSelect_Object_Unit(TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_Unit(
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, 
               ParentId Integer, ParentName TVarChar,
               BusinessId Integer, BusinessName TVarChar, 
               BranchId Integer, BranchName TVarChar,
               JuridicalId Integer, JuridicalName TVarChar,
               AccountGroupCode Integer, AccountGroupName TVarChar,
               AccountDirectionCode Integer, AccountDirectionName TVarChar,
               ProfitLossGroupCode Integer, ProfitLossGroupName TVarChar,
               ProfitLossDirectionCode Integer, ProfitLossDirectionName TVarChar,
               isErased boolean, isLeaf boolean) AS
$BODY$
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_Object_Unit());

   RETURN QUERY 
       SELECT 
             Object_Unit_View.Id     
           , Object_Unit_View.Code   
           , Object_Unit_View.Name
         
           , Object_Unit_View.ParentId 
           , Object_Unit_View.ParentName 

           , Object_Unit_View.BusinessId
           , Object_Unit_View.BusinessName 
         
           , Object_Unit_View.BranchId
           , Object_Unit_View.BranchName
         
           , Object_Unit_View.JuridicalId
           , Object_Unit_View.JuridicalName
         
           , View_AccountDirection.AccountGroupCode
           , View_AccountDirection.AccountGroupName
           , View_AccountDirection.AccountDirectionCode
           , View_AccountDirection.AccountDirectionName
         
           , lfObject_Unit_byProfitLossDirection.ProfitLossGroupCode
           , lfObject_Unit_byProfitLossDirection.ProfitLossGroupName
           , lfObject_Unit_byProfitLossDirection.ProfitLossDirectionCode
           , lfObject_Unit_byProfitLossDirection.ProfitLossDirectionName
         
           , Object_Unit_View.isErased
           , Object_Unit_View.isLeaf
       FROM Object_Unit_View
            LEFT JOIN lfSelect_Object_Unit_byProfitLossDirection() AS lfObject_Unit_byProfitLossDirection ON lfObject_Unit_byProfitLossDirection.UnitId = Object_Unit_View.Id
            LEFT JOIN Object_AccountDirection_View AS View_AccountDirection ON View_AccountDirection.AccountDirectionId = Object_Unit_View.AccountDirectionId
      ;
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_Unit(TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 03.11.13                                        * add lfSelect_Object_Unit_byProfitLossDirection and Object_AccountDirection_View
 28.10.13                         * ������� �� View              
 04.07.13          * ���������� ����� �����������              
 03.06.13          
*/

-- ����
-- SELECT * FROM gpSelect_Object_Unit ('2')