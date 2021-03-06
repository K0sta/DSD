-- Function: lpSelect_MI_PersonalService_Sign (Integer, Boolean, Boolean, TVarChar)

DROP FUNCTION IF EXISTS lpSelect_MI_PersonalService_Sign (Integer);

CREATE OR REPLACE FUNCTION lpSelect_MI_PersonalService_Sign(
    IN inMovementId  Integer       -- ���� ���������
)
RETURNS TABLE (Id             Integer
             , SignInternalId Integer
             , strSign        TVarChar -- ������������ - ����� �����������
             , strSignNo      TVarChar -- ������������ - ����� �� �����������
             , strIdSign      TVarChar -- Id ������������� - ����� �����������
             , strIdSignNo    TVarChar -- Id ������������� - ����� �� �����������
             , strMIIdSign    TVarChar -- Id MovementItem - ����� �����������
              )
AS
$BODY$
  DECLARE vbMovementDescId Integer;
BEGIN
   
     -- ��������� �� ��������� - ��� ����������� <������ ����������� �������>
     SELECT Movement.DescId  AS MovementDescId
            INTO vbMovementDescId
     FROM Movement
     WHERE Movement.Id = inMovementId;

     
     -- ���������
     RETURN QUERY 
     
     WITH -- ������ �� ������ ��� ������� ���������
          tmpObject AS (SELECT * FROM lpSelect_Object_SignInternalItem (vbMovementDescId, 0, 0))
          -- ������ �� ��� ����������� ��������� �������
        , tmpMI AS (SELECT MovementItem.Id                    AS MovementItemId
                         , MovementItem.ObjectId              AS SignInternalId
                         , MILO_Insert.ObjectId               AS UserId
                         , Object_User.ValueData              AS UserName
                    FROM MovementItem 
                       LEFT JOIN MovementItemLinkObject AS MILO_Insert
                                                        ON MILO_Insert.MovementItemId = MovementItem.Id
                                                       AND MILO_Insert.DescId = zc_MILinkObject_Insert()
                       LEFT JOIN Object AS Object_User ON Object_User.Id = MILO_Insert.ObjectId
                    WHERE MovementItem.MovementId = inMovementId
                      AND MovementItem.DescId     = zc_MI_Sign()
                      AND MovementItem.isErased   = FALSE
                      AND MovementItem.Amount <> 0
                    ORDER BY MovementItem.Amount
                   )
         -- ��� ��� ��������
       , tmpSign AS (SELECT STRING_AGG (tmpMI.UserName,                   ', ') AS strSign      -- � ��������
                          , STRING_AGG (tmpMI.UserId         :: TVarChar, ',')  AS strIdSign    -- ��� �������
                          , STRING_AGG (tmpMI.MovementItemId :: TVarChar, ',')  AS strMIIdSign  -- ��� �������
                     FROM tmpMI
                    )
         -- ��� ������� ���������
       , tmpSignNo AS (SELECT STRING_AGG (tmp.UserName,           ', ') AS strSignNo    -- � ��������
                            , STRING_AGG (tmp.UserId :: TVarChar, ',')  AS strIdSignNo  -- ��� �������
                       FROM
                      (SELECT tmpObject.UserName, tmpObject.UserId
                       FROM tmpObject
                            LEFT JOIN tmpMI ON tmpMI.UserId         = tmpObject.UserId
                                           AND tmpMI.SignInternalId = tmpObject.SignInternalId
                       WHERE tmpMI.UserId IS NULL
                       ORDER BY tmpObject.Ord
                       ) AS tmp
                       )
     -- ���������
     SELECT inMovementId                      AS Id
          , (SELECT DISTINCT tmpObject.SignInternalId FROM tmpObject) AS SignInternalId
          , tmpSign.strSign       :: TVarChar AS strSign
          , tmpSignNo.strSignNo   :: TVarChar AS strSignNo
          , tmpSign.strIdSign     :: TVarChar AS strIdSign
          , tmpSignNo.strIdSignNo :: TVarChar AS strIdSignNo
          , tmpSign.strMIIdSign   :: TVarChar AS strMIIdSign
     FROM tmpSign
          LEFT JOIN tmpSignNo ON 1=1
    ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.08.16         * 

*/

-- ����
-- SELECT * FROM lpSelect_MI_PersonalService_Sign (inMovementId:= 4136053)
