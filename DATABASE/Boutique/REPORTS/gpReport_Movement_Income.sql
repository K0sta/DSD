-- Function:  gpReport_Movement_Income()

DROP FUNCTION IF EXISTS gpReport_Movement_Income (TDateTime, TDateTime, Integer,Integer,Integer,Boolean, Boolean,Boolean, TVarChar);

CREATE OR REPLACE FUNCTION  gpReport_Movement_Income(
    IN inStartDate        TDateTime,  -- ���� ������
    IN inEndDate          TDateTime,  -- ���� ���������
    IN inUnitId           Integer  ,  -- �������������
    IN inBrandId          Integer  ,  -- �����
    IN inPartnerId        Integer  ,  -- ���������
    IN inisPartion        Boolean,    -- 
    IN inisSize           Boolean,    --
    IN inisPartner        Boolean,    --
    IN inSession          TVarChar    -- ������ ������������
)
RETURNS TABLE (
               InvNumber      TVarChar,
               OperDate       TDateTime,
               DescName       TVarChar,
               FromName       TVarChar,
               ToName         TVarChar,
               
               GoodsId Integer, GoodsCode Integer, GoodsName TVarChar,
               GoodsGroupNameFull TVarChar, MeasureName TVarChar,
               JuridicalName TVarChar,
               CompositionGroupName TVarChar,
               CompositionName TVarChar,
               GoodsInfoName TVarChar,
               LineFabricaName TVarChar,
               LabelName TVarChar,
               GoodsSizeName TVarChar,

               OperPrice           TFloat,
               OperPriceList       TFloat,
               Amount          TFloat,
  
               AmountSumm           TFloat,
               AmountPriceListSumm  TFloat
  )
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_Income());
    vbUserId:= lpGetUserBySession (inSession);

    -- ���������
    RETURN QUERY
    WITH
         tmpMovementIncome AS ( SELECT Movement_Income.Id AS MovementId
                                     , CASE WHEN inIsPartion = TRUE THEN MovementDesc_Income.ItemName ELSE CAST (NULL AS TVarChar)  END    AS DescName
                                     , CASE WHEN inIsPartion = TRUE THEN Movement_Income.InvNumber    ELSE CAST (NULL AS TVarChar)  END    AS InvNumber
                                     , CASE WHEN inIsPartion = TRUE THEN Movement_Income.OperDate     ELSE CAST (NULL AS TDateTime) END    AS OperDate
                                     , CASE WHEN inisPartner = TRUE THEN MovementLinkObject_From.ObjectId ELSE 0 END                     AS FromId
                                     , MovementLinkObject_To.ObjectId                                                                      AS ToId
                                FROM Movement AS Movement_Income
                                     -- ���� ��� ������
                                     INNER JOIN MovementLinkObject AS MovementLinkObject_To
                                                                   ON MovementLinkObject_To.MovementId = Movement_Income.Id
                                                                  AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                                                                  AND MovementLinkObject_To.ObjectId = inUnitId
                                     -- �� ���� ������    ���������                   
                                     INNER JOIN MovementLinkObject AS MovementLinkObject_From
                                                                   ON MovementLinkObject_From.MovementId = Movement_Income.Id
                                                                  AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
                                                                  AND (MovementLinkObject_From.ObjectId = inPartnerId OR inPartnerId = 0)
                                     -- �����
                                     INNER JOIN ObjectLink AS ObjectLink_Partner_Brand
                                                           ON ObjectLink_Partner_Brand.ObjectId = MovementLinkObject_From.ObjectId
                                                          AND ObjectLink_Partner_Brand.DescId = zc_ObjectLink_Partner_Brand()
                                                          AND (ObjectLink_Partner_Brand.ChildObjectId = inBrandId OR inBrandId = 0)

                                     LEFT JOIN MovementDesc AS MovementDesc_Income ON MovementDesc_Income.Id = Movement_Income.DescId                                                          
                                WHERE Movement_Income.DescId = zc_Movement_Income()
                                  AND Movement_Income.OperDate BETWEEN inStartDate AND inEndDate
                                 -- AND Movement_Income.StatusId = zc_Enum_Status_Complete() 
                              )

     , tmpData  AS  (SELECT tmpMovementIncome.InvNumber
                          , tmpMovementIncome.OperDate
                          , tmpMovementIncome.DescName
                          , tmpMovementIncome.FromId
                          , tmpMovementIncome.ToId
                          , MI_Income.ObjectId             AS GoodsId
                          , CASE WHEN inisSize = TRUE THEN Object_PartionGoods.GoodsSizeId  ELSE 0 END  AS GoodsSizeId
                          , Object_PartionGoods.MeasureId
                          , Object_PartionGoods.GoodsGroupId
                          , Object_PartionGoods.CompositionId
                          , Object_PartionGoods.CompositionGroupId
                          , Object_PartionGoods.GoodsInfoId
                          , Object_PartionGoods.LineFabricaId 
                          , Object_PartionGoods.LabelId
                          , Object_PartionGoods.JuridicalId

                          , COALESCE (MIFloat_CountForPrice.ValueData, 1)      AS CountForPrice
                          , SUM (COALESCE (MI_Income.Amount, 0))                AS Amount
                          , SUM (CASE WHEN COALESCE (MIFloat_CountForPrice.ValueData, 1) <> 0
                                          THEN CAST (COALESCE (MI_Income.Amount, 0) * COALESCE (MIFloat_OperPrice.ValueData, 0) / COALESCE (MIFloat_CountForPrice.ValueData, 1) AS NUMERIC (16, 2))
                                      ELSE CAST ( COALESCE (MI_Income.Amount, 0) * COALESCE (MIFloat_OperPrice.ValueData, 0) AS NUMERIC (16, 2))
                                 END) AS AmountSumm

                          , SUM (CASE WHEN COALESCE (MIFloat_CountForPrice.ValueData, 1) <> 0
                                          THEN CAST (COALESCE (MI_Income.Amount, 0) * COALESCE (MIFloat_OperPriceList.ValueData, 0) / COALESCE (MIFloat_CountForPrice.ValueData, 1) AS NUMERIC (16, 2))
                                      ELSE CAST ( COALESCE (MI_Income.Amount, 0) * COALESCE (MIFloat_OperPriceList.ValueData, 0) AS NUMERIC (16, 2))
                                 END) AS AmountPriceListSumm

                     FROM tmpMovementIncome
                          INNER JOIN MovementItem AS MI_Income 
                                                  ON MI_Income.MovementId = tmpMovementIncome.MovementId
                                                 AND MI_Income.isErased   = False
                          INNER JOIN Object_PartionGoods ON Object_PartionGoods.MovementItemId = MI_Income.PartionId
                                                        AND (Object_PartionGoods.BrandId = inBrandId OR inBrandId = 0)

                          LEFT JOIN MovementItemFloat AS MIFloat_CountForPrice
                                                      ON MIFloat_CountForPrice.MovementItemId = MI_Income.Id
                                                     AND MIFloat_CountForPrice.DescId = zc_MIFloat_CountForPrice()
                          LEFT JOIN MovementItemFloat AS MIFloat_OperPrice
                                                      ON MIFloat_OperPrice.MovementItemId = MI_Income.Id
                                                     AND MIFloat_OperPrice.DescId = zc_MIFloat_OperPrice()
                          LEFT JOIN MovementItemFloat AS MIFloat_OperPriceList
                                                      ON MIFloat_OperPriceList.MovementItemId = MI_Income.Id
                                                     AND MIFloat_OperPriceList.DescId = zc_MIFloat_OperPriceList()
                     GROUP BY tmpMovementIncome.InvNumber
                            , tmpMovementIncome.OperDate
                            , tmpMovementIncome.DescName
                            , tmpMovementIncome.FromId
                            , tmpMovementIncome.ToId
                            , MI_Income.ObjectId
                            , CASE WHEN inisSize = TRUE THEN Object_PartionGoods.GoodsSizeId  ELSE 0 END 
                            , Object_PartionGoods.MeasureId
                            , Object_PartionGoods.GoodsGroupId
                            , Object_PartionGoods.CompositionId
                            , Object_PartionGoods.CompositionGroupId
                            , Object_PartionGoods.GoodsInfoId
                            , Object_PartionGoods.LineFabricaId 
                            , Object_PartionGoods.LabelId
                            , Object_PartionGoods.JuridicalId
                            , COALESCE (MIFloat_CountForPrice.ValueData, 1)
              )
              

        SELECT
             tmpData.InvNumber
           , tmpData.OperDate
           , tmpData.DescName
           , Object_From.ValueData          AS FromName
           , Object_To.ValueData            AS ToName

           , Object_Goods.Id                AS GoodsId
           , Object_Goods.ObjectCode        AS GoodsCode
           , Object_Goods.ValueData         AS GoodsName
           , ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull
           , Object_Measure.ValueData       AS MeasureName
           , Object_Juridical.ValueData     AS JuridicalName
           , Object_CompositionGroup.ValueData   AS CompositionGroupName
           , Object_Composition.ValueData   AS CompositionName
           , Object_GoodsInfo.ValueData     AS GoodsInfoName
           , Object_LineFabrica.ValueData   AS LineFabricaName
           , Object_Label.ValueData         AS LabelName
           , Object_GoodsSize.ValueData     AS GoodsSizeName
           
           , CASE WHEN tmpData.Amount <> 0 THEN tmpData.AmountSumm  / tmpData.Amount ELSE 0 END          ::TFloat AS OperPrice
           , CASE WHEN tmpData.Amount <> 0 THEN tmpData.AmountPriceListSumm  / tmpData.Amount ELSE 0 END ::TFloat AS OperPriceList
           , tmpData.Amount                  ::TFloat
           , tmpData.AmountSumm              ::TFloat
           , tmpData.AmountPriceListSumm     ::TFloat 
           
        FROM tmpData
            LEFT JOIN Object AS Object_From ON Object_From.Id = tmpData.FromId
            LEFT JOIN Object AS Object_To   ON Object_To.Id   = tmpData.ToId
 
            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpData.GoodsId
            LEFT JOIN Object AS Object_GoodsGroup       ON Object_GoodsGroup.Id       = tmpData.GoodsGroupId
            LEFT JOIN Object AS Object_Measure          ON Object_Measure.Id          = tmpData.MeasureId
            LEFT JOIN Object AS Object_Composition      ON Object_Composition.Id      = tmpData.CompositionId
            LEFT JOIN Object AS Object_CompositionGroup ON Object_CompositionGroup.Id = tmpData.CompositionGroupId
            LEFT JOIN Object AS Object_GoodsInfo        ON Object_GoodsInfo.Id        = tmpData.GoodsInfoId
            LEFT JOIN Object AS Object_LineFabrica      ON Object_LineFabrica.Id      = tmpData.LineFabricaId 
            LEFT JOIN Object AS Object_Label            ON Object_Label.Id            = tmpData.LabelId
            LEFT JOIN Object AS Object_GoodsSize        ON Object_GoodsSize.Id        = tmpData.GoodsSizeId
            LEFT JOIN Object AS Object_Juridical        ON Object_Juridical.Id        = tmpData.JuridicalId
           
            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = tmpData.GoodsId
                                  AND ObjectString_Goods_GoodsGroupFull.DescId   = zc_ObjectString_Goods_GroupNameFull()

;
 END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 30.05.17         *
*/

-- ����
--SELECT * from gpReport_Movement_Income(    inStartDate := '01.12.2016' :: TDateTime, inEndDate:= '01.12.2018' :: TDateTime, inUnitId :=311,inBrandId  := 0 ,inPartnerId  := 0 , inisPartion  := TRUE,inisSize:=  TRUE, inisPartner := TRUE, inSession := '2':: TVarChar )
--SELECT * from gpReport_Movement_Income(    inStartDate := '01.12.2016' :: TDateTime, inEndDate:= '01.12.2018' :: TDateTime, inUnitId :=230,inBrandId  := 0 ,inPartnerId  := 0 , inisPartion  :=False,inisSize:=  False, inisPartner := False, inSession := '2':: TVarChar )

--select * from gpGet_Movement_Income(inMovementId := 22 , inOperDate := ('04.02.2018')::TDateTime ,  inSession := '2');
--select * from gpGet_Movement_Income(inMovementId := 22 , inOperDate := ('04.02.2018')::TDateTime ,  inSession := '2');