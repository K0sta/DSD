-- Function: gpReport_Goods ()

DROP FUNCTION IF EXISTS gpReport_Goods (TDateTime, TDateTime, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_Goods (
    IN inStartDate    TDateTime ,  
    IN inEndDate      TDateTime ,
    IN inLocationId   Integer   , 
    IN inGoodsId      Integer   ,
    IN inSession      TVarChar    -- ������ ������������
)
RETURNS TABLE  (MovementId Integer, InvNumber TVarChar, OperDate TDateTime, OperDatePartner TDateTime, MovementDescName TVarChar, MovementDescName_order TVarChar, isActive Boolean, isRemains Boolean
              , LocationDescName TVarChar, LocationCode Integer, LocationName TVarChar
              , CarCode Integer, CarName TVarChar
              , ObjectByDescName TVarChar, ObjectByCode Integer, ObjectByName TVarChar
              , PaidKindName TVarChar
              , GoodsCode Integer, GoodsName TVarChar, GoodsKindName TVarChar, PartionGoods TVarChar
              , Price TFloat
              , AmountStart TFloat, AmountIn TFloat, AmountOut TFloat, AmountEnd TFloat, Amount TFloat
              , SummStart TFloat, SummIn TFloat, SummOut TFloat, SummEnd TFloat, Summ TFloat
               )  
AS
$BODY$
BEGIN

    RETURN QUERY
    WITH tmpWhere AS (SELECT lfSelect.UnitId AS LocationId, zc_ContainerLinkObject_Unit() AS DescId, inGoodsId AS GoodsId FROM lfSelect_Object_Unit_byGroup (inLocationId) AS lfSelect
                    UNION
                     SELECT Object.Id AS LocationId, zc_ContainerLinkObject_Car() AS DescId, inGoodsId AS GoodsId FROM Object WHERE Object.DescId = zc_Object_Car() AND (Object.Id = inLocationId OR COALESCE(inLocationId, 0) = 0)
                    UNION
                     SELECT Object.Id AS LocationId, zc_ContainerLinkObject_Member() AS DescId, inGoodsId AS GoodsId FROM Object WHERE Object.DescId = zc_Object_Member() AND (Object.Id = inLocationId OR COALESCE(inLocationId, 0) = 0)
                    )
       , tmpContainer_Count AS (SELECT Container.Id          AS ContainerId
                                     , CLO_Location.ObjectId AS LocationId
                                     , Container.ObjectId    AS GoodsId
                                     , COALESCE (CLO_GoodsKind.ObjectId, 0) AS GoodsKindId
                                     , COALESCE (CLO_PartionGoods.ObjectId, 0) AS PartionGoodsId
                                     , Container.Amount
                                FROM tmpWhere
                                     INNER JOIN Container ON Container.ObjectId = tmpWhere.GoodsId
                                                         AND Container.DescId = zc_Container_Count()
                                     INNER JOIN ContainerLinkObject AS CLO_Location ON CLO_Location.ContainerId = Container.Id
                                                                                   AND CLO_Location.DescId = tmpWhere.DescId
                                                                                   AND CLO_Location.ObjectId = tmpWhere.LocationId
                                     LEFT JOIN ContainerLinkObject AS CLO_GoodsKind ON CLO_GoodsKind.ContainerId = Container.Id
                                                                                   AND CLO_GoodsKind.DescId = zc_ContainerLinkObject_GoodsKind()
                                     LEFT JOIN ContainerLinkObject AS CLO_PartionGoods ON CLO_PartionGoods.ContainerId = Container.Id
                                                                                      AND CLO_PartionGoods.DescId = zc_ContainerLinkObject_PartionGoods()
                               )
                , tmpMI_Count AS (SELECT tmpContainer_Count.ContainerId
                                       , tmpContainer_Count.LocationId
                                       , tmpContainer_Count.GoodsId
                                       , tmpContainer_Count.GoodsKindId
                                       , tmpContainer_Count.PartionGoodsId
                                       , tmpContainer_Count.Amount
                                       , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.MovementDescId IN (zc_Movement_Income(), zc_Movement_ReturnOut(), zc_Movement_Sale(), zc_Movement_ReturnIn())
                                                   THEN MIContainer.ContainerId_Analyzer
                                              ELSE 0
                                         END AS ContainerId_Analyzer
                                       , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                   THEN MIContainer.MovementId
                                              ELSE 0
                                         END AS MovementId
                                       , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                   THEN MIContainer.MovementItemId
                                              ELSE 0
                                         END AS MovementItemId
                                       , SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                        THEN MIContainer.Amount
                                                   ELSE 0
                                              END) AS Amount_Period
                                       , SUM (COALESCE (MIContainer.Amount, 0)) AS Amount_Total
                                       , MIContainer.MovementDescId
                                       , MIContainer.isActive
                                  FROM tmpContainer_Count
                                       LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.ContainerId = tmpContainer_Count.ContainerId
                                                                                     AND MIContainer.OperDate >= inStartDate
                                  GROUP BY tmpContainer_Count.ContainerId
                                         , tmpContainer_Count.LocationId
                                         , tmpContainer_Count.GoodsId
                                         , tmpContainer_Count.GoodsKindId
                                         , tmpContainer_Count.PartionGoodsId
                                         , tmpContainer_Count.Amount
                                         , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.MovementDescId IN (zc_Movement_Income(), zc_Movement_ReturnOut(), zc_Movement_Sale(), zc_Movement_ReturnIn())
                                                     THEN MIContainer.ContainerId_Analyzer
                                                ELSE 0
                                           END
                                         , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                     THEN MIContainer.MovementId
                                                ELSE 0
                                           END
                                         , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                     THEN MIContainer.MovementItemId
                                                ELSE 0
                                           END
                                         , MIContainer.MovementDescId
                                         , MIContainer.isActive
                                 )
       , tmpContainer_Summ AS (SELECT tmpContainer_Count.ContainerId AS ContainerId_Count
                                    , tmpContainer_Count.LocationId
                                    , tmpContainer_Count.GoodsId
                                    , tmpContainer_Count.GoodsKindId
                                    , tmpContainer_Count.PartionGoodsId
                                    , Container.Id AS ContainerId_Summ
                                    , Container.Amount
                               FROM tmpContainer_Count
                                    INNER JOIN Container ON Container.ParentId = tmpContainer_Count.ContainerId
                                                        AND Container.DescId = zc_Container_Summ()
                              )
                , tmpMI_Summ AS (SELECT tmpContainer_Summ.ContainerId_Count AS ContainerId
                                      , tmpContainer_Summ.LocationId
                                      , tmpContainer_Summ.GoodsId
                                      , tmpContainer_Summ.GoodsKindId
                                      , tmpContainer_Summ.PartionGoodsId
                                      , tmpContainer_Summ.Amount
                                      , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.MovementDescId IN (zc_Movement_Income(), zc_Movement_ReturnOut(), zc_Movement_Sale(), zc_Movement_ReturnIn())
                                                  THEN MIContainer.ContainerId_Analyzer
                                             ELSE 0
                                        END AS ContainerId_Analyzer
                                      , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                  THEN MIContainer.MovementId
                                             ELSE 0
                                        END AS MovementId
                                      , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                  THEN MIContainer.MovementItemId
                                             ELSE 0
                                        END AS MovementItemId
                                      , SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                       THEN MIContainer.Amount
                                                  ELSE 0
                                             END) AS Amount_Period
                                      , SUM (COALESCE (MIContainer.Amount, 0)) AS Amount_Total
                                      , MIContainer.MovementDescId
                                      , MIContainer.isActive
                                 FROM tmpContainer_Summ
                                      LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.ContainerId = tmpContainer_Summ.ContainerId_Summ
                                                                                    AND MIContainer.OperDate >= inStartDate
                                 GROUP BY tmpContainer_Summ.ContainerId_Count
                                        , tmpContainer_Summ.ContainerId_Summ
                                        , tmpContainer_Summ.LocationId
                                        , tmpContainer_Summ.GoodsId
                                        , tmpContainer_Summ.GoodsKindId
                                        , tmpContainer_Summ.PartionGoodsId
                                        , tmpContainer_Summ.Amount
                                        , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.MovementDescId IN (zc_Movement_Income(), zc_Movement_ReturnOut(), zc_Movement_Sale(), zc_Movement_ReturnIn())
                                                    THEN MIContainer.ContainerId_Analyzer
                                               ELSE 0
                                          END
                                        , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                    THEN MIContainer.MovementId
                                               ELSE 0
                                          END
                                        , CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                    THEN MIContainer.MovementItemId
                                               ELSE 0
                                          END
                                        , MIContainer.MovementDescId
                                        , MIContainer.isActive
                                )
   SELECT Movement.Id AS MovementId
        , Movement.InvNumber
        , Movement.OperDate
        , MovementDate_OperDatePartner.ValueData AS OperDatePartner
        , CASE WHEN Movement.DescId IN (zc_Movement_Send(), zc_Movement_SendOnPrice(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND tmpMIContainer_group.isActive = TRUE
                    THEN MovementDesc.ItemName || ' ������'
               WHEN Movement.DescId IN (zc_Movement_Send(), zc_Movement_SendOnPrice(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND tmpMIContainer_group.isActive = FALSE
                    THEN MovementDesc.ItemName || ' ������'
               ELSE MovementDesc.ItemName
          END :: TVarChar AS MovementDescName
        , CASE WHEN Movement.DescId = zc_Movement_Income()
                    THEN '01 ' || MovementDesc.ItemName
               ELSE MovementDesc.ItemName
          END :: TVarChar AS MovementDescName_order
        , CASE WHEN tmpMIContainer_group.MovementId <= 0 THEN NULL ELSE tmpMIContainer_group.isActive END :: Boolean AS isActive
        , CASE WHEN tmpMIContainer_group.MovementId <= 0 THEN TRUE ELSE FALSE END :: Boolean AS isRemains

        , ObjectDesc.ItemName            AS LocationDescName
        , Object_Location.ObjectCode     AS LocationCode
        , Object_Location.ValueData      AS LocationName
        , Object_Car.ObjectCode          AS CarCode
        , Object_Car.ValueData           AS CarName
        , ObjectDesc_By.ItemName         AS ObjectByDescName
        , Object_By.ObjectCode           AS ObjectByCode
        , Object_By.ValueData            AS ObjectByName

        , Object_PaidKind.ValueData AS PaidKindName

        , Object_Goods.ObjectCode AS GoodsCode
        , Object_Goods.ValueData  AS GoodsName
        , Object_GoodsKind.ValueData AS GoodsKindName
        , COALESCE (CASE WHEN Object_PartionGoods.ValueData <> '' THEN Object_PartionGoods.ValueData ELSE NULL END, '*' || tmpMIContainer_group.PartionGoods_item) :: TVarChar AS PartionGoods

        , CAST (CASE WHEN Movement.DescId = zc_Movement_Income() AND 1=0
                          THEN 0 -- MIFloat_Price.ValueData
                     WHEN tmpMIContainer_group.MovementId = -1 AND tmpMIContainer_group.AmountStart <> 0
                          THEN tmpMIContainer_group.SummStart / tmpMIContainer_group.AmountStart
                     WHEN tmpMIContainer_group.MovementId = -2 AND tmpMIContainer_group.AmountEnd <> 0
                          THEN tmpMIContainer_group.SummEnd / tmpMIContainer_group.AmountEnd
                     WHEN tmpMIContainer_group.AmountIn <> 0
                          THEN tmpMIContainer_group.SummIn / tmpMIContainer_group.AmountIn
                     WHEN tmpMIContainer_group.AmountOut <> 0
                          THEN tmpMIContainer_group.SummOut / tmpMIContainer_group.AmountOut
                     ELSE 0
                END AS TFloat) AS Price
        , CAST (tmpMIContainer_group.AmountStart AS TFloat) AS AmountStart
        , CAST (tmpMIContainer_group.AmountIn AS TFloat)    AS AmountIn
        , CAST (tmpMIContainer_group.AmountOut AS TFloat)   AS AmountOut
        , CAST (tmpMIContainer_group.AmountEnd AS TFloat)   AS AmountEnd 
        , CAST (tmpMIContainer_group.AmountIn + tmpMIContainer_group.AmountOut AS TFloat) AS Amount

        , CAST (tmpMIContainer_group.SummStart AS TFloat)   AS SummStart
        , CAST (tmpMIContainer_group.SummIn AS TFloat)      AS SummIn
        , CAST (tmpMIContainer_group.SummOut AS TFloat)     AS SummOut
        , CAST (tmpMIContainer_group.SummEnd AS TFloat)     AS SummEnd 
        , CAST (tmpMIContainer_group.SummIn + tmpMIContainer_group.SummOut AS TFloat) AS Summ

   FROM (SELECT tmpMIContainer_all.MovementId
              , MAX (tmpMIContainer_all.MovementItemId) AS MovementItemId
              , tmpMIContainer_all.LocationId
              , tmpMIContainer_all.GoodsId
              , tmpMIContainer_all.GoodsKindId
              , tmpMIContainer_all.PartionGoodsId
              , tmpMIContainer_all.ContainerId_Analyzer
              , tmpMIContainer_all.isActive
              , tmpMIContainer_all.PartionGoods_item
              , SUM (tmpMIContainer_all.AmountStart) AS AmountStart
              , SUM (tmpMIContainer_all.AmountEnd)   AS AmountEnd
              , SUM (tmpMIContainer_all.AmountIn)    AS AmountIn
              , SUM (tmpMIContainer_all.AmountOut)   AS AmountOut
              , SUM (tmpMIContainer_all.SummStart)   AS SummStart
              , SUM (tmpMIContainer_all.SummEnd)     AS SummEnd
              , SUM (tmpMIContainer_all.SummIn)      AS SummIn
              , SUM (tmpMIContainer_all.SummOut)     AS SummOut
        FROM (-- 1.1. ������� ���-��
              SELECT -1 AS MovementId
                   , 0 AS MovementItemId
                   , tmpMI_Count.ContainerId
                   , tmpMI_Count.LocationId
                   , tmpMI_Count.GoodsId
                   , tmpMI_Count.GoodsKindId
                   , tmpMI_Count.PartionGoodsId
                   , 0    AS ContainerId_Analyzer
                   , TRUE AS isActive
                   , tmpMI_Count.Amount - SUM (tmpMI_Count.Amount_Total)                                   AS AmountStart
                   , tmpMI_Count.Amount - SUM (tmpMI_Count.Amount_Total) + SUM (tmpMI_Count.Amount_Period) AS AmountEnd
                   , 0 AS AmountIn
                   , 0 AS AmountOut
                   , 0 AS SummStart
                   , 0 AS SummEnd
                   , 0 AS SummIn
                   , 0 AS SummOut
                   , ''  AS PartionGoods_item
              FROM tmpMI_Count
              GROUP BY tmpMI_Count.ContainerId
                     , tmpMI_Count.LocationId
                     , tmpMI_Count.GoodsId
                     , tmpMI_Count.GoodsKindId
                     , tmpMI_Count.PartionGoodsId
                     , tmpMI_Count.Amount
              HAVING tmpMI_Count.Amount - SUM (tmpMI_Count.Amount_Total) <> 0
                  OR SUM (tmpMI_Count.Amount_Period) <> 0
             UNION ALL
              -- 1.2. �������� ���-��
              SELECT tmpMI_Count.MovementId
                   , tmpMI_Count.MovementItemId
                   , tmpMI_Count.ContainerId
                   , tmpMI_Count.LocationId
                   , tmpMI_Count.GoodsId
                   , tmpMI_Count.GoodsKindId
                   , tmpMI_Count.PartionGoodsId
                   , tmpMI_Count.ContainerId_Analyzer
                   , tmpMI_Count.isActive
                   , 0 AS AmountStart
                   , 0 AS AmountEnd
                   , CASE WHEN tmpMI_Count.Amount_Period > 0 THEN      tmpMI_Count.Amount_Period ELSE 0 END AS AmountIn
                   , CASE WHEN tmpMI_Count.Amount_Period < 0 THEN -1 * tmpMI_Count.Amount_Period ELSE 0 END AS AmountOut
                   , 0 AS SummStart
                   , 0 AS SummEnd
                   , 0 AS SummIn
                   , 0 AS SummOut
                   , CASE WHEN tmpMI_Count.MovementDescId = zc_Movement_ProductionSeparate()
                               THEN MovementString_PartionGoods.ValueData
                          WHEN MIString_PartionGoods.ValueData <> ''
                               THEN MIString_PartionGoods.ValueData
                          ELSE TO_CHAR (MIDate_PartionGoods.ValueData, 'DD.MM.YYYY')
                     END AS PartionGoods_item
              FROM tmpMI_Count
                   LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                              ON MIDate_PartionGoods.MovementItemId = tmpMI_Count.MovementItemId
                                             AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                   LEFT JOIN MovementItemString AS MIString_PartionGoods
                                                ON MIString_PartionGoods.MovementItemId = tmpMI_Count.MovementItemId
                                               AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                   LEFT JOIN MovementString AS MovementString_PartionGoods
                                            ON MovementString_PartionGoods.MovementId = tmpMI_Count.MovementId
                                           AND MovementString_PartionGoods.DescId = zc_MovementString_PartionGoods()
                                           AND tmpMI_Count.MovementDescId = zc_Movement_ProductionSeparate()
              WHERE tmpMI_Count.Amount_Period <> 0
             UNION ALL
              -- 2.1. ������� �����
              SELECT -1 AS MovementId
                   , 0 AS MovementItemId
                   , tmpMI_Summ.ContainerId
                   , tmpMI_Summ.LocationId
                   , tmpMI_Summ.GoodsId
                   , tmpMI_Summ.GoodsKindId
                   , tmpMI_Summ.PartionGoodsId
                   , 0    AS ContainerId_Analyzer
                   , TRUE AS isActive
                   , 0 AS AmountStart
                   , 0 AS AmountEnd
                   , 0 AS AmountIn
                   , 0 AS AmountOut
                   , tmpMI_Summ.Amount - SUM (tmpMI_Summ.Amount_Total) AS SummStart
                   , tmpMI_Summ.Amount - SUM (tmpMI_Summ.Amount_Total) + SUM (tmpMI_Summ.Amount_Period) AS SummEnd
                   , 0 AS SummIn
                   , 0 AS SummOut
                   , '' AS PartionGoods_item
              FROM tmpMI_Summ
              GROUP BY tmpMI_Summ.ContainerId
                     , tmpMI_Summ.LocationId
                     , tmpMI_Summ.GoodsId
                     , tmpMI_Summ.GoodsKindId
                     , tmpMI_Summ.PartionGoodsId
                     , tmpMI_Summ.Amount
              HAVING tmpMI_Summ.Amount - SUM (tmpMI_Summ.Amount_Total) <> 0
                  OR SUM (tmpMI_Summ.Amount_Period) <> 0
             UNION ALL
              -- 2.2. �������� �����
              SELECT tmpMI_Summ.MovementId
                   , tmpMI_Summ.MovementItemId
                   , tmpMI_Summ.ContainerId
                   , tmpMI_Summ.LocationId
                   , tmpMI_Summ.GoodsId
                   , tmpMI_Summ.GoodsKindId
                   , tmpMI_Summ.PartionGoodsId
                   , tmpMI_Summ.ContainerId_Analyzer
                   , tmpMI_Summ.isActive
                   , 0 AS AmountStart
                   , 0 AS AmountEnd
                   , 0 AS AmountIn
                   , 0 AS AmountOut
                   , 0 AS SummStart
                   , 0 AS SummEnd
                   , CASE WHEN tmpMI_Summ.Amount_Period > 0 THEN      tmpMI_Summ.Amount_Period ELSE 0 END AS SummIn
                   , CASE WHEN tmpMI_Summ.Amount_Period < 0 THEN -1 * tmpMI_Summ.Amount_Period ELSE 0 END AS SummOut
                   , CASE WHEN tmpMI_Summ.MovementDescId = zc_Movement_ProductionSeparate()
                               THEN MovementString_PartionGoods.ValueData
                          WHEN MIString_PartionGoods.ValueData <> ''
                               THEN MIString_PartionGoods.ValueData
                          ELSE TO_CHAR (MIDate_PartionGoods.ValueData, 'DD.MM.YYYY')
                     END AS PartionGoods_item
              FROM tmpMI_Summ
                   LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                              ON MIDate_PartionGoods.MovementItemId = tmpMI_Summ.MovementItemId
                                             AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                   LEFT JOIN MovementItemString AS MIString_PartionGoods
                                                ON MIString_PartionGoods.MovementItemId = tmpMI_Summ.MovementItemId
                                               AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                   LEFT JOIN MovementString AS MovementString_PartionGoods
                                            ON MovementString_PartionGoods.MovementId = tmpMI_Summ.MovementId
                                           AND MovementString_PartionGoods.DescId = zc_MovementString_PartionGoods()
                                           AND tmpMI_Summ.MovementDescId = zc_Movement_ProductionSeparate()
              WHERE tmpMI_Summ.Amount_Period <> 0
             ) AS tmpMIContainer_all
         GROUP BY tmpMIContainer_all.MovementId
                -- , tmpMIContainer_all.MovementItemId
                , tmpMIContainer_all.LocationId
                , tmpMIContainer_all.GoodsId
                , tmpMIContainer_all.GoodsKindId
                , tmpMIContainer_all.PartionGoodsId
                , tmpMIContainer_all.ContainerId_Analyzer
                , tmpMIContainer_all.isActive
                , tmpMIContainer_all.PartionGoods_item
        ) AS tmpMIContainer_group
        LEFT JOIN Movement ON Movement.Id = tmpMIContainer_group.MovementId
        LEFT JOIN MovementDesc ON MovementDesc.Id = Movement.DescId

        LEFT JOIN ContainerLinkObject AS CLO_Object_By ON CLO_Object_By.ContainerId = tmpMIContainer_group.ContainerId_Analyzer
                                                      AND CLO_Object_By.DescId IN (zc_ContainerLinkObject_Partner(), zc_ContainerLinkObject_Member())
        LEFT JOIN MovementLinkObject AS MovementLinkObject_By
                                     ON MovementLinkObject_By.MovementId = tmpMIContainer_group.MovementId
                                    AND MovementLinkObject_By.DescId = CASE WHEN Movement.DescId = zc_Movement_Income() THEN zc_MovementLinkObject_From()
                                                                            WHEN Movement.DescId = zc_Movement_ReturnOut() THEN zc_MovementLinkObject_To()
                                                                            WHEN Movement.DescId = zc_Movement_Sale() THEN zc_MovementLinkObject_To()
                                                                            WHEN Movement.DescId = zc_Movement_ReturnIn() THEN zc_MovementLinkObject_From()
                                                                            WHEN Movement.DescId = zc_Movement_Loss() THEN zc_MovementLinkObject_ArticleLoss()
                                                                            WHEN Movement.DescId IN (zc_Movement_Send(), zc_Movement_SendOnPrice(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND tmpMIContainer_group.isActive = TRUE THEN zc_MovementLinkObject_From()
                                                                            WHEN Movement.DescId IN (zc_Movement_Send(), zc_Movement_SendOnPrice(), zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate()) AND tmpMIContainer_group.isActive = FALSE THEN zc_MovementLinkObject_To()
                                                                       END

        LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                     ON MovementLinkObject_PaidKind.MovementId = tmpMIContainer_group.MovementId
                                    AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
        LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = MovementLinkObject_PaidKind.ObjectId

        LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                               ON MovementDate_OperDatePartner.MovementId = tmpMIContainer_group.MovementId
                              AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()

        LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpMIContainer_group.GoodsId
        LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpMIContainer_group.GoodsKindId
        LEFT JOIN Object AS Object_Location_find ON Object_Location_find.Id = tmpMIContainer_group.LocationId
        LEFT JOIN ObjectDesc ON ObjectDesc.Id = Object_Location_find.DescId
        LEFT JOIN ObjectLink AS ObjectLink_Car_Unit ON ObjectLink_Car_Unit.ObjectId = tmpMIContainer_group.LocationId
                                                   AND ObjectLink_Car_Unit.DescId = zc_ObjectLink_Car_Unit()
        LEFT JOIN Object AS Object_Location ON Object_Location.Id = CASE WHEN Object_Location_find.DescId = zc_Object_Car() THEN ObjectLink_Car_Unit.ChildObjectId ELSE tmpMIContainer_group.LocationId END
        LEFT JOIN Object AS Object_Car ON Object_Car.Id = CASE WHEN Object_Location_find.DescId = zc_Object_Car() THEN tmpMIContainer_group.LocationId END
        LEFT JOIN Object AS Object_By ON Object_By.Id = CASE WHEN CLO_Object_By.ObjectId > 0 THEN CLO_Object_By.ObjectId ELSE MovementLinkObject_By.ObjectId END
        LEFT JOIN ObjectDesc AS ObjectDesc_By ON ObjectDesc_By.Id = Object_By.DescId
        LEFT JOIN Object AS Object_PartionGoods ON Object_PartionGoods.Id = tmpMIContainer_group.PartionGoodsId

   ;
    
        
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpReport_Goods (TDateTime, TDateTime, Integer, Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.05.14                                        * ALL
 10.04.14                                        * ALL
 09.02.14         *  GROUP BY tmp_All
                   , add GoodsKind
 21.12.13                                        * Personal -> Member
 05.11.13         *  
*/

-- ����
-- SELECT * FROM gpReport_Goods (inStartDate:= '01.01.2015', inEndDate:= '01.01.2015', inLocationId:=0, inGoodsId:= 1826, inSession:= zfCalc_UserAdmin());
