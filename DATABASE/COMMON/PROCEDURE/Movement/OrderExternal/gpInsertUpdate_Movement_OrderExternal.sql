-- Function: gpInsertUpdate_Movement_OrderExternal()

DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_OrderExternal (Integer, TVarChar, TVarChar, TDateTime, TDateTime, TFloat, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_OrderExternal(
 INOUT ioId                  Integer   , -- ���� ������� <�������� �����������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inInvNumberPartner    TVarChar  , -- ����� ������ � �����������
    IN inOperDate            TDateTime , -- ���� ���������
   OUT outOperDatePartner    TDateTime , -- ���� �������� ������ �� �����������
    IN inOperDateMark        TDateTime , -- ���� ����������
   OUT outPriceWithVAT       Boolean   , -- ���� � ��� (��/���)
   OUT outVATPercent         TFloat    , -- % ���
    IN inChangePercent       TFloat    , -- (-)% ������ (+)% �������
    IN inFromId              Integer   , -- �� ���� (� ���������)
    IN inToId                Integer   , -- ���� (� ���������)
    IN inPaidKindId          Integer   , -- ���� ���� ������
    IN inContractId          Integer   , -- ��������
    IN inRouteId             Integer   , -- �������
    IN inRouteSortingId      Integer   , -- ���������� ���������
    IN inPersonalId          Integer   , -- ��������� (����������)
 INOUT ioPriceListId         Integer   , -- ����� ����
   OUT outPriceListName      TVarChar  , -- ����� ����
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS RECORD AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_OrderExternal());

     -- ��������
     IF COALESCE (inContractId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ����������� �������� <�������>.';
     END IF;


     -- 1. ��� ��������� ������ �� �����������
     outOperDatePartner:= inOperDate + (COALESCE ((SELECT ValueData FROM ObjectFloat WHERE ObjectId = inFromId AND DescId = zc_ObjectFloat_Partner_PrepareDayCount()), 0) :: TVarChar || ' DAY') :: INTERVAL;

     -- 2. ��� ��������� ������ �� �����-����� !!!�� ���� outOperDatePartner!!!
     IF COALESCE (ioPriceListId, 0) = 0
     THEN
         SELECT PriceListId, PriceListName, PriceWithVAT, VATPercent
                INTO ioPriceListId, outPriceListName, outPriceWithVAT, outVATPercent
         FROM lfGet_Object_Partner_PriceList (inPartnerId:= inFromId, inOperDate:= outOperDatePartner);
     ELSE
         SELECT Object_PriceList.ValueData           AS PriceListName
              , ObjectBoolean_PriceWithVAT.ValueData AS PriceWithVAT
              , ObjectFloat_VATPercent.ValueData     AS VATPercent
                INTO outPriceListName, outPriceWithVAT, outVATPercent
         FROM Object AS Object_PriceList
              LEFT JOIN ObjectBoolean AS ObjectBoolean_PriceWithVAT
                                      ON ObjectBoolean_PriceWithVAT.ObjectId = Object_PriceList.Id
                                     AND ObjectBoolean_PriceWithVAT.DescId = zc_ObjectBoolean_PriceList_PriceWithVAT()
              LEFT JOIN ObjectFloat AS ObjectFloat_VATPercent
                                    ON ObjectFloat_VATPercent.ObjectId = Object_PriceList.Id
                                   AND ObjectFloat_VATPercent.DescId = zc_ObjectFloat_PriceList_VATPercent()
         WHERE Object_PriceList.Id = ioPriceListId;
     END IF;


     -- ����������
     ioId:= lpInsertUpdate_Movement_OrderExternal (ioId                  := ioId
                                                 , inInvNumber           := inInvNumber
                                                 , inInvNumberPartner    := inInvNumberPartner
                                                 , inOperDate            := inOperDate
                                                 , inOperDatePartner     := outOperDatePartner
                                                 , inOperDateMark        := inOperDateMark
                                                 , inPriceWithVAT        := outPriceWithVAT
                                                 , inVATPercent          := outVATPercent
                                                 , inChangePercent       := inChangePercent
                                                 , inFromId              := inFromId
                                                 , inToId                := inToId
                                                 , inPaidKindId          := inPaidKindId
                                                 , inContractId          := inContractId
                                                 , inRouteId             := inRouteId
                                                 , inRouteSortingId      := inRouteSortingId
                                                 , inPersonalId          := inPersonalId
                                                 , inPriceListId         := ioPriceListId
                                                 , inUserId              := vbUserId
                                                  );

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 18.08.14                                        * add lpInsertUpdate_Movement_OrderExternal
 26.08.14                                                        *
 25.08.14                                        * all
 18.08.14                                                        *
 06.06.14                                                        *
 01.08.13         *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_OrderExternal (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inOperDatePartner:= '01.01.2013', inOperDateMark:= '01.01.2013', inInvNumberPartner:= 'xxx', inFromId:= 1, inPersonalId:= 0, inRouteId:= 0, inRouteSortingId:= 0, inSession:= '2')
