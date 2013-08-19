-- Function: lfGet_Object_AccountByInfoMoneyDestination (Integer, Integer, Integer)

-- DROP FUNCTION lfGet_Object_AccountByInfoMoneyDestination (Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lfGet_Object_AccountByInfoMoneyDestination(IN inAccountGroupId Integer, IN inAccountDirectionId Integer, IN inInfoMoneyDestinationId Integer)

RETURNS Integer
AS
$BODY$
BEGIN

     -- �������� ������ ��� ����������� ������ (�� ����� ���� ��� ��� �����������)
     RETURN ( 
       SELECT 
            Object_Account.Id           
       FROM Object AS Object_Account
                 JOIN ObjectLink AS ObjectLink_Account_AccountGroup
                                 ON ObjectLink_Account_AccountGroup.ObjectId = Object_Account.Id 
                                AND ObjectLink_Account_AccountGroup.DescId = zc_ObjectLink_Account_AccountGroup()

                 JOIN ObjectLink AS ObjectLink_Account_AccountDirection
                                 ON ObjectLink_Account_AccountDirection.ObjectId = Object_Account.Id 
                                AND ObjectLink_Account_AccountDirection.DescId = zc_ObjectLink_Account_AccountDirection()

                 JOIN ObjectLink AS ObjectLink_Account_InfoMoneyDestination
                                 ON ObjectLink_Account_InfoMoneyDestination.ObjectId = Object_Account.Id
                                AND ObjectLink_Account_InfoMoneyDestination.DescId = zc_ObjectLink_Account_InfoMoneyDestination()

       WHERE ObjectLink_Account_AccountGroup.ChildObjectId = inAccountGroupId AND ObjectLink_Account_AccountDirection.ChildObjectId = inAccountDirectionId 
         AND ObjectLink_Account_InfoMoneyDestination.ChildObjectId = inInfoMoneyDestinationId AND Object_Account.DescId = zc_Object_Account());

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION lfGet_Object_AccountByInfoMoneyDestination (Integer, Integer, Integer) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 13.08.13                        *
*/

-- ����
-- SELECT * FROM lfGet_Object_AccountByInfoMoneyDestination ()
