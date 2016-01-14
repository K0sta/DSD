-- Function: gpSelect_Object_Member (TVarChar)

DROP FUNCTION IF EXISTS gpSelect_Object_Member (Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_Member(
    IN inIsShowAll        Boolean,       --
    IN inSession          TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar
             , INN TVarChar, DriverCertificate TVarChar, Comment TVarChar
             , isOfficial Boolean
             , InfoMoneyId Integer, InfoMoneyCode Integer, InfoMoneyName TVarChar, InfoMoneyName_all TVarChar
             , StartSummerDate TDateTime, EndSummerDate TDateTime
             , SummerFuel TFloat, WinterFuel TFloat, Reparation TFloat, LimitMoney TFloat, LimitFuel TFloat
             , CarNameAll TVarChar, CarName TVarChar, CarModelName TVarChar
             , isErased boolean) AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbIsAllUnit Boolean;
   DECLARE vbIsConstraint Boolean;
   DECLARE vbObjectId_Constraint Integer;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Object_Member());
   vbUserId:= lpGetUserBySession (inSession);

   vbIsAllUnit:= NOT EXISTS (SELECT 1 FROM Object_RoleAccessKeyGuide_View WHERE UnitId_PersonalService <> 0 AND UserId = vbUserId);

   -- ������������ ������� �������
   vbObjectId_Constraint:= (SELECT Object_RoleAccessKeyGuide_View.BranchId FROM Object_RoleAccessKeyGuide_View WHERE Object_RoleAccessKeyGuide_View.UserId = vbUserId AND Object_RoleAccessKeyGuide_View.BranchId <> 0 GROUP BY Object_RoleAccessKeyGuide_View.BranchId);
   vbIsConstraint:= COALESCE (vbObjectId_Constraint, 0) > 0;

   -- ���������
   RETURN QUERY 
   with tmpCar AS (SELECT Max( ObjectLink_Car_PersonalDriver.ObjectId) AS CarId
                        , View_PersonalDriver.PersonalId
                        , View_PersonalDriver.MemberId
                   FROM ObjectLink AS ObjectLink_Car_PersonalDriver 
                       Inner JOIN Object_Personal_View AS View_PersonalDriver 
                                                       ON View_PersonalDriver.PersonalId = ObjectLink_Car_PersonalDriver.ChildObjectId
                   WHERE  ObjectLink_Car_PersonalDriver.DescId = zc_ObjectLink_Car_PersonalDriver() 
                   GROUP BY View_PersonalDriver.PersonalId
                          , View_PersonalDriver.MemberId
                   )
                   
     SELECT 
           Object_Member.Id         AS Id
         , Object_Member.ObjectCode AS Code
         , Object_Member.ValueData  AS Name
         
         , ObjectString_INN.ValueData               AS INN
         , ObjectString_DriverCertificate.ValueData AS DriverCertificate
         , ObjectString_Comment.ValueData           AS Comment

         , ObjectBoolean_Official.ValueData         AS isOfficial
 
         , Object_InfoMoney_View.InfoMoneyId
         , Object_InfoMoney_View.InfoMoneyCode
         , Object_InfoMoney_View.InfoMoneyName
         , Object_InfoMoney_View.InfoMoneyName_all

         , COALESCE(ObjectDate_StartSummer.ValueData, Null)  ::TDateTime  AS StartSummerDate
         , COALESCE(ObjectDate_EndSummer.ValueData, Null)  ::TDateTime    AS EndSummerDate

         , COALESCE(ObjectFloat_SummerFuel.ValueData, 0) ::TFloat  AS SummerFuel
         , COALESCE(ObjectFloat_WinterFuel.ValueData, 0) ::TFloat  AS WinterFuel
         , COALESCE(ObjectFloat_Reparation.ValueData, 0) ::TFloat  AS Reparation
         , COALESCE(ObjectFloat_Limit.ValueData, 0) ::TFloat       AS LimitMoney
         , COALESCE(ObjectFloat_LimitFuel.ValueData, 0) ::TFloat   AS LimitFuel

         , (COALESCE (Object_CarModel.ValueData, '') || ' ' || COALESCE (Object_Car.ValueData, '')) :: TVarChar AS CarNameAll
         , Object_Car.ValueData       AS CarName
         , Object_CarModel.ValueData  AS CarModelName
         
         , Object_Member.isErased                   AS isErased

     FROM Object AS Object_Member
          LEFT JOIN (SELECT View_Personal.MemberId
                     FROM Object_Personal_View AS View_Personal
                          INNER JOIN Object_RoleAccessKeyGuide_View AS View_RoleAccessKeyGuide
                                                                    ON View_RoleAccessKeyGuide.UserId = vbUserId
                                                                   AND View_RoleAccessKeyGuide.UnitId_PersonalService = View_Personal.UnitId
                                                                   AND vbIsAllUnit = FALSE
                     GROUP BY View_Personal.MemberId
                    ) AS View_Personal ON View_Personal.MemberId = Object_Member.Id
          LEFT JOIN (SELECT View_Personal.MemberId
                     FROM ObjectLink AS ObjectLink_Unit_Branch
                          INNER JOIN Object_Personal_View AS View_Personal ON View_Personal.UnitId = ObjectLink_Unit_Branch.ObjectId
                     WHERE ObjectLink_Unit_Branch.ChildObjectId = vbObjectId_Constraint
                       AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
                     GROUP BY View_Personal.MemberId
                    UNION
                     SELECT View_Personal.MemberId
                     FROM Object_Personal_View AS View_Personal
                     WHERE View_Personal.PositionId = 81178 -- ����������
                        OR View_Personal.PositionId = 8466  -- ��������
                        OR View_Personal.UnitId = 8409 -- ����� ������������
                     GROUP BY View_Personal.MemberId
                    ) AS View_Personal_Branch ON View_Personal_Branch.MemberId = Object_Member.Id

          LEFT JOIN ObjectBoolean AS ObjectBoolean_Official
                                  ON ObjectBoolean_Official.ObjectId = Object_Member.Id
                                 AND ObjectBoolean_Official.DescId = zc_ObjectBoolean_Member_Official()
          LEFT JOIN ObjectString AS ObjectString_INN
                                 ON ObjectString_INN.ObjectId = Object_Member.Id 
                                AND ObjectString_INN.DescId = zc_ObjectString_Member_INN()
          LEFT JOIN ObjectString AS ObjectString_DriverCertificate
                                 ON ObjectString_DriverCertificate.ObjectId = Object_Member.Id 
                                AND ObjectString_DriverCertificate.DescId = zc_ObjectString_Member_DriverCertificate()
          LEFT JOIN ObjectString AS ObjectString_Comment
                                 ON ObjectString_Comment.ObjectId = Object_Member.Id 
                                AND ObjectString_Comment.DescId = zc_ObjectString_Member_Comment()
         LEFT JOIN ObjectLink AS ObjectLink_Member_InfoMoney
                              ON ObjectLink_Member_InfoMoney.ObjectId = Object_Member.Id
                             AND ObjectLink_Member_InfoMoney.DescId = zc_ObjectLink_Member_InfoMoney()
         LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = ObjectLink_Member_InfoMoney.ChildObjectId

         
         LEFT JOIN ObjectDate AS ObjectDate_StartSummer
                              ON ObjectDate_StartSummer.ObjectId = Object_Member.Id
                             AND ObjectDate_StartSummer.DescId = zc_ObjectDate_Member_StartSummer()

         LEFT JOIN ObjectDate AS ObjectDate_EndSummer
                              ON ObjectDate_EndSummer.ObjectId = Object_Member.Id
                             AND ObjectDate_EndSummer.DescId = zc_ObjectDate_Member_EndSummer()

         LEFT JOIN ObjectFloat AS ObjectFloat_SummerFuel
                               ON ObjectFloat_SummerFuel.ObjectId = Object_Member.Id
                              AND ObjectFloat_SummerFuel.DescId = zc_ObjectFloat_Member_Summer()

         LEFT JOIN ObjectFloat AS ObjectFloat_WinterFuel
                               ON ObjectFloat_WinterFuel.ObjectId = Object_Member.Id
                              AND ObjectFloat_WinterFuel.DescId = zc_ObjectFloat_Member_Winter()

         LEFT JOIN ObjectFloat AS ObjectFloat_Reparation
                               ON ObjectFloat_Reparation.ObjectId = Object_Member.Id
                              AND ObjectFloat_Reparation.DescId = zc_ObjectFloat_Member_Reparation()

         LEFT JOIN ObjectFloat AS ObjectFloat_Limit
                               ON ObjectFloat_Limit.ObjectId = Object_Member.Id
                              AND ObjectFloat_Limit.DescId = zc_ObjectFloat_Member_Limit()
                              
         LEFT JOIN ObjectFloat AS ObjectFloat_LimitFuel
                               ON ObjectFloat_LimitFuel.ObjectId = Object_Member.Id
                              AND ObjectFloat_LimitFuel.DescId = zc_ObjectFloat_Member_LimitFuel()

         LEFT JOIN tmpCar ON tmpCar.MemberId = Object_Member.Id
         
         LEFT JOIN Object AS Object_Car ON Object_Car.Id = tmpCar.CarId
         LEFT JOIN ObjectLink AS Car_CarModel ON Car_CarModel.ObjectId = Object_Car.Id
                                                AND Car_CarModel.DescId = zc_ObjectLink_Car_CarModel()
         LEFT JOIN Object AS Object_CarModel ON Object_CarModel.Id = Car_CarModel.ChildObjectId
                              
     WHERE Object_Member.DescId = zc_Object_Member()
       AND (Object_Member.isErased = FALSE
            OR (Object_Member.isErased = TRUE AND inIsShowAll = TRUE)
           )
       AND (View_Personal.MemberId > 0
            OR vbIsAllUnit = TRUE
           )
       AND (View_Personal_Branch.MemberId > 0
            OR vbIsConstraint = FALSE
           )
  UNION ALL
          SELECT
             CAST (0 as Integer)    AS Id
           , 0    AS Code
           , CAST ('�������' as TVarChar)  AS NAME
           , CAST ('' as TVarChar)  AS INN
           , CAST ('' as TVarChar)  AS DriverCertificate
           , CAST ('' as TVarChar)  AS Comment
           , FALSE                  AS isOfficial
           , CAST (0 as Integer)    AS InfoMoneyId
           , CAST (0 as Integer)    AS InfoMoneyCode
           , CAST ('' as TVarChar)  AS InfoMoneyName   
           , CAST ('' as TVarChar)  AS InfoMoneyName_all

           , CAST (Null as TDateTime) AS StartSummerDate
           , CAST (Null as TDateTime) AS EndSummerDate

           , CAST (0 as TFloat) AS SummerFuel
           , CAST (0 as TFloat) AS WinterFuel
           , CAST (0 as TFloat) AS Reparation
           , CAST (0 as TFloat) AS LimitMoney
           , CAST (0 as TFloat) AS LimitFuel
           , CAST ('' as TVarChar)  AS CarNameAll
           , CAST ('' as TVarChar)  AS CarName
           , CAST ('' as TVarChar)  AS CarModelName
           , FALSE AS isErased


    ;
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_Member (Boolean, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 14.01.16         * add Car, StartSummerDate, EndSummerDate 
                           , SummerFuel, WinterFuel, Reparation, LimitMoney, LimitFuel
 19.02.15         * add InfoMoney
 24.09.13                                        * add vbIsAllUnit
 12.09.14                                        * add isOfficial
 12.09.13                                        * add inIsShowAll
 13.12.13                                        * del Object_RoleAccessKey_View
 08.12.13                                        * add Object_RoleAccessKey_View
 01.10.13         *  add DriverCertificate, Comment             
 01.07.13         *              
*/

-- ����
-- SELECT * FROM gpSelect_Object_Member (FALSE, zfCalc_UserAdmin()) order by 3
-- SELECT * FROM gpSelect_Object_Member (TRUE, zfCalc_UserAdmin())  order by 3