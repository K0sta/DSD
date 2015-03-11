-- View: Object_Unit_View

DROP VIEW IF EXISTS MovementItem_Income_View;

CREATE OR REPLACE VIEW MovementItem_Income_View AS 
       SELECT
             MovementItem.Id                    AS Id
           , MovementItem.ObjectId              AS GoodsId
           , Object_Goods.ObjectCode            AS GoodsCode
           , Object_Goods.ValueData             AS GoodsName
           , MILinkObject_Goods.ObjectId        AS PartnerGoodsId
           , Object_PartnerGoods.GoodsCode      AS PartnerGoodsCode
           , Object_PartnerGoods.GoodsName      AS PartnerGoodsName
           , MovementItem.Amount                AS Amount
           , MIFloat_Price.ValueData            AS Price
           , (((COALESCE (MovementItem.Amount, 0)) * MIFloat_Price.ValueData)::NUMERIC (16, 2))::TFloat AS AmountSumm
           , MovementItem.isErased              AS isErased
           , MovementItem.MovementId            AS MovementId
           , MIDate_ExpirationDate.ValueData    AS ExpirationDate
           , MIString_PartionGoods.ValueData    AS PartionGoods
           , MIString_FEA.ValueData             AS FEA
           , MIString_Measure.ValueData         AS Measure
           , Object_PartnerGoods.MakerName      AS MakerName

       FROM  MovementItem 
            LEFT JOIN MovementItemFloat AS MIFloat_Price
                                        ON MIFloat_Price.MovementItemId = MovementItem.Id
                                       AND MIFloat_Price.DescId = zc_MIFloat_Price()

            LEFT JOIN MovementItemDate  AS MIDate_ExpirationDate
                                        ON MIDate_ExpirationDate.MovementItemId = MovementItem.Id
                                       AND MIDate_ExpirationDate.DescId = zc_MIDate_PartionGoods()                                         

            LEFT JOIN MovementItemString AS MIString_PartionGoods
                                         ON MIString_PartionGoods.MovementItemId = MovementItem.Id
                                        AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()                                         

            LEFT JOIN MovementItemString AS MIString_Measure
                                         ON MIString_Measure.MovementItemId = MovementItem.Id
                                        AND MIString_Measure.DescId = zc_MIString_Measure()                                         

            LEFT JOIN MovementItemString AS MIString_FEA
                                         ON MIString_FEA.MovementItemId = MovementItem.Id
                                        AND MIString_FEA.DescId = zc_MIString_FEA()                                         

            LEFT JOIN MovementItemLinkObject AS MILinkObject_Goods
                                             ON MILinkObject_Goods.MovementItemId = MovementItem.Id
                                            AND MILinkObject_Goods.DescId = zc_MILinkObject_Goods()

            LEFT JOIN Object_Goods_View AS Object_PartnerGoods ON Object_PartnerGoods.Id = MILinkObject_Goods.ObjectId

            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MovementItem.ObjectId

   WHERE MovementItem.DescId     = zc_MI_Master();


ALTER TABLE MovementItem_Income_View
  OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 06.03.15                        * 
 11.12.14                        * 
*/

-- ����
-- SELECT * FROM Movement_Income_View where id = 805
