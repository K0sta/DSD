-- Function: lpReport_byAccount ()

DROP FUNCTION IF EXISTS lpReport_AccountMotion (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean);
DROP FUNCTION IF EXISTS lpReport_AccountMotion (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Boolean, Boolean, Boolean);

CREATE OR REPLACE FUNCTION lpReport_AccountMotion (
    IN inStartDate              TDateTime ,  
    IN inEndDate                TDateTime ,
    IN inAccountGroupId         Integer , 
    IN inAccountDirectionId     Integer , 
    IN inInfoMoneyId            Integer , 
    IN inAccountId              Integer ,
    IN inBusinessId             Integer ,
    IN inProfitLossGroupId      Integer ,
    IN inProfitLossDirectionId  Integer , 
    IN inProfitLossId           Integer ,
    IN inBranchId               Integer ,
    IN inUserId                 Integer ,
    IN inIsMovement             Boolean ,
    IN inIsGoods                Boolean ,
    IN inIsGoodsKind            Boolean ,
    IN inIsDetail               Boolean 
)
RETURNS TABLE  (InvNumber Integer, MovementId Integer, OperDate TDateTime, MovementDescName TVarChar
              , InfoMoneyCode Integer, InfoMoneyGroupName TVarChar, InfoMoneyDestinationName TVarChar, InfoMoneyName TVarChar
              , JuridicalBasisCode Integer, JuridicalBasisName TVarChar
              , BusinessCode Integer, BusinessName TVarChar
              , PaidKindName TVarChar, ContractName TVarChar
              , ObjectId_Direction Integer, ObjectCode_Direction Integer, ObjectName_Direction TVarChar
              , ObjectCode_Destination Integer, ObjectName_Destination TVarChar
              , DescName_Direction TVarChar
              , DescName_Destination TVarChar
              , GoodsKindName TVarChar 
              , RouteCode_inf Integer, RouteName_inf TVarChar
              , UnitCode_inf Integer, UnitName_inf TVarChar
              , BranchCode_inf Integer, BranchName_inf TVarChar
              , BusinessCode_inf Integer, BusinessName_inf TVarChar
              , SummStart TFloat, SummIn TFloat, SummOut TFloat, SummEnd TFloat--, OperPrice TFloat
              , AccountGroupCode Integer, AccountGroupName TVarChar
              , AccountDirectionCode Integer, AccountDirectionName TVarChar
              , AccountCode Integer, AccountName TVarChar, AccountName_All TVarChar
              , AccountGroupCode_inf Integer, AccountGroupName_inf TVarChar
              , AccountDirectionCode_inf Integer, AccountDirectionName_inf TVarChar
              , AccountCode_inf Integer, AccountName_inf TVarChar, AccountName_All_inf TVarChar
              , ProfitLossName_All_inf TVarChar
              
              , InfoMoneyId_Detail Integer, InfoMoneyCode_Detail Integer
              , InfoMoneyGroupName_Detail TVarChar, InfoMoneyDestinationName_Detail TVarChar
              , InfoMoneyName_Detail TVarChar, InfoMoneyName_all_Detail TVarChar
              )  
AS
$BODY$
   DECLARE vbIsMovement Boolean;
BEGIN

     -- ��������� ��� ��������
     IF inUserId = 9457 -- ���������� �.�.
     THEN
         inUserId:= NULL;
         RETURN;
     END IF;

    --
    -- RAISE EXCEPTION 'vbIsMovement = <%>', vbIsMovement;

    -- ���������
    RETURN QUERY
    WITH tmpContainer AS  (SELECT Container.Id                  AS ContainerId
                                , Container.ObjectId            AS AccountId
                                , Container.Amount
                                , ContainerLO_Business.ObjectId AS BusinessId
                           FROM (SELECT AccountId FROM Object_Account_View 
                                 WHERE -- !!!ONLY!!! inAccountId OR inAccountGroupId OR inAccountDirectionId
                                      ((Object_Account_View.AccountGroupId = COALESCE (inAccountGroupId, 0) AND COALESCE (inAccountDirectionId, 0) = 0 AND COALESCE (inAccountId, 0) = 0)
                                    OR (Object_Account_View.AccountDirectionId = COALESCE (inAccountDirectionId, 0) AND COALESCE (inAccountId, 0) = 0)
                                    OR Object_Account_View.AccountId = COALESCE (inAccountId, 0)
                                      )
                                   OR (EXISTS (SELECT 1 FROM ObjectLink_UserRole_View WHERE RoleId = zc_Enum_Role_Admin() AND UserId = inUserId)
                                   AND COALESCE (inAccountGroupId, 0) = 0 AND COALESCE (inAccountDirectionId, 0) = 0 AND COALESCE (inAccountId, 0) = 0
                                      )
                                 ) AS tmpAccount -- ����
                                
                                INNER JOIN Container ON Container.ObjectId = tmpAccount.AccountId
                                                    AND Container.DescId = zc_Container_Summ()
                                LEFT JOIN ContainerLinkObject AS ContainerLO_Business
                                                              ON ContainerLO_Business.ContainerId = Container.Id
                                                             AND ContainerLO_Business.DescId = zc_ContainerLinkObject_Business()
                                                             AND ContainerLO_Business.ObjectId > 0
                           WHERE ContainerLO_Business.ObjectId = inBusinessId OR COALESCE (inBusinessId, 0) = 0
                           )

    , tmpContainer_Remains AS (SELECT tmpContainer.BusinessId
                                    , tmpContainer.ContainerId
                                    , tmpContainer.AccountId
                                    , tmpContainer.Amount - COALESCE (SUM (MIContainer.Amount), 0) AS SummStart
                                    , tmpContainer.Amount - COALESCE (SUM (CASE WHEN MIContainer.OperDate > inEndDate THEN  MIContainer.Amount ELSE 0 END), 0) AS SummEnd
                               FROM tmpContainer
                                    LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.Containerid = tmpContainer.ContainerId
                                                                                  AND MIContainer.OperDate >= inStartDate
                               GROUP BY tmpContainer.BusinessId, tmpContainer.ContainerId, tmpContainer.AccountId, tmpContainer.Amount
                               HAVING (tmpContainer.Amount - COALESCE (SUM (MIContainer.Amount), 0) <> 0)
                                   OR (tmpContainer.Amount - COALESCE (SUM (CASE WHEN MIContainer.OperDate > inEndDate THEN MIContainer.Amount ELSE 0 END), 0) <> 0)
                              )

    , tmpContainer_Motion AS (SELECT tmpContainer.BusinessId            AS BusinessId
                                   , tmpContainer.ContainerId           AS ContainerId
                                   , tmpContainer.AccountId             AS AccountId
                                   , MIContainer.ContainerId_Analyzer
                                   , CASE WHEN (inIsGoodsKind = TRUE AND inIsGoods = TRUE) THEN MIContainer.ObjectIntId_Analyzer ELSE 0 END AS GoodsKindId
                                                                   
                                   , CASE WHEN inIsMovement = TRUE THEN MIContainer.ObjectId_Analyzer ELSE 0 END :: Integer AS ObjectId_inf
                                   , MIContainer.MovementItemId         AS MovementItemId
         
                                   , MIContainer.MovementId
   
                                   , CASE WHEN inIsMovement = TRUE THEN MIContainer.OperDate ELSE NULL END :: TDateTime AS OperDate
                                                                                       
                                   , CASE WHEN tmpContainer.AccountId = zc_Enum_Account_100301() -- ������� �������� �������
                                               THEN tmpContainer.ContainerId
                                          ELSE MIContainer.ContainerId_Analyzer
                                     END                                AS ContainerId_ProfitLoss
                                   ,  (CASE WHEN MIContainer.isActive = TRUE AND COALESCE (MIContainer.AccountId, 0) <> zc_Enum_Account_100301() -- ������� �������� �������
                                                    THEN MIContainer.Amount
                                               ELSE 0
                                          END)                          AS SummIn
                                   ,  (CASE WHEN MIContainer.isActive = FALSE OR MIContainer.AccountId = zc_Enum_Account_100301() -- ������� �������� �������
                                                    THEN -1 * MIContainer.Amount
                                               ELSE 0
                                          END)                          AS SummOut
                                   , MIContainer.Amount
                              FROM tmpContainer
                                   INNER JOIN MovementItemContainer AS MIContainer
                                                                    ON MIContainer.ContainerId = tmpContainer.ContainerId
                                                                   AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                              )
    , tmpAnalyzer AS (SELECT Container.Id
                           , Container.ObjectId
                      FROM Container
                      WHERE Container.Id IN (SELECT DISTINCT tmpContainer_Motion.ContainerId_Analyzer FROM tmpContainer_Motion)
                      )
    , tmpMovement AS (SELECT Movement.Id
                           , Movement.InvNumber
                           , Movement.DescId
                      FROM Movement
                      WHERE Movement.Id IN (SELECT DISTINCT tmpContainer_Motion.MovementId FROM tmpContainer_Motion)
                      )
    , tmpMIContainer AS (SELECT MovementItemContainer.MovementItemId
                              , MovementItemContainer.Amount
                         FROM MovementItemContainer
                         WHERE MovementItemContainer.MovementItemId IN (SELECT tmpContainer_Motion.MovementItemId FROM tmpContainer_Motion)
                           AND MovementItemContainer.DescId = zc_MIContainer_Count()
                         )
    , tmpMotion AS (SELECT tmpContainer.BusinessId             AS BusinessId
                         , tmpContainer.ContainerId            AS ContainerId
                         , tmpContainer.AccountId              AS AccountId
                         , tmpContainer.ContainerId_Analyzer   AS ContainerId_inf
                         , Container.ObjectId                  AS AccountId_inf
                         , tmpContainer.GoodsKindId
                         
                         , tmpContainer.ObjectId_inf
                         , tmpContainer.MovementItemId         AS MovementItemId

                         , Movement.DescId                                                                    AS MovementDescId
                         , CASE WHEN inIsMovement = TRUE THEN Movement.Id          ELSE 0    END :: Integer   AS MovementId
                         , CASE WHEN inIsMovement = TRUE THEN Movement.InvNumber   ELSE ''   END :: TVarChar  AS InvNumber
                         , tmpContainer.OperDate
                                                                             
                         , tmpContainer.ContainerId_ProfitLoss
                         , SUM (tmpContainer.SummIn)                          AS SummIn
                         , SUM (tmpContainer.SummOut)                          AS SummOut

                         --, CASE WHEN COALESCE (MIContainer_Count.Amount, 0) <> 0 THEN ABS (tmpContainer.Amount) / ABS (MIContainer_Count.Amount) ELSE 0 END AS OperPrice

                    FROM tmpContainer_Motion AS tmpContainer
                         
                         LEFT JOIN tmpAnalyzer AS Container ON Container.Id = tmpContainer.ContainerId_Analyzer
                         LEFT JOIN tmpMovement AS Movement ON Movement.Id = tmpContainer.MovementId
                         
                         LEFT JOIN tmpMIContainer AS MIContainer_Count ON MIContainer_Count.MovementItemId = tmpContainer.MovementItemId
                                                                             --AND MIContainer_Count.DescId = zc_MIContainer_Count()
                                                                             AND Movement.DescId IN (zc_Movement_Transport(), zc_Movement_Income())
                    GROUP BY tmpContainer.BusinessId
                           , tmpContainer.ContainerId
                           , tmpContainer.AccountId

                           , tmpContainer.ContainerId_Analyzer
                           , Container.ObjectId
                           , tmpContainer.ObjectId_inf
                           , Movement.DescId
                           , CASE WHEN inIsMovement = TRUE THEN Movement.Id          ELSE 0    END
                           , CASE WHEN inIsMovement = TRUE THEN Movement.InvNumber   ELSE ''   END
                           , tmpContainer.OperDate
                           , tmpContainer.MovementItemId
                           --, CASE WHEN COALESCE (MIContainer_Count.Amount, 0) <> 0 THEN ABS (tmpContainer.Amount) / ABS (MIContainer_Count.Amount) ELSE 0 END
                           , tmpContainer.ContainerId_ProfitLoss
                           , tmpContainer.GoodsKindId
                    )

    , tmpData AS (SELECT tmp.BusinessId
                       , tmp.ContainerId
                       , tmp.AccountId
                       , tmp.ContainerId_inf
                       , tmp.AccountId_inf
                       , tmp.ContainerId_ProfitLoss
                       , tmp.ObjectId_inf
                       , tmp.GoodsKindId
                       , tmp.MovementId
                       , tmp.MovementDescId
                       , tmp.InvNumber
                       , tmp.OperDate
                       , 0 AS SummStart
                       , 0 AS SummEnd
                       , tmp.SummIn
                       , tmp.SummOut
                       --, tmp.OperPrice

                       , CASE WHEN inIsMovement = TRUE THEN MILinkObject_MoneyPlace.ObjectId ELSE 0 END :: Integer AS MoneyPlaceId_inf
                       , MILinkObject_Route.ObjectId  AS RouteId_inf
                       , MILinkObject_Unit.ObjectId   AS UnitId_inf
                       , MILinkObject_Branch.ObjectId AS BranchId_inf
                                              
                  FROM tmpMotion AS tmp
                       LEFT JOIN MovementItemLinkObject AS MILinkObject_Route
                                                        ON MILinkObject_Route.MovementItemId = tmp.MovementItemId
                                                       AND MILinkObject_Route.DescId = zc_MILinkObject_Route()
                       LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                                        ON MILinkObject_Unit.MovementItemId = tmp.MovementItemId
                                                       AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
                       LEFT JOIN MovementItemLinkObject AS MILinkObject_Branch
                                                        ON MILinkObject_Branch.MovementItemId = tmp.MovementItemId
                                                       AND MILinkObject_Branch.DescId = zc_MILinkObject_Branch()
                       LEFT JOIN MovementItemLinkObject AS MILinkObject_MoneyPlace
                                                        ON MILinkObject_MoneyPlace.MovementItemId = tmp.MovementItemId
                                                       AND MILinkObject_MoneyPlace.DescId = zc_MILinkObject_MoneyPlace()
                  WHERE MILinkObject_Branch.ObjectId = inBranchId OR inBranchId = 0
                  )

    , tmpReport_All AS (-- ������� ���. �������.
                        SELECT tmp.BusinessId
                             , tmp.ContainerId
                             , tmp.AccountId
                             , 0 AS ContainerId_inf
                             , 0 AS AccountId_inf
                             , 0 AS ContainerId_ProfitLoss
                             , 0 AS ObjectId_inf
                             , 0 AS GoodsKindId
                             , 0 AS MovementId
                             , 0 AS MovementDescId
                             , ''   :: TVarChar  AS InvNumber
                             , NULL :: TDateTime AS OperDate
                             , tmp.SummStart
                             , tmp.SummEnd
                             , 0 AS SummIn
                             , 0 AS SummOut
                             , 0 AS MoneyPlaceId_inf
                             , 0 AS RouteId_inf
                             , 0 AS UnitId_inf
                             , 0 AS BranchId_inf
                        FROM tmpContainer_Remains AS tmp
                       UNION ALL
                        --��������
                        SELECT tmp.BusinessId
                             , tmp.ContainerId
                             , tmp.AccountId
                             , tmp.ContainerId_inf
                             , tmp.AccountId_inf
                             , tmp.ContainerId_ProfitLoss
                             , tmp.ObjectId_inf
                             , tmp.GoodsKindId
                             , tmp.MovementId
                             , tmp.MovementDescId
                             , tmp.InvNumber
                             , tmp.OperDate
                             , 0 AS SummStart
                             , 0 AS SummEnd
                             , tmp.SummIn
                             , tmp.SummOut
                             , tmp.MoneyPlaceId_inf
                             , tmp.RouteId_inf
                             , tmp.UnitId_inf
                             , tmp.BranchId_inf
                        FROM tmpData AS tmp
                        )
    , tmpCLO AS (SELECT ContainerLinkObject.*
                 FROM ContainerLinkObject
                 WHERE ContainerLinkObject.ContainerId IN (SELECT tmpReport_All.ContainerId FROM tmpReport_All 
                                                         UNION
                                                           SELECT DISTINCT tmpReport_All.ContainerId_inf FROM tmpReport_All
                                                           )
                   AND ContainerLinkObject.ObjectId > 0
                   AND ContainerLinkObject.DescId IN (zc_ContainerLinkObject_JuridicalBasis()
                                                    , zc_ContainerLinkObject_Juridical()
                                                    , zc_ContainerLinkObject_Unit()
                                                    , zc_ContainerLinkObject_Car()
                                                    , zc_ContainerLinkObject_Member()
                                                    , zc_ContainerLinkObject_Cash()
                                                    , zc_ContainerLinkObject_BankAccount()
                                                    , zc_ContainerLinkObject_PaidKind()
                                                    , zc_ContainerLinkObject_Contract()
                                                    , zc_ContainerLinkObject_InfoMoney()
                                                    , zc_ContainerLinkObject_Goods()
                                                    , zc_ContainerLinkObject_Business()
                                                    , zc_ContainerLinkObject_Branch()
                                                     )

                 )
    , tmpCLO_ProfitLoss AS (SELECT ContainerLinkObject.*
                            FROM ContainerLinkObject
                            WHERE ContainerLinkObject.ContainerId IN (SELECT DISTINCT tmpReport_All.ContainerId_ProfitLoss FROM tmpReport_All)
                              AND ContainerLinkObject.ObjectId > 0
                              AND ContainerLinkObject.DescId = zc_ContainerLinkObject_ProfitLoss()
                             )
            
    , tmpCLO_inf AS (SELECT tmpCLO.*
                     FROM tmpCLO 
                     WHERE tmpCLO.ContainerId IN (SELECT DISTINCT tmpReport_All.ContainerId_inf FROM tmpReport_All)
                     )    
    , tmpInfoMoneyDetail AS (SELECT CLO_InfoMoneyDetail.*
                             FROM ContainerLinkObject AS CLO_InfoMoneyDetail
                             WHERE CLO_InfoMoneyDetail.ContainerId IN (SELECT tmpReport_All.ContainerId FROM tmpReport_All)
                               AND CLO_InfoMoneyDetail.DescId = zc_ContainerLinkObject_InfoMoneyDetail()
                               AND inIsDetail = TRUE
                             )
        --LEFT JOIN Object_InfoMoney_View AS View_InfoMoneyDetail ON View_InfoMoneyDetail.InfoMoneyId = CLO_InfoMoneyDetail.ObjectId
                                                                                           
    , tmpReport AS (SELECT ContainerLO_JuridicalBasis.ObjectId AS JuridicalBasisId
                         , tmpReport_All.BusinessId
                         , COALESCE (ContainerLO_InfoMoney.ObjectId, ContainerLO_InfoMoney_inf.ObjectId) AS InfoMoneyId
                         , ContainerLO_PaidKind.ObjectId  AS PaidKindId
                         , ContainerLO_Contract.ObjectId  AS ContractId
                         , tmpReport_All.GoodsKindId
                         , CASE WHEN tmpReport_All.MovementDescId IN (zc_Movement_BankAccount(), zc_Movement_Cash())
                                     THEN tmpReport_All.ObjectId_inf
                                ELSE COALESCE (ContainerLO_Cash.ObjectId, COALESCE (ContainerLO_BankAccount.ObjectId, COALESCE (ContainerLO_Juridical.ObjectId, COALESCE (ContainerLO_Unit.ObjectId, COALESCE (ContainerLO_Car.ObjectId, COALESCE (ContainerLO_Member.ObjectId
                                             , COALESCE (ContainerLO_Juridical_inf.ObjectId, COALESCE (ContainerLO_Unit_inf.ObjectId, COALESCE (ContainerLO_Car_inf.ObjectId, ContainerLO_Member_inf.ObjectId)))))))))
                           END AS ObjectId_Direction
                         , CASE WHEN tmpReport_All.MovementDescId IN (zc_Movement_BankAccount(), zc_Movement_Cash())
                                     THEN COALESCE (ContainerLO_Cash_inf.ObjectId, ContainerLO_BankAccount_inf.ObjectId)
                                ELSE COALESCE (ContainerLO_Goods.ObjectId, ContainerLO_Goods_inf.ObjectId)
                           END AS ObjectId_Destination
            
                         , SUM (tmpReport_All.SummStart)  AS SummStart
                         , SUM (tmpReport_All.SummIn)     AS SummIn
                         , SUM (tmpReport_All.SummOut)    AS SummOut
                         , SUM (tmpReport_All.SummEnd)    AS SummEnd
            
                         , tmpReport_All.MovementDescId
                         , tmpReport_All.InvNumber
                         , tmpReport_All.MovementId
                         , tmpReport_All.OperDate
            
                         , tmpReport_All.AccountId
                         , tmpReport_All.AccountId_inf
                         , ContainerLO_ProfitLoss_inf.ObjectId AS ProfitLossId_inf
                         , ContainerLO_Business_inf.ObjectId AS BusinessId_inf
                         , COALESCE (ContainerLO_Branch_inf.ObjectId, tmpReport_All.BranchId_inf) AS BranchId_inf
            
                         , tmpReport_All.ObjectId_inf
                         , tmpReport_All.MoneyPlaceId_inf
                         , tmpReport_All.UnitId_inf
                         , tmpReport_All.RouteId_inf
                         
                         , CLO_InfoMoneyDetail.ObjectId AS ObjectId_Detail
            
                    FROM tmpReport_All
                        LEFT JOIN tmpCLO AS ContainerLO_JuridicalBasis ON ContainerLO_JuridicalBasis.ContainerId = tmpReport_All.ContainerId
                                                                                   AND ContainerLO_JuridicalBasis.DescId = zc_ContainerLinkObject_JuridicalBasis()
                                                                                   AND ContainerLO_JuridicalBasis.ObjectId > 0
            
                        LEFT JOIN tmpCLO AS ContainerLO_Juridical ON ContainerLO_Juridical.ContainerId = tmpReport_All.ContainerId
                                                                              AND ContainerLO_Juridical.DescId = zc_ContainerLinkObject_Juridical()
                                                                              AND ContainerLO_Juridical.ObjectId > 0
                        LEFT JOIN tmpCLO AS ContainerLO_Unit ON ContainerLO_Unit.ContainerId = tmpReport_All.ContainerId
                                                                         AND ContainerLO_Unit.DescId = zc_ContainerLinkObject_Unit()
                                                                         AND ContainerLO_Unit.ObjectId > 0
                        LEFT JOIN tmpCLO AS ContainerLO_Car ON ContainerLO_Car.ContainerId = tmpReport_All.ContainerId
                                                                        AND ContainerLO_Car.DescId = zc_ContainerLinkObject_Car()
                                                                        AND ContainerLO_Car.ObjectId > 0
                        LEFT JOIN tmpCLO AS ContainerLO_Member ON ContainerLO_Member.ContainerId = tmpReport_All.ContainerId
                                                                           AND ContainerLO_Member.DescId = zc_ContainerLinkObject_Member()
                                                                           AND ContainerLO_Member.ObjectId > 0
                        LEFT JOIN tmpCLO AS ContainerLO_Cash ON ContainerLO_Cash.ContainerId = tmpReport_All.ContainerId
                                                                         AND ContainerLO_Cash.DescId = zc_ContainerLinkObject_Cash()
                                                                         AND ContainerLO_Cash.ObjectId > 0
                        LEFT JOIN tmpCLO AS ContainerLO_BankAccount ON ContainerLO_BankAccount.ContainerId = tmpReport_All.ContainerId
                                                                                AND ContainerLO_BankAccount.DescId = zc_ContainerLinkObject_BankAccount()
                                                                                AND ContainerLO_BankAccount.ObjectId > 0
            
                        LEFT JOIN tmpCLO AS ContainerLO_PaidKind ON ContainerLO_PaidKind.ContainerId = tmpReport_All.ContainerId
                                                                             AND ContainerLO_PaidKind.DescId = zc_ContainerLinkObject_PaidKind()
                                                                             AND ContainerLO_PaidKind.ObjectId > 0
                        LEFT JOIN tmpCLO AS ContainerLO_Contract ON ContainerLO_Contract.ContainerId = tmpReport_All.ContainerId
                                                                             AND ContainerLO_Contract.DescId = zc_ContainerLinkObject_Contract()
                                                                             AND ContainerLO_Contract.ObjectId > 0
            
                        LEFT JOIN tmpCLO_ProfitLoss AS ContainerLO_ProfitLoss_inf ON ContainerLO_ProfitLoss_inf.ContainerId = tmpReport_All.ContainerId_ProfitLoss
                                                                                   AND ContainerLO_ProfitLoss_inf.DescId = zc_ContainerLinkObject_ProfitLoss()
                                                                                   AND ContainerLO_ProfitLoss_inf.ObjectId > 0
                        LEFT JOIN tmpCLO_inf AS ContainerLO_Business_inf ON ContainerLO_Business_inf.ContainerId = tmpReport_All.ContainerId_inf
                                                                                 AND ContainerLO_Business_inf.DescId = zc_ContainerLinkObject_Business()
                                                                                 AND ContainerLO_Business_inf.ObjectId > 0
                        LEFT JOIN tmpCLO_inf AS ContainerLO_Branch_inf ON ContainerLO_Branch_inf.ContainerId = tmpReport_All.ContainerId_inf
                                                                               AND ContainerLO_Branch_inf.DescId = zc_ContainerLinkObject_Branch()
                                                                               AND ContainerLO_Branch_inf.ObjectId > 0
            
                        LEFT JOIN tmpCLO_inf AS ContainerLO_Juridical_inf ON ContainerLO_Juridical_inf.ContainerId = tmpReport_All.ContainerId_inf
                                                                                  AND ContainerLO_Juridical_inf.DescId = zc_ContainerLinkObject_Juridical()
                                                                                  AND ContainerLO_Juridical_inf.ObjectId > 0
                        LEFT JOIN tmpCLO_inf AS ContainerLO_Unit_inf ON ContainerLO_Unit_inf.ContainerId = tmpReport_All.ContainerId_inf
                                                                             AND ContainerLO_Unit_inf.DescId = zc_ContainerLinkObject_Unit()
                                                                             AND ContainerLO_Unit_inf.ObjectId > 0
                        LEFT JOIN tmpCLO_inf AS ContainerLO_Car_inf ON ContainerLO_Car_inf.ContainerId = tmpReport_All.ContainerId_inf
                                                                            AND ContainerLO_Car_inf.DescId = zc_ContainerLinkObject_Car()
                                                                            AND ContainerLO_Car_inf.ObjectId > 0
                        LEFT JOIN tmpCLO_inf AS ContainerLO_Member_inf ON ContainerLO_Member_inf.ContainerId = tmpReport_All.ContainerId_inf
                                                                               AND ContainerLO_Member_inf.DescId = zc_ContainerLinkObject_Member()
                                                                               AND ContainerLO_Member_inf.ObjectId > 0
                        LEFT JOIN tmpCLO_inf AS ContainerLO_Cash_inf ON ContainerLO_Cash_inf.ContainerId = tmpReport_All.ContainerId_inf
                                                                             AND ContainerLO_Cash_inf.DescId = zc_ContainerLinkObject_Cash()
                                                                             AND ContainerLO_Cash_inf.ObjectId > 0
                        LEFT JOIN tmpCLO_inf AS ContainerLO_BankAccount_inf ON ContainerLO_BankAccount_inf.ContainerId = tmpReport_All.ContainerId_inf
                                                                                    AND ContainerLO_BankAccount_inf.DescId = zc_ContainerLinkObject_BankAccount()
                                                                                    AND ContainerLO_BankAccount_inf.ObjectId > 0
            
                        LEFT JOIN tmpCLO AS ContainerLO_InfoMoney ON ContainerLO_InfoMoney.ContainerId = tmpReport_All.ContainerId
                                                                              AND ContainerLO_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
                                                                              AND ContainerLO_InfoMoney.ObjectId > 0
                        LEFT JOIN tmpCLO_inf AS ContainerLO_InfoMoney_inf ON ContainerLO_InfoMoney_inf.ContainerId = tmpReport_All.ContainerId_inf
                                                                                  AND ContainerLO_InfoMoney_inf.DescId = zc_ContainerLinkObject_InfoMoney()
                                                                                  AND ContainerLO_InfoMoney_inf.ObjectId > 0
                        LEFT JOIN tmpCLO AS ContainerLO_Goods ON ContainerLO_Goods.ContainerId = tmpReport_All.ContainerId
                                                                          AND ContainerLO_Goods.DescId = zc_ContainerLinkObject_Goods()
                                                                          AND ContainerLO_Goods.ObjectId > 0
                                                                          AND inIsGoods = TRUE
                        LEFT JOIN tmpCLO_inf AS ContainerLO_Goods_inf ON ContainerLO_Goods_inf.ContainerId = tmpReport_All.ContainerId_inf
                                                                              AND ContainerLO_Goods_inf.DescId = zc_ContainerLinkObject_Goods()
                                                                              AND ContainerLO_Goods_inf.ObjectId > 0
                                                                              AND inIsGoods = TRUE
                        LEFT JOIN tmpInfoMoneyDetail AS CLO_InfoMoneyDetail 
                                                     ON CLO_InfoMoneyDetail.ContainerId = tmpReport_All.ContainerId

                    GROUP BY ContainerLO_JuridicalBasis.ObjectId
                           , tmpReport_All.BusinessId
                           , COALESCE (ContainerLO_InfoMoney.ObjectId, ContainerLO_InfoMoney_inf.ObjectId)
                           , ContainerLO_PaidKind.ObjectId
                           , ContainerLO_Contract.ObjectId
                           , CASE WHEN tmpReport_All.MovementDescId IN (zc_Movement_BankAccount(), zc_Movement_Cash())
                                       THEN tmpReport_All.ObjectId_inf
                                  ELSE COALESCE (ContainerLO_Cash.ObjectId, COALESCE (ContainerLO_BankAccount.ObjectId, COALESCE (ContainerLO_Juridical.ObjectId, COALESCE (ContainerLO_Unit.ObjectId, COALESCE (ContainerLO_Car.ObjectId, COALESCE (ContainerLO_Member.ObjectId
                                               , COALESCE (ContainerLO_Juridical_inf.ObjectId, COALESCE (ContainerLO_Unit_inf.ObjectId, COALESCE (ContainerLO_Car_inf.ObjectId, ContainerLO_Member_inf.ObjectId)))))))))
                             END
                           , CASE WHEN tmpReport_All.MovementDescId IN (zc_Movement_BankAccount(), zc_Movement_Cash())
                                       THEN COALESCE (ContainerLO_Cash_inf.ObjectId, ContainerLO_BankAccount_inf.ObjectId)
                                  ELSE COALESCE (ContainerLO_Goods.ObjectId, ContainerLO_Goods_inf.ObjectId)
                             END
            
                           , tmpReport_All.MovementDescId
                           , tmpReport_All.OperDate
                           , tmpReport_All.MovementId  
                           , tmpReport_All.InvNumber
            
                           , tmpReport_All.AccountId
                           , tmpReport_All.AccountId_inf
                           , ContainerLO_ProfitLoss_inf.ObjectId
                           , ContainerLO_Business_inf.ObjectId
                           , ContainerLO_Branch_inf.ObjectId
            
                           , tmpReport_All.ObjectId_inf
                           , tmpReport_All.MoneyPlaceId_inf
                           , tmpReport_All.BranchId_inf
                           , tmpReport_All.UnitId_inf
                           , tmpReport_All.RouteId_inf
                           
                           , CLO_InfoMoneyDetail.ObjectId
                           , tmpReport_All.GoodsKindId
                    )
               
               
    -- ���������
    SELECT zfConvert_StringToNumber (tmpReport.InvNumber) AS InvNumber
         , tmpReport.MovementId
         , tmpReport.OperDate
         , MovementDesc.ItemName             AS MovementDescName
         , View_InfoMoney.InfoMoneyCode
         , View_InfoMoney.InfoMoneyGroupName
         , View_InfoMoney.InfoMoneyDestinationName
         , View_InfoMoney.InfoMoneyName
         , Object_JuridicalBasis.ObjectCode  AS JuridicalBasisCode
         , Object_JuridicalBasis.ValueData   AS JuridicalBasisName
         , Object_Business.ObjectCode        AS BusinessCode
         , Object_Business.ValueData         AS BusinessName
         , Object_PaidKind.ValueData         AS PaidKindName
         , View_Contract_InvNumber.InvNumber AS ContractName

         , Object_Direction.Id             AS ObjectId_Direction
         , Object_Direction.ObjectCode     AS ObjectCode_Direction
         , (COALESCE (Object_Bank.ValueData || ' * ', '') || Object_Direction.ValueData) :: TVarChar AS ObjectName_Direction
         , Object_Destination.ObjectCode   AS ObjectCode_Destination
         , Object_Destination.ValueData    AS ObjectName_Destination
         , ObjectDesc_Direction.ItemName   AS DescName_Direction
         , ObjectDesc_Destination.ItemName AS DescName_Destination
         , Object_GoodsKind.ValueData      AS GoodsKindName

         , Object_Route_inf.ObjectCode    AS RouteCode_inf
         , Object_Route_inf.ValueData     AS RouteName_inf

         , Object_Unit_inf.ObjectCode     AS UnitCode_inf
         , Object_Unit_inf.ValueData      AS UnitName_inf
         , Object_Branch_inf.ObjectCode   AS BranchCode_inf
         , Object_Branch_inf.ValueData    AS BranchName_inf
         , Object_Business_inf.ObjectCode AS BusinessCode_inf
         , Object_Business_inf.ValueData  AS BusinessName_inf

         , tmpReport.SummStart :: TFloat AS SummStart
         , tmpReport.SummIn    :: TFloat AS SummIn
         , tmpReport.SummOut   :: TFloat AS SummOut
         , tmpReport.SummEnd   :: TFloat AS SummEnd
         
         , View_Account.AccountGroupCode
         , View_Account.AccountGroupName
         , View_Account.AccountDirectionCode
         , View_Account.AccountDirectionName
         , View_Account.AccountCode
         , View_Account.AccountName
         , View_Account.AccountName_All

         , View_Account_inf.AccountGroupCode      AS AccountGroupCode_inf
         , View_Account_inf.AccountGroupName      AS AccountGroupName_inf
         , View_Account_inf.AccountDirectionCode  AS AccountDirectionCode_inf
         , View_Account_inf.AccountDirectionName  AS AccountDirectionName_inf
         , View_Account_inf.AccountCode           AS AccountCode_inf
         , View_Account_inf.AccountName           AS AccountName_inf
         , View_Account_inf.AccountName_all       AS AccountName_All_inf

         , View_ProfitLoss_inf.ProfitLossName_all AS ProfitLossName_All_inf

         , View_InfoMoneyDetail.InfoMoneyId              AS InfoMoneyId_Detail
         , View_InfoMoneyDetail.InfoMoneyCode            AS InfoMoneyCode_Detail
         , View_InfoMoneyDetail.InfoMoneyGroupName       AS InfoMoneyGroupName_Detail
         , View_InfoMoneyDetail.InfoMoneyDestinationName AS InfoMoneyDestinationName_Detail
         , View_InfoMoneyDetail.InfoMoneyName            AS InfoMoneyName_Detail
         , View_InfoMoneyDetail.InfoMoneyName_all        AS InfoMoneyName_all_Detail

   FROM tmpReport

       LEFT JOIN Object AS Object_JuridicalBasis ON Object_JuridicalBasis.Id = tmpReport.JuridicalBasisId
       LEFT JOIN Object AS Object_Business ON Object_Business.Id = tmpReport.BusinessId
       LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = tmpReport.PaidKindId
       LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = tmpReport.ContractId

       LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = tmpReport.InfoMoneyId
       LEFT JOIN Object_InfoMoney_View AS View_InfoMoneyDetail ON View_InfoMoneyDetail.InfoMoneyId = tmpReport.ObjectId_Detail

       LEFT JOIN Object AS Object_Business_inf ON Object_Business_inf.Id = tmpReport.BusinessId_inf
       LEFT JOIN Object AS Object_Branch_inf ON Object_Branch_inf.Id = tmpReport.BranchId_inf
       LEFT JOIN Object AS Object_Unit_inf ON Object_Unit_inf.Id = tmpReport.UnitId_inf
       LEFT JOIN Object AS Object_Route_inf ON Object_Route_inf.Id = tmpReport.RouteId_inf
       LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpReport.GoodsKindId

       LEFT JOIN MovementDesc ON MovementDesc.Id = tmpReport.MovementDescId

       LEFT JOIN Object_Account_View AS View_Account ON View_Account.AccountId = tmpReport.AccountId
       LEFT JOIN Object_Account_View AS View_Account_inf ON View_Account_inf.AccountId = tmpReport.AccountId_inf

       LEFT JOIN Object_ProfitLoss_View AS View_ProfitLoss_inf ON View_ProfitLoss_inf.ProfitLossId = tmpReport.ProfitLossId_inf

       LEFT JOIN Object AS Object_Direction   ON Object_Direction.Id
                         = CASE WHEN tmpReport.MovementDescId IN (zc_Movement_BankAccount(), zc_Movement_Cash())
                                     THEN CASE WHEN tmpReport.SummIn > 0 THEN tmpReport.ObjectId_Direction ELSE tmpReport.ObjectId_Destination END
                                ELSE COALESCE (tmpReport.ObjectId_Direction
                                             , CASE WHEN tmpReport.SummIn > 0 THEN tmpReport.ObjectId_inf ELSE tmpReport.MoneyPlaceId_inf END
                                              )
                           END
       LEFT JOIN Object AS Object_Destination ON Object_Destination.Id
                         = CASE WHEN tmpReport.MovementDescId IN (zc_Movement_BankAccount(), zc_Movement_Cash()) 
                                     THEN CASE WHEN tmpReport.SummIn > 0 THEN tmpReport.ObjectId_Destination ELSE tmpReport.ObjectId_Direction END
                                ELSE COALESCE (tmpReport.ObjectId_Destination
                                             , CASE WHEN tmpReport.SummIn > 0 THEN tmpReport.MoneyPlaceId_inf ELSE tmpReport.ObjectId_inf END
                                              )
                           END

       LEFT JOIN ObjectDesc AS ObjectDesc_Direction ON ObjectDesc_Direction.Id = Object_Direction.DescId
       LEFT JOIN ObjectDesc AS ObjectDesc_Destination ON ObjectDesc_Destination.Id = Object_Destination.DescId

       LEFT JOIN ObjectLink AS ObjectLink_BankAccount_Bank
                            ON ObjectLink_BankAccount_Bank.ObjectId = tmpReport.ObjectId_Direction
                           AND ObjectLink_BankAccount_Bank.DescId = zc_ObjectLink_BankAccount_Bank()
       LEFT JOIN Object AS Object_Bank ON Object_Bank.Id = ObjectLink_BankAccount_Bank.ChildObjectId

    WHERE (View_ProfitLoss_inf.ProfitLossGroupId = inProfitLossGroupId OR 0 = inProfitLossGroupId)
      AND (View_ProfitLoss_inf.ProfitLossDirectionId = inProfitLossDirectionId OR 0 = inProfitLossDirectionId)
      AND (View_ProfitLoss_inf.ProfitLossId = inProfitLossId OR 0 = inProfitLossId)
      AND (COALESCE (View_InfoMoney.InfoMoneyGroupId, 0) <> zc_Enum_InfoMoneyGroup_60000() -- ���������� �����
        OR View_Account.AccountGroupId = zc_Enum_AccountGroup_110000 () -- �������
          )
    ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 18.06.18         *
*/

-- ����
-- SELECT * FROM lpReport_AccountMotion (inStartDate:= '01.06.2018', inEndDate:= '10.06.2018', inAccountGroupId:= 0, inAccountDirectionId:= 0, inInfoMoneyId:= 0, inAccountId:= 9128, inBusinessId:= 0, inProfitLossGroupId:= 0,  inProfitLossDirectionId:= 0,  inProfitLossId:= 0,  inBranchId:= 0, inUserId:= 5);

   -- IN inIsMovement             Boolean
