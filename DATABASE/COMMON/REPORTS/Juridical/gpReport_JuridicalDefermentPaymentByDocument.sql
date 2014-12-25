-- Function: gpReport_JuridicalSold()

DROP FUNCTION IF EXISTS gpReport_JuridicalDefermentPaymentByDocument (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, TFloat, TVarChar);
DROP FUNCTION IF EXISTS gpReport_JuridicalDefermentPaymentByDocument (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_JuridicalDefermentPaymentByDocument(
    IN inOperDate         TDateTime , -- 
    IN inContractDate     TDateTime , -- 
    IN inJuridicalId      Integer   ,
    IN inAccountId        Integer   , --
    IN inContractId       Integer   , --
    IN inPaidKindId       Integer   , --
    IN inBranchId         Integer   , --
    IN inPeriodCount      Integer   , --
    IN inSumm             TFloat    , 
    IN inSession          TVarChar    -- ������ ������������
)
RETURNS TABLE (Id Integer, OperDate TDateTime, InvNumber TVarChar, TotalSumm TFloat, FromName TVarChar, ToName TVarChar, ContractNumber TVarChar, ContractTagName TVarChar, PaidKindName TVarChar)
AS
$BODY$
   DECLARE vbLenght Integer;
   DECLARE vbOperDate TDateTime;
   DECLARE vbNextOperDate TDateTime;
   DECLARE vbOperSumm TFloat;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Report_Fuel());

     -- �������� ������� �� ���� �� ��. ����� � ������� ���������. 
     -- ��� �� �������� ������� � �������� �� ������ 
  vbLenght := 7;

  -- !!!����� ������ �� �� �������� � �� "�����"!!!
  CREATE TEMP TABLE _tmpContract (ContractId Integer) ON COMMIT DROP; 
  INSERT INTO _tmpContract (ContractId)
      SELECT COALESCE (View_Contract_ContractKey_find.ContractId, View_Contract_ContractKey.ContractId) AS ContractId
      FROM Object_Contract_ContractKey_View AS View_Contract_ContractKey
           LEFT JOIN Object_Contract_ContractKey_View AS View_Contract_ContractKey_find ON View_Contract_ContractKey_find.ContractKeyId = View_Contract_ContractKey.ContractKeyId
      WHERE View_Contract_ContractKey.ContractId = inContractId;


  IF inPeriodCount < 5 THEN

    RETURN QUERY  
        SELECT 
              Movement.Id
            , Movement.OperDate
            , Movement.InvNumber
            , MovementFloat_TotalSumm.ValueData  AS TotalSumm
            , Object_From.ValueData AS FromName
            , Object_To.ValueData   AS ToName
            , View_Contract_InvNumber.InvNumber AS ContractNumber
            , View_Contract_InvNumber.ContractTagName
            , Object_PaidKind.ValueData  AS PaidKindName
         FROM (SELECT zc_Movement_Sale() AS DescId, zc_MovementLinkObject_Contract() AS DescId_Contract, zc_MovementLinkObject_PaidKind() AS DescId_PaidKind
              UNION ALL
               SELECT zc_Movement_TransferDebtOut() AS DescId, zc_MovementLinkObject_ContractTo() AS DescId_Contract, zc_MovementLinkObject_PaidKindTo() AS DescId_PaidKind
              ) AS tmpDesc
              INNER JOIN Movement ON Movement.DescId = tmpDesc.DescId
                                 AND Movement.StatusId = zc_Enum_Status_Complete()
                                 AND Movement.OperDate >= (inContractDate::date - vbLenght * inPeriodCount)
                                 AND Movement.OperDate < (inContractDate::date - vbLenght * (inPeriodCount - 1))
              INNER JOIN MovementLinkObject AS MovementLinkObject_To
                                            ON MovementLinkObject_To.MovementId = Movement.Id
                                           AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
              LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                           ON MovementLinkObject_Partner.MovementId = Movement.Id
                                          AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
              LEFT JOIN Object AS Object_To ON Object_To.Id = COALESCE (MovementLinkObject_Partner.ObjectId, MovementLinkObject_To.ObjectId)
              LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                   ON ObjectLink_Partner_Juridical.ObjectId = MovementLinkObject_To.ObjectId
                                  AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()

              LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                           ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                          AND MovementLinkObject_PaidKind.DescId = tmpDesc.DescId_PaidKind
              LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = MovementLinkObject_PaidKind.ObjectId

              LEFT JOIN MovementLinkObject AS MovementLinkObject_Branch
                                           ON MovementLinkObject_Branch.MovementId = Movement.Id
                                          AND MovementLinkObject_Branch.DescId = zc_MovementLinkObject_Branch()

              LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                           ON MovementLinkObject_Contract.MovementId = Movement.Id
                                          AND MovementLinkObject_Contract.DescId = tmpDesc.DescId_Contract
              -- !!!���������� ��������!!!
              LEFT JOIN _tmpContract ON _tmpContract.ContractId = MovementLinkObject_Contract.ObjectId
              LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = MovementLinkObject_Contract.ObjectId

              LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                           ON MovementLinkObject_From.MovementId = Movement.Id
                                          AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
              LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

              LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                      ON MovementFloat_TotalSumm.MovementId = Movement.Id
                                     AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()

        WHERE (_tmpContract.ContractId > 0 OR inContractId = 0)
          AND (MovementLinkObject_PaidKind.ObjectId = inPaidKindId OR inPaidKindId = 0)
          AND (MovementLinkObject_Branch.ObjectId = inBranchId OR inBranchId = 0)
          AND COALESCE (ObjectLink_Partner_Juridical.ChildObjectId, MovementLinkObject_To.ObjectId) = inJuridicalId
    ORDER BY OperDate;
    
    ELSE
      vbOperDate := (inContractDate::DATE) - vbLenght * 4;
      vbNextOperDate := vbOperDate;
      vbOperSumm := 0;
      
      -- ���������� ��������� �� ����
      CREATE TEMP TABLE _tempMovement (Id Integer, DescId_Contract Integer, DescId_PaidKind Integer, Summ TFloat) ON COMMIT DROP; 
      
      -- ���� ����� ��������� ������ �������
      WHILE (vbOperSumm < inSumm) AND NOT (vbNextOperDate IS NULL) LOOP
         -- ����� ����
         SELECT MAX (Movement.OperDate) INTO vbNextOperDate
         FROM (SELECT zc_Movement_Sale() AS DescId, zc_MovementLinkObject_Contract() AS DescId_Contract, zc_MovementLinkObject_PaidKind() AS DescId_PaidKind
              UNION ALL
               SELECT zc_Movement_TransferDebtOut() AS DescId, zc_MovementLinkObject_ContractTo() AS DescId_Contract, zc_MovementLinkObject_PaidKindTo() AS DescId_PaidKind
              ) AS tmpDesc
              INNER JOIN Movement ON Movement.DescId = tmpDesc.DescId
                                 AND Movement.StatusId = zc_Enum_Status_Complete()
                                 AND Movement.OperDate < vbOperDate 
              INNER JOIN MovementLinkObject AS MovementLinkObject_To
                                            ON MovementLinkObject_To.MovementId = Movement.Id
                                           AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
              LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                   ON ObjectLink_Partner_Juridical.ObjectId = MovementLinkObject_To.ObjectId
                                  AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
              LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                           ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                          AND MovementLinkObject_PaidKind.DescId = tmpDesc.DescId_PaidKind
              LEFT JOIN MovementLinkObject AS MovementLinkObject_Branch
                                           ON MovementLinkObject_Branch.MovementId = Movement.Id
                                          AND MovementLinkObject_Branch.DescId = zc_MovementLinkObject_Branch()
              LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                           ON MovementLinkObject_Contract.MovementId = Movement.Id
                                          AND MovementLinkObject_Contract.DescId = tmpDesc.DescId_Contract
              -- !!!���������� ��������!!!
              LEFT JOIN _tmpContract ON _tmpContract.ContractId = MovementLinkObject_Contract.ObjectId

      	 WHERE (_tmpContract.ContractId > 0 OR inContractId = 0)
           AND (MovementLinkObject_PaidKind.ObjectId = inPaidKindId OR inPaidKindId = 0)
           AND (MovementLinkObject_Branch.ObjectId = inBranchId OR inBranchId = 0)
      	   AND COALESCE (ObjectLink_Partner_Juridical.ChildObjectId, MovementLinkObject_To.ObjectId) = inJuridicalId;
      	 
     -- 	raise EXCEPTION 'vbNextOperDate %, % ', vbNextOperDate, vbOperDate   	 ;
      	 
         --
      	 IF vbNextOperDate IS NOT NULL
         THEN
             -- ��� ��������� �� ��������� ���� 
             INSERT INTO _tempMovement (Id, DescId_Contract, DescId_PaidKind, Summ)
      	        SELECT Movement.Id, tmpDesc.DescId_Contract, tmpDesc.DescId_PaidKind, MovementFloat_TotalSumm.ValueData
                FROM (SELECT zc_Movement_Sale() AS DescId, zc_MovementLinkObject_Contract() AS DescId_Contract, zc_MovementLinkObject_PaidKind() AS DescId_PaidKind
                     UNION ALL
                      SELECT zc_Movement_TransferDebtOut() AS DescId, zc_MovementLinkObject_ContractTo() AS DescId_Contract, zc_MovementLinkObject_PaidKindTo() AS DescId_PaidKind
                     ) AS tmpDesc
                     INNER JOIN Movement ON Movement.DescId = tmpDesc.DescId
                                        AND Movement.StatusId = zc_Enum_Status_Complete()
                                        AND Movement.OperDate = vbNextOperDate -- Movement.OperDate < vbOperDate AND Movement.OperDate >= vbNextOperDate

                     INNER JOIN MovementLinkObject AS MovementLinkObject_To
                                                   ON MovementLinkObject_To.MovementId = Movement.Id
                                                  AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                     LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                          ON ObjectLink_Partner_Juridical.ObjectId = MovementLinkObject_To.ObjectId
                                         AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                     LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                                  ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                                 AND MovementLinkObject_PaidKind.DescId = tmpDesc.DescId_PaidKind

                     LEFT JOIN MovementLinkObject AS MovementLinkObject_Branch
                                                  ON MovementLinkObject_Branch.MovementId = Movement.Id
                                                 AND MovementLinkObject_Branch.DescId = zc_MovementLinkObject_Branch()

                     LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                                  ON MovementLinkObject_Contract.MovementId = Movement.Id
                                                 AND MovementLinkObject_Contract.DescId = tmpDesc.DescId_Contract
                     -- !!!���������� ��������!!!
                     LEFT JOIN _tmpContract ON _tmpContract.ContractId = MovementLinkObject_Contract.ObjectId

                     LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                             ON MovementFloat_TotalSumm.MovementId =  Movement.Id
                                            AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()

                WHERE (_tmpContract.ContractId > 0 OR inContractId = 0)
                  AND (MovementLinkObject_PaidKind.ObjectId = inPaidKindId OR inPaidKindId = 0)
                  AND (MovementLinkObject_Branch.ObjectId = inBranchId OR inBranchId = 0)
                  AND COALESCE (ObjectLink_Partner_Juridical.ChildObjectId, MovementLinkObject_To.ObjectId) = inJuridicalId;

             -- ����� ������
             vbOperDate := vbNextOperDate;
      	    
      	 END IF;

         -- ����� �� ���� ��������� ����������
         SELECT COALESCE (SUM (Summ), 0) INTO vbOperSumm FROM _tempMovement;

      END LOOP;


     RETURN  QUERY  
        SELECT
              Movement.Id
            , Movement.OperDate
            , Movement.InvNumber
            , MovementFloat_TotalSumm.ValueData  AS TotalSumm
            , Object_From.ValueData AS FromName
            , Object_To.ValueData   AS ToName
            , View_Contract_InvNumber.InvNumber AS ContractNumber
            , View_Contract_InvNumber.ContractTagName
            , Object_PaidKind.ValueData  AS PaidKindName
        FROM Movement 
             INNER JOIN _tempMovement ON _tempMovement.Id = Movement.Id
             LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                          ON MovementLinkObject_From.MovementId = Movement.Id
                                         AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
             LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

             LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                          ON MovementLinkObject_To.MovementId = Movement.Id
                                         AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
             LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                          ON MovementLinkObject_Partner.MovementId = Movement.Id
                                         AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
             LEFT JOIN Object AS Object_To ON Object_To.Id = COALESCE (MovementLinkObject_Partner.ObjectId, MovementLinkObject_To.ObjectId)

             LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                          ON MovementLinkObject_Contract.MovementId = Movement.Id
                                         AND MovementLinkObject_Contract.DescId = _tempMovement.DescId_Contract
             LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = MovementLinkObject_Contract.ObjectId

             LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                          ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                         AND MovementLinkObject_PaidKind.DescId = _tempMovement.DescId_PaidKind
             LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = MovementLinkObject_PaidKind.ObjectId

             LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                     ON MovementFloat_TotalSumm.MovementId =  Movement.Id
                                    AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()
        ORDER BY Movement.OperDate;
         
    END IF;
          
          --, zc_Movement_ReturnIn()) 
    -- �����. �������� ��������� ������. 
    -- ����� �������

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpReport_JuridicalDefermentPaymentByDocument (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, TFloat, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 05.07.14                                        * add zc_Movement_TransferDebtOut
 05.05.14                                        * add inPaidKindId
 26.04.14                                        * add Object_Contract_ContractKey_View
 01.04.14                          * 
 27.03.14                          * 
 21.02.14                          * 
*/

-- ����
-- SELECT * FROM gpReport_JuridicalDefermentPaymentByDocument ('01.01.2014'::TDateTime, '01.02.2013'::TDateTime, 0, 0, 0, 0, 0, 0, inSession:= '2' :: TVarChar); 
