DROP FUNCTION IF EXISTS lpComplete_Movement_Sale (Integer, Integer);

CREATE OR REPLACE FUNCTION lpComplete_Movement_Sale(
    IN inMovementId        Integer  , -- ���� ���������
    IN inUserId            Integer    -- ������������
)
RETURNS VOID
AS
$BODY$
  DECLARE vbMovementDescId          Integer;
  DECLARE vbOperDate                TDateTime;
  DECLARE vbUnitId                  Integer;
  DECLARE vbClientId                Integer;
  DECLARE vbAccountDirectionId_From Integer;
  DECLARE vbAccountDirectionId_To   Integer;
  DECLARE vbJuridicalId_Basis       Integer; -- �������� ���� �� ������������
  DECLARE vbBusinessId              Integer; -- �������� ���� �� ������������

  DECLARE vbWhereObjectId_Analyzer_from Integer; -- ��������� ��� ��������
  DECLARE vbWhereObjectId_Analyzer_to   Integer; -- ��������� ��� ��������
BEGIN
     -- !!!�����������!!! �������� ������� ��������
     DELETE FROM _tmpMIContainer_insert;
     -- !!!�����������!!! �������� ������� - �������� �� �����������, �� ����� ���������� ��� ������������ �������� � ���������
     DELETE FROM _tmpItem_SummClient;
     -- !!!�����������!!! �������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     DELETE FROM _tmpItem;


     -- ��������� �� ���������
     SELECT _tmp.MovementDescId, _tmp.OperDate, _tmp.UnitId, _tmp.ClientId
          , _tmp.AccountDirectionId_From, _tmp.AccountDirectionId_To
            INTO vbMovementDescId
               , vbOperDate
               , vbUnitId
               , vbClientId
               , vbAccountDirectionId_From
               , vbAccountDirectionId_To
     FROM (SELECT Movement.DescId AS MovementDescId
                , Movement.OperDate
                , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit()   THEN Object_From.Id ELSE 0 END, 0) AS UnitId
                , COALESCE (CASE WHEN Object_To.DescId   = zc_Object_Client() THEN Object_To.Id   ELSE 0 END, 0) AS ClientId

                  -- ��������� ������ - ����������� - !!!�������� - zc_Enum_AccountDirection_10100!!! ������ + ��������
                , COALESCE (ObjectLink_Unit_AccountDirection.ChildObjectId, zc_Enum_AccountDirection_10100()) AS AccountDirectionId_From

                  -- !!!������ - zc_Enum_AccountDirection_20100!!! �������� + ����������
                , zc_Enum_AccountDirection_20100() AS AccountDirectionId_To

           FROM Movement
                LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                             ON MovementLinkObject_From.MovementId = Movement.Id
                                            AND MovementLinkObject_From.DescId     = zc_MovementLinkObject_From()
                LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

                LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                             ON MovementLinkObject_To.MovementId = Movement.Id
                                            AND MovementLinkObject_To.DescId     = zc_MovementLinkObject_To()
                LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

                LEFT JOIN ObjectLink AS ObjectLink_Unit_AccountDirection
                                     ON ObjectLink_Unit_AccountDirection.ObjectId = MovementLinkObject_From.ObjectId
                                    AND ObjectLink_Unit_AccountDirection.DescId   = zc_ObjectLink_Unit_AccountDirection()

           WHERE Movement.Id       = inMovementId
             AND Movement.DescId   = zc_Movement_Sale()
             AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
          ) AS _tmp;


     -- ������������ - ��������� ��� ��������
     vbWhereObjectId_Analyzer_from:= CASE WHEN vbUnitId   <> 0 THEN vbUnitId   END;
     -- ������������ - ��������� ��� ��������
     vbWhereObjectId_Analyzer_to  := CASE WHEN vbClientId <> 0 THEN vbClientId END;


     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (MovementItemId
                         , ContainerId_Summ, ContainerId_Goods
                         , GoodsId, PartionId, GoodsSizeId
                         , OperCount, OperPrice, CountForPrice, OperSumm, OperSumm_Currency
                         , OperSumm_ToPay, OperSummPriceList, TotalChangePercent, TotalPay
                         , Summ_10201, Summ_10202, Summ_10203, Summ_10204
                         , AccountId, InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , CurrencyValue, ParValue
                          )
        WITH -- ���� - �� �������
             tmpCurrency AS (SELECT *
                             FROM lfSelect_Movement_CurrencyAll_byDate (inOperDate      := vbOperDate
                                                                      , inCurrencyFromId:= zc_Currency_Basis()
                                                                      , inCurrencyToId  := 0
                                                                       )
                            )
        -- ���������
        SELECT _tmp.MovementItemId
             , 0 AS ContainerId_Summ          -- ���������� �����
             , 0 AS ContainerId_Goods         -- ���������� �����
             , _tmp.GoodsId
             , _tmp.PartionId
             , _tmp.GoodsSizeId
             , _tmp.OperCount

               -- ���� - �� ������
             , _tmp.OperPrice
               -- ���� �� ���������� - �� ������
             , _tmp.CountForPrice

               -- ����� �� ��. � zc_Currency_Basis
             , CASE WHEN _tmp.CurrencyId = zc_Currency_Basis()
                         THEN _tmp.OperSumm_Currency
                    WHEN _tmp.CurrencyId = tmpCurrency.CurrencyFromId
                         THEN zfCalc_CurrencyFrom (_tmp.OperSumm_Currency, tmpCurrency.Amount, tmpCurrency.ParValue)
                    WHEN _tmp.CurrencyId = tmpCurrency.CurrencyToId
                         THEN zfCalc_CurrencyTo (_tmp.OperSumm_Currency, tmpCurrency.Amount, tmpCurrency.ParValue)
               END AS OperSumm
               -- ����� �� ��. � ������
             , _tmp.OperSumm_Currency


               -- ����� � ������
             , _tmp.OperSummPriceList - _tmp.TotalChangePercent AS OperSumm_ToPay

             , _tmp.OperSummPriceList  -- ����� �� ������
             , _tmp.TotalChangePercent -- ����� ����� ������
             , _tmp.TotalPay           -- ����� ����� ������

             , _tmp.Summ_10201         -- �������� ������
             , _tmp.Summ_10202         -- ������ outlet
             , _tmp.Summ_10203         -- ������ �������
             , _tmp.Summ_10204         -- ������ ��������������


             , 0 AS AccountId          -- ����(�����������), ���������� �����

               -- �� ��� Sale - ��� ����������� ����� ������
             , _tmp.InfoMoneyGroupId
             , _tmp.InfoMoneyDestinationId
             , _tmp.InfoMoneyId

               -- ���� - �� �������
             , tmpCurrency.Amount   AS CurrencyValue
               -- ������� ����� - �� �������
             , tmpCurrency.ParValue AS ParValue

        FROM (SELECT MovementItem.Id                  AS MovementItemId
                   , MovementItem.ObjectId            AS GoodsId
                   , MovementItem.PartionId           AS PartionId
                   , Object_PartionGoods.GoodsSizeId  AS GoodsSizeId
                   , MovementItem.Amount              AS OperCount
                   , Object_PartionGoods.OperPrice    AS OperPrice
                   , CASE WHEN Object_PartionGoods.CountForPrice > 0 THEN Object_PartionGoods.CountForPrice ELSE 1 END AS CountForPrice
                   , Object_PartionGoods.CurrencyId   AS CurrencyId

                     -- ����� �� ��. � ������ - � ����������� �� 2-� ������
                   , zfCalc_SummIn (MovementItem.Amount, Object_PartionGoods.OperPrice, Object_PartionGoods.CountForPrice) AS OperSumm_Currency

                     -- ����� �� ������ - � ����������� �� 2-� ������
                   , zfCalc_SummPriceList (MovementItem.Amount, MIFloat_OperPriceList.ValueData) AS OperSummPriceList
                     -- ����� ����� ������ (� ���) - ������ ��� �������� ��������� - ����������� 1)�� %������ + 2)��������������
                   , COALESCE (MIFloat_TotalChangePercent.ValueData, 0)                          AS TotalChangePercent
                     -- ����� ����� ������ (� ���) - � ������� ��������� �� zc_MI_Child
                   , COALESCE (MIFloat_TotalPay.ValueData, 0)                                    AS TotalPay

                     -- �������� ������
                   , CASE WHEN MILinkObject_DiscountSaleKind.ObjectId = zc_Enum_DiscountSaleKind_Period() THEN zfCalc_SummPriceList (MovementItem.Amount, MIFloat_OperPriceList.ValueData) - zfCalc_SummChangePercent (MovementItem.Amount, MIFloat_OperPriceList.ValueData, MIFloat_ChangePercent.ValueData) ELSE 0 END AS Summ_10201
                     -- ������ outlet
                   , CASE WHEN MILinkObject_DiscountSaleKind.ObjectId = zc_Enum_DiscountSaleKind_Outlet() THEN zfCalc_SummPriceList (MovementItem.Amount, MIFloat_OperPriceList.ValueData) - zfCalc_SummChangePercent (MovementItem.Amount, MIFloat_OperPriceList.ValueData, MIFloat_ChangePercent.ValueData) ELSE 0 END AS Summ_10202
                     -- ������ �������
                   , CASE WHEN MILinkObject_DiscountSaleKind.ObjectId = zc_Enum_DiscountSaleKind_Client() THEN zfCalc_SummPriceList (MovementItem.Amount, MIFloat_OperPriceList.ValueData) - zfCalc_SummChangePercent (MovementItem.Amount, MIFloat_OperPriceList.ValueData, MIFloat_ChangePercent.ValueData) ELSE 0 END AS Summ_10203
                     -- ������ ��������������
                   , COALESCE (MIFloat_SummChangePercent.ValueData, 0) AS Summ_10204

                     -- �������������� ������
                   , View_InfoMoney.InfoMoneyGroupId
                     -- �������������� ����������
                   , View_InfoMoney.InfoMoneyDestinationId
                     -- ������ ����������
                   , View_InfoMoney.InfoMoneyId

              FROM Movement
                   JOIN MovementItem ON MovementItem.MovementId = Movement.Id
                                    AND MovementItem.DescId     = zc_MI_Master()
                                    AND MovementItem.isErased   = FALSE
                   LEFT JOIN MovementItemFloat AS MIFloat_OperPriceList
                                               ON MIFloat_OperPriceList.MovementItemId = MovementItem.Id
                                              AND MIFloat_OperPriceList.DescId         = zc_MIFloat_OperPriceList()
                   LEFT JOIN MovementItemFloat AS MIFloat_TotalChangePercent
                                               ON MIFloat_TotalChangePercent.MovementItemId = MovementItem.Id
                                              AND MIFloat_TotalChangePercent.DescId         = zc_MIFloat_TotalChangePercent()
                   LEFT JOIN MovementItemFloat AS MIFloat_TotalPay
                                               ON MIFloat_TotalPay.MovementItemId = MovementItem.Id
                                              AND MIFloat_TotalPay.DescId         = zc_MIFloat_TotalPay()
                   LEFT JOIN MovementItemFloat AS MIFloat_ChangePercent
                                               ON MIFloat_ChangePercent.MovementItemId = MovementItem.Id
                                              AND MIFloat_ChangePercent.DescId         = zc_MIFloat_ChangePercent()
                   LEFT JOIN MovementItemFloat AS MIFloat_SummChangePercent
                                               ON MIFloat_SummChangePercent.MovementItemId = MovementItem.Id
                                              AND MIFloat_SummChangePercent.DescId         = zc_MIFloat_SummChangePercent()
                                              
                   LEFT JOIN MovementItemLinkObject AS MILinkObject_DiscountSaleKind
                                                    ON MILinkObject_DiscountSaleKind.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_DiscountSaleKind.DescId         = zc_MILinkObject_DiscountSaleKind()

                   LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                        ON ObjectLink_Goods_InfoMoney.ObjectId = MovementItem.ObjectId
                                       AND ObjectLink_Goods_InfoMoney.DescId   = zc_ObjectLink_Goods_InfoMoney()
                   LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = COALESCE (ObjectLink_Goods_InfoMoney.ChildObjectId, zc_Enum_InfoMoney_10101()) -- !!!��������!!! ������ + ������ + ������
                   LEFT JOIN Object_PartionGoods ON Object_PartionGoods.MovementItemId = MovementItem.PartionId


              WHERE Movement.Id       = inMovementId
                AND Movement.DescId   = zc_Movement_Income()
                AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
             ) AS _tmp
             LEFT JOIN tmpCurrency ON tmpCurrency.CurrencyFromId = _tmp.CurrencyId OR tmpCurrency.CurrencyToId = _tmp.CurrencyId
            ;

     -- �������� ��� ������ �� ��� ����
     IF EXISTS (SELECT 1 FROM _tmpItem WHERE _tmpItem.TotalChangePercent <> _tmpItem.Summ_10201 + _tmpItem.Summ_10202 + _tmpItem.Summ_10203 + _tmpItem.Summ_10204)
     THEN
         RAISE EXCEPTION '������. ����� ����� <%> �� ����� <%>.', (SELECT _tmpItem.TotalChangePercent FROM _tmpItem WHERE _tmpItem.TotalChangePercent <> _tmpItem.Summ_10201 + _tmpItem.Summ_10202 + _tmpItem.Summ_10203 + _tmpItem.Summ_10204 ORDER BY _tmpItem.MovementItemId LIMIT 1)
                                                                , (SELECT _tmpItem.Summ_10201 + _tmpItem.Summ_10202 + _tmpItem.Summ_10203 + _tmpItem.Summ_10204 FROM _tmpItem WHERE _tmpItem.TotalChangePercent <> _tmpItem.Summ_10201 + _tmpItem.Summ_10202 + _tmpItem.Summ_10203 + _tmpItem.Summ_10204 ORDER BY _tmpItem.MovementItemId LIMIT 1)
         ;
     END IF;


     -- 5.0. ������������ ��-�� �� ������: <����> + <���� �� ����������> + ���� - �� �������
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_OperPrice(),     _tmpItem.MovementItemId, _tmpItem.OperPrice)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_CountForPrice(), _tmpItem.MovementItemId, _tmpItem.CountForPrice)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_CurrencyValue(), _tmpItem.MovementItemId, _tmpItem.CurrencyValue)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_ParValue(),      _tmpItem.MovementItemId, _tmpItem.ParValue)
     FROM _tmpItem;



     -- 5.1. ����� - ����������� ��������� ��������
     PERFORM lpInsertUpdate_MovementItemContainer_byTable();

    -- 5.2. ����� - ����������� ������ ������ ��������� + ��������� ��������
    PERFORM lpComplete_Movement (inMovementId := inMovementId
                               , inDescId     := zc_Movement_Sale()
                               , inUserId     := inUserId
                                );

    -- 6. �������� �������� ����� �� ����������
    PERFORM lpUpdate_Object_Client_Total (inMovementId:= inMovementId, inIsComplete:= TRUE, inUserId:= inUserId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.   ��������� �.�.
 14.05.17         *
*/

-- ����
-- SELECT * FROM lpComplete_Movement_Sale (inMovementId:= 1100, inUserId:= zfCalc_UserAdmin() :: Integer)
