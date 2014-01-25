-- Function: lpComplete_Movement_TransportService (Integer, Integer)

DROP FUNCTION IF EXISTS lpComplete_Movement_TransportService (Integer, Integer);

CREATE OR REPLACE FUNCTION lpComplete_Movement_TransportService(
    IN inMovementId        Integer  , -- ���� ���������
    IN inUserId            Integer    -- ������������
)                              
RETURNS VOID
--  RETURNS TABLE (MovementItemId Integer, MovementId Integer, OperDate TDateTime, JuridicalId_From Integer, isCorporate Boolean, PersonalId_From Integer, UnitId Integer, BranchId_Unit Integer, PersonalId_Packer Integer, PaidKindId Integer, ContractId Integer, ContainerId_Goods Integer, GoodsId Integer, GoodsKindId Integer, AssetId Integer, PartionGoods TVarChar, OperCount TFloat, tmpOperSumm_Partner TFloat, OperSumm_Partner TFloat, tmpOperSumm_Packer TFloat, OperSumm_Packer TFloat, AccountDirectionId Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer, InfoMoneyDestinationId_isCorporate Integer, InfoMoneyId_isCorporate Integer, JuridicalId_basis Integer, BusinessId Integer, isPartionCount Boolean, isPartionSumm Boolean, PartionMovementId Integer, PartionGoodsId Integer)
AS
$BODY$
BEGIN

     -- !!!�����������!!! �������� ������� ��������
     DELETE FROM _tmpMIContainer_insert;
     -- !!!�����������!!! �������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     DELETE FROM _tmpItem;


     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (OperDate, ObjectId, ObjectDescId, OperSumm
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId, JuridicalId_Basis
                         , UnitId, BranchId, ContractId, PaidKindId
                         , IsActive, IsMaster
                          )
        SELECT Movement.OperDate
             , COALESCE (MovementItem.ObjectId, 0) AS ObjectId
             , COALESCE (Object.DescId, 0) AS ObjectDescId
             , -1 * MovementItem.Amount AS OperSumm
             , MovementItem.Id AS MovementItemId
             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����
               -- ������ ����
             , COALESCE (lfObject_Unit_byProfitLossDirection.ProfitLossGroupId, 0) AS ProfitLossGroupId
               -- ��������� ���� - �����������
             , COALESCE (lfObject_Unit_byProfitLossDirection.ProfitLossDirectionId, 0) AS ProfitLossDirectionId
               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyGroupId, 0) AS InfoMoneyGroupId
               -- �������������� ����������
             , COALESCE (View_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId
               -- ������: ������ �� ������������� (����� ��������)
             , COALESCE (ObjectLink_Unit_Business.ChildObjectId, 0) AS BusinessId
               -- ������� ��.����: ������ �� ������������� (����� ��������)
             , COALESCE (ObjectLink_Unit_Juridical.ChildObjectId, 0) AS JuridicalId_Basis
             , COALESCE (MILinkObject_Unit.ObjectId, 0) AS UnitId
               -- ������: ������ �� �������������
             , COALESCE (ObjectLink_Unit_Branch.ChildObjectId, 0) AS BranchId
             , COALESCE (MILinkObject_Contract.ObjectId, 0) AS ContractId
             , MILinkObject_PaidKind.ObjectId AS PaidKindId
             , FALSE AS IsActive
             , TRUE AS IsMaster
        FROM Movement
             JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Master()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                              ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                             AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                              ON MILinkObject_Unit.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Contract
                                              ON MILinkObject_Contract.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Contract.DescId = zc_MILinkObject_Contract()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_PaidKind
                                              ON MILinkObject_PaidKind.MovementItemId = MovementItem.Id
                                             AND MILinkObject_PaidKind.DescId = zc_MILinkObject_PaidKind()

             LEFT JOIN Object ON Object.Id = MovementItem.ObjectId
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Juridical ON ObjectLink_Unit_Juridical.ObjectId = MILinkObject_Unit.ObjectId
                                                              AND ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Business ON ObjectLink_Unit_Business.ObjectId = MILinkObject_Unit.ObjectId
                                                             AND ObjectLink_Unit_Business.DescId = zc_ObjectLink_Unit_Business()
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch ON ObjectLink_Unit_Branch.ObjectId = MILinkObject_Unit.ObjectId
                                                           AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
             LEFT JOIN lfSelect_Object_Unit_byProfitLossDirection() AS lfObject_Unit_byProfitLossDirection ON lfObject_Unit_byProfitLossDirection.UnitId = MILinkObject_Unit.ObjectId
             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MILinkObject_InfoMoney.ObjectId
        WHERE Movement.Id = inMovementId
          AND Movement.DescId = zc_Movement_TransportService()
          AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
       ;

     -- ��������
     IF EXISTS (SELECT _tmpItem.ObjectId FROM _tmpItem WHERE _tmpItem.ObjectId = 0)
     THEN
         RAISE EXCEPTION '������.� ��������� �� ���������� <����������� ����>. ���������� ����������.';
     END IF;
   
     -- ��������
     IF EXISTS (SELECT _tmpItem.JuridicalId_Basis FROM _tmpItem WHERE _tmpItem.JuridicalId_Basis = 0)
     THEN
         RAISE EXCEPTION '������.� <������������� (����� ��������)> �� ����������� ������� �� ����. ���������� ����������.';
     END IF;


     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (OperDate, ObjectId, ObjectDescId, OperSumm
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId, JuridicalId_Basis
                         , UnitId, BranchId, ContractId, PaidKindId
                         , IsActive, IsMaster
                          )
        SELECT _tmpItem.OperDate
             , 0 AS ObjectId
             , 0 AS ObjectDescId
             , -1 * _tmpItem.OperSumm
             , _tmpItem.MovementItemId
             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����
             , _tmpItem.ProfitLossGroupId, _tmpItem.ProfitLossDirectionId
             , _tmpItem.InfoMoneyGroupId, _tmpItem.InfoMoneyDestinationId, _tmpItem.InfoMoneyId
               -- ������: ������ �� ������������� (����� ��������)
             , _tmpItem.BusinessId
               -- ������� ��.���� ������ �� ������������� (����� ��������)
             , _tmpItem.JuridicalId_Basis
             , _tmpItem.UnitId
               -- ������: ������ �� ������������� (����� ��������)
             , _tmpItem.BranchId
             , _tmpItem.ContractId, _tmpItem.PaidKindId
             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster
        FROM _tmpItem
       ;

     -- �������� ��������
     PERFORM lpComplete_Movement_Finance (inMovementId := inMovementId
                                        , inUserId     := inUserId);

     -- !!!5. ����������� �������� � ��������� ��������� �� ������ ��� ��������!!!
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_UnitRoute(), tmp.MovementItemId, tmp.UnitId_Route)
           , lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_BranchRoute(), tmp.MovementItemId, tmp.BranchId_Route)
     FROM (SELECT _tmpItem.MovementItemId
                , COALESCE (ObjectLink_Route_Unit.ChildObjectId, 0) AS UnitId_Route
                , COALESCE (ObjectLink_UnitRoute_Branch.ChildObjectId, 0) AS BranchId_Route
           FROM _tmpItem
                LEFT JOIN MovementItemLinkObject AS MILinkObject_Route
                                                 ON MILinkObject_Route.MovementItemId = _tmpItem.MovementItemId
                                                AND MILinkObject_Route.DescId = zc_MILinkObject_Route()
                LEFT JOIN ObjectLink AS ObjectLink_Route_Unit
                                     ON ObjectLink_Route_Unit.ObjectId = MILinkObject_Route.ObjectId
                                    AND ObjectLink_Route_Unit.DescId = zc_ObjectLink_Route_Unit()
                LEFT JOIN ObjectLink AS ObjectLink_UnitRoute_Branch
                                     ON ObjectLink_UnitRoute_Branch.ObjectId = ObjectLink_Route_Unit.ChildObjectId
                                    AND ObjectLink_UnitRoute_Branch.DescId = zc_ObjectLink_Unit_Branch()
           WHERE AccountId = zc_Enum_Account_100301() -- 100301; "������� �������� �������"
          ) AS tmp;


     -- 5.2. ����� - ����������� ������ ������ ���������
     UPDATE Movement SET StatusId = zc_Enum_Status_Complete() WHERE Id = inMovementId AND DescId = zc_Movement_TransportService() AND StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased());

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 25.01.14                                        * all
 04.01.14         * 
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 103, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM lpComplete_Movement_TransportService (inMovementId:= 103, inUserId:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 103, inSession:= zfCalc_UserAdmin())
