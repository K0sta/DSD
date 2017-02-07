-- Function: gpInsertUpdate_HistoryCost()

DROP FUNCTION IF EXISTS gpInsertUpdate_HistoryCost (TDateTime, TDateTime, Integer, Integer, Integer, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_HistoryCost(
    IN inStartDate       TDateTime , --
    IN inEndDate         TDateTime , --
    IN inBranchId        Integer , --
    IN inItearationCount Integer , --
    IN inInsert          Integer , --
    IN inDiffSumm        TFloat , --
    IN inSession         TVarChar    -- ������ ������������
)                              
--  RETURNS VOID
  RETURNS TABLE (vbItearation Integer, vbCountDiff Integer, Price TFloat, PriceNext TFloat, Price_external TFloat, PriceNext_external TFloat, FromContainerId Integer, ContainerId Integer, isInfoMoney_80401 Boolean, CalcSummCurrent TFloat, CalcSummNext TFloat, CalcSummCurrent_external TFloat, CalcSummNext_external TFloat, StartCount TFloat, StartSumm TFloat, IncomeCount TFloat, IncomeSumm TFloat, calcCount TFloat, calcSumm TFloat, calcCount_external TFloat, calcSumm_external TFloat, OutCount TFloat, OutSumm TFloat, UnitId Integer, UnitName TVarChar)
--  RETURNS TABLE (ContainerId Integer, StartCount TFloat, StartSumm TFloat, IncomeCount TFloat, IncomeSumm TFloat, calcCount TFloat, calcSumm TFloat, OutCount TFloat, OutSumm TFloat)
--  RETURNS TABLE (MasterContainerId Integer, ContainerId Integer, OperCount TFloat)
AS
$BODY$
   DECLARE vbStartDate_zavod TDateTime;
   DECLARE vbEndDate_zavod TDateTime;

   DECLARE vbItearation Integer;
   DECLARE vbCountDiff Integer;

   DECLARE vb11 TFloat;
   DECLARE vb12 TFloat;
   DECLARE vb13 TFloat;
   DECLARE vb14 TFloat;

   DECLARE vb21 TFloat;
   DECLARE vb22 TFloat;
   DECLARE vb23 TFloat;
   DECLARE vb24 TFloat;

   DECLARE vb31 TFloat;
   DECLARE vb32 TFloat;
   DECLARE vb33 TFloat;
   DECLARE vb34 TFloat;

   DECLARE vb41 TFloat;
   DECLARE vb42 TFloat;
   DECLARE vb43 TFloat;
   DECLARE vb44 TFloat;

   DECLARE vb51 TFloat;
   DECLARE vb52 TFloat;
   DECLARE vb53 TFloat;
   DECLARE vb54 TFloat;

   DECLARE vb61 TFloat;
   DECLARE vb62 TFloat;
   DECLARE vb63 TFloat;
   DECLARE vb64 TFloat;

   DECLARE vb71 TFloat;
   DECLARE vb72 TFloat;
   DECLARE vb73 TFloat;
   DECLARE vb74 TFloat;

   DECLARE vb81 TFloat;
   DECLARE vb82 TFloat;
   DECLARE vb83 TFloat;
   DECLARE vb84 TFloat;

   DECLARE vb91 TFloat;
   DECLARE vb92 TFloat;
   DECLARE vb93 TFloat;
   DECLARE vb94 TFloat;

   DECLARE vb101 TFloat;
   DECLARE vb102 TFloat;
   DECLARE vb103 TFloat;
   DECLARE vb104 TFloat;

   DECLARE vb111 TFloat;
   DECLARE vb112 TFloat;
   DECLARE vb113 TFloat;
   DECLARE vb114 TFloat;

   DECLARE vb121 TFloat;
   DECLARE vb122 TFloat;
   DECLARE vb123 TFloat;
   DECLARE vb124 TFloat;

   DECLARE vb131 TFloat;
   DECLARE vb132 TFloat;
   DECLARE vb133 TFloat;
   DECLARE vb134 TFloat;

   DECLARE vb141 TFloat;
   DECLARE vb142 TFloat;
   DECLARE vb143 TFloat;
   DECLARE vb144 TFloat;

   DECLARE vb151 TFloat;
   DECLARE vb152 TFloat;
   DECLARE vb153 TFloat;
   DECLARE vb154 TFloat;

   DECLARE vb161 TFloat;
   DECLARE vb162 TFloat;
   DECLARE vb163 TFloat;
   DECLARE vb164 TFloat;

   DECLARE vb171 TFloat;
   DECLARE vb172 TFloat;
   DECLARE vb173 TFloat;
   DECLARE vb174 TFloat;

   DECLARE vb181 TFloat;
   DECLARE vb182 TFloat;
   DECLARE vb183 TFloat;
   DECLARE vb184 TFloat;

   DECLARE vb191 TFloat;
   DECLARE vb192 TFloat;
   DECLARE vb193 TFloat;
   DECLARE vb194 TFloat;

   DECLARE vb201 TFloat;
   DECLARE vb202 TFloat;
   DECLARE vb203 TFloat;
   DECLARE vb204 TFloat;

   DECLARE vb211 TFloat;
   DECLARE vb212 TFloat;
   DECLARE vb213 TFloat;
   DECLARE vb214 TFloat;

   DECLARE vb221 TFloat;
   DECLARE vb222 TFloat;
   DECLARE vb223 TFloat;
   DECLARE vb224 TFloat;

   DECLARE vb231 TFloat;
   DECLARE vb232 TFloat;
   DECLARE vb233 TFloat;
   DECLARE vb234 TFloat;

   DECLARE vb241 TFloat;
   DECLARE vb242 TFloat;
   DECLARE vb243 TFloat;
   DECLARE vb244 TFloat;

   DECLARE vb251 TFloat;
   DECLARE vb252 TFloat;
   DECLARE vb253 TFloat;
   DECLARE vb254 TFloat;

   DECLARE vb261 TFloat;
   DECLARE vb262 TFloat;
   DECLARE vb263 TFloat;
   DECLARE vb264 TFloat;

   DECLARE vb271 TFloat;
   DECLARE vb272 TFloat;
   DECLARE vb273 TFloat;
   DECLARE vb274 TFloat;

   DECLARE vb281 TFloat;
   DECLARE vb282 TFloat;
   DECLARE vb283 TFloat;
   DECLARE vb284 TFloat;

   DECLARE vb291 TFloat;
   DECLARE vb292 TFloat;
   DECLARE vb293 TFloat;
   DECLARE vb294 TFloat;

   DECLARE vb301 TFloat;
   DECLARE vb302 TFloat;
   DECLARE vb303 TFloat;
   DECLARE vb304 TFloat;

   DECLARE vb311 TFloat;
   DECLARE vb312 TFloat;
   DECLARE vb313 TFloat;
   DECLARE vb314 TFloat;

   DECLARE vb321 TFloat;
   DECLARE vb322 TFloat;
   DECLARE vb323 TFloat;
   DECLARE vb324 TFloat;

   DECLARE vb331 TFloat;
   DECLARE vb332 TFloat;
   DECLARE vb333 TFloat;
   DECLARE vb334 TFloat;

   DECLARE vb341 TFloat;
   DECLARE vb342 TFloat;
   DECLARE vb343 TFloat;
   DECLARE vb344 TFloat;

   DECLARE vb351 TFloat;
   DECLARE vb352 TFloat;
   DECLARE vb353 TFloat;
   DECLARE vb354 TFloat;

BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_InsertUpdate_HistoryCost());

-- !!!��������!!!
-- RETURN;
-- IF inBranchId <> 8379 THEN RETURN; END IF;

-- !!!��������!!!
-- IF inStartDate = '01.01.2017' THEN inItearationCount:= 100; END IF;
 IF inItearationCount >= 800 THEN inItearationCount:= 400; END IF;
-- !!!��������!!!

     -- !!!���� �� ������, ����� ��������� ���� ������ 1-�� ����� ������!!!
     vbStartDate_zavod:= DATE_TRUNC ('MONTH', inStartDate);
     -- !!!���� �� ������, ����� �������� ���� ������ ��������� ����� ������!!!
     vbEndDate_zavod:= DATE_TRUNC ('MONTH', inStartDate) + INTERVAL '1 MONTH' - INTERVAL '1 DAY';
/*
-- if inBranchId = 0 then return; end if;
if inBranchId = 0 then
     inStartDate:= '01.05.2016';
     inEndDate  := '30.05.2016';
     vbStartDate_zavod:= '01.05.2016';
     vbEndDate_zavod  := '30.05.2016';
end if;
*/

     -- ������� - ������ ��������� ������� �������� ���������� �/�.
     CREATE TEMP TABLE _tmpMaster (ContainerId Integer, UnitId Integer, isInfoMoney_80401 Boolean, StartCount TFloat, StartSumm TFloat, IncomeCount TFloat, IncomeSumm TFloat, calcCount TFloat, calcSumm TFloat, calcCount_external TFloat, calcSumm_external TFloat, OutCount TFloat, OutSumm TFloat) ON COMMIT DROP;
     -- ������� - ������� ��� Master
     CREATE TEMP TABLE _tmpChild (MasterContainerId Integer, ContainerId Integer, MasterContainerId_Count Integer, ContainerId_Count Integer, OperCount TFloat, isExternal Boolean, DescId Integer) ON COMMIT DROP;
     -- ������� - "����������"
     CREATE TEMP TABLE _tmpDiff (ContainerId Integer, MovementItemId_diff Integer, Summ_diff TFloat) ON COMMIT DROP;

     -- ������� - ������ ������ + ������ ���������
     CREATE TEMP TABLE _tmpUnit_branch (UnitId Integer) ON COMMIT DROP;
     INSERT INTO _tmpUnit_branch (UnitId)
        SELECT ObjectLink_Unit_Branch.ObjectId AS UnitId
        FROM ObjectLink AS ObjectLink_Unit_Branch
        WHERE COALESCE (inBranchId, 0) <= 0
          -- AND ObjectLink_Unit_Branch.ChildObjectId <> zc_Branch_Basis()
          AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
          AND ObjectLink_Unit_Branch.ChildObjectId IN (8374   -- 4. ������ ������
                                                     , 301310 -- 11. ������ ���������
                                                     , 8373   -- 3. ������ �������� (������)
                                                     , 8375   -- 5. ������ �������� (����������)
                                                     , 8377   -- 7. ������ ��.���
                                                     , 8381   -- 9. ������ �������
                                                     , 8379   -- 2. ������ ����
                                                      )
      UNION
       SELECT ObjectLink_Unit_Branch.ObjectId AS UnitId
        FROM ObjectLink AS ObjectLink_Unit_Branch
        WHERE inBranchId > 0
          AND ObjectLink_Unit_Branch.ChildObjectId = inBranchId
          AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
       ;     
     -- ������� - ������ ������ + ������ ���������
     CREATE TEMP TABLE _tmpContainer_branch (ContainerId Integer) ON COMMIT DROP;
     INSERT INTO _tmpContainer_branch (ContainerId)
        SELECT ContainerLinkObject.ContainerId
        FROM _tmpUnit_branch
             INNER JOIN ContainerLinkObject ON ContainerLinkObject.ObjectId = _tmpUnit_branch.UnitId
                                           AND ContainerLinkObject.DescId = zc_ContainerLinkObject_Unit()
       ;


     -- ��������� ������� ���������� � ����� - ���, ������, ������
       WITH tmpContainerS_zavod AS (SELECT Container_Summ.*
                                    FROM Container AS Container_Summ
                                         LEFT JOIN _tmpContainer_branch ON _tmpContainer_branch.ContainerId = Container_Summ.Id
                                    WHERE _tmpContainer_branch.ContainerId IS NULL
                                      AND Container_Summ.DescId = zc_Container_Summ()
                                      AND Container_Summ.ParentId > 0
                                      AND Container_Summ.ObjectId <> zc_Enum_Account_20901()  -- ������ + ��������� ����
                                      AND Container_Summ.ObjectId <> zc_Enum_Account_110101() -- ������� + ����� � ����
                                   )
         , tmpContainerS_branch AS (SELECT Container_Summ.*
                                    FROM Container AS Container_Summ
                                         INNER JOIN _tmpContainer_branch ON _tmpContainer_branch.ContainerId = Container_Summ.Id
                                    WHERE Container_Summ.DescId = zc_Container_Summ()
                                      AND Container_Summ.ParentId > 0
                                      AND Container_Summ.ObjectId <> zc_Enum_Account_20901()  -- ������ + ��������� ����
                                      AND Container_Summ.ObjectId <> zc_Enum_Account_110101() -- ������� + ����� � ����
                                   )
           , tmpContainerList AS (SELECT Container_Summ.Id, Container_Summ.ParentId, Container_Summ.ObjectId
                                  FROM tmpContainerS_zavod AS Container_Summ
                                       LEFT JOIN MovementItemContainer AS MIContainer
                                                                       ON MIContainer.ContainerId = Container_Summ.Id
                                                                      AND MIContainer.OperDate >= vbStartDate_zavod
                                                                      AND MIContainer.AccountId <> zc_Enum_Account_110101() -- ������� + ����� � ����
                                  WHERE Container_Summ.DescId = zc_Container_Summ()
                                    AND Container_Summ.ParentId > 0
                                    AND Container_Summ.ObjectId <> zc_Enum_Account_20901()  -- ������ + ��������� ����
                                    AND Container_Summ.ObjectId <> zc_Enum_Account_110101() -- ������� + ����� � ����
                                  GROUP BY Container_Summ.Id, Container_Summ.ParentId, Container_Summ.Amount, Container_Summ.ObjectId
                                  HAVING Container_Summ.Amount - COALESCE (SUM (MIContainer.Amount), 0) <> 0 -- AS StartSumm
                                      OR MAX (CASE WHEN MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod THEN Container_Summ.Id ELSE 0 END) > 0
                                 UNION ALL
                                  SELECT Container_Summ.Id, Container_Summ.ParentId, Container_Summ.ObjectId
                                  FROM tmpContainerS_branch AS Container_Summ
                                       LEFT JOIN MovementItemContainer AS MIContainer
                                                                       ON MIContainer.ContainerId = Container_Summ.Id
                                                                      AND MIContainer.OperDate >= inStartDate
                                                                      AND MIContainer.AccountId <> zc_Enum_Account_110101() -- ������� + ����� � ����
                                  WHERE Container_Summ.DescId = zc_Container_Summ()
                                    AND Container_Summ.ParentId > 0
                                    AND Container_Summ.ObjectId <> zc_Enum_Account_20901()  -- ������ + ��������� ����
                                    AND Container_Summ.ObjectId <> zc_Enum_Account_110101() -- ������� + ����� � ����
                                  GROUP BY Container_Summ.Id, Container_Summ.ParentId, Container_Summ.Amount, Container_Summ.ObjectId
                                  HAVING Container_Summ.Amount - COALESCE (SUM (MIContainer.Amount), 0) <> 0 -- AS StartSumm
                                      OR MAX (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate THEN Container_Summ.Id ELSE 0 END) > 0
                                 )
     , tmpContainer_zavod AS (SELECT Container.*, COALESCE (Object_Unit.Id, 0) AS UnitId
                                   , CASE WHEN 1 = 0 /*ObjectLink_Unit_HistoryCost.ChildObjectId > 0*/ THEN TRUE ELSE FALSE END AS isHistoryCost_ReturnIn
                              FROM Container
                                   LEFT JOIN _tmpContainer_branch ON _tmpContainer_branch.ContainerId = Container.Id
                                   LEFT JOIN ContainerLinkObject AS ContainerLinkObject_Account
                                                                 ON ContainerLinkObject_Account.ContainerId = Container.Id
                                                                AND ContainerLinkObject_Account.DescId = zc_ContainerLinkObject_Account()
                                   LEFT JOIN ContainerLinkObject AS ContainerLinkObject_Unit
                                                                 ON ContainerLinkObject_Unit.ContainerId = Container.Id
                                                                AND ContainerLinkObject_Unit.DescId = zc_ContainerLinkObject_Unit()
                                   LEFT JOIN Object AS Object_Unit ON Object_Unit.Id     = ContainerLinkObject_Unit.ObjectId
                                                                  AND Object_Unit.Id     <> zc_Juridical_Basis()
                                                                  -- AND Object_Unit.DescId <> zc_Object_Juridical()
                                   LEFT JOIN ObjectLink AS ObjectLink_Unit_HistoryCost
                                                        ON ObjectLink_Unit_HistoryCost.ObjectId = ContainerLinkObject_Unit.ObjectId
                                                       AND ObjectLink_Unit_HistoryCost.DescId = zc_ObjectLink_Unit_HistoryCost()
                              WHERE _tmpContainer_branch.ContainerId IS NULL
                                AND ((Container.DescId = zc_Container_Count() AND ContainerLinkObject_Account.ContainerId IS NULL)
                                  OR (Container.DescId = zc_Container_Summ() AND Container.ParentId > 0 AND Container.ObjectId <> zc_Enum_Account_110101()) -- ������� + ����� � ����
                                    )
                             )
    , tmpContainer_branch AS (SELECT Container.*, COALESCE (Object_Unit.Id, 0) AS UnitId
                                   , CASE WHEN ObjectLink_Unit_HistoryCost.ChildObjectId > 0 THEN TRUE ELSE FALSE END AS isHistoryCost_ReturnIn
                              FROM Container
                                   INNER JOIN _tmpContainer_branch ON _tmpContainer_branch.ContainerId = Container.Id
                                   LEFT JOIN ContainerLinkObject AS ContainerLinkObject_Account
                                                                 ON ContainerLinkObject_Account.ContainerId = Container.Id
                                                                AND ContainerLinkObject_Account.DescId = zc_ContainerLinkObject_Account()
                                   LEFT JOIN ContainerLinkObject AS ContainerLinkObject_Unit
                                                                 ON ContainerLinkObject_Unit.ContainerId = Container.Id
                                                                AND ContainerLinkObject_Unit.DescId = zc_ContainerLinkObject_Unit()
                                   LEFT JOIN Object AS Object_Unit ON Object_Unit.Id     = ContainerLinkObject_Unit.ObjectId
                                                                  AND Object_Unit.Id     <> zc_Juridical_Basis()
                                                                  -- AND Object_Unit.DescId <> zc_Object_Juridical()
                                   LEFT JOIN ObjectLink AS ObjectLink_Unit_HistoryCost
                                                        ON ObjectLink_Unit_HistoryCost.ObjectId = ContainerLinkObject_Unit.ObjectId
                                                       AND ObjectLink_Unit_HistoryCost.DescId = zc_ObjectLink_Unit_HistoryCost()
                              WHERE ((Container.DescId = zc_Container_Count() AND ContainerLinkObject_Account.ContainerId IS NULL)
                                  OR (Container.DescId = zc_Container_Summ() AND Container.ParentId > 0 AND Container.ObjectId <> zc_Enum_Account_110101()) -- ������� + ����� � ����
                                    )
                             )
       -- , tmpAccount_60000 AS (SELECT Object_Account_View.AccountId FROM Object_Account_View WHERE Object_Account_View.AccountGroupId = zc_Enum_AccountGroup_60000()) -- ������� ������� ��������

     INSERT INTO _tmpMaster (ContainerId, UnitId, isInfoMoney_80401, StartCount, StartSumm, IncomeCount, IncomeSumm, calcCount, calcSumm, calcCount_external, calcSumm_external, OutCount, OutSumm)
        SELECT COALESCE (Container_Summ.Id, tmpContainer.ContainerId) AS ContainerId
             , tmpContainer.UnitId AS UnitId
             , CASE WHEN ContainerLinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_80401() OR ContainerLinkObject_InfoMoneyDetail.ObjectId = zc_Enum_InfoMoney_80401()
                         THEN TRUE
                    ELSE FALSE
               END AS isInfoMoney_80401 -- ������� �������� �������

             , SUM (tmpContainer.StartCount) AS StartCount
             , SUM (tmpContainer.StartSumm)  AS StartSumm
             , SUM (tmpContainer.IncomeCount) + SUM (CASE WHEN ContainerLinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_80401() OR ContainerLinkObject_InfoMoneyDetail.ObjectId = zc_Enum_InfoMoney_80401() -- ������� �������� �������
                                                             THEN tmpContainer.SendOnPriceCountIn_Cost
                                                          ELSE 0 -- tmpContainer.SendOnPriceCountIn
                                                     END)
                                              + SUM (CASE WHEN tmpContainer.isHistoryCost_ReturnIn = TRUE
                                                             THEN tmpContainer.ReturnInCount
                                                          ELSE 0
                                                     END) AS IncomeCount
             , SUM (tmpContainer.IncomeSumm) + SUM (CASE WHEN ContainerLinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_80401() OR ContainerLinkObject_InfoMoneyDetail.ObjectId = zc_Enum_InfoMoney_80401() -- ������� �������� �������
                                                              THEN tmpContainer.SendOnPriceSummIn_Cost
                                                         ELSE 0 -- tmpContainer.SendOnPriceSummIn
                                                    END)
                                              + SUM (CASE WHEN tmpContainer.isHistoryCost_ReturnIn = TRUE
                                                             THEN tmpContainer.ReturnInSumm
                                                          ELSE 0
                                                     END) AS IncomeSumm
             , SUM (tmpContainer.calcCount) + SUM (CASE WHEN ContainerLinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_80401() OR ContainerLinkObject_InfoMoneyDetail.ObjectId = zc_Enum_InfoMoney_80401() -- ������� �������� �������
                                                             THEN 0
                                                          ELSE tmpContainer.SendOnPriceCountIn
                                                     END) AS calcCount
             , SUM (tmpContainer.calcSumm) + SUM (CASE WHEN ContainerLinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_80401() OR ContainerLinkObject_InfoMoneyDetail.ObjectId = zc_Enum_InfoMoney_80401() -- ������� �������� �������
                                                              THEN 0
                                                         ELSE tmpContainer.SendOnPriceSummIn
                                                    END) AS calcSumm

             , SUM (tmpContainer.calcCount_external) + SUM (CASE WHEN ContainerLinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_80401() OR ContainerLinkObject_InfoMoneyDetail.ObjectId = zc_Enum_InfoMoney_80401() -- ������� �������� �������
                                                             THEN 0
                                                          ELSE tmpContainer.SendOnPriceCountIn
                                                     END) AS calcCount_external
             , SUM (tmpContainer.calcSumm_external) + SUM (CASE WHEN ContainerLinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_80401() OR ContainerLinkObject_InfoMoneyDetail.ObjectId = zc_Enum_InfoMoney_80401() -- ������� �������� �������
                                                              THEN 0
                                                         ELSE tmpContainer.SendOnPriceSummIn
                                                    END) AS calcSumm_external

             , SUM (tmpContainer.OutCount) + SUM (CASE WHEN ContainerLinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_80401() OR ContainerLinkObject_InfoMoneyDetail.ObjectId = zc_Enum_InfoMoney_80401() -- ������� �������� �������
                                                            THEN tmpContainer.SendOnPriceCountOut_Cost
                                                       ELSE tmpContainer.SendOnPriceCountOut
                                                  END) AS OutCount
             , SUM (tmpContainer.OutSumm) + SUM (CASE WHEN ContainerLinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_80401() OR ContainerLinkObject_InfoMoneyDetail.ObjectId = zc_Enum_InfoMoney_80401() -- ������� �������� �������
                                                           THEN tmpContainer.SendOnPriceSummOut_Cost
                                                      ELSE tmpContainer.SendOnPriceSummOut
                                                 END) AS OutSumm
        FROM (SELECT Container.Id AS ContainerId
                   , Container.UnitId
                   , Container.isHistoryCost_ReturnIn
                   , Container.DescId
                   , Container.ObjectId
                     -- Start
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) ELSE 0 END AS StartCount
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) ELSE 0 END AS StartSumm
                     -- Income
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Income()) AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod /*AND MIContainer.Amount > 0*/ THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS IncomeCount
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Income()) AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod /*AND MIContainer.Amount > 0*/ THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS IncomeSumm
                     -- SendOnPrice
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_SendOnPrice() AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.isActive = TRUE /*MIContainer.Amount > 0*/ THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceCountIn
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_SendOnPrice() AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.isActive = TRUE /*MIContainer.Amount > 0*/ THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceSummIn
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_SendOnPrice() AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.isActive = FALSE /*MIContainer.Amount < 0*/ THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceCountOut
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_SendOnPrice() AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.isActive = FALSE /*MIContainer.Amount < 0*/ THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceSummOut

                     -- <> ������� + ����� � ����
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MovementBoolean_HistoryCost.ValueData = TRUE AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceCountIn_Cost
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MovementBoolean_HistoryCost.ValueData = TRUE AND MIContainer.AccountId <> zc_Enum_Account_110101() AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceSummIn_Cost

                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN COALESCE (MovementBoolean_HistoryCost.ValueData, FALSE) = FALSE AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceCountOut_Cost
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN COALESCE (MovementBoolean_HistoryCost.ValueData, FALSE) = FALSE AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceSummOut_Cost
                     -- Calc
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Send(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.Amount > 0 THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                   + CASE WHEN Container.DescId = zc_Container_CountSupplier() THEN Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) + COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_Income() AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                   + CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_ProductionUnion()) AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.Amount < 0 AND MovementLinkObject_User.ObjectId = zc_Enum_Process_Auto_Defroster() THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                     AS CalcCount
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Send(), zc_Movement_ProductionSeparate()) AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.Amount > 0 THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                   + CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_ProductionUnion()) AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.ParentId IS NULL THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                   - CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_ProductionUnion()) AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.ParentId IS NULL AND MovementLinkObject_User.ObjectId = zc_Enum_Process_Auto_Defroster() THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                     AS CalcSumm
                     -- Calc_external, �.�. AnalyzerId <> UnitId
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Send(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND COALESCE (MIContainer.AnalyzerId, 0) <> Container.UnitId AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.Amount > 0 THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                   + CASE WHEN Container.DescId = zc_Container_CountSupplier() THEN Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) + COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_Income() AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                     AS CalcCount_external
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Send(), zc_Movement_ProductionSeparate()) AND COALESCE (MIContainer.AnalyzerId, 0) <> Container.UnitId AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.Amount > 0 THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                   + CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_ProductionUnion()) AND COALESCE (MIContainer.AnalyzerId, 0) <> Container.UnitId AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.ParentId IS NULL THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                     AS CalcSumm_external
                     -- ReturnIn
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_ReturnIn() AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS ReturnInCount
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_ReturnIn() AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS ReturnInSumm
                     -- Out
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId NOT IN (zc_Movement_Income(), zc_Movement_SendOnPrice(), zc_Movement_Send(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod /*AND MIContainer.Amount < 0*/ THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS OutCount
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId NOT IN (zc_Movement_Income(), zc_Movement_SendOnPrice(), zc_Movement_Send(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod /*AND MIContainer.Amount < 0*/ THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS OutSumm
              FROM tmpContainer_zavod AS Container
                   LEFT JOIN ContainerLinkObject AS ContainerLinkObject_Account
                                                 ON ContainerLinkObject_Account.ContainerId = Container.Id
                                                AND ContainerLinkObject_Account.DescId = zc_ContainerLinkObject_Account()
                   LEFT JOIN MovementItemContainer AS MIContainer
                                                   ON MIContainer.ContainerId = Container.Id
                                                  AND MIContainer.OperDate >= vbStartDate_zavod
                                                  -- AND COALESCE (MIContainer.AccountId, 0) <> zc_Enum_Account_110101() -- ������� + ����� � ����
                   LEFT JOIN MovementBoolean AS MovementBoolean_HistoryCost
                                             ON MovementBoolean_HistoryCost.MovementId = MIContainer.MovementId
                                            AND MovementBoolean_HistoryCost.DescId = zc_MovementBoolean_HistoryCost()
                   LEFT JOIN MovementLinkObject AS MovementLinkObject_User
                                                ON MovementLinkObject_User.MovementId = MIContainer.MovementId
                                               AND MovementLinkObject_User.DescId = zc_MovementLinkObject_User()
              GROUP BY Container.Id
                     , Container.UnitId
                     , Container.isHistoryCost_ReturnIn
                     , Container.DescId
                     , Container.ObjectId
                     , Container.Amount
              HAVING (Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) <> 0)
                  OR (COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.Amount > 0 THEN MIContainer.Amount ELSE 0 END), 0) <> 0)
                  OR (COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod AND MIContainer.Amount < 0 THEN -MIContainer.Amount ELSE 0 END), 0) <> 0)
             UNION ALL
              SELECT Container.Id AS ContainerId
                   , Container.UnitId
                   , Container.isHistoryCost_ReturnIn
                   , Container.DescId
                   , Container.ObjectId
                     -- Start
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) ELSE 0 END AS StartCount
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) ELSE 0 END AS StartSumm
                     -- Income
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Income()) AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate /*AND MIContainer.Amount > 0*/ THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS IncomeCount
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Income()) AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate /*AND MIContainer.Amount > 0*/ THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS IncomeSumm
                     -- SendOnPrice
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_SendOnPrice() AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.isActive = TRUE /*MIContainer.Amount > 0*/ THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceCountIn
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_SendOnPrice() AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.isActive = TRUE /*MIContainer.Amount > 0*/ THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceSummIn
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_SendOnPrice() AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.isActive = FALSE /*MIContainer.Amount < 0*/ THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceCountOut
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_SendOnPrice() AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.isActive = FALSE /*MIContainer.Amount < 0*/ THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceSummOut

                     -- <> ������� + ����� � ����
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MovementBoolean_HistoryCost.ValueData = TRUE AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceCountIn_Cost
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MovementBoolean_HistoryCost.ValueData = TRUE AND MIContainer.AccountId <> zc_Enum_Account_110101() AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceSummIn_Cost

                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN COALESCE (MovementBoolean_HistoryCost.ValueData, FALSE) = FALSE AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceCountOut_Cost
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN COALESCE (MovementBoolean_HistoryCost.ValueData, FALSE) = FALSE AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS SendOnPriceSummOut_Cost
                     -- Calc
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Send(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount > 0 THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                   + CASE WHEN Container.DescId = zc_Container_CountSupplier() THEN Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) + COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_Income() AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                     AS CalcCount
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Send(), zc_Movement_ProductionSeparate()) AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount > 0 THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                   + CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_ProductionUnion()) AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.ParentId IS NULL THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                     AS CalcSumm
                     -- Calc_external, �.�. AnalyzerId <> UnitId
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Send(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND COALESCE (MIContainer.AnalyzerId, 0) <> Container.UnitId AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount > 0 THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                   + CASE WHEN Container.DescId = zc_Container_CountSupplier() THEN Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) + COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_Income() AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                     AS CalcCount_external
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_Send(), zc_Movement_ProductionSeparate()) AND COALESCE (MIContainer.AnalyzerId, 0) <> Container.UnitId AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount > 0 THEN  MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                   + CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId IN (zc_Movement_ProductionUnion()) AND COALESCE (MIContainer.AnalyzerId, 0) <> Container.UnitId AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.ParentId IS NULL THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END
                     AS CalcSumm_external
                     -- ReturnIn
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_ReturnIn() AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS ReturnInCount
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_ReturnIn() AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate THEN MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS ReturnInSumm
                     -- Out
                   , CASE WHEN Container.DescId = zc_Container_Count() THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId NOT IN (zc_Movement_Income(), zc_Movement_SendOnPrice(), zc_Movement_Send(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate /*AND MIContainer.Amount < 0*/ THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS OutCount
                   , CASE WHEN Container.DescId = zc_Container_Summ()  THEN COALESCE (SUM (CASE WHEN MIContainer.MovementDescId NOT IN (zc_Movement_Income(), zc_Movement_SendOnPrice(), zc_Movement_Send(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate /*AND MIContainer.Amount < 0*/ THEN -1 * MIContainer.Amount ELSE 0 END), 0) ELSE 0 END AS OutSumm
              FROM tmpContainer_branch AS Container
                   LEFT JOIN ContainerLinkObject AS ContainerLinkObject_Account
                                                 ON ContainerLinkObject_Account.ContainerId = Container.Id
                                                AND ContainerLinkObject_Account.DescId = zc_ContainerLinkObject_Account()
                   LEFT JOIN MovementItemContainer AS MIContainer
                                                   ON MIContainer.ContainerId = Container.Id
                                                  AND MIContainer.OperDate >= inStartDate
                                                  -- AND COALESCE (MIContainer.AccountId, 0) <> zc_Enum_Account_110101() -- ������� + ����� � ����

                   LEFT JOIN MovementBoolean AS MovementBoolean_HistoryCost
                                             ON MovementBoolean_HistoryCost.MovementId = MIContainer.MovementId
                                            AND MovementBoolean_HistoryCost.DescId = zc_MovementBoolean_HistoryCost()
              GROUP BY Container.Id
                     , Container.UnitId
                     , Container.isHistoryCost_ReturnIn
                     , Container.DescId
                     , Container.ObjectId
                     , Container.Amount
              HAVING (Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) <> 0)
                  OR (COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount > 0 THEN MIContainer.Amount ELSE 0 END), 0) <> 0)
                  OR (COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount < 0 THEN -MIContainer.Amount ELSE 0 END), 0) <> 0)
             ) AS tmpContainer
             LEFT JOIN tmpContainerList AS Container_Summ ON Container_Summ.ParentId = tmpContainer.ContainerId
                                                         AND tmpContainer.DescId = zc_Container_Count()
             /*LEFT JOIN Container AS Container_Summ
                                 ON Container_Summ.ParentId = tmpContainer.ContainerId
                                AND Container_Summ.DescId = zc_Container_Summ()
                                AND Container_Summ.ObjectId <> zc_Enum_Account_20901() -- "��������� ����"
                                AND tmpContainer.DescId = zc_Container_Count()*/
             LEFT JOIN ContainerLinkObject AS ContainerLinkObject_JuridicalBasis
                                           ON ContainerLinkObject_JuridicalBasis.ContainerId = tmpContainer.ContainerId
                                          AND ContainerLinkObject_JuridicalBasis.DescId = zc_ContainerLinkObject_JuridicalBasis()
                                          AND tmpContainer.DescId = zc_Container_Count()
             LEFT JOIN ContainerLinkObject AS ContainerLinkObject_Business
                                           ON ContainerLinkObject_Business.ContainerId = tmpContainer.ContainerId
                                          AND ContainerLinkObject_Business.DescId = zc_ContainerLinkObject_Business()
                                          AND tmpContainer.DescId = zc_Container_Count()
             /*LEFT JOIN lfSelect_ContainerSumm_byAccount (zc_Enum_Account_20901()) AS lfContainerSumm_20901
                                                                                  ON lfContainerSumm_20901.GoodsId = tmpContainer.ObjectId
                                                                                 AND lfContainerSumm_20901.JuridicalId_basis = COALESCE (ContainerLinkObject_JuridicalBasis.ObjectId, 0)
                                                                                 AND lfContainerSumm_20901.BusinessId = COALESCE (ContainerLinkObject_Business.ObjectId, 0)
                                                                                 AND tmpContainer.DescId = zc_Container_Count()*/

             /*LEFT JOIN ContainerObjectCost ON ContainerObjectCost.ObjectCostId = COALESCE (lfContainerSumm_20901.ContainerId, COALESCE (Container_Summ.Id, tmpContainer.ContainerId))
                                          AND ContainerObjectCost.ObjectCostDescId = zc_ObjectCost_Basis()*/

             -- LEFT JOIN tmpAccount_60000 ON tmpAccount_60000.AccountId = COALESCE (Container_Summ.ObjectId, tmpContainer.ObjectId)
             LEFT JOIN ContainerLinkObject AS ContainerLinkObject_InfoMoney
                                           ON ContainerLinkObject_InfoMoney.ContainerId = COALESCE (Container_Summ.Id, tmpContainer.ContainerId)
                                          AND ContainerLinkObject_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
             LEFT JOIN ContainerLinkObject AS ContainerLinkObject_InfoMoneyDetail
                                           ON ContainerLinkObject_InfoMoneyDetail.ContainerId = COALESCE (Container_Summ.Id, tmpContainer.ContainerId)
                                          AND ContainerLinkObject_InfoMoneyDetail.DescId = zc_ContainerLinkObject_InfoMoneyDetail()

        -- GROUP BY COALESCE (lfContainerSumm_20901.ContainerId, COALESCE (Container_Summ.Id, tmpContainer.ContainerId)) -- ContainerObjectCost.ObjectCostId
        GROUP BY COALESCE (Container_Summ.Id, tmpContainer.ContainerId) -- ContainerObjectCost.ObjectCostId
               , tmpContainer.UnitId
               , CASE WHEN ContainerLinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_80401() OR ContainerLinkObject_InfoMoneyDetail.ObjectId = zc_Enum_InfoMoney_80401() -- ������� �������� �������
                           THEN TRUE
                      ELSE FALSE
                 END
       ;

     -- ������ !!! Recycled !!!
     -- DELETE FROM _tmpMaster WHERE _tmpMaster.ContainerId IN (976442, 976754); -- 06.2016
     -- DELETE FROM _tmpMaster WHERE _tmpMaster.ContainerId IN (10705, 295520); -- 06.2016
     -- DELETE FROM _tmpMaster WHERE _tmpMaster.ContainerId IN (142372, 147559); -- 08.2016
     -- DELETE FROM _tmpMaster WHERE _tmpMaster.ContainerId IN (955225, 147523  -- 09.2016
     --                                                       , 955228, 189406, 955227, 147524, 955226, 147525, 955221, 147522, 1088976, 699999, 955223, 955224, 393568, 149497);
     -- DELETE FROM _tmpMaster WHERE _tmpMaster.ContainerId IN (647643, 663076, 639413, 633042, 633033); -- 11.2016
--     DELETE FROM _tmpMaster WHERE _tmpMaster.ContainerId IN (SELECT CLO.ContainerId FROM ContainerLinkObject as CLO WHERE CLO.DescId = zc_ContainerLinkObject_Member()
--                                                                                                                      AND CLO.ObjectId = 12573); -- ���������� ����� ��������


     IF inBranchId = 0 -- OR 1 = 1
     THEN
     -- ������� ��� Master
     INSERT INTO _tmpChild (MasterContainerId, ContainerId, MasterContainerId_Count, ContainerId_Count, OperCount, isExternal, DescId)
        WITH tmpContainer_count AS (SELECT Container.Id AS ContainerId
                                    FROM Container
                                         LEFT JOIN ContainerLinkObject AS ContainerLinkObject_Account
                                                                       ON ContainerLinkObject_Account.ContainerId = Container.Id
                                                                      AND ContainerLinkObject_Account.DescId = zc_ContainerLinkObject_Account()
                                         LEFT JOIN _tmpContainer_branch ON _tmpContainer_branch.ContainerId = Container.Id
                                    WHERE Container.DescId = zc_Container_Count() AND ContainerLinkObject_Account.ContainerId IS NULL
                                      AND _tmpContainer_branch.ContainerId IS NULL
                             )
            , tmpContainer_master AS (SELECT _tmpMaster.ContainerId
                                      FROM _tmpMaster
                                           LEFT JOIN _tmpContainer_branch ON _tmpContainer_branch.ContainerId = _tmpMaster.ContainerId
                                      WHERE _tmpContainer_branch.ContainerId IS NULL
                                     )
           , MIContainer_Count_In AS (SELECT MIContainer_Count_In.MovementItemId, MIContainer_Count_In.ContainerId, SUM (MIContainer_Count_In.Amount) AS Amount
                                      FROM tmpContainer_count
                                           INNER JOIN MovementItemContainer AS MIContainer_Count_In
                                                                            ON MIContainer_Count_In.OperDate BETWEEN inStartDate AND inEndDate
                                                                           AND MIContainer_Count_In.ContainerId  = tmpContainer_count.ContainerId
                                                                           AND MIContainer_Count_In.DescId       = zc_MIContainer_Count()
                                                                           AND MIContainer_Count_In.isActive     = TRUE
                                                                           AND MIContainer_Count_In.MovementDescId IN (zc_Movement_Send(), zc_Movement_SendOnPrice(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate())
                                      GROUP BY MIContainer_Count_In.MovementItemId, MIContainer_Count_In.ContainerId
                                     )
           , MIContainer_Count_Out AS (SELECT MIContainer_Count_Out.MovementId, MIContainer_Count_Out.MovementDescId, MIContainer_Count_Out.OperDate, MIContainer_Count_Out.MovementItemId, MIContainer_Count_Out.ContainerId, MIContainer_Count_Out.WhereObjectId_Analyzer, SUM (MIContainer_Count_Out.Amount) AS Amount
                                       FROM tmpContainer_count
                                            INNER JOIN MovementItemContainer AS MIContainer_Count_Out
                                                                             ON MIContainer_Count_Out.OperDate BETWEEN inStartDate AND inEndDate
                                                                            AND MIContainer_Count_Out.ContainerId = tmpContainer_count.ContainerId
                                                                            AND MIContainer_Count_Out.DescId      = zc_MIContainer_Count()
                                                                            AND MIContainer_Count_Out.isActive    = FALSE
                                                                            AND MIContainer_Count_Out.MovementDescId IN (zc_Movement_Send(), zc_Movement_SendOnPrice(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate())
                                       GROUP BY MIContainer_Count_Out.MovementId, MIContainer_Count_Out.MovementDescId, MIContainer_Count_Out.OperDate, MIContainer_Count_Out.MovementItemId, MIContainer_Count_Out.ContainerId, MIContainer_Count_Out.WhereObjectId_Analyzer
                                      )
           , MIContainer_Summ_Out AS (SELECT DISTINCT MIContainer_Summ_Out.MovementId, MIContainer_Summ_Out.MovementItemId
                                           , MIContainer_Summ_Out.ParentId, MIContainer_Summ_Out.ContainerId
                                      FROM _tmpMaster
                                           INNER JOIN MovementItemContainer AS MIContainer_Summ_Out
                                                                            ON MIContainer_Summ_Out.OperDate BETWEEN inStartDate AND inEndDate
                                                                           AND MIContainer_Summ_Out.ContainerId = _tmpMaster.ContainerId
                                                                           AND MIContainer_Summ_Out.DescId      = zc_MIContainer_Summ()
                                                                           AND MIContainer_Summ_Out.isActive    = FALSE
                                                                           AND MIContainer_Summ_Out.ParentId    > 0
                                                                           AND MIContainer_Summ_Out.MovementDescId IN (zc_Movement_Send(), zc_Movement_SendOnPrice(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate())
                                     )
            , MIContainer_Summ_In AS (SELECT tmp.ParentId, MIContainer_Summ_In.MovementId, MIContainer_Summ_In.ContainerId, MIContainer_Summ_In.MovementItemId, MIContainer_Summ_In.WhereObjectId_Analyzer
                                           , SUM (MIContainer_Summ_In.Amount) AS Amount
                                      FROM (SELECT DISTINCT MIContainer_Summ_Out.ParentId FROM MIContainer_Summ_Out) AS tmp
                                           INNER JOIN MovementItemContainer AS MIContainer_Summ_In ON MIContainer_Summ_In.Id = tmp.ParentId
                                           INNER JOIN tmpContainer_master ON tmpContainer_master.ContainerId = MIContainer_Summ_In.ContainerId
                                      GROUP BY tmp.ParentId, MIContainer_Summ_In.MovementId, MIContainer_Summ_In.ContainerId, MIContainer_Summ_In.MovementItemId, MIContainer_Summ_In.WhereObjectId_Analyzer
                                     )
        SELECT COALESCE (MIContainer_Summ_In.ContainerId, 0)   AS MasterContainerId
             , COALESCE (MIContainer_Summ_Out.ContainerId, 0)  AS ContainerId
             , COALESCE (MIContainer_Count_In.ContainerId, 0)  AS MasterContainerId_Count
             , COALESCE (MIContainer_Count_Out.ContainerId, 0) AS ContainerId_Count
             , SUM (CASE WHEN MIContainer_Count_Out.MovementDescId IN (zc_Movement_ProductionSeparate())
                             THEN CASE WHEN  COALESCE (_tmp.Summ, 0) <> 0 THEN COALESCE (-1 * MIContainer_Count_Out.Amount * MIContainer_Summ_In.Amount / _tmp.Summ, 0) ELSE 0 END
                         WHEN MIContainer_Count_Out.MovementDescId IN (zc_Movement_Send(), zc_Movement_SendOnPrice())
                             THEN COALESCE (1 * MIContainer_Count_In.Amount, 0)
                         WHEN MIContainer_Count_Out.MovementDescId IN (zc_Movement_ProductionUnion())
                             THEN COALESCE (-1 * MIContainer_Count_Out.Amount, 0)
                         ELSE 0
                    END) AS OperCount
             , CASE WHEN MIContainer_Count_Out.WhereObjectId_Analyzer = MIContainer_Summ_In.WhereObjectId_Analyzer THEN FALSE ELSE TRUE END AS isExternal
             , 0 AS MovementDescId
             -- , MIContainer_Count_Out.MovementDescId
        FROM MIContainer_Count_Out
             JOIN MIContainer_Summ_Out ON MIContainer_Summ_Out.MovementId     = MIContainer_Count_Out.MovementId
                                      AND MIContainer_Summ_Out.MovementItemId = MIContainer_Count_Out.MovementItemId

             JOIN MIContainer_Summ_In ON MIContainer_Summ_In.ParentId = MIContainer_Summ_Out.ParentId

             JOIN MIContainer_Count_In ON MIContainer_Count_In.MovementItemId = MIContainer_Summ_In.MovementItemId

             LEFT JOIN MovementLinkObject AS MovementLinkObject_User
                                          ON MovementLinkObject_User.MovementId = MIContainer_Count_Out.MovementId
                                         AND MovementLinkObject_User.DescId = zc_MovementLinkObject_User()
                                         AND MovementLinkObject_User.ObjectId = zc_Enum_Process_Auto_Defroster()

             LEFT JOIN (SELECT Movement.Id AS  MovementId
                             , MIContainer_Summ_Out.MovementItemId
                             , MIContainer_Summ_Out.ContainerId
                             , COALESCE (SUM (-1 * MIContainer_Summ_Out.Amount), 0) AS Summ
                        FROM Movement
                             LEFT JOIN MovementItemContainer AS MIContainer_Summ_Out
                                                             ON MIContainer_Summ_Out.MovementId = Movement.Id
                                                            AND MIContainer_Summ_Out.DescId = zc_MIContainer_Summ()
                                                            AND MIContainer_Summ_Out.isActive = FALSE
                        WHERE Movement.OperDate BETWEEN vbStartDate_zavod AND vbEndDate_zavod
                          AND Movement.DescId = zc_Movement_ProductionSeparate()
                          AND Movement.StatusId = zc_Enum_Status_Complete()
                        GROUP BY Movement.Id
                               , MIContainer_Summ_Out.MovementItemId
                               , MIContainer_Summ_Out.ContainerId
                       ) AS _tmp ON _tmp.MovementId = MIContainer_Count_Out.MovementId
                                AND _tmp.ContainerId = MIContainer_Summ_Out.ContainerId
                                AND _tmp.MovementItemId = MIContainer_Summ_Out.MovementItemId
                                AND MIContainer_Count_Out.MovementDescId = zc_Movement_ProductionSeparate()
        WHERE MovementLinkObject_User.MovementId IS NULL
        GROUP BY MIContainer_Summ_In.ContainerId
               , MIContainer_Summ_Out.ContainerId
               , MIContainer_Count_In.ContainerId
               , MIContainer_Count_Out.ContainerId
               , MIContainer_Count_Out.WhereObjectId_Analyzer
               , MIContainer_Summ_In.WhereObjectId_Analyzer
               -- , MIContainer_Count_Out.MovementDescId
        ;

     END IF; -- if inBranchId >= 0


/*     -- ����������� ����� ������� ��� (�.�. ������� �������� �� �����������)
       -- ����������� ����� ������� ��� (�.�. ������� �������� �� �����������) !!!�� �������� ������� ���� �� > 01.06.2014!!!*/


     -- !!!��������, ���� ������!!!
     -- delete from _tmpChild where _tmpChild.MasterContainerId IN ( SELECT _tmpChild.MasterContainerId FROM _tmpChild GROUP BY _tmpChild.MasterContainerId, _tmpChild.ContainerId HAVING COUNT(*) > 1);


     -- ��������1
     IF EXISTS (SELECT _tmpMaster.ContainerId FROM _tmpMaster GROUP BY _tmpMaster.ContainerId HAVING COUNT(*) > 1)
     THEN
         RAISE EXCEPTION '��������1 - SELECT ContainerId FROM _tmpMaster GROUP BY ContainerId HAVING COUNT(*) > 1 ContainerId = % + count = %'
                       , (SELECT _tmpMaster.ContainerId FROM _tmpMaster GROUP BY _tmpMaster.ContainerId HAVING COUNT(*) > 1 LIMIT 1)
                       , (SELECT COUNT(*) FROM _tmpMaster WHERE _tmpMaster.ContainerId IN (SELECT _tmpMaster.ContainerId FROM _tmpMaster GROUP BY _tmpMaster.ContainerId HAVING COUNT(*) > 1))
                        ;
     END IF;
     -- ��������2
     IF EXISTS (SELECT _tmpChild.MasterContainerId, _tmpChild.ContainerId FROM _tmpChild GROUP BY _tmpChild.MasterContainerId, _tmpChild.ContainerId HAVING COUNT(*) > 1)
     THEN
         RAISE EXCEPTION '��������2 - SELECT MasterContainerId, ContainerId FROM _tmpChild GROUP BY MasterContainerId, ContainerId HAVING COUNT(*) > 1 :  MasterContainerId = % and ContainerId = %'
                       , (SELECT _tmpChild.MasterContainerId FROM _tmpChild GROUP BY _tmpChild.MasterContainerId, _tmpChild.ContainerId HAVING COUNT(*) > 1 ORDER BY _tmpChild.MasterContainerId, _tmpChild.ContainerId LIMIT 1)
                       , (SELECT _tmpChild.ContainerId FROM _tmpChild GROUP BY _tmpChild.MasterContainerId, _tmpChild.ContainerId HAVING COUNT(*) > 1 ORDER BY _tmpChild.MasterContainerId, _tmpChild.ContainerId LIMIT 1)
                        ;
     END IF;


     -- ����***
     -- SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb11, vb12, vb13, vb14 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889;


     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     -- !!! �� � ������ - �������� ��� �/� !!!
     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

     -- !!! 1-�� �������� ��� ���� !!!
         UPDATE _tmpMaster SET CalcSumm          = _tmpSumm.CalcSumm
                             , CalcSumm_external = _tmpSumm.CalcSumm_external
               -- ������ ����� ���� ������������
         FROM (SELECT _tmpChild.MasterContainerId AS ContainerId
                    , CAST (SUM (_tmpChild.OperCount * _tmpPrice.OperPrice) AS TFloat) AS CalcSumm
                    , CAST (SUM (CASE WHEN _tmpChild.isExternal = TRUE THEN _tmpChild.OperCount * _tmpPrice.OperPrice_external ELSE 0 END) AS TFloat) AS CalcSumm_external
                    -- , CAST (SUM (CASE WHEN _tmpChild.DescId = zc_Movement_Send() THEN _tmpChild.OperCount * _tmpPrice.OperPrice ELSE 0 END) AS TFloat) AS CalcSumm_external
               FROM 
                    -- ������ ����
                    (SELECT _tmpMaster.ContainerId
                          , CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                                      THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) <> 0
                                                     THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                                ELSE  0
                                           END
                                 WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) > 0)
                                    OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) < 0))
                                     THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                 ELSE 0
                            END AS OperPrice
                          , CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                                      THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) <> 0
                                                     THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                                                ELSE  0
                                           END
                                 WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) > 0)
                                    OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) < 0))
                                     THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                                 ELSE 0
                            END AS OperPrice_external
                     FROM _tmpMaster
                    ) AS _tmpPrice 
                    JOIN _tmpChild ON _tmpChild.ContainerId = _tmpPrice.ContainerId
                                  -- ����������� � ��� ������ ���� ��� � ����
                                  -- AND _tmpChild.MasterContainerId <> _tmpChild.ContainerId

               GROUP BY _tmpChild.MasterContainerId
              ) AS _tmpSumm 
         WHERE _tmpMaster.ContainerId = _tmpSumm.ContainerId;


     -- ����***
     -- SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb21, vb22, vb23, vb24 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889;


     -- !!! ��������� �������� ��� �������� !!!
     vbItearation:=0;
     vbCountDiff:= 100000;
     WHILE vbItearation < inItearationCount AND vbCountDiff > 0
     LOOP
         UPDATE _tmpMaster SET CalcSumm          = _tmpSumm.CalcSumm
                             , CalcSumm_external = _tmpSumm.CalcSumm_external
               -- ������ ����� ���� ������������
         FROM (SELECT _tmpChild.MasterContainerId AS ContainerId
                    , CAST (SUM (_tmpChild.OperCount * _tmpPrice.OperPrice) AS TFloat) AS CalcSumm
                    , CAST (SUM (CASE WHEN _tmpChild.isExternal = TRUE THEN _tmpChild.OperCount * CASE WHEN _tmpPrice.OperPrice_external > 12345 THEN 1.2345 ELSE _tmpPrice.OperPrice_external END ELSE 0 END) AS TFloat) AS CalcSumm_external
                    -- , CAST (SUM (CASE WHEN _tmpChild.DescId = zc_Movement_Send() THEN _tmpChild.OperCount * _tmpPrice.OperPrice ELSE 0 END) AS TFloat) AS CalcSumm_external
               FROM 
                    -- ������ ����
                    (SELECT _tmpMaster.ContainerId
                          , CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                                      THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) <> 0
                                                     THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                                ELSE  0
                                           END
                                 WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) > 0)
                                    OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) < 0))
                                     THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                 ELSE 0
                            END AS OperPrice
                          , CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                                      THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) <> 0
                                                     THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                                                ELSE  0
                                           END
                                 WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) > 0)
                                    OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) < 0))
                                     THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                                 ELSE 0
                            END AS OperPrice_external
                     FROM _tmpMaster
                    ) AS _tmpPrice 
                    JOIN _tmpChild ON _tmpChild.ContainerId = _tmpPrice.ContainerId
                                  -- ����������� � ��� ������ ���� ��� � ����
                                  -- AND _tmpChild.MasterContainerId <> _tmpChild.ContainerId

               GROUP BY _tmpChild.MasterContainerId
              ) AS _tmpSumm 
         WHERE _tmpMaster.ContainerId = _tmpSumm.ContainerId
           --*** AND COALESCE (_tmpMaster.UnitId, 0) <> CASE WHEN vbItearation < 2 THEN -1 ELSE 8451 END -- ��� ��������
           -- AND COALESCE (_tmpMaster.UnitId, 0) <> CASE WHEN vbItearation < 2 THEN -1 ELSE 8440 END -- ���������
        ;

        /*-- ����***
          IF vbItearation = 0  THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb31, vb32, vb33, vb34 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 1  THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb41, vb42, vb43, vb44 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 2  THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb51, vb52, vb53, vb54 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 3  THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb61, vb62, vb63, vb64 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 4  THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb71, vb72, vb73, vb74 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 5  THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb81, vb82, vb83, vb84 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 6  THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb91, vb92, vb93, vb94 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 7  THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb101, vb102, vb103, vb104 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 8  THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb111, vb112, vb113, vb114 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 9  THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb121, vb122, vb123, vb124 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 10 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb131, vb132, vb133, vb134 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 11 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb141, vb142, vb143, vb144 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 12 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb151, vb152, vb153, vb154 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 13 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb161, vb162, vb163, vb164 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 14 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb171, vb172, vb173, vb174 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 15 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb181, vb182, vb183, vb184 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 16 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb191, vb192, vb193, vb194 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;

          IF vbItearation = 17 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb201, vb202, vb203, vb204 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 18 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb211, vb212, vb213, vb214 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 19 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb221, vb222, vb223, vb224 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 20 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb231, vb232, vb233, vb234 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 21 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb241, vb242, vb243, vb244 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 22 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb251, vb252, vb253, vb254 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 23 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb261, vb262, vb263, vb264 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 24 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb271, vb272, vb273, vb274 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 25 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb281, vb282, vb283, vb284 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 26 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb291, vb292, vb293, vb294 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;

          IF vbItearation = 27 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb301, vb302, vb303, vb304 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 28 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb311, vb312, vb313, vb314 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 29 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb321, vb322, vb323, vb324 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 30 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb331, vb332, vb333, vb334 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 31 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb341, vb342, vb343, vb344 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;
          IF vbItearation = 32 THEN SELECT _tmpMaster.CalcSumm, _tmpMaster.CalcSumm_external, _tmpMaster.calcCount, _tmpMaster.calcCount_external INTO vb351, vb352, vb353, vb354 FROM _tmpMaster WHERE _tmpMaster.ContainerId = 251889; END IF;*/

         -- ������� ������� � ��� ������������ �/�
         SELECT Count(*) INTO vbCountDiff
         FROM _tmpMaster
               -- ������ ����� ���� ������������
            , (SELECT _tmpChild.MasterContainerId AS ContainerId
                    , CAST (SUM (_tmpChild.OperCount * _tmpPrice.OperPrice) AS TFloat) AS CalcSumm
               FROM 
                    -- ������ ����
                    (SELECT _tmpMaster.ContainerId
                          , CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                                      THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) <> 0
                                                     THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                                ELSE  0
                                           END
                                 WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) > 0)
                                    OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) < 0))
                                     THEN  (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                 ELSE 0
                            END AS OperPrice
                     FROM _tmpMaster
                    ) AS _tmpPrice 
                    JOIN _tmpChild ON _tmpChild.ContainerId = _tmpPrice.ContainerId
                                  -- ����������� � ��� ������ ���� ��� � ����
                                  -- AND _tmpChild.MasterContainerId <> _tmpChild.ContainerId
               GROUP BY _tmpChild.MasterContainerId
              ) AS _tmpSumm 
         WHERE _tmpMaster.ContainerId = _tmpSumm.ContainerId
           AND ABS (_tmpMaster.CalcSumm - _tmpSumm.CalcSumm) > inDiffSumm
           --*** AND COALESCE (_tmpMaster.UnitId, 0) <> CASE WHEN vbItearation < 2 THEN -1 ELSE 8451 END -- ��� ��������
           -- AND COALESCE (_tmpMaster.UnitId, 0) <> CASE WHEN vbItearation < 2 THEN -1 ELSE 8440 END -- ���������
        ;

         -- ���������� ��������
         vbItearation:= vbItearation + 1;

     END LOOP;


     -- ����***
     /*RAISE EXCEPTION '%   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ;
                      %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ;
                      %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ;
                      %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ; %   %   %   % ;
                     '
                                                                                       , vb11, vb12, vb13, vb14
                                                                                       , vb21, vb22, vb23, vb24
                                                                                       , vb31, vb32, vb33, vb34
                                                                                       , vb41, vb42, vb43, vb44
                                                                                       , vb51, vb52, vb53, vb54
                                                                                       , vb61, vb62, vb63, vb64
                                                                                       , vb71, vb72, vb73, vb74
                                                                                       , vb81, vb82, vb83, vb84
                                                                                       , vb91, vb92, vb93, vb94
                                                                                       , vb101, vb102, vb103, vb104
                                                                                       , vb111, vb112, vb113, vb114
                                                                                       , vb121, vb122, vb123, vb124
                                                                                       , vb131, vb132, vb133, vb134
                                                                                       , vb141, vb142, vb143, vb144
                                                                                       , vb151, vb152, vb153, vb154
                                                                                       , vb161, vb162, vb163, vb164
                                                                                       , vb171, vb172, vb173, vb174
                                                                                       , vb181, vb182, vb183, vb184
                                                                                       , vb191, vb192, vb193, vb194
                                                                                       , vb201, vb202, vb203, vb204
                                                                                       , vb211, vb212, vb213, vb214
                                                                                       , vb221, vb222, vb223, vb224
                                                                                       , vb231, vb232, vb233, vb234
                                                                                       , vb241, vb242, vb243, vb244
                                                                                       , vb251, vb252, vb253, vb254
                                                                                       , vb261, vb262, vb263, vb264
                                                                                       , vb271, vb272, vb273, vb274
                                                                                       , vb281, vb282, vb283, vb284
                                                                                       , vb291, vb292, vb293, vb294
                                                                                       , vb301, vb302, vb303, vb304
                                                                                       , vb311, vb312, vb313, vb314
                                                                                       , vb321, vb322, vb323, vb324
                                                                                       , vb331, vb332, vb333, vb334
                                                                                       , vb341, vb342, vb343, vb344
                                                                                       , vb351, vb352, vb353, vb354
                                                                                        ;*/


     IF inInsert > 0 THEN

     -- ��������� Diff
     /*INSERT INTO _tmpDiff (ContainerId, MovementItemId_diff, Summ_diff)
        SELECT HistoryCost.ContainerId, MAX (HistoryCost.MovementItemId_diff), SUM (HistoryCost.Summ_diff) FROM HistoryCost WHERE HistoryCost.Summ_diff <> 0 AND ((inStartDate BETWEEN StartDate AND EndDate) OR (inEndDate BETWEEN StartDate AND EndDate)) GROUP BY HistoryCost.ContainerId;
     */
     IF inBranchId > 0
     THEN
         -- ������� ���������� �/� - !!!��� 1-��� �������!!!
         DELETE FROM HistoryCost WHERE ((StartDate BETWEEN inStartDate AND inEndDate) OR (EndDate BETWEEN inStartDate AND inEndDate))
                                    -- ((inStartDate BETWEEN StartDate AND EndDate) OR (inEndDate BETWEEN StartDate AND EndDate))
                                   AND HistoryCost.ContainerId IN (SELECT _tmpContainer_branch.ContainerId FROM _tmpContainer_branch);
                                                                  /*(SELECT ContainerLinkObject.ContainerId
                                                                   FROM _tmpUnit_branch
                                                                        INNER JOIN ContainerLinkObject ON ContainerLinkObject.ObjectId = _tmpUnit_branch.UnitId
                                                                                                      AND ContainerLinkObject.DescId = zc_ContainerLinkObject_Unit()
                                                                  );*/
         -- ��������� ��� ��������� - !!!��� 1-��� �������!!!
         INSERT INTO HistoryCost (ContainerId, StartDate, EndDate, Price, Price_external, StartCount, StartSumm, IncomeCount, IncomeSumm, CalcCount, CalcSumm, CalcCount_external, CalcSumm_external, OutCount, OutSumm, MovementItemId_diff, Summ_diff)
            SELECT _tmpMaster.ContainerId, inStartDate AS StartDate, inEndDate AS EndDate
                 , CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                             THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) <> 0
                                            THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                       ELSE  0
                                  END
                        WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) > 0)
                           OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) < 0))
                             THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                        ELSE 0
                   END AS Price
                 , CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                             THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) <> 0
                                            THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                                       ELSE  0
                                  END
                        WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) > 0)
                           OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) < 0))
                             THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                        ELSE 0
                   END AS Price_external
                 , _tmpMaster.StartCount, _tmpMaster.StartSumm, _tmpMaster.IncomeCount, _tmpMaster.IncomeSumm, _tmpMaster.CalcCount, _tmpMaster.CalcSumm, _tmpMaster.CalcCount_external, _tmpMaster.CalcSumm_external, _tmpMaster.OutCount, _tmpMaster.OutSumm
                 , _tmpDiff.MovementItemId_diff, _tmpDiff.Summ_diff
            FROM _tmpMaster
                 LEFT JOIN _tmpDiff ON _tmpDiff.ContainerId = _tmpMaster.ContainerId
            WHERE (((_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm)          <> 0)
                OR ((_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) <> 0)
                  )
              AND _tmpMaster.ContainerId IN (SELECT _tmpContainer_branch.ContainerId FROM _tmpContainer_branch);
                                            /*(SELECT ContainerLinkObject.ContainerId
                                             FROM _tmpUnit_branch
                                                  INNER JOIN ContainerLinkObject ON ContainerLinkObject.ObjectId = _tmpUnit_branch.UnitId
                                                                                AND ContainerLinkObject.DescId = zc_ContainerLinkObject_Unit()
                                            );*/
     ELSE
         -- ������� ���������� �/� - !!!����� ���� ��������!!!
         DELETE FROM HistoryCost WHERE ((StartDate BETWEEN inStartDate AND inEndDate) OR (EndDate BETWEEN inStartDate AND inEndDate))
                                    -- ((inStartDate BETWEEN StartDate AND EndDate) OR (inEndDate BETWEEN StartDate AND EndDate))
                                   AND HistoryCost.ContainerId NOT IN (SELECT _tmpContainer_branch.ContainerId FROM _tmpContainer_branch);
                                                                      /*(SELECT ContainerLinkObject.ContainerId
                                                                       FROM _tmpUnit_branch
                                                                            INNER JOIN ContainerLinkObject ON ContainerLinkObject.ObjectId = _tmpUnit_branch.UnitId
                                                                                                          AND ContainerLinkObject.DescId = zc_ContainerLinkObject_Unit()
                                                                      );*/
         -- ��������� ��� ��������� - !!!����� ���� ��������!!!
         INSERT INTO HistoryCost (ContainerId, StartDate, EndDate, Price, Price_external, StartCount, StartSumm, IncomeCount, IncomeSumm, CalcCount, CalcSumm, CalcCount_external, CalcSumm_external, OutCount, OutSumm, MovementItemId_diff, Summ_diff)
            SELECT _tmpMaster.ContainerId, inStartDate AS StartDate
                 , DATE_TRUNC ('MONTH', inStartDate) + INTERVAL '1 MONTH' - INTERVAL '1 DAY' AS EndDate
                 , CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                             THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) <> 0
                                            THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                       ELSE  0
                                  END
                        WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) > 0)
                           OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) < 0))
                             THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                        ELSE 0
                   END AS Price
                 , CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                             THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) <> 0
                                            THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                                       ELSE  0
                                  END
                        WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) > 0)
                           OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) < 0))
                             THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                        ELSE 0
                   END AS Price_external
                 , _tmpMaster.StartCount, _tmpMaster.StartSumm, _tmpMaster.IncomeCount, _tmpMaster.IncomeSumm, _tmpMaster.CalcCount, _tmpMaster.CalcSumm, _tmpMaster.CalcCount_external, _tmpMaster.CalcSumm_external, _tmpMaster.OutCount, _tmpMaster.OutSumm
                 , _tmpDiff.MovementItemId_diff, _tmpDiff.Summ_diff
            FROM _tmpMaster
                 LEFT JOIN _tmpDiff ON _tmpDiff.ContainerId = _tmpMaster.ContainerId
            WHERE (((_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm)          <> 0)
                OR ((_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) <> 0)
                  )
              AND _tmpMaster.ContainerId NOT IN (SELECT _tmpContainer_branch.ContainerId FROM _tmpContainer_branch);
                                                /*(SELECT ContainerLinkObject.ContainerId
                                                 FROM _tmpUnit_branch
                                                      INNER JOIN ContainerLinkObject ON ContainerLinkObject.ObjectId = _tmpUnit_branch.UnitId
                                                                                    AND ContainerLinkObject.DescId = zc_ContainerLinkObject_Unit()
                                                );*/
     END IF;


        -- !!!��������!!!
        UPDATE HistoryCost SET Price          = 1.1234 * CASE WHEN HistoryCost.Price < 0 THEN -1 ELSE 1 END
                             , Price_external = 1.1234 * CASE WHEN HistoryCost.Price < 0 THEN -1 ELSE 1 END
        FROM Container
             INNER JOIN ContainerLinkObject AS ContainerLO_Goods
                                            ON ContainerLO_Goods.ContainerId = Container.Id
                                           AND ContainerLO_Goods.DescId = zc_ContainerLinkObject_Goods()
             INNER JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                   ON ObjectLink_Goods_InfoMoney.ObjectId = ContainerLO_Goods.ObjectId
                                  AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
             INNER JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId
                                                               AND (View_InfoMoney.InfoMoneyGroupId IN (zc_Enum_InfoMoneyGroup_30000()) -- ������
                                                                 OR View_InfoMoney.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_10100() -- �������� ����� + ������ �����
                                                                                                            , zc_Enum_InfoMoneyDestination_20900() -- ���� 
                                                                                                            , zc_Enum_InfoMoneyDestination_21000() -- �����
                                                                                                            , zc_Enum_InfoMoneyDestination_21100() -- �������
                                                                                                             )
                                                                   )
        WHERE HistoryCost.StartDate = inStartDate
          AND ABS (HistoryCost.Price) >  800
          AND HistoryCost.ContainerId = Container.Id
       ;        

        -- !!!��������-1!!!
        /*UPDATE MovementItemContainer SET ContainerIntId_analyzer = ContainerId
        WHERE MovementItemContainer.OperDate BETWEEN inStartDate AND inEndDate
          AND MovementItemContainer.MovementDescId = zc_Movement_Sale()
          AND MovementItemContainer.DescId = zc_MIContainer_Count()
          AND MovementItemContainer.ContainerIntId_analyzer IS NULL
       ;
        -- !!!��������-2!!!
        CREATE TEMP TABLE _tmpMIContainer_update_analyzer (MovementId Integer, MovementItemId Integer, ContainerId Integer) ON COMMIT DROP;
        INSERT INTO _tmpMIContainer_update_analyzer (MovementId, MovementItemId, ContainerId)
              SELECT DISTINCT MIContainer.MovementId, MIContainer.MovementItemId, MIContainer.ContainerId
              FROM MovementItemContainer AS MIContainer
              WHERE MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                AND MIContainer.MovementDescId = zc_Movement_Sale()
                AND MIContainer.DescId = zc_MIContainer_Count()
       ;
        UPDATE MovementItemContainer SET ContainerIntId_analyzer = _tmpMIContainer_update_analyzer.ContainerId
        FROM _tmpMIContainer_update_analyzer
        WHERE MovementItemContainer.MovementId     = _tmpMIContainer_update_analyzer.MovementId
          AND MovementItemContainer.MovementItemId = _tmpMIContainer_update_analyzer.MovementItemId
          AND MovementItemContainer.DescId         = zc_MIContainer_Summ()
          AND MovementItemContainer.ContainerIntId_analyzer IS NULL
       ;*/

     END IF; -- if inInsert > 0

     IF inInsert <> 12345 THEN -- 12345 - ��� Load_PostgreSql
     -- tmp - test
     RETURN QUERY
        SELECT vbItearation, vbCountDiff
             , CAST (CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                               THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) <> 0
                                              THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                         ELSE  0
                                    END
                          WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) > 0)
                             OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) < 0))
                               THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount)
                          ELSE 0
                     END AS TFloat) AS Price
             , CAST (CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                               THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) <> 0
                                              THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + CASE WHEN _tmpSumm.CalcSumm <> 0 THEN _tmpSumm.CalcSumm ELSE _tmpMaster.CalcSumm END) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                         ELSE  0
                                    END
                          WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + CASE WHEN _tmpSumm.CalcSumm <> 0 THEN _tmpSumm.CalcSumm ELSE _tmpMaster.CalcSumm END) > 0)
                             OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + CASE WHEN _tmpSumm.CalcSumm <> 0 THEN _tmpSumm.CalcSumm ELSE _tmpMaster.CalcSumm END) < 0))
                               THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + CASE WHEN _tmpSumm.CalcSumm <> 0 THEN _tmpSumm.CalcSumm ELSE _tmpMaster.CalcSumm END) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount)
                          ELSE 0
                     END AS TFloat) AS PriceNext

             , CAST (CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                               THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) <> 0
                                              THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                                         ELSE  0
                                    END
                          WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount_external) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) > 0)
                             OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount_external) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) < 0))
                               THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount_external)
                          ELSE 0
                     END AS TFloat) AS Price_external
             , CAST (CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                               THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) <> 0
                                              THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + CASE WHEN _tmpSumm.CalcSumm_external <> 0 THEN _tmpSumm.CalcSumm_external ELSE _tmpMaster.CalcSumm_external END) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                                         ELSE  0
                                    END
                          WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount_external) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + CASE WHEN _tmpSumm.CalcSumm_external <> 0 THEN _tmpSumm.CalcSumm_external ELSE _tmpMaster.CalcSumm_external END) > 0)
                             OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount_external) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + CASE WHEN _tmpSumm.CalcSumm_external <> 0 THEN _tmpSumm.CalcSumm_external ELSE _tmpMaster.CalcSumm_external END) < 0))
                               THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + CASE WHEN _tmpSumm.CalcSumm_external <> 0 THEN _tmpSumm.CalcSumm_external ELSE _tmpMaster.CalcSumm_external END) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount_external)
                          ELSE 0
                     END AS TFloat) AS PriceNext_external

             , _tmpSumm.FromContainerId
             , _tmpMaster.ContainerId
             , _tmpMaster.isInfoMoney_80401
             , _tmpMaster.CalcSumm          AS CalcSummCurrent,          CAST (COALESCE (_tmpSumm.CalcSumm, 0)          AS TFloat) AS CalcSummNext
             , _tmpMaster.CalcSumm_external AS CalcSummCurrent_external, CAST (COALESCE (_tmpSumm.CalcSumm_external, 0) AS TFloat) AS CalcSummNext_external
             , _tmpMaster.StartCount, _tmpMaster.StartSumm, _tmpMaster.IncomeCount, _tmpMaster.IncomeSumm, _tmpMaster.CalcCount, _tmpMaster.CalcSumm, _tmpMaster.CalcCount_external, _tmpMaster.CalcSumm_external, _tmpMaster.OutCount, _tmpMaster.OutSumm
             , _tmpMaster.UnitId
             , Object_Unit.ValueData AS UnitName

         FROM _tmpMaster LEFT JOIN
               -- ������ ����� ���� ������������
              (SELECT _tmpChild.MasterContainerId AS ContainerId
--                    , _tmpChild.ContainerId AS FromContainerId
                    , 0 AS FromContainerId
                    , CAST (SUM (_tmpChild.OperCount * _tmpPrice.OperPrice) AS TFloat) AS CalcSumm
                    , CAST (SUM (CASE WHEN _tmpChild.isExternal = TRUE THEN _tmpChild.OperCount * _tmpPrice.OperPrice_external ELSE 0 END) AS TFloat) AS CalcSumm_external

               FROM 
                    -- ������ ����
                    (SELECT _tmpMaster.ContainerId
                          , CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                                      THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) <> 0
                                                     THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                                ELSE  0
                                           END
                                 WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) > 0)
                                    OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) < 0))
                                      THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount)
                                 ELSE 0
                            END AS OperPrice
                          , CASE WHEN _tmpMaster.isInfoMoney_80401 = TRUE
                                      THEN CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) <> 0
                                                     THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                                                ELSE  0
                                           END
                                 WHEN (((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) > 0)
                                    OR ((_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) < 0))
                                      THEN (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm_external) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.calcCount_external)
                                 ELSE 0
                            END AS OperPrice_external
                     FROM _tmpMaster
                    ) AS _tmpPrice 
                    JOIN _tmpChild ON _tmpChild.ContainerId = _tmpPrice.ContainerId
                                  -- ����������� � ��� ������ ���� ��� � ����
                                  -- AND _tmpChild.MasterContainerId <> _tmpChild.ContainerId
               GROUP BY _tmpChild.MasterContainerId
--                      , _tmpChild.ContainerId
              ) AS _tmpSumm ON _tmpMaster.ContainerId = _tmpSumm.ContainerId
              LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = _tmpMaster.UnitId
        ;
     END IF; -- if inInsert <> 12345

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
     INSERT INTO _tmpMaster (ContainerId, StartCount, StartSumm, IncomeCount, IncomeSumm , CalcCount, CalcSumm)
        SELECT CAST (1 AS Integer) AS ContainerId, CAST (30 AS TFloat) AS StartCount, CAST (280 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm
       UNION ALL
        SELECT CAST (2 AS Integer) AS ContainerId, CAST (50 AS TFloat) AS StartCount, CAST (340 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm
       UNION ALL
        SELECT CAST (3 AS Integer) AS ContainerId, CAST (20 AS TFloat) AS StartCount, CAST (0 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm
       UNION ALL
        SELECT CAST (4 AS Integer) AS ContainerId, CAST (13 AS TFloat) AS StartCount, CAST (14 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm
       UNION ALL
        SELECT CAST (5 AS Integer) AS ContainerId, CAST (20 AS TFloat) AS StartCount, CAST (20 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm
       ;
     -- ������� - ��� �������
     INSERT INTO _tmpChild (MasterContainerId, ContainerId, OperCount)
        SELECT 3 AS MasterContainerId, 1 AS ContainerId, 5 AS OperCount
       UNION ALL
        SELECT 3 AS MasterContainerId, 2 AS ContainerId, 7 AS OperCount
       UNION ALL
        SELECT 3 AS MasterContainerId, 5 AS ContainerId, 2 AS OperCount
       UNION ALL
        SELECT 5 AS MasterContainerId, 1 AS ContainerId, 4 AS OperCount
       UNION ALL
        SELECT 5 AS MasterContainerId, 2 AS ContainerId, 6 AS OperCount
       UNION ALL
        SELECT 5 AS MasterContainerId, 3 AS ContainerId, 2 AS OperCount
       UNION ALL
        SELECT 5 AS MasterContainerId, 4 AS ContainerId, 1 AS OperCount
       UNION ALL
        SELECT 4 AS MasterContainerId, 3 AS ContainerId, 10 AS OperCount
       ;


     INSERT INTO _tmpMaster (ContainerId, StartCount, StartSumm, IncomeCount, IncomeSumm , CalcCount, CalcSumm)
     INSERT INTO _tmpMaster (ContainerId, StartCount, StartSumm, IncomeCount, IncomeSumm, calcCount, calcSumm, OutCount, OutSumm)
        SELECT CAST (1 AS Integer) AS ContainerId, CAST (60 AS TFloat) AS StartCount, CAST (280 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm, CAST (0 AS TFloat) AS OutCount, CAST (0 AS TFloat) AS OutSumm
       UNION ALL
        SELECT CAST (2 AS Integer) AS ContainerId, CAST (60 AS TFloat) AS StartCount, CAST (0 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm, CAST (0 AS TFloat) AS OutCount, CAST (0 AS TFloat) AS OutSumm
       UNION ALL
        SELECT CAST (3 AS Integer) AS ContainerId, CAST (4 AS TFloat) AS StartCount, CAST (14 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm, CAST (0 AS TFloat) AS OutCount, CAST (0 AS TFloat) AS OutSumm
       UNION ALL
        SELECT CAST (4 AS Integer) AS ContainerId, CAST (5 AS TFloat) AS StartCount, CAST (20 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm, CAST (0 AS TFloat) AS OutCount, CAST (0 AS TFloat) AS OutSumm
       ;
     -- ������� - ��� �������
     INSERT INTO _tmpChild (MasterContainerId, ContainerId, OperCount)
        SELECT 2 AS MasterContainerId, 1 AS ContainerId, 30 AS OperCount
       UNION ALL
        SELECT 2 AS MasterContainerId, 3 AS ContainerId, 1 AS OperCount
       UNION ALL
        SELECT 2 AS MasterContainerId, 4 AS ContainerId, 1 AS OperCount
       UNION ALL
        SELECT 2 AS MasterContainerId, 2 AS ContainerId, 30 AS OperCount
       UNION ALL
        SELECT 1 AS MasterContainerId, 2 AS ContainerId, 30 AS OperCount
       ;
*/

-- select lpInsertUpdate_ObjectLink (zc_ObjectLink_Unit_HistoryCost(), 8462, 8462 /*8459*/); -- ����� ���� -> ����� ���������� 
-- select lpInsertUpdate_ObjectLink (zc_ObjectLink_Unit_HistoryCost(), 8461, 8461 /*8459*/); -- ����� ��������� -> ����� ���������� 
-- select lpInsertUpdate_ObjectLink (zc_ObjectLink_Unit_HistoryCost(), 256716, 256716 /*8459*/); -- ����� ����� -> ����� ���������� 
-- select lpInsertUpdate_ObjectLink (zc_ObjectLink_Unit_HistoryCost(), 428365, 428365 ); -- ����� ��������� �.����
-- select lpInsertUpdate_ObjectLink (zc_ObjectLink_Unit_HistoryCost(), 309599, 301309); -- ����� ��������� �.��������� -> ����� �� �.���������
-- select lpInsertUpdate_ObjectLink (zc_ObjectLink_Unit_HistoryCost(), 428366 , 428366 ); -- ����� ��������� �.������ ���
-- select lpInsertUpdate_ObjectLink (zc_ObjectLink_Unit_HistoryCost(), 428364 , 428364 ); -- ����� ��������� �.�������� (������)
-- select lpInsertUpdate_ObjectLink (zc_ObjectLink_Unit_HistoryCost(), 409007 , 409007 ); -- ����� ��������� �.�������
-- select lpInsertUpdate_ObjectLink (zc_ObjectLink_Unit_HistoryCost(), 428363 ,428363 ); -- ����� ��������� �.�������� (����������)

-- select 'zc_isHistoryCost', zc_isHistoryCost()union all select 'zc_isHistoryCost_byInfoMoneyDetail', zc_isHistoryCost_byInfoMoneyDetail() order by 1;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.08.15                                        * add inBranchId
 08.11.14                                        * add zc_ObjectLink_Unit_HistoryCost
 13.08.14                                        * ObjectCostId -> ContainerId
 10.08.14                                        * add SendOnPrice
 15.09.13                                        * add zc_Container_CountSupplier and zc_Enum_Account_20901
 13.07.13                                        * add JOIN Container
 10.07.13                                        *
*/

-- SELECT * FROM HistoryCost where ContainerId in ( 976442, 976754) ORDER BY 1 DESC

/*
select distinct Object.ObjectCode, Object.ValueData, Object2.ObjectCode, Object2.ValueData, Object3.ObjectCode, Object3.ValueData, Object4.ValueData
from Container 
     left join ContainerLinkObject on ContainerLinkObject.ContainerId = Container.Id and ContainerLinkObject.DescId = zc_ContainerLinkObject_Unit() left join Object on Object.Id = ContainerLinkObject.ObjectId
     left join ContainerLinkObject as clo2 on clo2.ContainerId = Container.Id and clo2.DescId = zc_ContainerLinkObject_Goods()                      left join Object as Object2 on Object2.Id = clo2.ObjectId
     left join ContainerLinkObject as clo3 on clo3.ContainerId = Container.Id and clo3.DescId = zc_ContainerLinkObject_GoodsKind()                  left join Object as Object3 on Object3.Id = clo3.ObjectId
     left join ContainerLinkObject as clo4 on clo4.ContainerId = Container.Id and clo4.DescId = zc_ContainerLinkObject_PartionGoods()               left join Object as Object4 on Object4.Id = clo4.ObjectId
where  Container.Id in (SELECT HistoryCost.ContainerId FROM HistoryCost WHERE ('01.12.2016' BETWEEN StartDate AND EndDate) and abs (Price) = 1.1234 and CalcSumm > 1000)
order by 3, 5

SELECT * FROM HistoryCost WHERE ('01.12.2016' BETWEEN StartDate AND EndDate) and abs (Price) = 1.1234 order by Price desc -- and CalcSumm > 1000000
*/

-- ������ ����
-- SELECT * FROM gpInsertUpdate_HistoryCost (inStartDate:= '01.01.2016', inEndDate:= '31.01.2016', inBranchId:= 8379, inItearationCount:= 1000, inInsert:= 12345, inDiffSumm:= 0.009, inSession:= '2') -- WHERE CalcSummCurrent <> CalcSummNext

-- ����
-- SELECT * FROM gpInsertUpdate_HistoryCost (inStartDate:= '01.01.2017', inEndDate:= '31.01.2017', inBranchId:= 0, inItearationCount:= 500, inInsert:= -1, inDiffSumm:= 0, inSession:= '2')  WHERE Price <> PriceNext
-- SELECT * FROM gpInsertUpdate_HistoryCost (inStartDate:= '01.01.2017', inEndDate:= '31.01.2017', inBranchId:= 0, inItearationCount:= 500, inInsert:= -1, inDiffSumm:= 0.009, inSession:= '2') ORDER BY ABS (Price) DESC -- WHERE CalcSummCurrent <> CalcSummNext