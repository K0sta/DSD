-- Function: gpSelect_MI_ReestrReturnUser()

DROP FUNCTION IF EXISTS gpSelect_MI_ReestrReturnUser(TDateTime, TDateTime, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MI_ReestrReturnUser(
    IN inStartDate          TDateTime , 
    IN inEndDate            TDateTime , 
    IN inReestrKindId       Integer   ,
    IN inSession            TVarChar    -- ������ ������������
)
RETURNS TABLE ( Id Integer, MovementId Integer, LineNum Integer
              , StatusCode Integer, StatusName TVarChar
              , OperDate TDateTime, InvNumber TVarChar
              , UpdateName TVarChar, UpdateDate TDateTime
              , Date_Insert TDateTime, MemberName_Insert TVarChar
              , Date_RemakeBuh TDateTime, Date_Buh TDateTime
              , Member_RemakeBuh TVarChar, Member_Buh TVarChar
              , BarCode_ReturnIn TVarChar, OperDate_ReturnIn TDateTime, InvNumber_ReturnIn TVarChar
              , OperDatePartner TDateTime, InvNumberPartner TVarChar, StatusCode_ReturnIn Integer, StatusName_ReturnIn TVarChar
              , TotalCountKg TFloat, TotalSumm TFloat
              , FromName TVarChar, ToName TVarChar
              , PaidKindName TVarChar
              , ContractCode Integer, ContractName TVarChar, ContractTagName TVarChar
              , JuridicalName_To TVarChar, OKPO_To TVarChar 
              , ReestrKindName TVarChar
               )
AS
$BODY$
   DECLARE vbUserId Integer;

   DECLARE vbMemberId_user  Integer;
   DECLARE vbDateDescId     Integer;
   DECLARE vbMILinkObjectId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpGetUserBySession (inSession);


     -- ������������
     vbDateDescId := (SELECT CASE WHEN inReestrKindId = zc_Enum_ReestrKind_RemakeBuh() THEN zc_MIDate_RemakeBuh()
                                  WHEN inReestrKindId = zc_Enum_ReestrKind_Buh()       THEN zc_MIDate_Buh()
                             END AS DateDescId
                      );
     -- ������������
     vbMILinkObjectId := (SELECT CASE WHEN inReestrKindId = zc_Enum_ReestrKind_RemakeBuh() THEN zc_MILinkObject_RemakeBuh()
                                      WHEN inReestrKindId = zc_Enum_ReestrKind_Buh()       THEN zc_MILinkObject_Buh()
                                 END AS MILinkObjectId
                      );

     -- ������������ <���������� ����> - ��� ����������� ���� inReestrKindId
     vbMemberId_user:= CASE WHEN vbUserId = 5 THEN 9457 ELSE
                       (SELECT ObjectLink_User_Member.ChildObjectId
                        FROM ObjectLink AS ObjectLink_User_Member
                        WHERE ObjectLink_User_Member.DescId = zc_ObjectLink_User_Member()
                          AND ObjectLink_User_Member.ObjectId = vbUserId)
                       END
                      ;
     -- ��������
     IF COALESCE (vbMemberId_user, 0) = 0
     THEN 
          RAISE EXCEPTION '������.� ������������ <%> �� ��������� �������� <���.����>.', lfGet_Object_ValueData (vbUserId);
     END IF;


     -- ���������
     RETURN QUERY
     WITH
         -- �������� ����� ������� - ��� ������ ������������
         tmpMI AS (SELECT MIDate.MovementItemId 
                        , MovementFloat_MovementItemId.MovementId AS MovementId_ReturnIn
                   FROM MovementItemDate AS MIDate
                        INNER JOIN MovementItemLinkObject AS MILinkObject_RemakeBuh
                                                          ON MILinkObject_RemakeBuh.MovementItemId = MIDate.MovementItemId
                                                         AND MILinkObject_RemakeBuh.DescId         = vbMILinkObjectId 
                                                         AND MILinkObject_RemakeBuh.ObjectId       = vbMemberId_user 
                        LEFT JOIN MovementFloat AS MovementFloat_MovementItemId
                                                ON MovementFloat_MovementItemId.ValueData = MIDate.MovementItemId  
                                               AND MovementFloat_MovementItemId.DescId    = zc_MovementFloat_MovementItemId()
                   WHERE MIDate.DescId = vbDateDescId 
                     AND MIDate.ValueData >= inStartDate AND MIDate.ValueData < inEndDate + INTERVAL '1 DAY'
                   )
       -- ���������
       SELECT MovementItem.Id
            , MovementItem.MovementId           AS MovementId
            , CAST (ROW_NUMBER() OVER (ORDER BY MovementItem.Id) AS Integer) AS LineNum
            , Object_Status.ObjectCode          AS StatusCode
            , Object_Status.ValueData           AS StatusName
            , Movement_Reestr.OperDate                  AS OperDate
            , Movement_Reestr.InvNumber                 AS InvNumber
           
            , Object_Update.ValueData           AS UpdateName
            , MovementDate_Update.ValueData     AS UpdateDate

            , MIDate_Insert.ValueData                   AS Date_Insert
            , Object_Member.ValueData                   AS MemberName_Insert

            , MIDate_RemakeBuh.ValueData                AS Date_RemakeBuh
            , MIDate_Buh.ValueData                      AS Date_Buh
            , Object_RemakeBuh.ValueData                AS Member_RemakeBuh
            , Object_Buh.ValueData                      AS Member_Buh

            , zfFormat_BarCode (zc_BarCodePref_Movement(), Movement_ReturnIn.Id) AS BarCode_ReturnIn
            , Movement_ReturnIn.OperDate                AS OperDate_ReturnIn
            , Movement_ReturnIn.InvNumber               AS InvNumber_ReturnIn
            , MovementDate_OperDatePartner.ValueData    AS OperDatePartner
            , MovementString_InvNumberPartner.ValueData AS InvNumberPartner
            , Object_Status_ReturnIn.ObjectCode         AS StatusCode_ReturnIn
            , Object_Status_ReturnIn.ValueData          AS StatusName_ReturnIn
    
            , MovementFloat_TotalCountKg.ValueData      AS TotalCountKg
            , MovementFloat_TotalSumm.ValueData         AS TotalSumm

            , Object_From.ValueData                     AS FromName
            , Object_To.ValueData                       AS ToName   
            , Object_PaidKind.ValueData                 AS PaidKindName
            , View_Contract_InvNumber.ContractCode      AS ContractCode
            , View_Contract_InvNumber.InvNumber         AS ContractName
            , View_Contract_InvNumber.ContractTagName
            , Object_JuridicalTo.ValueData              AS JuridicalName_To
            , ObjectHistory_JuridicalDetails_View.OKPO  AS OKPO_To

            , Object_ReestrKind.ValueData               AS ReestrKindName    

       FROM tmpMI
            LEFT JOIN MovementItem ON MovementItem.Id = tmpMI.MovementItemId
            LEFT JOIN Object AS Object_Member ON Object_Member.Id = MovementItem.ObjectId
            LEFT JOIN Movement AS Movement_Reestr ON Movement_Reestr.Id = MovementItem.MovementId
            LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement_Reestr.StatusId
            
            LEFT JOIN MovementDate AS MovementDate_Update
                                   ON MovementDate_Update.MovementId = Movement_Reestr.Id
                                  AND MovementDate_Update.DescId = zc_MovementDate_Update()
            LEFT JOIN MovementLinkObject AS MLO_Update
                                         ON MLO_Update.MovementId = Movement_Reestr.Id
                                        AND MLO_Update.DescId = zc_MovementLinkObject_Update()
            LEFT JOIN Object AS Object_Update ON Object_Update.Id = MLO_Update.ObjectId  

            LEFT JOIN MovementItemDate AS MIDate_Insert
                                       ON MIDate_Insert.MovementItemId = MovementItem.Id
                                      AND MIDate_Insert.DescId = zc_MIDate_Insert()
            --
            LEFT JOIN MovementItemDate AS MIDate_RemakeBuh
                                       ON MIDate_RemakeBuh.MovementItemId = MovementItem.Id
                                      AND MIDate_RemakeBuh.DescId = zc_MIDate_RemakeBuh()
            LEFT JOIN MovementItemDate AS MIDate_Buh
                                       ON MIDate_Buh.MovementItemId = MovementItem.Id
                                      AND MIDate_Buh.DescId = zc_MIDate_Buh()

            LEFT JOIN MovementItemLinkObject AS MILinkObject_RemakeBuh
                                             ON MILinkObject_RemakeBuh.MovementItemId = MovementItem.Id
                                            AND MILinkObject_RemakeBuh.DescId = zc_MILinkObject_RemakeBuh()
            LEFT JOIN Object AS Object_RemakeBuh ON Object_RemakeBuh.Id = MILinkObject_RemakeBuh.ObjectId

            LEFT JOIN MovementItemLinkObject AS MILinkObject_Buh
                                             ON MILinkObject_Buh.MovementItemId = MovementItem.Id
                                            AND MILinkObject_Buh.DescId = zc_MILinkObject_Buh()
            LEFT JOIN Object AS Object_Buh ON Object_Buh.Id = MILinkObject_Buh.ObjectId

            --
            LEFT JOIN Movement AS Movement_ReturnIn ON Movement_ReturnIn.id = tmpMI.MovementId_ReturnIn  -- ���. ��������
            LEFT JOIN Object AS Object_Status_ReturnIn ON Object_Status_ReturnIn.Id = Movement_ReturnIn.StatusId
            LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                   ON MovementDate_OperDatePartner.MovementId = Movement_ReturnIn.Id
                                  AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
            LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                     ON MovementString_InvNumberPartner.MovementId = Movement_ReturnIn.Id
                                    AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()

            LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                    ON MovementFloat_TotalSumm.MovementId = Movement_ReturnIn.Id
                                   AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()
            LEFT JOIN MovementFloat AS MovementFloat_TotalCountKg
                                    ON MovementFloat_TotalCountKg.MovementId = Movement_ReturnIn.Id
                                   AND MovementFloat_TotalCountKg.DescId = zc_MovementFloat_TotalCountKg()

            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement_ReturnIn.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId
            
            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement_ReturnIn.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                 ON ObjectLink_Partner_Juridical.ObjectId = Object_From.Id
                                AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
            LEFT JOIN Object AS Object_JuridicalTo ON Object_JuridicalTo.Id = ObjectLink_Partner_Juridical.ChildObjectId
            LEFT JOIN ObjectHistory_JuridicalDetails_View ON ObjectHistory_JuridicalDetails_View.JuridicalId = Object_JuridicalTo.Id
           
            LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                         ON MovementLinkObject_PaidKind.MovementId = Movement_ReturnIn.Id
                                        AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
            LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = MovementLinkObject_PaidKind.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = Movement_ReturnIn.Id
                                        AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
            LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = MovementLinkObject_Contract.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_ReestrKind
                                         ON MovementLinkObject_ReestrKind.MovementId = Movement_ReturnIn.Id
                                        AND MovementLinkObject_ReestrKind.DescId = zc_MovementLinkObject_ReestrKind()
            LEFT JOIN Object AS Object_ReestrKind ON Object_ReestrKind.Id = MovementLinkObject_ReestrKind.ObjectId
           ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 12.03.17         *
*/

-- ����
-- SELECT * FROM gpSelect_MI_ReestrReturnUser (inStartDate:= '24.10.2016', inEndDate:= '24.10.2016', inReestrKindId:= 736914,  inSession := '5');