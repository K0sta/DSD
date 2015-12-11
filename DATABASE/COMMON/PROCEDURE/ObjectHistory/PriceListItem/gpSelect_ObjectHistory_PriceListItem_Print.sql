-- Function: gpSelect_ObjectHistory_PriceListItem_Print ()


DROP FUNCTION IF EXISTS gpSelect_ObjectHistory_PriceListItem_Print (Integer, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_ObjectHistory_PriceListItem_Print(
    IN inPriceListId        Integer   , -- ���� 
    IN inOperDate           TDateTime , -- ���� ��������
    IN inSession            TVarChar    -- ������ ������������
)                              
RETURNS TABLE (Id Integer , ObjectId Integer
                , GoodsId Integer, GoodsCode Integer, GoodsName TVarChar, GoodsGroupNameFull TVarChar
                , TradeMarkName TVarChar
                , MeasureName TVarChar, ValuePrice TFloat, ValuePriceWithVAT TFloat
                , Weight TFloat
                , Value4 TVarChar, Value5 TVarChar, Value6 TVarChar
                
                
               )
AS
$BODY$
   DECLARE vbPriceWithVAT_pl Boolean;
   DECLARE vbVATPercent_pl TFloat;
BEGIN

     vbPriceWithVAT_pl:= (SELECT ObjectBoolean.ValueData FROM ObjectBoolean WHERE ObjectBoolean.ObjectId = inPriceListId AND ObjectBoolean.DescId = zc_ObjectBoolean_PriceList_PriceWithVAT());
     -- 
     vbVATPercent_pl:= (SELECT ObjectFloat.ValueData FROM ObjectFloat WHERE ObjectFloat.ObjectId = inPriceListId AND ObjectFloat.DescId = zc_ObjectFloat_PriceList_VATPercent());
     -- �������� ������
     RETURN QUERY 


--select * from Object where Id = 44483
                 
       SELECT
             ObjectHistory_PriceListItem.Id
           , ObjectHistory_PriceListItem.ObjectId

           , ObjectLink_PriceListItem_Goods.ChildObjectId AS GoodsId
           , Object_Goods.ObjectCode AS GoodsCode
           , Object_Goods.ValueData  AS GoodsName
                    
           , ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull
           , Object_TradeMark.ValueData      AS TradeMarkName
           , Object_Measure.ValueData     AS MeasureName

           , CASE WHEN vbPriceWithVAT_pl = TRUE THEN COALESCE (ObjectHistoryFloat_PriceListItem_Value.ValueData, 0) / (1 + vbVATPercent_pl / 100) ELSE COALESCE (ObjectHistoryFloat_PriceListItem_Value.ValueData, 0) END :: TFloat  AS ValuePrice
           , CASE WHEN vbPriceWithVAT_pl = FALSE THEN COALESCE (ObjectHistoryFloat_PriceListItem_Value.ValueData, 0) * (1 + vbVATPercent_pl / 100) ELSE COALESCE (ObjectHistoryFloat_PriceListItem_Value.ValueData, 0) END :: TFloat AS ValuePriceWithVAT

           , ObjectFloat_Weight.ValueData AS Weight

           , (COALESCE (ObjectString_Value4.ValueData,'')||'' )::  TVarChar AS Value4
           , ObjectString_Value5.ValueData AS Value5
           , ObjectString_Value6.ValueData AS Value6

          
          
       FROM ObjectLink AS ObjectLink_PriceListItem_PriceList

                                   
            LEFT JOIN ObjectLink AS ObjectLink_PriceListItem_Goods
                                 ON ObjectLink_PriceListItem_Goods.ObjectId = ObjectLink_PriceListItem_PriceList.ObjectId
                                AND ObjectLink_PriceListItem_Goods.DescId = zc_ObjectLink_PriceListItem_Goods()
            LEFT JOIN Object AS Object_Goods
                             ON Object_Goods.Id = ObjectLink_PriceListItem_Goods.ChildObjectId

            LEFT JOIN ObjectHistory AS ObjectHistory_PriceListItem
                                    ON ObjectHistory_PriceListItem.ObjectId = ObjectLink_PriceListItem_PriceList.ObjectId
                                   AND ObjectHistory_PriceListItem.DescId = zc_ObjectHistory_PriceListItem()
                                   AND inOperDate >= ObjectHistory_PriceListItem.StartDate AND inOperDate < ObjectHistory_PriceListItem.EndDate
            LEFT JOIN ObjectHistoryFloat AS ObjectHistoryFloat_PriceListItem_Value
                                         ON ObjectHistoryFloat_PriceListItem_Value.ObjectHistoryId = ObjectHistory_PriceListItem.Id
                                        AND ObjectHistoryFloat_PriceListItem_Value.DescId = zc_ObjectHistoryFloat_PriceListItem_Value()

            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = Object_Goods.Id
                                  AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()

            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Goods_TradeMark
                                 ON ObjectLink_Goods_TradeMark.ObjectId = Object_Goods.Id 
                                AND ObjectLink_Goods_TradeMark.DescId = zc_ObjectLink_Goods_TradeMark()
            LEFT JOIN Object AS Object_TradeMark ON Object_TradeMark.Id = ObjectLink_Goods_TradeMark.ChildObjectId

            LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                  ON ObjectFloat_Weight.ObjectId = Object_Goods.Id 
                                 AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()     

            LEFT JOIN ObjectLink AS GoodsQuality_Goods
                                 ON GoodsQuality_Goods.ChildObjectId = Object_Goods.Id 
                                AND GoodsQuality_Goods.DescId = zc_ObjectLink_GoodsQuality_Goods()  
            LEFT JOIN ObjectString AS ObjectString_Value2							-- ����� ��������� 
                                   ON ObjectString_Value2.ObjectId = GoodsQuality_Goods.ObjectId
                                  AND ObjectString_Value2.DescId = zc_ObjectString_GoodsQuality_Value2() 
            LEFT JOIN ObjectString AS ObjectString_Value4							-- ����� ��������� � ���.���������, �8
                                   ON ObjectString_Value4.ObjectId = GoodsQuality_Goods.ObjectId
                                  AND ObjectString_Value4.DescId = zc_ObjectString_GoodsQuality_Value4()
            LEFT JOIN ObjectString AS ObjectString_Value5							-- �������� �������� - ����� ��������� ����� �������, �10
                                   ON ObjectString_Value5.ObjectId = GoodsQuality_Goods.ObjectId
                                  AND ObjectString_Value5.DescId = zc_ObjectString_GoodsQuality_Value5()                             
            LEFT JOIN ObjectString AS ObjectString_Value6							-- �������� �������� - ����� ��������� �������� ������, �11
                                   ON ObjectString_Value6.ObjectId = GoodsQuality_Goods.ObjectId
                                  AND ObjectString_Value6.DescId = zc_ObjectString_GoodsQuality_Value6()                           
                      

       WHERE ObjectLink_PriceListItem_PriceList.DescId = zc_ObjectLink_PriceListItem_PriceList()
         AND ObjectLink_PriceListItem_PriceList.ChildObjectId = inPriceListId
         AND (ObjectHistoryFloat_PriceListItem_Value.ValueData <> 0 ) --OR ObjectHistory_PriceListItem.StartDate <> zc_DateStart())
         AND Object_Goods.isErased = FAlSE
       ;
       
   END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 03.12.15         * 
*/

-- ����
-- SELECT * FROM gpSelect_ObjectHistory_PriceListItem_Print (zc_PriceList_ProductionSeparate(), CURRENT_TIMESTAMP, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_ObjectHistory_PriceListItem_Print (zc_PriceList_Basis(), CURRENT_TIMESTAMP, inSession:= zfCalc_UserAdmin())

--select * from gpSelect_ObjectHistory_PriceListItem_Print(inPriceListId := 18879 , inOperDate := '11.11.2015' ,  inSession := '5');