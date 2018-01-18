-- Function: lpInsertUpdate_MovementFloat_TotalSumm (Integer)

DROP FUNCTION IF EXISTS lpInsertUpdate_MovementFloat_TotalSummSale (Integer);
DROP FUNCTION IF EXISTS lpInsertUpdate_MovementFloat_TotalSummIncome (Integer);
DROP FUNCTION IF EXISTS lpInsertUpdate_MovementFloat_TotalSumm (Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_MovementFloat_TotalSumm(
    IN inMovementId Integer -- ���� ������� <��������>
)
  RETURNS VOID AS
$BODY$
  DECLARE vbMovementDescId Integer;

  DECLARE vbTotalCount TFloat;
  DECLARE vbTotalCountRemains TFloat;
  DECLARE vbTotalSumm TFloat;
  DECLARE vbTotalSummPriceList TFloat;
  DECLARE vbTotalSummRemainsPriceList TFloat;

  DECLARE vbTotalCountSecond TFloat;
  DECLARE vbTotalCountSecondRemains TFloat;
  DECLARE vbTotalSummSecondPriceList TFloat;
  DECLARE vbTotalSummSecondRemainsPriceList TFloat;

  DECLARE vbTotalSummChange TFloat;
  DECLARE vbTotalSummPay TFloat;

  DECLARE vbTotalSummChangePay TFloat;
  DECLARE vbTotalSummPayOth TFloat;
  DECLARE vbTotalCountReturn TFloat;
  DECLARE vbTotalSummReturn TFloat;
  DECLARE vbTotalSummPayReturn TFloat;
  DECLARE vbTotalSummBalance TFloat;
/*  DECLARE vbTotalCountSecond TFloat;
*/
BEGIN
     IF COALESCE (inMovementId, 0) = 0
     THEN
         RAISE EXCEPTION '������.������� ��������� �� ��������.';
     END IF;


     -- ��� ��������� ����� ��� ������� �������� ����
     vbMovementDescId:= (SELECT Movement.DescId FROM Movement WHERE Movement.Id = inMovementId);

     --
     SELECT SUM (COALESCE(MovementItem.Amount, 0))                                                                  AS TotalCount
          , SUM (zfCalc_SummIn (MovementItem.Amount, MIFloat_OperPrice.ValueData, MIFloat_CountForPrice.ValueData)) AS TotalSumm
          , SUM (CAST (zfCalc_SummIn (MovementItem.Amount, MIFloat_OperPrice.ValueData, MIFloat_CountForPrice.ValueData)
                     * COALESCE (MIFloat_CurrencyValue.ValueData, 0) / CASE WHEN MIFloat_ParValue.ValueData > 0
                                                                            THEN MIFloat_ParValue.ValueData
                                                                            ELSE 1
                                                                      END
                 AS NUMERIC (16, 2))
                )                                                                                                   AS TotalSummBalance
          , SUM (zfCalc_SummPriceList (MovementItem.Amount, MIFloat_OperPriceList.ValueData))                       AS TotalSummPriceList

          , SUM (COALESCE (MIFloat_TotalChangePercent.ValueData, 0) + COALESCE (MIFloat_SummChangePercent.ValueData, 0)) AS TotalSummChange
          , SUM (COALESCE (MIFloat_TotalPay.ValueData,0))                                                                AS TotalSummPay

          , 0 AS TotalSummChangePay
          , 0 AS TotalSummPayOth
          , 0 AS TotalCountReturn
          , 0 AS TotalSummReturn
          , 0 AS TotalSummPayReturn

            ---
          , SUM (COALESCE(MIFloat_AmountRemains.ValueData, 0))       AS TotalCountRemains
          , SUM (COALESCE(MIFloat_AmountSecond.ValueData, 0))        AS TotalCountSecond
          , SUM (COALESCE(MIFloat_AmountSecondRemains.ValueData, 0)) AS TotalCountSecondRemains
          , SUM (zfCalc_SummPriceList (MIFloat_AmountSecond.ValueData, MIFloat_OperPriceList.ValueData))        AS TotalSummSecondPriceList
          , SUM (zfCalc_SummPriceList (MIFloat_AmountSecondRemains.ValueData, MIFloat_OperPriceList.ValueData)) AS TotalSummSecondRemainsPriceList
          , SUM (zfCalc_SummPriceList (MIFloat_AmountRemains.ValueData, MIFloat_OperPriceList.ValueData))       AS TotalSummRemainsPriceList

          --, COALESCE (MIFloat_CurrencyValue.ValueData, 0)              ::TFloat AS CurrencyValue
          --, COALESCE (MIFloat_ParValue.ValueData, 0)                   ::TFloat AS ParValue

            INTO vbTotalCount, vbTotalSumm, vbTotalSummBalance, vbTotalSummPriceList
               , vbTotalSummChange, vbTotalSummPay
               , vbTotalSummChangePay, vbTotalSummPayOth, vbTotalCountReturn, vbTotalSummReturn, vbTotalSummPayReturn
               , vbTotalCountRemains, vbTotalCountSecond, vbTotalCountSecondRemains
               , vbTotalSummSecondPriceList, vbTotalSummSecondRemainsPriceList, vbTotalSummRemainsPriceList
       
       FROM MovementItem
            LEFT JOIN MovementItemFloat AS MIFloat_CountForPrice
                                        ON MIFloat_CountForPrice.MovementItemId = MovementItem.Id
                                       AND MIFloat_CountForPrice.DescId = zc_MIFloat_CountForPrice()
            LEFT JOIN MovementItemFloat AS MIFloat_OperPrice
                                        ON MIFloat_OperPrice.MovementItemId = MovementItem.Id
                                       AND MIFloat_OperPrice.DescId = zc_MIFloat_OperPrice()
            LEFT JOIN MovementItemFloat AS MIFloat_OperPriceList
                                        ON MIFloat_OperPriceList.MovementItemId = MovementItem.Id
                                       AND MIFloat_OperPriceList.DescId = zc_MIFloat_OperPriceList()

            LEFT JOIN MovementItemFloat AS MIFloat_AmountRemains
                                        ON MIFloat_AmountRemains.MovementItemId = MovementItem.Id
                                       AND MIFloat_AmountRemains.DescId = zc_MIFloat_AmountRemains()
            LEFT JOIN MovementItemFloat AS MIFloat_AmountSecond
                                        ON MIFloat_AmountSecond.MovementItemId = MovementItem.Id
                                       AND MIFloat_AmountSecond.DescId = zc_MIFloat_AmountSecond()
            LEFT JOIN MovementItemFloat AS MIFloat_AmountSecondRemains
                                        ON MIFloat_AmountSecondRemains.MovementItemId = MovementItem.Id
                                       AND MIFloat_AmountSecondRemains.DescId = zc_MIFloat_AmountSecondRemains()


            LEFT JOIN MovementItemFloat AS MIFloat_SummChangePercent
                                        ON MIFloat_SummChangePercent.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummChangePercent.DescId         = zc_MIFloat_SummChangePercent()
                                       -- ������ ��� ������� �����������
                                       AND vbMovementDescId                         = zc_Movement_GoodsAccount()

            LEFT JOIN MovementItemFloat AS MIFloat_TotalChangePercent
                                        ON MIFloat_TotalChangePercent.MovementItemId = MovementItem.Id
                                       AND MIFloat_TotalChangePercent.DescId         = zc_MIFloat_TotalChangePercent()

            LEFT JOIN MovementItemFloat AS MIFloat_TotalPay
                                        ON MIFloat_TotalPay.MovementItemId = MovementItem.Id
                                       AND MIFloat_TotalPay.DescId         = zc_MIFloat_TotalPay()

            LEFT JOIN MovementItemFloat AS MIFloat_CurrencyValue
                                        ON MIFloat_CurrencyValue.MovementItemId = MovementItem.Id
                                       AND MIFloat_CurrencyValue.DescId         = zc_MIFloat_CurrencyValue()
            LEFT JOIN MovementItemFloat AS MIFloat_ParValue
                                        ON MIFloat_ParValue.MovementItemId = MovementItem.Id
                                       AND MIFloat_ParValue.DescId         = zc_MIFloat_ParValue()
      WHERE MovementItem.MovementId = inMovementId
        AND MovementItem.DescId     = zc_MI_Master()
        AND MovementItem.isErased = false;


      IF vbMovementDescId IN (zc_Movement_Inventory())
         THEN
             -- ��������� �������� <����� ����������>
             PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalCount(), inMovementId, vbTotalCount + vbTotalCountSecond);
             -- ��������� �������� <����� ����� �� ������>
             PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSummPriceList(), inMovementId, vbTotalSummPriceList + vbTotalSummSecondPriceList);

             -- ��������� �������� <����� ���������� �������>
             PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalCountRemains(), inMovementId, vbTotalCountRemains + vbTotalCountSecondRemains);
             -- ��������� �������� <����� ����� �� ������ - �������>
             PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSummRemainsPriceList(), inMovementId, vbTotalSummRemainsPriceList + vbTotalSummSecondRemainsPriceList);
      ELSE

             -- ��������� �������� <����� ����������("������� ��������")>
             PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalCount(), inMovementId, vbTotalCount);
             -- ��������� �������� <����� �����>
             PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSumm(), inMovementId, vbTotalSumm);
             -- ��������� �������� <����� ����� ��. � ���>
             PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSummBalance(), inMovementId, vbTotalSummBalance);
             -- ��������� �������� <����� ����� �� ������>
             PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSummPriceList(), inMovementId, vbTotalSummPriceList);

             -- ��������� �������� <����� ����� ������ � ���>
             PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSummChange(), inMovementId, vbTotalSummChange);
             -- ��������� �������� <����� ����� ������ (� ���)>
             PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSummPay(), inMovementId, vbTotalSummPay);

             -- ��������� �������� <����� ����� ������ � ���>
             -- PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSummChangePay(), inMovementId, vbTotalSummChangePay);
             -- ��������� �������� <����� ����� ������ (� ���)>
             -- PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSummPayOth(), inMovementId, vbTotalSummPayOth);
             -- ��������� �������� <����� ���������� ��������>
             -- PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalCountReturn(), inMovementId, vbTotalCountReturn);
             -- ��������� �������� <����� ����� �������� �� ������� (� ���)>
             -- PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSummReturn(), inMovementId, vbTotalSummReturn);
             -- ��������� �������� <����� ����� �������� ������ (� ���)>
             -- PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSummPayReturn(), inMovementId, vbTotalSummPayReturn);

      END IF;


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertUpdate_MovementFloat_TotalSumm (Integer) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 21.07.17         *
 15.06.17         *
 28.04.15                         *
*/
-- select lpInsertUpdate_MovementFloat_TotalSumm (inMovementId:= id) from gpSelect_Movement_WeighingPartner (inStartDate := ('01.06.2014')::TDateTime , inEndDate := ('30.06.2014')::TDateTime ,  inSession := '5') as a
-- ����
-- SELECT lpInsertUpdate_MovementFloat_TotalSumm (inMovementId:= Movement.Id) from Movement where DescId = zc_Movement_Income() and OperDate between ('01.11.2014')::TDateTime and  ('31.12.2014')::TDateTime
