/*
  �������� 
    - ������� ObjectHistoryDesc (������ o�������)
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ObjectHistoryDesc(
   Id                    INTEGER NOT NULL PRIMARY KEY, 
   Code                  TVarChar NOT NULL UNIQUE,
   ItemName              TVarChar);


/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
13.06.02                                         
*/
