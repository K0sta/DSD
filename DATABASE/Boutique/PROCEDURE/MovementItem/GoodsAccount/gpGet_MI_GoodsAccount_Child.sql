-- Function: gpGet_Movement_Income()

DROP FUNCTION IF EXISTS gpGet_MI_GoodsAccount_Child (Integer, Integer, TVarChar);


CREATE OR REPLACE FUNCTION gpGet_MI_GoodsAccount_Child(
    IN inId             Integer  , -- ����
    IN inMovementId     Integer  , --
    IN inSession        TVarChar   -- ������ ������������
)
RETURNS TABLE (Id Integer
             , CurrencyValue_USD TFloat, ParValue_USD TFloat
             , CurrencyValue_EUR TFloat, ParValue_EUR TFloat
             , AmountGRN      TFloat
             , AmountUSD      TFloat
             , AmountEUR      TFloat
             , AmountCard     TFloat
             , AmountDiscount TFloat
             , AmountToPay    TFloat
             , AmountRemains  TFloat
             , AmountDiff     TFloat
             , isPayTotal     Boolean
             , isGRN          Boolean
             , isUSD          Boolean
             , isEUR          Boolean
             , isCard         Boolean
             , isDiscount     Boolean
              )
AS
$BODY$
   DECLARE vbUserId            Integer;
   DECLARE vbOperDate          TDateTime;
   DECLARE vbSummToPay         TFloat;
   DECLARE vbSummChangePercent TFloat;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpGetUserBySession (inSession);

     
     -- ������ �� ���������
     vbOperDate:= (SELECT Movement.OperDate FROM Movement WHERE Movement.Id = inMovementId);

         -- ����� � ������
         SELECT CAST ( SUM (((CASE WHEN COALESCE (MIFloat_CountForPrice.ValueData, 0) <> 0
                                  THEN CAST (COALESCE (MI_Sale.Amount, 0) * COALESCE (MIFloat_OperPriceList.ValueData, 0) / COALESCE (MIFloat_CountForPrice.ValueData, 1) AS NUMERIC (16, 2))
                                  ELSE CAST ( COALESCE (MI_Sale.Amount, 0) * COALESCE (MIFloat_OperPriceList.ValueData, 0) AS NUMERIC (16, 2))
                             END) 
                               - COALESCE (MIFloat_TotalChangePercent.ValueData, 0)
                               - COALESCE (MIFloat_TotalPay_Sale.ValueData, 0)
                               - COALESCE (MIFloat_TotalReturn.ValueData, 0)
                       ) * (CASE WHEN Movement_Sale.DescId = zc_Movement_Sale() THEN 1 ELSE -1 END))  AS TFloat) AS SummDebt 
              , CAST ( SUM (COALESCE(MIFloat_SummChangePercent.ValueData,0) ) AS NUMERIC (16, 2))
        INTO vbSumm, vbSummChangePercent
         FROM MovementItem 
              LEFT JOIN MovementItemFloat AS MIFloat_SummChangePercent
                                          ON MIFloat_SummChangePercent.MovementItemId = MovementItem.Id
                                         AND MIFloat_SummChangePercent.DescId         = zc_MIFloat_SummChangePercent()

              LEFT JOIN MovementItemLinkObject AS MILinkObject_PartionMI
                                               ON MILinkObject_PartionMI.MovementItemId = MovementItem.Id
                                              AND MILinkObject_PartionMI.DescId = zc_MILinkObject_PartionMI()
              LEFT JOIN Object AS Object_PartionMI ON Object_PartionMI.Id = MILinkObject_PartionMI.ObjectId
              LEFT JOIN MovementItem AS MI_Sale ON MI_Sale.Id = Object_PartionMI.ObjectCode
              LEFT JOIN Movement AS Movement_Sale ON Movement_Sale.Id = MI_Sale.MovementId
              LEFT JOIN MovementDesc ON MovementDesc.Id = Movement_Sale.DescId
              ----         
              LEFT JOIN MovementItemFloat AS MIFloat_CountForPrice
                                          ON MIFloat_CountForPrice.MovementItemId = MI_Sale.Id
                                         AND MIFloat_CountForPrice.DescId = zc_MIFloat_CountForPrice()
              LEFT JOIN MovementItemFloat AS MIFloat_OperPriceList
                                          ON MIFloat_OperPriceList.MovementItemId = MI_Sale.Id
                                         AND MIFloat_OperPriceList.DescId = zc_MIFloat_OperPriceList()
              LEFT JOIN MovementItemFloat AS MIFloat_TotalPay_Sale
                                          ON MIFloat_TotalPay_Sale.MovementItemId = MI_Sale.Id
                                         AND MIFloat_TotalPay_Sale.DescId         = zc_MIFloat_TotalPay()    
              LEFT JOIN MovementItemFloat AS MIFloat_TotalReturn
                                          ON MIFloat_TotalReturn.MovementItemId = MI_Sale.Id
                                         AND MIFloat_TotalReturn.DescId         = zc_MIFloat_TotalReturn()    
              LEFT JOIN MovementItemFloat AS MIFloat_TotalPayReturn
                                          ON MIFloat_TotalPayReturn.MovementItemId = MI_Sale.Id
                                         AND MIFloat_TotalPayReturn.DescId         = zc_MIFloat_TotalPayReturn() 
              LEFT JOIN MovementItemFloat AS MIFloat_TotalChangePercent
                                          ON MIFloat_TotalChangePercent.MovementItemId = MI_Sale.Id
                                         AND MIFloat_TotalChangePercent.DescId         = zc_MIFloat_TotalChangePercent()   
          WHERE (MovementItem.Id = inId OR inId = 0)
            AND MovementItem.MovementId = inMovementId
            AND MovementItem.DescId     = zc_MI_Master()
            AND MovementItem.isErased   = FALSE;


     IF COALESCE (inId, 0) = 0    -- ������� ������ �����
     THEN
         -- ���������
         RETURN QUERY 
         WITH tmpMI AS 
                     (SELECT SUM (CASE WHEN Object.DescId = zc_Object_Cash() AND MILinkObject_Currency.ObjectId = zc_Currency_GRN() THEN COALESCE(MovementItem.Amount,0) ELSE 0 END) AS AmountGRN
                           , SUM (CASE WHEN Object.DescId = zc_Object_Cash() AND MILinkObject_Currency.ObjectId = zc_Currency_USD() THEN COALESCE(MovementItem.Amount,0) ELSE 0 END) AS AmountUSD
                           , SUM (CASE WHEN Object.DescId = zc_Object_Cash() AND MILinkObject_Currency.ObjectId = zc_Currency_EUR() THEN COALESCE(MovementItem.Amount,0) ELSE 0 END) AS AmountEUR
                           , SUM (CASE WHEN Object.DescId = zc_Object_BankAccount() THEN MovementItem.Amount ELSE 0 END) AS AmountCard
                      FROM MovementItem
                            LEFT JOIN Object ON Object.Id = MovementItem.ObjectId
                            LEFT JOIN MovementItemLinkObject AS MILinkObject_Currency
                                                             ON MILinkObject_Currency.MovementItemId = MovementItem.Id
                                                            AND MILinkObject_Currency.DescId = zc_MILinkObject_Currency()
                      WHERE MovementItem.MovementId = inMovementId
                        AND MovementItem.DescId     = zc_MI_Child()
                        AND MovementItem.isErased   = FALSE
                     )

          SELECT 0                       :: Integer  AS Id
               , tmp_USD.Amount          ::TFloat    AS CurrencyValue_USD
               , tmp_USD.ParValue        ::TFloat    AS ParValue_USD
               , tmp_EUR.Amount          ::TFloat    AS CurrencyValue_EUR
               , tmp_EUR.ParValue        ::TFloat    AS ParValue_EUR
               , tmpMI.AmountGRN         ::TFloat
               , tmpMI.AmountUSD         ::TFloat
               , tmpMI.AmountEUR         ::TFloat
               , tmpMI.AmountCard        ::TFloat
               , vbSummChangePercent     ::TFloat    AS AmountDiscount

               , vbSumm                  ::TFloat AS Amount

               , CASE WHEN vbSumm - ( COALESCE (tmpMI.AmountGRN,0) 
                                    + (COALESCE(tmpMI.AmountUSD,0) * COALESCE(tmp_USD.Amount,0))
                                    + (COALESCE(tmpMI.AmountEUR,0) * COALESCE(tmp_EUR.Amount,0)) 
                                    + COALESCE(tmpMI.AmountCard,0)
                                    + COALESCE(vbSummChangePercent,0) ) > 0 
                      THEN vbSumm - ( COALESCE (tmpMI.AmountGRN,0) 
                                    + (COALESCE(tmpMI.AmountUSD,0) * COALESCE(tmp_USD.Amount,0))
                                    + (COALESCE(tmpMI.AmountEUR,0) * COALESCE(tmp_EUR.Amount,0)) 
                                    + COALESCE(tmpMI.AmountCard,0)
                                    + COALESCE(vbSummChangePercent,0) )
                      ELSE 0
                 END                              ::TFloat AS AmountRemains          
               , CASE WHEN vbSumm - ( COALESCE (tmpMI.AmountGRN,0) 
                                    + (COALESCE(tmpMI.AmountUSD,0) * COALESCE(tmp_USD.Amount,0))
                                    + (COALESCE(tmpMI.AmountEUR,0) * COALESCE(tmp_EUR.Amount,0)) 
                                    + COALESCE(tmpMI.AmountCard,0)
                                    + COALESCE(vbSummChangePercent,0) ) < 0 
                      THEN (vbSumm - ( COALESCE (tmpMI.AmountGRN,0) 
                                    + (COALESCE(tmpMI.AmountUSD,0) * COALESCE(tmp_USD.Amount,0))
                                    + (COALESCE(tmpMI.AmountEUR,0) * COALESCE(tmp_EUR.Amount,0)) 
                                    + COALESCE(tmpMI.AmountCard,0) 
                                    + COALESCE(vbSummChangePercent,0))) * (-1)
                      ELSE 0
                 END                              ::TFloat AS AmountChange
               
                 , TRUE AS isPayTotal
                 , CASE WHEN COALESCE (tmpMI.AmountGRN,0) <> 0 THEN TRUE ELSE FALSE END     AS isGRN
                 , CASE WHEN COALESCE (tmpMI.AmountUSD,0) <> 0 THEN TRUE ELSE FALSE END     AS isUSD
                 , CASE WHEN COALESCE (tmpMI.AmountEUR,0) <> 0 THEN TRUE ELSE FALSE END     AS isEUR
                 , CASE WHEN COALESCE (tmpMI.AmountCard,0) <> 0 THEN TRUE ELSE FALSE END    AS isCard
                 , CASE WHEN COALESCE (vbSummChangePercent,0) <> 0 THEN TRUE ELSE FALSE END AS isDiscount

           FROM tmpMI
               LEFT JOIN lfSelect_Movement_Currency_byDate (inOperDate:= vbOperDate, inCurrencyFromId:= zc_Currency_Basis(), inCurrencyToId:= zc_Currency_USD()) AS tmp_USD ON 1=1
               LEFT JOIN lfSelect_Movement_Currency_byDate (inOperDate:= vbOperDate, inCurrencyFromId:= zc_Currency_Basis(), inCurrencyToId:= zc_Currency_EUR()) AS tmp_EUR ON 1=1
                ;

     ELSE
         -- ���������
         RETURN QUERY
           WITH tmpMI AS 
                     (SELECT SUM (CASE WHEN Object.DescId = zc_Object_Cash() AND MILinkObject_Currency.ObjectId = zc_Currency_GRN() THEN COALESCE(MovementItem.Amount,0) ELSE 0 END) AS AmountGRN
                           , SUM (CASE WHEN Object.DescId = zc_Object_Cash() AND MILinkObject_Currency.ObjectId = zc_Currency_USD() THEN COALESCE(MovementItem.Amount,0) ELSE 0 END) AS AmountUSD
                           , SUM (CASE WHEN Object.DescId = zc_Object_Cash() AND MILinkObject_Currency.ObjectId = zc_Currency_EUR() THEN COALESCE(MovementItem.Amount,0) ELSE 0 END) AS AmountEUR
                           , SUM (CASE WHEN Object.DescId = zc_Object_BankAccount() THEN MovementItem.Amount ELSE 0 END) AS AmountCard
                           , SUM (CASE WHEN Object.DescId = zc_Object_Cash() AND MILinkObject_Currency.ObjectId = zc_Currency_USD() THEN COALESCE(MIFloat_CurrencyValue.ValueData,0) ELSE 0 END) AS CurrencyValue_USD
                           , SUM (CASE WHEN Object.DescId = zc_Object_Cash() AND MILinkObject_Currency.ObjectId = zc_Currency_EUR() THEN COALESCE(MIFloat_CurrencyValue.ValueData,0) ELSE 0 END) AS CurrencyValue_EUR
                      FROM MovementItem
                            LEFT JOIN Object ON Object.Id = MovementItem.ObjectId
                            LEFT JOIN MovementItemLinkObject AS MILinkObject_Currency
                                                             ON MILinkObject_Currency.MovementItemId = MovementItem.Id
                                                            AND MILinkObject_Currency.DescId = zc_MILinkObject_Currency()
                            LEFT JOIN MovementItemFloat AS MIFloat_CurrencyValue
                                                        ON MIFloat_CurrencyValue.MovementItemId = MovementItem.Id
                                                       AND MIFloat_CurrencyValue.DescId         = zc_MIFloat_CurrencyValue()    
                            LEFT JOIN MovementItemFloat AS MIFloat_ParValue
                                                        ON MIFloat_ParValue.MovementItemId = MovementItem.Id
                                                       AND MIFloat_ParValue.DescId         = zc_MIFloat_ParValue() 
                      WHERE MovementItem.ParentId     = inId
                        AND MovementItem.MovementId = inMovementId
                        AND MovementItem.DescId     = zc_MI_Child()
                        AND MovementItem.isErased   = FALSE
                      )
           -- ���������
           SELECT
                 inId AS Id
               , COALESCE (tmpMI.CurrencyValue_USD, tmp_USD.Amount)      ::TFloat    AS CurrencyValue_USD
               , tmp_USD.ParValue        ::TFloat    AS ParValue_USD
               , COALESCE (tmpMI.CurrencyValue_EUR, tmp_EUR.Amount)      ::TFloat    AS CurrencyValue_EUR
               , tmp_EUR.ParValue        ::TFloat    AS ParValue_EUR

               , tmpMI.AmountGRN         ::TFloat
               , tmpMI.AmountUSD         ::TFloat
               , tmpMI.AmountEUR         ::TFloat
               , tmpMI.AmountCard        ::TFloat
               , vbSummChangePercent     ::TFloat    AS AmountDiscount

               , vbSumm                  ::TFloat AS Amount

               , CASE WHEN vbSumm - (  COALESCE(tmpMI.AmountGRN,0) 
                                    + (COALESCE(tmpMI.AmountUSD,0) * COALESCE (tmpMI.CurrencyValue_USD, tmp_USD.Amount))
                                    + (COALESCE(tmpMI.AmountEUR,0) * COALESCE (tmpMI.CurrencyValue_EUR, tmp_EUR.Amount)) 
                                    +  COALESCE(tmpMI.AmountCard,0) 
                                    + COALESCE(vbSummChangePercent,0)) > 0 
                      THEN vbSumm - ( COALESCE (tmpMI.AmountGRN,0) 
                                    + (COALESCE(tmpMI.AmountUSD,0) * COALESCE (tmpMI.CurrencyValue_USD, tmp_USD.Amount))
                                    + (COALESCE(tmpMI.AmountEUR,0) * COALESCE (tmpMI.CurrencyValue_EUR, tmp_EUR.Amount)) 
                                    +  COALESCE(tmpMI.AmountCard,0)
                                    + COALESCE(vbSummChangePercent,0) )
                      ELSE 0
                 END                                 ::TFloat AS AmountRemains          
               , CASE WHEN vbSumm - ( COALESCE (tmpMI.AmountGRN,0) 
                                    + (COALESCE(tmpMI.AmountUSD,0) * COALESCE (tmpMI.CurrencyValue_USD, tmp_USD.Amount))
                                    + (COALESCE(tmpMI.AmountEUR,0) * COALESCE (tmpMI.CurrencyValue_EUR, tmp_EUR.Amount)) 
                                    + COALESCE (tmpMI.AmountCard,0)
                                    + COALESCE(vbSummChangePercent,0) ) < 0 
                      THEN (vbSumm - ( COALESCE(tmpMI.AmountGRN,0) 
                                    + (COALESCE(tmpMI.AmountUSD,0) * COALESCE (tmpMI.CurrencyValue_USD, tmp_USD.Amount))
                                    + (COALESCE(tmpMI.AmountEUR,0) * COALESCE (tmpMI.CurrencyValue_EUR, tmp_EUR.Amount)) 
                                    +  COALESCE(tmpMI.AmountCard,0)
                                    + COALESCE(vbSummChangePercent,0) )) * (-1)
                      ELSE 0
                 END                                 ::TFloat AS AmountChange

               , False AS isPayTotal
               , CASE WHEN COALESCE (tmpMI.AmountGRN,0) <> 0 THEN TRUE ELSE FALSE END     AS isGRN
               , CASE WHEN COALESCE (tmpMI.AmountUSD,0) <> 0 THEN TRUE ELSE FALSE END     AS isUSD
               , CASE WHEN COALESCE (tmpMI.AmountEUR,0) <> 0 THEN TRUE ELSE FALSE END     AS isEUR
               , CASE WHEN COALESCE (tmpMI.AmountCard,0) <> 0 THEN TRUE ELSE FALSE END    AS isCard
               , CASE WHEN COALESCE (vbSummChangePercent,0) <> 0 THEN TRUE ELSE FALSE END AS isDiscount

           FROM tmpMI
                LEFT JOIN lfSelect_Movement_Currency_byDate (inOperDate:= vbOperDate, inCurrencyFromId:= zc_Currency_Basis(), inCurrencyToId:= zc_Currency_USD()) AS tmp_USD ON 1=1
                LEFT JOIN lfSelect_Movement_Currency_byDate (inOperDate:= vbOperDate, inCurrencyFromId:= zc_Currency_Basis(), inCurrencyToId:= zc_Currency_EUR()) AS tmp_EUR ON 1=1
               ;

    END IF;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 18.05.17         *
*/

-- ����
-- SELECT * FROM gpGet_MI_GoodsAccount_Child (inId := 92 , inMovementId := 28 ,  inSession := '2');