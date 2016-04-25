-- Function: gpGet_Movement_Income()

DROP FUNCTION IF EXISTS gpGet_Movement_Income (Integer, TVarChar);


CREATE OR REPLACE FUNCTION gpGet_Movement_Income(
    IN inMovementId        Integer  , -- ���� ���������
    IN inSession           TVarChar   -- ������ ������������
)
RETURNS TABLE (Id Integer, InvNumber TVarChar, OperDate TDateTime, StatusCode Integer, StatusName TVarChar
             , PriceWithVAT Boolean
             , FromId Integer, FromName TVarChar
             , ToId Integer, ToName TVarChar
             , NDSKindId Integer, NDSKindName TVarChar
             , ContractId Integer, ContractName TVarChar
             , PaymentDate TDateTime
             , InvNumberBranch TVarChar, BranchDate TDateTime
             , Checked Boolean, isDocument Boolean
             , JuridicalId Integer, JuridicalName TVarChar
             , IsPay Boolean, DateLastPay TDateTime
             , Movement_OrderId Integer, Movement_OrderInvNumber TVarChar, Movement_OrderInvNumber_full TVarChar
              )
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := PERFORM lpCheckRight (inSession, zc_Enum_Process_Get_Movement_Income());
     vbUserId := inSession;

     IF COALESCE (inMovementId, 0) = 0
     THEN
     RETURN QUERY
         SELECT
               0                                                AS Id
             , CAST (NEXTVAL ('movement_Income_seq') AS TVarChar) AS InvNumber
             , CURRENT_DATE::TDateTime                          AS OperDate
             , Object_Status.Code                               AS StatusCode
             , Object_Status.Name                               AS StatusName
             , CAST (False as Boolean)                          AS PriceWithVAT
             , 0                                                AS FromId
             , CAST ('' AS TVarChar)                            AS FromName
             , 0                                                AS ToId
             , CAST ('' AS TVarChar)                            AS ToName
             , 0                                                AS NDSKindId
             , CAST ('' AS TVarChar)                            AS NDSKindName
             , 0                                                AS ContractId
             , CAST ('' AS TVarChar)                            AS ContractName
             , CURRENT_DATE::TDateTime                          AS PaymentDate
             , ''::TVarChar                                     AS InvNumberBranch
             , CURRENT_DATE::TDateTime                          AS BranchDate
             , false                                            AS Checked
             , false                                            AS isDocument  
             , 0                                                AS JuridicalId
             , CAST('' as TVarChar)                             AS JuridicalName
             , False                                            AS isPay
             , NULL::TDateTime                                  AS DateLastPay
    
             , 0                                                AS Movement_OrderId
             , CAST('' as TVarChar)                             AS Movement_OrderInvNumber
             , CAST('' as TVarChar)                             AS Movement_OrderInvNumber_full

          FROM lfGet_Object_Status(zc_Enum_Status_UnComplete()) AS Object_Status;

     ELSE

     RETURN QUERY
        WITH 
        Movement_Income AS (
                        SELECT
                             Movement_Income_View.Id
                           , Movement_Income_View.InvNumber
                           , Movement_Income_View.OperDate
                           , Movement_Income_View.StatusCode
                           , Movement_Income_View.StatusName
                           , Movement_Income_View.PriceWithVAT
                           , Movement_Income_View.FromId
                           , Movement_Income_View.FromName
                           , Movement_Income_View.ToId
                           , Movement_Income_View.ToName
                           , Movement_Income_View.NDSKindId
                           , Movement_Income_View.NDSKindName
                           , Movement_Income_View.ContractId
                           , Movement_Income_View.ContractName
                           , CASE WHEN Movement_Income_View.PaySumm > 0.01 
                                    OR Movement_Income_View.StatusId <> zc_Enum_Status_Complete() 
                                  THEN Movement_Income_View.PaymentDate 
                             END::TDateTime AS PaymentDate
                           , Movement_Income_View.InvNumberBranch
                           , Movement_Income_View.BranchDate
                           , COALESCE(Movement_Income_View.Checked, false)    AS Checked
                           , COALESCE(Movement_Income_View.isDocument, false) AS isDocument
                           , Movement_Income_View.JuridicalId
                           , Movement_Income_View.JuridicalName
                           , CASE WHEN Movement_Income_View.PaySumm <= 0.01 then TRUE ELSE FALSE END AS isPay
                           , Movement_Income_View.PaymentContainerId
                           , MLM_Order.MovementChildId          AS Movement_OrderId
                        FROM Movement_Income_View
                           LEFT JOIN MovementLinkMovement AS MLM_Order
                                                          ON MLM_Order.MovementId = Movement_Income_View.Id
                                                         AND MLM_Order.DescId = zc_MovementLinkMovement_Order()

                        WHERE Movement_Income_View.Id = inMovementId
                    )
        SELECT 
            Movement_Income.Id
          , Movement_Income.InvNumber
          , Movement_Income.OperDate
          , Movement_Income.StatusCode
          , Movement_Income.StatusName
          , Movement_Income.PriceWithVAT
          , Movement_Income.FromId
          , Movement_Income.FromName
          , Movement_Income.ToId
          , Movement_Income.ToName
          , Movement_Income.NDSKindId
          , Movement_Income.NDSKindName
          , Movement_Income.ContractId
          , Movement_Income.ContractName
          , Movement_Income.PaymentDate
          , Movement_Income.InvNumberBranch
          , Movement_Income.BranchDate
          , Movement_Income.Checked
          , Movement_Income.isDocument
          , Movement_Income.JuridicalId
          , Movement_Income.JuridicalName
          , Movement_Income.isPay
          , MAX(MovementItemContainer.OperDate)::TDateTime AS LastDatePay

          , Movement_Order.Id                              AS Movement_OrderId
          , Movement_Order.InvNumber                       AS Movement_OrderInvNumber
          , ('� ' || Movement_Order.InvNumber ||' �� '||TO_CHAR(Movement_Order.OperDate , 'DD.MM.YYYY') ) :: TVarChar AS Movement_OrderInvNumber_full

        FROM Movement_Income
             LEFT JOIN Movement AS Movement_Order ON Movement_Order.Id = Movement_Income.Movement_OrderId
             LEFT OUTER JOIN MovementItemContainer ON MovementItemContainer.ContainerId = Movement_Income.PaymentContainerId
                                                  AND MovementItemContainer.MovementDescId in (zc_Movement_BankAccount(), zc_Movement_Payment())
        GROUP BY
            Movement_Income.Id
          , Movement_Income.InvNumber
          , Movement_Income.OperDate
          , Movement_Income.StatusCode
          , Movement_Income.StatusName
          , Movement_Income.PriceWithVAT
          , Movement_Income.FromId
          , Movement_Income.FromName
          , Movement_Income.ToId
          , Movement_Income.ToName
          , Movement_Income.NDSKindId
          , Movement_Income.NDSKindName
          , Movement_Income.ContractId
          , Movement_Income.ContractName
          , Movement_Income.PaymentDate
          , Movement_Income.InvNumberBranch
          , Movement_Income.BranchDate
          , Movement_Income.Checked
          , Movement_Income.isDocument
          , Movement_Income.JuridicalId
          , Movement_Income.JuridicalName
          , Movement_Income.isPay
          , Movement_Order.InvNumber
          , Movement_Order.Id  ;
    END IF;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpGet_Movement_Income (Integer, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 22.04.16         *
 30.01.16         *
 21.12.15                                                                       *
 07.12.15                                                                       *
 21.05.15                         *
 03.07.14                                                        *
*/

-- ����
-- SELECT * FROM gpGet_Movement_Income (inMovementId:= 1, inSession:= '9818')