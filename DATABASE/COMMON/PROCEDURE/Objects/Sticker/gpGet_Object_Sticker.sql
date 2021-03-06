-- Function: gpGet_Object_Sticker()

DROP FUNCTION IF EXISTS gpGet_Object_Sticker (Integer, TVarChar);
DROP FUNCTION IF EXISTS gpGet_Object_Sticker (Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_Sticker(
    IN inId          Integer,       -- ����� 
    IN inMaskId      Integer,       -- 
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Comment TVarChar
             , JuridicalId Integer, JuridicalName TVarChar
             , GoodsId Integer, GoodsName TVarChar
             , StickerGroupId Integer, StickerGroupName TVarChar
             , StickerTypeId Integer, StickerTypeName TVarChar
             , StickerTagId Integer, StickerTagName TVarChar
             , StickerSortId Integer, StickerSortName TVarChar
             , StickerNormId Integer, StickerNormName TVarChar
             , StickerFileId Integer, StickerFileName TVarChar
             , isInfo TBlob
             , Value1 TFloat, Value2 TFloat, Value3 TFloat, Value4 TFloat, Value5 TFloat
              )
AS
$BODY$
   DECLARE vbPriceListId Integer;
   DECLARE vbPriceListName TVarChar;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Get_Object_Sticker());
    
   IF (COALESCE (inId, 0) = 0 AND COALESCE (inMaskId, 0) = 0)
   THEN
       RETURN QUERY 

       SELECT CAST (0 as Integer)     AS Id
            , lfGet_ObjectCode(0, zc_Object_Sticker()) AS Code
            , CAST ('' as TVarChar)   AS Comment

            , CAST (0 as Integer)     AS JuridicalId
            , CAST ('' as TVarChar)   AS JuridicalName 

            , CAST (0 as Integer)     AS GoodsId
            , CAST ('' as TVarChar)   AS GoodsName
            
            , CAST (0 as Integer)     AS StickerGroupId
            , CAST ('' as TVarChar)   AS StickerGroupName 

            , CAST (0 as Integer)     AS StickerTypeId
            , CAST ('' as TVarChar)   AS StickerTypeName

            , CAST (0 as Integer)     AS StickerTagId
            , CAST ('' as TVarChar)   AS StickerTagName

            , CAST (0 as Integer)     AS StickerSortId
            , CAST ('' as TVarChar)   AS StickerSortName
            
            , CAST (0 as Integer)     AS StickerNormId
            , CAST ('' as TVarChar)   AS StickerNormName
            
            , CAST (0 as Integer)     AS StickerFileId
            , CAST ('' as TVarChar)   AS StickerFileName
                  
            , CAST ('' as TBlob)      AS isInfo
                                    
            , CAST (0 as TFloat)      AS Value1
            , CAST (0 as TFloat)      AS Value2
            , CAST (0 as TFloat)      AS Value3
            , CAST (0 as TFloat)      AS Value4
            , CAST (0 as TFloat)      AS Value5
            ;
   ELSE
       RETURN QUERY 
       SELECT Object_Sticker.Id                 AS Id
            --, Object_Sticker.ObjectCode         AS Code
            , CASE WHEN  COALESCE (inId, 0) = 0 THEN lfGet_ObjectCode (0, zc_Object_Sticker()) ELSE Object_Sticker.ObjectCode END AS Code
            , Object_Sticker.ValueData          AS Comment

            , Object_Juridical.Id               AS JuridicalId
            , Object_Juridical.ValueData        AS JuridicalName 

            , Object_Goods.Id                   AS GoodsId
            , Object_Goods.ValueData            AS GoodsName
            
            , Object_StickerGroup.Id            AS StickerGroupId
            , Object_StickerGroup.ValueData     AS StickerGroupName 

            , Object_StickerType.Id             AS StickerTypeId
            , Object_StickerType.ValueData      AS StickerTypeName

            , Object_StickerTag.Id              AS StickerTagId
            , Object_StickerTag.ValueData       AS StickerTagName

            , Object_StickerSort.Id             AS StickerSortId
            , Object_StickerSort.ValueData      AS StickerSortName
            
            , Object_StickerNorm.Id             AS StickerNormId
            , Object_StickerNorm.ValueData      AS StickerNormName
            
            , Object_StickerFile.Id             AS StickerFileId
            , Object_StickerFile.ValueData      AS StickerFileName
                  
            , ObjectBlob_Info.ValueData         AS isInfo
                                    
            , ObjectFloat_Value1.ValueData      AS Value1
            , ObjectFloat_Value2.ValueData      AS Value2
            , ObjectFloat_Value3.ValueData      AS Value3
            , ObjectFloat_Value4.ValueData      AS Value4
            , ObjectFloat_Value5.ValueData      AS Value5

       FROM Object AS Object_Sticker
            
             LEFT JOIN ObjectLink AS ObjectLink_Sticker_Juridical
                                  ON ObjectLink_Sticker_Juridical.ObjectId = Object_Sticker.Id
                                 AND ObjectLink_Sticker_Juridical.DescId = zc_ObjectLink_Sticker_Juridical()
             LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = ObjectLink_Sticker_Juridical.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Sticker_Goods
                                  ON ObjectLink_Sticker_Goods.ObjectId = Object_Sticker.Id
                                 AND ObjectLink_Sticker_Goods.DescId = zc_ObjectLink_Sticker_Goods()
             LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = ObjectLink_Sticker_Goods.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Sticker_StickerGroup
                                  ON ObjectLink_Sticker_StickerGroup.ObjectId = Object_Sticker.Id
                                 AND ObjectLink_Sticker_StickerGroup.DescId = zc_ObjectLink_Sticker_StickerGroup()
             LEFT JOIN Object AS Object_StickerGroup ON Object_StickerGroup.Id = ObjectLink_Sticker_StickerGroup.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Sticker_StickerType
                                  ON ObjectLink_Sticker_StickerType.ObjectId = Object_Sticker.Id 
                                 AND ObjectLink_Sticker_StickerType.DescId = zc_ObjectLink_Sticker_StickerType()
             LEFT JOIN Object AS Object_StickerType ON Object_StickerType.Id = ObjectLink_Sticker_StickerType.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Sticker_StickerTag
                                  ON ObjectLink_Sticker_StickerTag.ObjectId = Object_Sticker.Id
                                 AND ObjectLink_Sticker_StickerTag.DescId = zc_ObjectLink_Sticker_StickerTag()
             LEFT JOIN Object AS Object_StickerTag ON Object_StickerTag.Id = ObjectLink_Sticker_StickerTag.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Sticker_StickerSort
                                  ON ObjectLink_Sticker_StickerSort.ObjectId = Object_Sticker.Id 
                                 AND ObjectLink_Sticker_StickerSort.DescId = zc_ObjectLink_Sticker_StickerSort()
             LEFT JOIN Object AS Object_StickerSort ON Object_StickerSort.Id = ObjectLink_Sticker_StickerSort.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Sticker_StickerNorm
                                  ON ObjectLink_Sticker_StickerNorm.ObjectId = Object_Sticker.Id 
                                 AND ObjectLink_Sticker_StickerNorm.DescId = zc_ObjectLink_Sticker_StickerNorm()
             LEFT JOIN Object AS Object_StickerNorm ON Object_StickerNorm.Id = ObjectLink_Sticker_StickerNorm.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Sticker_StickerFile
                                  ON ObjectLink_Sticker_StickerFile.ObjectId = Object_Sticker.Id 
                                 AND ObjectLink_Sticker_StickerFile.DescId = zc_ObjectLink_Sticker_StickerFile()
             LEFT JOIN Object AS Object_StickerFile ON Object_StickerFile.Id = ObjectLink_Sticker_StickerFile.ChildObjectId 

             LEFT JOIN ObjectFloat AS ObjectFloat_Value1
                                   ON ObjectFloat_Value1.ObjectId = Object_Sticker.Id 
                                  AND ObjectFloat_Value1.DescId = zc_ObjectFloat_Sticker_Value1()

             LEFT JOIN ObjectFloat AS ObjectFloat_Value2
                                   ON ObjectFloat_Value2.ObjectId = Object_Sticker.Id 
                                  AND ObjectFloat_Value2.DescId = zc_ObjectFloat_Sticker_Value2()

             LEFT JOIN ObjectFloat AS ObjectFloat_Value3
                                   ON ObjectFloat_Value3.ObjectId = Object_Sticker.Id 
                                  AND ObjectFloat_Value3.DescId = zc_ObjectFloat_Sticker_Value3()

             LEFT JOIN ObjectFloat AS ObjectFloat_Value4
                                   ON ObjectFloat_Value4.ObjectId = Object_Sticker.Id 
                                  AND ObjectFloat_Value4.DescId = zc_ObjectFloat_Sticker_Value4()

             LEFT JOIN ObjectFloat AS ObjectFloat_Value5
                                   ON ObjectFloat_Value5.ObjectId = Object_Sticker.Id 
                                  AND ObjectFloat_Value5.DescId = zc_ObjectFloat_Sticker_Value5()
             
             LEFT JOIN ObjectBlob AS ObjectBlob_Info
                                  ON ObjectBlob_Info.ObjectId = Object_Sticker.Id 
                                 AND ObjectBlob_Info.DescId = zc_ObjectBlob_Sticker_Info()

       WHERE Object_Sticker.Id = CASE WHEN COALESCE (inId, 0) = 0 THEN inMaskId ELSE inId END;

   END IF;
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 23.10.17         *
*/

-- ����
-- SELECT * FROM gpGet_Object_Sticker (100, '2')