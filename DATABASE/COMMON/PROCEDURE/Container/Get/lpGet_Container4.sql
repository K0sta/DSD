﻿-- Function: lpget_containerid(integer, integer, integer, integer, integer)

-- DROP FUNCTION lpget_containerid(integer, integer, integer, integer, integer, integer, integer, Integer);

CREATE OR REPLACE FUNCTION lpget_containerid(incontainerdescid integer, inAccontId Integer, inobjectid1 integer, indescid1 integer, inobjectid2 integer, indescid2 integer, inobjectid3 integer, indescid3 integer)
  RETURNS integer AS
$BODY$DECLARE
  ContainerId Integer;
BEGIN
  SELECT Container.Id INTO ContainerId
  FROM Container 
  JOIN ContainerLinkObject ContainerLinkObject1
    ON ContainerLinkObject1.ObjectId = inObjectId1
   AND ContainerLinkObject1.DescId = inDescId1
   AND ContainerLinkObject1.ContainerId = Container.Id
  JOIN ContainerLinkObject ContainerLinkObject2
    ON ContainerLinkObject2.ContainerId = Container.Id
   AND ContainerLinkObject2.ObjectId = inObjectId2
   AND ContainerLinkObject2.DescId = inDescId2
  JOIN ContainerLinkObject ContainerLinkObject3
    ON ContainerLinkObject3.ContainerId = Container.Id
   AND ContainerLinkObject3.ObjectId = inObjectId3
   AND ContainerLinkObject3.DescId = inDescId3
 WHERE Container.DescId = inContainerDescId AND Container.AccountId = inAccountId;
 IF NOT FOUND THEN
    INSERT INTO Container (DescId, Amount, AccountId)
            VALUES (inContainerDescId, 0, inAccountId) RETURNING Id INTO  ContainerId;

    INSERT INTO ContainerLinkObject(DescId, ContainerId, ObjectId)
           VALUES (inDescId1, ContainerId, inObjectId1);
    INSERT INTO ContainerLinkObject(DescId, ContainerId, ObjectId)
           VALUES (inDescId2, ContainerId, inObjectId2);
    INSERT INTO ContainerLinkObject(DescId, ContainerId, ObjectId)
           VALUES (inDescId3, ContainerId, inObjectId3);
 END IF;  
 return ContainerId;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 10;
ALTER FUNCTION lpget_containerid(integer, integer, integer, integer, integer, integer, integer, integer)
  OWNER TO postgres;
