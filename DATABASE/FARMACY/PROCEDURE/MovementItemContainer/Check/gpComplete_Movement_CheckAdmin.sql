-- Function: gpComplete_Movement_IncomeAdmin()

DROP FUNCTION IF EXISTS gpComplete_Movement_CheckAdmin (Integer, TVarChar);
DROP FUNCTION IF EXISTS gpComplete_Movement_CheckAdmin (Integer,Integer, TVarChar);
DROP FUNCTION IF EXISTS gpComplete_Movement_CheckAdmin (Integer,Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_CheckAdmin(
    IN inMovementId        Integer              , -- ���� ���������
    IN inPaidType          Integer              , --��� ������ 0-������, 1-�����
    IN inCashRegisterId    Integer              , --� ��������� ��������
    IN inSession           TVarChar DEFAULT ''     -- ������ ������������
)
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
  DECLARE vbPaidTypeId Integer;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    --vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Complete_Income());
    vbUserId:= inSession;
    IF NOT EXISTS(SELECT 1 
                  FROM 
                      Movement
                  WHERE
                      ID = inMovementId
                      AND
                      DescId = zc_Movement_Check()
                      AND
                      StatusId = zc_Enum_Status_Uncomplete()
                 )
    THEN
        RAISE EXCEPTION '������. �������� �� ��������, ���� �� ��������� � ��������� "�� ��������"!';
    END IF;
    --��������� ��� ������
    if inPaidType = 0 then
        PERFORM lpInsertUpdate_MovementLinkObject(zc_MovementLinkObject_PaidType(),inMovementId,zc_Enum_PaidType_Cash());
    ELSEIF inPaidType = 1 THEN
        PERFORM lpInsertUpdate_MovementLinkObject(zc_MovementLinkObject_PaidType(),inMovementId,zc_Enum_PaidType_Card());
    ELSE
        RAISE EXCEPTION '������.�� ��������� ��� ������';
    END IF;
    --��������� ����� � �������� ���������
    IF inCashRegisterId <> 0 THEN
        PERFORM lpInsertUpdate_MovementLinkObject(zc_MovementLinkObject_CashRegister(),inMovementId,inCashRegisterId);
    END IF;
    -- ����������� �������� �����
    PERFORM lpInsertUpdate_MovementFloat_TotalSumm (inMovementId);

    -- ���������� ��������
    PERFORM lpComplete_Movement_Check(inMovementId, -- ���� ���������
                                      vbUserId);    -- ������������                          
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpComplete_Movement_CheckAdmin (Integer,Integer, Integer, TVarChar) OWNER TO postgres;
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 07.08.15                                                                       *
 
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 579, inSession:= '2')
-- SELECT * FROM gpComplete_Movement_Income (inMovementId:= 579, inIsLastComplete:= FALSE, inSession:= '2')
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 579, inSession:= '2')
