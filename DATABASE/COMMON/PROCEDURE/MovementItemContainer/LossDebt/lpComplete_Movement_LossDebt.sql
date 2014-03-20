-- Function: lpComplete_Movement_LossDebt (Integer, Integer)

DROP FUNCTION IF EXISTS lpComplete_Movement_LossDebt (Integer, Integer);

CREATE OR REPLACE FUNCTION lpComplete_Movement_LossDebt(
    IN inMovementId        Integer  , -- ���� ���������
    IN inUserId            Integer    -- ������������
)                              
RETURNS VOID
--  RETURNS TABLE (MovementItemId Integer, MovementId Integer, OperDate TDateTime, JuridicalId_From Integer, isCorporate Boolean, PersonalId_From Integer, UnitId Integer, BranchId_Unit Integer, PersonalId_Packer Integer, PaidKindId Integer, ContractId Integer, ContainerId_Goods Integer, GoodsId Integer, GoodsKindId Integer, AssetId Integer, PartionGoods TVarChar, OperCount TFloat, tmpOperSumm_Partner TFloat, OperSumm_Partner TFloat, tmpOperSumm_Packer TFloat, OperSumm_Packer TFloat, AccountDirectionId Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer, InfoMoneyDestinationId_isCorporate Integer, InfoMoneyId_isCorporate Integer, JuridicalId_basis Integer, BusinessId Integer, isPartionCount Boolean, isPartionSumm Boolean, PartionMovementId Integer, PartionGoodsId Integer)
AS
$BODY$
   DECLARE vbPartionMovementId Integer;
BEGIN

     -- !!!�����������!!! �������� ������� ��������
     DELETE FROM _tmpMIContainer_insert;
     -- !!!�����������!!! �������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     DELETE FROM _tmpItem;

     -- !!!��� ����� ��� ������!!!
     vbPartionMovementId:= lpInsertFind_Object_PartionMovement (0);

     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     WITH tmpMovement AS (SELECT Movement.Id AS MovementId, Movement.OperDate, COALESCE (MovementLinkObject_Account.ObjectId, 0) AS AccountId, COALESCE (MovementLinkObject_PaidKind.ObjectId, zc_Enum_PaidKind_FirstForm()) AS PaidKindId
                          FROM Movement
                               LEFT JOIN MovementLinkObject AS MovementLinkObject_Account
                                                            ON MovementLinkObject_Account.MovementId = Movement.Id
                                                           AND MovementLinkObject_Account.DescId = zc_MovementLinkObject_Account()
                                                           -- AND MovementLinkObject_Account.ObjectId = zc_Enum_Account_50401() -- ������� ������� �������� - ���������
                               LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                                            ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                                           AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
                          WHERE Movement.Id = inMovementId
                            AND Movement.DescId = zc_Movement_LossDebt()
                            AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
                         )
        , tmpMovementItem AS (SELECT tmpMovement.OperDate
                                   , COALESCE (MovementItem.ObjectId, 0) AS ObjectId
                                   , COALESCE (Object.DescId, 0) AS ObjectDescId
                                   , CASE WHEN MIBoolean_Calculated.ValueData = TRUE THEN COALESCE (MIFloat_Summ.ValueData, 0) ELSE MovementItem.Amount END AS OperSumm
                                   , MovementItem.Id AS MovementItemId
                                   , tmpMovement.MovementId
                                   , 0 AS ContainerId                             -- ���������� �����
                                   , 0 AS AccountGroupId, 0 AS AccountDirectionId -- ���������� �����, ��� ...
                                   , CASE WHEN MILinkObject_InfoMoney.ObjectId IN (zc_Enum_InfoMoney_21501(), zc_Enum_InfoMoney_21502()) -- ������ �� ��������� + ������ �� ������ �����
                                               THEN tmpMovement.AccountId
                                          ELSE 0
                                     END AS AccountId
                                   , tmpMovement.AccountId AS AccountId_main
                                     -- ������ ����
                                   , 0 AS ProfitLossGroupId
                                     -- ��������� ���� - �����������
                                   , 0 AS ProfitLossDirectionId
                                   -- �������������� ������ ����������
                                   , COALESCE (View_InfoMoney.InfoMoneyGroupId, 0) AS InfoMoneyGroupId
                                   -- �������������� ����������
                                   , COALESCE (View_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
                                   -- �������������� ������ ����������
                                   , COALESCE (View_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId
                                     -- ������: ���
                                   , 0  AS BusinessId
                                     -- ������� ��.����: ������ �� ��������
                                   , COALESCE (ObjectLink_Contract_JuridicalBasis.ChildObjectId, 0) AS JuridicalId_Basis
                                   , 0 AS UnitId
                                     -- ������: ���
                                   , 0 AS BranchId
                                   , COALESCE (MILinkObject_Contract.ObjectId, 0)  AS ContractId
                                   , COALESCE (MILinkObject_PaidKind.ObjectId, 0)  AS PaidKindId
                                   , MIBoolean_Calculated.ValueData AS isCalculated
                              FROM tmpMovement
                                   JOIN MovementItem ON MovementItem.MovementId = tmpMovement.MovementId
                                                    AND MovementItem.DescId = zc_MI_Master()
                                                    AND MovementItem.isErased = FALSE
                                   LEFT JOIN Object ON Object.Id = MovementItem.ObjectId
                                   LEFT JOIN MovementItemFloat AS MIFloat_Summ 
                                                               ON MIFloat_Summ.MovementItemId = MovementItem.Id
                                                              AND MIFloat_Summ.DescId = zc_MIFloat_Summ()
                                   LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                                                    ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                                                   AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                                   LEFT JOIN MovementItemLinkObject AS MILinkObject_Contract
                                                                    ON MILinkObject_Contract.MovementItemId = MovementItem.Id
                                                                   AND MILinkObject_Contract.DescId = zc_MILinkObject_Contract()
                                   LEFT JOIN MovementItemLinkObject AS MILinkObject_PaidKind
                                                                    ON MILinkObject_PaidKind.MovementItemId = MovementItem.Id
                                                                   AND MILinkObject_PaidKind.DescId = zc_MILinkObject_PaidKind()
                                   LEFT JOIN MovementItemBoolean AS MIBoolean_Calculated
                                                                 ON MIBoolean_Calculated.MovementItemId = MovementItem.Id
                                                                AND MIBoolean_Calculated.DescId = zc_MIBoolean_Calculated()
                                   LEFT JOIN ObjectLink AS ObjectLink_Contract_JuridicalBasis ON ObjectLink_Contract_JuridicalBasis.ObjectId = MILinkObject_Contract.ObjectId
                                                                                             AND ObjectLink_Contract_JuridicalBasis.DescId = zc_ObjectLink_Contract_JuridicalBasis()
                                   LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MILinkObject_InfoMoney.ObjectId
                             )
        , tmpListContainer AS (SELECT Container.Id AS ContainerId
                                    , Container.Amount
                                    , tmpMovementItem.JuridicalId
                                    , tmpMovementItem.InfoMoneyId
                                    , tmpMovementItem.PaidKindId
                                    , tmpMovementItem.JuridicalId_Basis
                                    , tmpMovementItem.BusinessId
                               FROM (SELECT ObjectId AS JuridicalId, InfoMoneyId, PaidKindId, JuridicalId_Basis, BusinessId, AccountId FROM tmpMovementItem WHERE isCalculated = TRUE GROUP BY ObjectId, InfoMoneyId, PaidKindId, JuridicalId_Basis, BusinessId, AccountId
                                    ) AS tmpMovementItem
                                    JOIN ContainerLinkObject AS ContainerLO_Juridical
                                                             ON ContainerLO_Juridical.DescId = zc_ContainerLinkObject_Juridical()
                                                            AND ContainerLO_Juridical.ObjectId = tmpMovementItem.JuridicalId
                                    JOIN ContainerLinkObject AS ContainerLO_InfoMoney
                                                             ON ContainerLO_InfoMoney.ContainerId = ContainerLO_Juridical.ContainerId
                                                            AND ContainerLO_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
                                                            AND ContainerLO_InfoMoney.ObjectId = tmpMovementItem.InfoMoneyId
                                    JOIN ContainerLinkObject AS ContainerLO_PaidKind
                                                             ON ContainerLO_PaidKind.ContainerId = ContainerLO_Juridical.ContainerId
                                                            AND ContainerLO_PaidKind.DescId = zc_ContainerLinkObject_PaidKind()
                                                            AND ContainerLO_PaidKind.ObjectId = tmpMovementItem.PaidKindId
                                    JOIN ContainerLinkObject AS ContainerLO_JuridicalBasis
                                                             ON ContainerLO_JuridicalBasis.ContainerId = ContainerLO_Juridical.ContainerId
                                                            AND ContainerLO_JuridicalBasis.DescId = zc_ContainerLinkObject_JuridicalBasis()
                                                            AND ContainerLO_JuridicalBasis.ObjectId = tmpMovementItem.JuridicalId_Basis
                                    JOIN ContainerLinkObject AS ContainerLO_Business
                                                             ON ContainerLO_Business.ContainerId = ContainerLO_Juridical.ContainerId
                                                            AND ContainerLO_Business.DescId = zc_ContainerLinkObject_Business()
                                                            AND ContainerLO_Business.ObjectId = tmpMovementItem.BusinessId
                                    JOIN Container ON Container.Id = ContainerLO_Juridical.ContainerId
                                                  AND Container.DescId = zc_Container_Summ()
                                                  AND (Container.ObjectId = tmpMovementItem.AccountId
                                                    OR (tmpMovementItem.AccountId = 0 AND Container.ObjectId <> zc_Enum_Account_50401()) -- ������� ������� �������� - ���������
                                                      )
                                    LEFT JOIN ContainerLinkObject AS ContainerLO_PartionMovement
                                                                  ON ContainerLO_PartionMovement.ContainerId = Container.Id
                                                                 AND ContainerLO_PartionMovement.DescId = zc_ContainerLinkObject_PartionMovement()
                                                                 AND ContainerLO_PartionMovement.ObjectId = 0
                               WHERE ContainerLO_PartionMovement.ContainerId IS NULL -- !!!���������� �������!!!
                              UNION
                               SELECT Container.Id AS ContainerId
                                    , Container.Amount
                                    , ContainerLO_Juridical.ObjectId AS JuridicalId
                                    , ContainerLO_InfoMoney.ObjectId AS InfoMoneyId
                                    , ContainerLO_PaidKind.ObjectId AS PaidKindId
                                    , ContainerLO_JuridicalBasis.ObjectId AS JuridicalId_Basis
                                    , ContainerLO_Business.ObjectId AS BusinessId
                               FROM tmpMovement
                                    JOIN Object_Account_View AS View_Account ON View_Account.AccountId = tmpMovement.AccountId
                                    -- JOIN Object_Account_View AS View_Account_find ON View_Account_find.AccountDirectionId = View_Account.AccountDirectionId
                                    JOIN Object_Account_View AS View_Account_find ON View_Account_find.AccountId = View_Account.AccountId
                                    JOIN Container ON Container.ObjectId = View_Account_find.AccountId
                                                  AND Container.DescId = zc_Container_Summ()
                                    JOIN ContainerLinkObject AS ContainerLO_PaidKind
                                                             ON ContainerLO_PaidKind.ContainerId = Container.Id
                                                            AND ContainerLO_PaidKind.DescId = zc_ContainerLinkObject_PaidKind()
                                                            AND ContainerLO_PaidKind.ObjectId = tmpMovement.PaidKindId
                                    JOIN ContainerLinkObject AS ContainerLO_Juridical
                                                             ON ContainerLO_Juridical.ContainerId = Container.Id
                                                            AND ContainerLO_Juridical.DescId = zc_ContainerLinkObject_Juridical()
                                    JOIN ContainerLinkObject AS ContainerLO_InfoMoney
                                                             ON ContainerLO_InfoMoney.ContainerId = Container.Id
                                                            AND ContainerLO_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
                                    JOIN ContainerLinkObject AS ContainerLO_JuridicalBasis
                                                             ON ContainerLO_JuridicalBasis.ContainerId = Container.Id
                                                            AND ContainerLO_JuridicalBasis.DescId = zc_ContainerLinkObject_JuridicalBasis()
                                    JOIN ContainerLinkObject AS ContainerLO_Business
                                                             ON ContainerLO_Business.ContainerId = Container.Id
                                                            AND ContainerLO_Business.DescId = zc_ContainerLinkObject_Business()
                                    LEFT JOIN ContainerLinkObject AS ContainerLO_PartionMovement
                                                                  ON ContainerLO_PartionMovement.ContainerId = Container.Id
                                                                 AND ContainerLO_PartionMovement.DescId = zc_ContainerLinkObject_PartionMovement()
                                                                 AND ContainerLO_PartionMovement.ObjectId = 0
                               WHERE tmpMovement.AccountId <> 0
                                 AND ContainerLO_PartionMovement.ContainerId IS NULL -- !!!���������� �������!!!
                              )
        , tmpContainerSumm AS (SELECT tmpListContainer.ContainerId
                                    , tmpListContainer.Amount - COALESCE (SUM (MIContainer.Amount), 0) AS SummRemainsEnd
                                    , tmpListContainer.JuridicalId
                                    , tmpListContainer.InfoMoneyId
                                    , tmpListContainer.PaidKindId
                                    , tmpListContainer.JuridicalId_Basis
                                    , tmpListContainer.BusinessId
                               FROM tmpListContainer
                                    LEFT JOIN tmpMovement ON 1 = 1
                                    LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.Containerid = tmpListContainer.ContainerId
                                                                                  AND MIContainer.OperDate > tmpMovement.OperDate
                               GROUP BY tmpListContainer.ContainerId
                                      , tmpListContainer.Amount
                                      , tmpListContainer.JuridicalId
                                      , tmpListContainer.InfoMoneyId
                                      , tmpListContainer.PaidKindId
                                      , tmpListContainer.JuridicalId_Basis
                                      , tmpListContainer.BusinessId
                              )
        , tmpResult AS (SELECT tmpMovementItem.OperDate
                             , tmpMovementItem.ObjectId
                             , tmpMovementItem.ObjectDescId
                             , CASE WHEN tmpMovementItem.isCalculated = TRUE
                                         THEN tmpMovementItem.OperSumm - COALESCE (tmpContainerSumm.SummRemainsEnd, 0)
                                    ELSE tmpMovementItem.OperSumm
                               END AS OperSumm
                             , tmpMovementItem.MovementItemId
                             , tmpMovementItem.ContainerId
                             , tmpMovementItem.AccountGroupId, tmpMovementItem.AccountDirectionId, tmpMovementItem.AccountId

                             , tmpMovementItem.ProfitLossGroupId
                             , tmpMovementItem.ProfitLossDirectionId
                             , tmpMovementItem.InfoMoneyGroupId
                             , tmpMovementItem.InfoMoneyDestinationId
                             , tmpMovementItem.InfoMoneyId
                             , tmpMovementItem.BusinessId
                             , tmpMovementItem.JuridicalId_Basis
                             , tmpMovementItem.UnitId
                             , tmpMovementItem.BranchId
                             , tmpMovementItem.ContractId
                             , tmpMovementItem.PaidKindId
                        FROM tmpMovementItem
                             LEFT JOIN (SELECT tmpContainerSumm.*, ContainerLO_Contract.ObjectId AS ContractId
                                        FROM tmpContainerSumm
                                             JOIN ContainerLinkObject AS ContainerLO_Contract
                                                                      ON ContainerLO_Contract.ContainerId = tmpContainerSumm.ContainerId
                                                                     AND ContainerLO_Contract.DescId = zc_ContainerLinkObject_Contract()
                                       ) AS tmpContainerSumm ON tmpContainerSumm.JuridicalId = tmpMovementItem.ObjectId
                                                            AND tmpContainerSumm.InfoMoneyId = tmpMovementItem.InfoMoneyId
                                                            AND tmpContainerSumm.PaidKindId  = tmpMovementItem.PaidKindId
                                                            AND tmpContainerSumm.JuridicalId_Basis = tmpMovementItem.JuridicalId_Basis
                                                            AND tmpContainerSumm.BusinessId = tmpMovementItem.BusinessId
                                                            AND tmpContainerSumm.ContractId = tmpMovementItem.ContractId
                      UNION ALL
                        SELECT tmpMovement.OperDate
                             , tmpContainerSumm.JuridicalId AS ObjectId
                             , zc_Object_Juridical() AS ObjectDescId
                             , -1 * tmpContainerSumm.SummRemainsEnd AS OperSumm
                             , lpInsertUpdate_MovementItem_LossDebt (ioId                 := 0
                                                                   , inMovementId         := tmpMovement.MovementId
                                                                   , inJuridicalId        := tmpContainerSumm.JuridicalId
                                                                   , inAmount             := 0
                                                                   , inSumm               := 0
                                                                   , inIsCalculated       := TRUE
                                                                   , inContractId         := ContainerLO_Contract.ObjectId
                                                                   , inPaidKindId         := tmpContainerSumm.PaidKindId
                                                                   , inInfoMoneyId        := tmpContainerSumm.InfoMoneyId
                                                                   , inUnitId             := NULL
                                                                   , inUserId             := inUserId
                                                                    ) AS MovementItemId
                             , tmpContainerSumm.ContainerId
                             , 0 AS AccountGroupId, 0 AS AccountDirectionId -- ���������� �����, ��� ...
                             , CASE WHEN tmpContainerSumm.InfoMoneyId IN (zc_Enum_InfoMoney_21501(), zc_Enum_InfoMoney_21502()) -- ������ �� ��������� + ������ �� ������ �����
                                         THEN tmpMovement.AccountId
                                    ELSE 0
                               END AS AccountId 

                               -- ������ ����
                             , 0 AS ProfitLossGroupId
                               -- ��������� ���� - �����������
                             , 0 AS ProfitLossDirectionId
                               -- �������������� ������ ����������
                             , COALESCE (View_InfoMoney.InfoMoneyGroupId, 0) AS InfoMoneyGroupId
                               -- �������������� ����������
                             , COALESCE (View_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
                               -- �������������� ������ ����������
                             , COALESCE (View_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId
                               -- ������: ���
                             , 0  AS BusinessId
                             , tmpContainerSumm.JuridicalId_Basis
                             , 0 AS UnitId
                               -- ������: ���
                             , 0 AS BranchId
                             , ContainerLO_Contract.ObjectId AS ContractId
                             , tmpContainerSumm.PaidKindId
                        FROM tmpContainerSumm
                             JOIN ContainerLinkObject AS ContainerLO_Contract
                                                      ON ContainerLO_Contract.ContainerId = tmpContainerSumm.ContainerId
                                                     AND ContainerLO_Contract.DescId = zc_ContainerLinkObject_Contract()
                                                     AND ContainerLO_Contract.ObjectId > 0
                             LEFT JOIN tmpMovement ON 1 = 1
                             LEFT JOIN tmpMovementItem
                                    ON tmpMovementItem.ObjectId = tmpContainerSumm.JuridicalId
                                   AND tmpMovementItem.InfoMoneyId = tmpContainerSumm.InfoMoneyId
                                   AND tmpMovementItem.PaidKindId = tmpContainerSumm.PaidKindId 
                                   AND tmpMovementItem.JuridicalId_Basis = tmpContainerSumm.JuridicalId_Basis
                                   AND tmpMovementItem.BusinessId = tmpContainerSumm.BusinessId
                                   AND tmpMovementItem.ContractId = ContainerLO_Contract.ObjectId
                             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = tmpContainerSumm.InfoMoneyId
                        WHERE tmpContainerSumm.SummRemainsEnd <> 0
                          AND tmpMovementItem.ObjectId IS NULL
                       )
     -- ������
     INSERT INTO _tmpItem (OperDate, ObjectId, ObjectDescId, OperSumm
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId, JuridicalId_Basis
                         , UnitId, BranchId, ContractId, PaidKindId
                         , IsActive, IsMaster
                          )
        SELECT tmpResult.OperDate
             , tmpResult.ObjectId
             , tmpResult.ObjectDescId
             , tmpResult.OperSumm
             , tmpResult.MovementItemId
             , tmpResult.ContainerId
             , tmpResult.AccountGroupId, tmpResult.AccountDirectionId, tmpResult.AccountId

             , tmpResult.ProfitLossGroupId
             , tmpResult.ProfitLossDirectionId
             , tmpResult.InfoMoneyGroupId
             , tmpResult.InfoMoneyDestinationId
             , tmpResult.InfoMoneyId
             , tmpResult.BusinessId
             , tmpResult.JuridicalId_Basis
             , tmpResult.UnitId
             , tmpResult.BranchId
             , tmpResult.ContractId
             , tmpResult.PaidKindId
             , CASE WHEN tmpResult.OperSumm >= 0 THEN TRUE ELSE FALSE END AS IsActive
             , TRUE AS IsMaster
        FROM tmpResult
       UNION ALL
        SELECT tmpResult.OperDate
             , CASE WHEN tmpResult.OperDate < '01.01.2014' THEN zc_Enum_ProfitLoss_80301() ELSE 0 END AS ObjectId -- ������� � ������� + �������� ����������� ������������� + ���������
             , 0 AS ObjectDescId
             , -1 * tmpResult.OperSumm
             , tmpResult.MovementItemId
             , tmpResult.ContainerId
             , tmpResult.AccountGroupId, tmpResult.AccountDirectionId, 0 AccountId /*AS tmpResult.AccountId*/

             , tmpResult.ProfitLossGroupId
             , CASE WHEN tmpResult.OperDate < '01.01.2014' THEN tmpResult.ProfitLossDirectionId ELSE zc_Enum_ProfitLossDirection_80300() END AS ProfitLossDirectionId -- �������� ����������� �������������
             , tmpResult.InfoMoneyGroupId
             , tmpResult.InfoMoneyDestinationId
             , tmpResult.InfoMoneyId
             , tmpResult.BusinessId
             , tmpResult.JuridicalId_Basis
             , tmpResult.UnitId
             , tmpResult.BranchId
             , tmpResult.ContractId
             , tmpResult.PaidKindId
             , CASE WHEN tmpResult.OperSumm >= 0 THEN FALSE ELSE TRUE END AS IsActive
             , FALSE AS IsMaster
        FROM tmpResult
       ;

     -- ��������
     IF EXISTS (SELECT _tmpItem.ObjectId FROM _tmpItem WHERE _tmpItem.ObjectId = 0 AND _tmpItem.IsMaster = TRUE)
     THEN
         RAISE EXCEPTION '������.� ��������� �� ���������� <����������� ����>.���������� ����������.';
     END IF;
     IF EXISTS (SELECT _tmpItem.ContractId FROM _tmpItem WHERE _tmpItem.ContractId = 0 AND _tmpItem.IsMaster = TRUE)
     THEN
         RAISE EXCEPTION '������.� ��������� �� ��������� <� ���.>.���������� ����������.';
     END IF;
     IF EXISTS (SELECT _tmpItem.PaidKindId FROM _tmpItem WHERE _tmpItem.PaidKindId = 0 AND _tmpItem.IsMaster = TRUE)
     THEN
         RAISE EXCEPTION '������.� ��������� �� ���������� <����� ������>.���������� ����������.';
     END IF;
     IF EXISTS (SELECT _tmpItem.InfoMoneyId FROM _tmpItem WHERE _tmpItem.InfoMoneyId = 0 AND _tmpItem.IsMaster = TRUE)
     THEN
         RAISE EXCEPTION '������.� ��������� �� ���������� <�� ������ ����������>.���������� ����������.';
     END IF;
     IF EXISTS (SELECT _tmpItem.JuridicalId_Basis FROM _tmpItem WHERE _tmpItem.JuridicalId_Basis = 0 AND _tmpItem.IsMaster = TRUE)
     THEN
         RAISE EXCEPTION '������.� <��������> �� ����������� <������� ����������� ����>.���������� ����������.<%><%>', lfGet_Object_ValueData ((SELECT MAX (ObjectId) FROM _tmpItem WHERE _tmpItem.JuridicalId_Basis = 0 AND _tmpItem.IsMaster = TRUE)), (SELECT MAX (ContractId) FROM _tmpItem WHERE _tmpItem.JuridicalId_Basis = 0 AND _tmpItem.IsMaster = TRUE);
     END IF;

     -- �������� ��������
     PERFORM lpComplete_Movement_Finance (inMovementId := inMovementId
                                        , inUserId     := inUserId);

     -- !!!5.0. ����������� �������� � ��������� ��������� �� ������ ��� ��������!!!
     UPDATE MovementItem SET Amount =  _tmpItem.OperSumm
     FROM _tmpItem
          JOIN MovementItemBoolean AS MIBoolean_Calculated
                                   ON MIBoolean_Calculated.MovementItemId = _tmpItem.MovementItemId
                                  AND MIBoolean_Calculated.DescId = zc_MIBoolean_Calculated()
                                  AND MIBoolean_Calculated.ValueData = TRUE
     WHERE MovementItem.Id = _tmpItem.MovementItemId
       AND _tmpItem.IsMaster = TRUE
    ;


     -- 5.2. ����� - ����������� ������ ������ ���������
     UPDATE Movement SET StatusId = zc_Enum_Status_Complete() WHERE Id = inMovementId AND DescId = zc_Movement_LossDebt() AND StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased());

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 20.03.14                                        * add !!!���������� �������!!!
 19.03.14                                        * add View_Account_find
 10.03.14                                        * add zc_Enum_Account_50401
 30.01.14                                        * all
 27.01.14         * 
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 103, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM lpComplete_Movement_LossDebt (inMovementId:= 103, inUserId:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 103, inSession:= zfCalc_UserAdmin())
