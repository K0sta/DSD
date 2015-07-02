-- Function: gpReport_Goods_Movement ()

DROP FUNCTION IF EXISTS gpReport_GoodsMI_SaleReturnInUnit (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Boolean, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_GoodsMI_SaleReturnInUnit (
    IN inStartDate    TDateTime ,
    IN inEndDate      TDateTime ,
    IN inBranchId     Integer   , -- ������
    IN inAreaId       Integer   , -- ������ (����������� -> �� ����)
    IN inRetailId     Integer   , -- �������� ���� (�� ����)
    IN inJuridicalId  Integer   ,
    IN inPaidKindId   Integer   , --
    IN inTradeMarkId  Integer   ,
    IN inGoodsGroupId Integer   ,
    IN inInfoMoneyId  Integer   ,-- �������������� ������
    IN inIsPartner    Boolean   , --
    IN inIsTradeMark  Boolean   , --
    IN inIsGoods      Boolean   , --
    IN inIsGoodsKind  Boolean   , --
    IN inSession      TVarChar    -- ������ ������������
)
RETURNS TABLE (GoodsGroupName TVarChar, GoodsGroupNameFull TVarChar
             , GoodsCode Integer, GoodsName TVarChar, GoodsKindName TVarChar, MeasureName TVarChar
             , TradeMarkName TVarChar, GoodsGroupAnalystName TVarChar, GoodsTagName TVarChar, GoodsGroupStatName TVarChar
             , GoodsPlatformName TVarChar
             , JuridicalGroupName TVarChar
             , BranchCode Integer, BranchName TVarChar
             , JuridicalCode Integer, JuridicalName TVarChar, OKPO TVarChar
             , RetailName TVarChar, RetailReportName TVarChar
             , AreaName TVarChar, PartnerTagName TVarChar
             , Address TVarChar, RegionName TVarChar, ProvinceName TVarChar, CityKindName TVarChar, CityName TVarChar, ProvinceCityName TVarChar, StreetKindName TVarChar, StreetName TVarChar
             , PartnerId Integer, PartnerCode Integer, PartnerName TVarChar
             , ContractCode Integer, ContractNumber TVarChar, ContractTagName TVarChar, ContractTagGroupName TVarChar
             , PersonalName TVarChar, UnitName_Personal TVarChar, BranchName_Personal TVarChar
             , PersonalTradeName TVarChar, UnitName_PersonalTrade TVarChar
             , InfoMoneyGroupName TVarChar, InfoMoneyDestinationName TVarChar, InfoMoneyCode Integer, InfoMoneyName TVarChar, InfoMoneyName_all TVarChar
             , AccountName TVarChar
             , Sale_Summ TFloat, Sale_Summ_10200 TFloat, Sale_Summ_10300 TFloat, Sale_SummCost TFloat, Sale_SummCost_10500 TFloat, Sale_SummCost_40200 TFloat
             , Sale_Amount_Weight TFloat , Sale_Amount_Sh TFloat, Sale_AmountPartner_Weight TFloat , Sale_AmountPartner_Sh TFloat
             , Return_Summ TFloat, Return_Summ_10300 TFloat, Return_SummCost TFloat, Return_SummCost_40200 TFloat
             , Return_Amount_Weight TFloat, Return_Amount_Sh TFloat, Return_AmountPartner_Weight TFloat, Return_AmountPartner_Sh TFloat
             , Sale_Amount_10500_Weight TFloat
             , Sale_Amount_40200_Weight TFloat
             , Return_Amount_40200_Weight TFloat
             , ReturnPercent TFloat
              )
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_...());
     vbUserId:= lpGetUserBySession (inSession);

       RETURN QUERY
       WITH tmp_Send AS  (SELECT MovementLinkObject_From.ObjectId                         AS FromId
                               , CASE WHEN inIsPartner = TRUE THEN MovementLinkObject_To.ObjectId ELSE 0 END AS ToId
                               , CASE WHEN inIsGoods = TRUE OR inIsTradeMark = TRUE THEN MovementItem.ObjectId  ELSE 0 END AS GoodsId
                               , CASE WHEN inIsGoodsKind = TRUE THEN MILinkObject_GoodsKind.ObjectId ELSE 0 END AS GoodsKindId
                               , SUM (MovementItem.Amount)                                AS Amount_Count
                               , SUM (CASE WHEN MIFloat_CountForPrice.ValueData > 0
                                                THEN COALESCE (MIFloat_Price.ValueData, 0) / MIFloat_CountForPrice.ValueData
                                           ELSE COALESCE (MIFloat_Price.ValueData, 0)
                                      END * MovementItem.Amount * 1.2)                    AS Amount_Summ
                          FROM Movement
                               INNER JOIN MovementLinkObject AS MovementLinkObject_From
                                                             ON MovementLinkObject_From.MovementId = Movement.Id
                                                            AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
                                                            AND MovementLinkObject_From.ObjectId = 8459 -- ����� ����������
                               LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                        ON MovementLinkObject_To.MovementId = Movement.Id
                                       AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                               INNER JOIN MovementItem ON MovementItem.MovementId = Movement.Id
                                                      AND MovementItem.DescId     = zc_MI_Master()
                                                      AND MovementItem.isErased   = FALSE
                               LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                           ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                          AND MIFloat_Price.DescId = zc_MIFloat_Price()
                               LEFT JOIN MovementItemFloat AS MIFloat_CountForPrice
                                                           ON MIFloat_CountForPrice.MovementItemId = MovementItem.Id
                                                          AND MIFloat_CountForPrice.DescId = zc_MIFloat_CountForPrice()
                               LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                            ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                           AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()

                          WHERE Movement.OperDate BETWEEN inStartDate AND inEndDate
                            AND Movement.StatusId = zc_Enum_Status_Complete()
                            AND Movement.DescId = zc_Movement_SendOnPrice()
                          GROUP BY MovementLinkObject_From.ObjectId
                                 , CASE WHEN inIsPartner = TRUE THEN MovementLinkObject_To.ObjectId ELSE 0 END
                                 , CASE WHEN inIsGoods = TRUE OR inIsTradeMark = TRUE THEN MovementItem.ObjectId  ELSE 0 END
                                 , CASE WHEN inIsGoodsKind = TRUE THEN MILinkObject_GoodsKind.ObjectId ELSE 0 END
                         )


       SELECT * FROM gpReport_GoodsMI_SaleReturnIn (inStartDate
                                                      , inEndDate
                                                      , inBranchId
                                                      , inAreaId
                                                      , inRetailId
                                                      , inJuridicalId
                                                      , inPaidKindId
                                                      , inTradeMarkId
                                                      , inGoodsGroupId
                                                      , inInfoMoneyId
                                                      , inIsPartner
                                                      , inIsTradeMark
                                                      , inIsGoods
                                                      , inIsGoodsKind
                                                      , inSession
                                                       )
    UNION ALL

     SELECT Object_GoodsGroup.ValueData        AS GoodsGroupName
          , ObjectString_Goods_GroupNameFull.ValueData AS GoodsGroupNameFull
          , Object_Goods.ObjectCode            AS GoodsCode
          , Object_Goods.ValueData             AS GoodsName
          , Object_GoodsKind.ValueData         AS GoodsKindName
          , Object_Measure.ValueData           AS MeasureName
          , Object_TradeMark.ValueData         AS TradeMarkName
          , Object_GoodsGroupAnalyst.ValueData AS GoodsGroupAnalystName
          , Object_GoodsTag.ValueData          AS GoodsTagName
          , Object_GoodsGroupStat.ValueData    AS GoodsGroupStatName
          , Object_GoodsPlatform.ValueData     AS GoodsPlatformName

          , '' :: TVarChar AS JuridicalGroupName
          , Object_Branch.ObjectCode    AS BranchCode
          , Object_Branch.ValueData     AS BranchName

          , Object_Partner.ObjectCode    AS JuridicalCode
          , Object_Partner.ValueData     AS JuridicalName

          , '' :: TVarChar AS OKPO

          , '' :: TVarChar AS RetailName
          , '' :: TVarChar AS RetailReportName

          , '' :: TVarChar AS AreaName
          , '' :: TVarChar AS PartnerTagName
          , '' :: TVarChar AS Address
          , '' :: TVarChar AS RegionName
          , '' :: TVarChar AS ProvinceName
          , '' :: TVarChar AS CityKindName
          , '' :: TVarChar AS CityName
          , '' :: TVarChar AS ProvinceCityName
          , '' :: TVarChar AS StreetKindName
          , '' :: TVarChar AS StreetName

          , Object_Partner.ObjectCode    AS PartnerId
          , Object_Partner.ObjectCode    AS PartnerCode
          , Object_Partner.ValueData     AS PartnerName

          , 0 :: Integer   ContractCode
          , '' :: TVarChar AS ContractNumber
          , '' :: TVarChar ContractTagName
          , '' :: TVarChar ContractTagGroupName

          , '' :: TVarChar AS PersonalName
          , '' :: TVarChar AS UnitName_Personal
          , '' :: TVarChar AS BranchName_Personal

          , '' :: TVarChar AS PersonalTradeName
          , '' :: TVarChar AS UnitName_PersonalTrade

          , View_InfoMoney.InfoMoneyGroupName              AS InfoMoneyGroupName
          , View_InfoMoney.InfoMoneyDestinationName        AS InfoMoneyDestinationName
          , View_InfoMoney.InfoMoneyCode                   AS InfoMoneyCode
          , View_InfoMoney.InfoMoneyName                   AS InfoMoneyName
          , View_InfoMoney.InfoMoneyName_all               AS InfoMoneyName_all

          , '' :: TVarChar AS AccountName

         , tmpOperationGroup.Amount_Summ          :: TFloat  AS Sale_Summ
         , 0    :: TFloat  AS Sale_Summ_10200
         , 0    :: TFloat  AS Sale_Summ_10300
         , 0      :: TFloat  AS Sale_SummCost
         , 0  :: TFloat  AS Sale_SummCost_10500
         , 0 :: TFloat  AS Sale_SummCost_40200

         , tmpOperationGroup.Amount_CountWeight :: TFloat  AS Sale_Amount_Weight
         , tmpOperationGroup.Amount_CountSh     :: TFloat  AS Sale_Amount_Sh

         , tmpOperationGroup.Amount_CountWeight :: TFloat AS Sale_AmountPartner_Weight
         , tmpOperationGroup.Amount_CountSh     :: TFloat AS Sale_AmountPartner_Sh

         , 0 :: TFloat AS Return_Summ
         , 0 :: TFloat AS Return_Summ_10300
         , 0 :: TFloat AS Return_SummCost
         , 0 :: TFloat AS Return_SummCost_40200

         , 0 :: TFloat AS Return_Amount_Weight
         , 0 :: TFloat AS Return_Amount_Sh

         , 0 :: TFloat AS Return_AmountPartner_Weight
         , 0 :: TFloat AS Return_AmountPartner_Sh

         , 0 :: TFloat AS Sale_Amount_10500_Weight
         , 0 :: TFloat AS Sale_Amount_40200_Weight
         , 0 :: TFloat AS Return_Amount_40200_Weight

         , 0 :: TFloat AS ReturnPercent

     FROM (SELECT tmp_Send.FromId
                , tmp_Send.ToId
                , tmp_Send.GoodsId
                , tmp_Send.GoodsKindId
                , CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN tmp_Send.Amount_Count ELSE 0 END                                 AS Amount_CountSh
                , tmp_Send.Amount_Count * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END  AS Amount_CountWeight
                , tmp_Send.Amount_Summ
           FROM tmp_Send
                LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure ON ObjectLink_Goods_Measure.ObjectId = tmp_Send.GoodsId
                                                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
                LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                      ON ObjectFloat_Weight.ObjectId = tmp_Send.GoodsId
                                     AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()
          ) AS tmpOperationGroup
          LEFT JOIN Object AS Object_Goods on Object_Goods.Id = tmpOperationGroup.GoodsId
          LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpOperationGroup.GoodsKindId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroupAnalyst
                               ON ObjectLink_Goods_GoodsGroupAnalyst.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_GoodsGroupAnalyst.DescId = zc_ObjectLink_Goods_GoodsGroupAnalyst()
          LEFT JOIN Object AS Object_GoodsGroupAnalyst ON Object_GoodsGroupAnalyst.Id = ObjectLink_Goods_GoodsGroupAnalyst.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_TradeMark
                               ON ObjectLink_Goods_TradeMark.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_TradeMark.DescId = zc_ObjectLink_Goods_TradeMark()
          LEFT JOIN Object AS Object_TradeMark ON Object_TradeMark.Id = ObjectLink_Goods_TradeMark.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                               ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
          LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsTag
                               ON ObjectLink_Goods_GoodsTag.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_GoodsTag.DescId = zc_ObjectLink_Goods_GoodsTag()
          LEFT JOIN Object AS Object_GoodsTag ON Object_GoodsTag.Id = ObjectLink_Goods_GoodsTag.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroupStat
                               ON ObjectLink_Goods_GoodsGroupStat.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_GoodsGroupStat.DescId = zc_ObjectLink_Goods_GoodsGroupStat()
          LEFT JOIN Object AS Object_GoodsGroupStat ON Object_GoodsGroupStat.Id = ObjectLink_Goods_GoodsGroupStat.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                               ON ObjectLink_Goods_GoodsGroup.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup()
          LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = ObjectLink_Goods_GoodsGroup.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsPlatform
                               ON ObjectLink_Goods_GoodsPlatform.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_GoodsPlatform.DescId = zc_ObjectLink_Goods_GoodsPlatform()
          LEFT JOIN Object AS Object_GoodsPlatform ON Object_GoodsPlatform.Id = ObjectLink_Goods_GoodsPlatform.ChildObjectId
            
          LEFT JOIN ObjectString AS ObjectString_Goods_GroupNameFull
                                 ON ObjectString_Goods_GroupNameFull.ObjectId = Object_Goods.Id
                                AND ObjectString_Goods_GroupNameFull.DescId = zc_ObjectString_Goods_GroupNameFull()

          LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                               ON ObjectLink_Goods_InfoMoney.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
          LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId

          LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = tmpOperationGroup.ToId
          LEFT JOIN Object AS Object_Branch ON Object_Branch.Id = zc_Branch_Basis()
         ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 22.03.15                                        * add inIsGoodsKind
 11.01.15                                        * all
 12.12.14                                        * all
 27.10.14                                        * add inIsPartner AND inIsGoods
 13.09.14                                        * add GoodsTagName and GroupStatName and BranchName and JuridicalGroupName
 11.07.14                                        * add RetailName and OKPO
 06.05.14                                        * add GoodsGroupNameFull
 28.03.14                                        * all
 06.02.14         *
*/

-- ����
-- SELECT * FROM gpReport_GoodsMI_SaleReturnInUnit (inStartDate:= '01.07.2015', inEndDate:= '01.07.2015', inBranchId:= 0, inAreaId:= 1, inRetailId:= 0, inJuridicalId:= 0, inPaidKindId:= zc_Enum_PaidKind_FirstForm(), inTradeMarkId:= 0, inGoodsGroupId:= 0, inInfoMoneyId:= zc_Enum_InfoMoney_30101(), inIsPartner:= TRUE, inIsTradeMark:= FALSE, inIsGoods:= FALSE, inIsGoodsKind:= FALSE, inSession:= zfCalc_UserAdmin());
