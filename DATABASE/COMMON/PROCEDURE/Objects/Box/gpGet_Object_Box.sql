﻿-- Function: gpGet_Object_Box()

DROP FUNCTION IF EXISTS gpGet_Object_Box (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_Box(
    IN inId          Integer,       -- Единица измерения
    IN inSession     TVarChar       -- сессия пользователя
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar
             , BoxVolume TFloat, BoxWeight TFloat
             , BoxHeight TFloat, BoxLength TFloat, BoxWidth TFloat
             , isErased boolean) AS
$BODY$BEGIN

  -- проверка прав пользователя на вызов процедуры
  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Box());

  IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY
       SELECT
             CAST (0 as Integer)    AS Id
           , COALESCE(MAX (Object.ObjectCode), 0) + 1 AS Code
           , CAST ('' as TVarChar)  AS Name
           , CAST (NULL as TFLOAT)  AS BoxVolume
           , CAST (NULL as TFLOAT)  AS BoxWeight
           , CAST (NULL as TFLOAT)  AS BoxHeight
           , CAST (NULL as TFLOAT)  AS BoxLength
           , CAST (NULL as TFLOAT)  AS BoxWidth
           , CAST (NULL AS Boolean) AS isErased

       FROM Object
       WHERE Object.DescId = zc_Object_Box();
   ELSE
       RETURN QUERY
       SELECT
             Object.Id         AS Id
           , Object.ObjectCode AS Code
           , Object.ValueData  AS Name
           , OF_Box_Volume.ValueData  AS BoxVolume
           , OF_Box_Weight.ValueData  AS BoxWeight
           , COALESCE (ObjectFloat_Height.ValueData,0) ::TFloat  AS BoxHeight
           , COALESCE (ObjectFloat_Length.ValueData,0) ::TFloat  AS BoxLength
           , COALESCE (ObjectFloat_Width.ValueData,0)  ::TFloat  AS BoxWidth
           , Object.isErased   AS isErased

       FROM Object
        LEFT JOIN ObjectFloat AS OF_Box_Volume
                              ON OF_Box_Volume.ObjectId = Object.Id
                             AND OF_Box_Volume.DescId = zc_ObjectFloat_Box_Volume()
        LEFT JOIN ObjectFloat AS OF_Box_Weight
                              ON OF_Box_Weight.ObjectId = Object.Id
                             AND OF_Box_Weight.DescId = zc_ObjectFloat_Box_Weight()
                
        LEFT JOIN ObjectFloat AS ObjectFloat_Height
                              ON ObjectFloat_Height.ObjectId = Object.Id
                             AND ObjectFloat_Height.DescId = zc_ObjectFloat_Box_Height()

        LEFT JOIN ObjectFloat AS ObjectFloat_Length
                              ON ObjectFloat_Length.ObjectId = Object.Id
                             AND ObjectFloat_Length.DescId = zc_ObjectFloat_Box_Length()

        LEFT JOIN ObjectFloat AS ObjectFloat_Width
                              ON ObjectFloat_Width.ObjectId = Object.Id
                             AND ObjectFloat_Width.DescId = zc_ObjectFloat_Box_Width()
                             
       WHERE Object.Id = inId;
   END IF;

END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Object_Box(integer, TVarChar)
  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.   Манько Д.А.
 24.06.18         *
 09.10.14                                                       *

*/

-- тест
-- SELECT * FROM gpGet_Object_Box(0,'2')