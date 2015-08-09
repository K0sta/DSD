unit MainCash;

interface

uses
  DataModul, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorBase, Vcl.ActnList, dsdAction,
  cxPropertiesStore, dsdAddOn, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.ExtCtrls, cxSplitter, dsdDB, Datasnap.DBClient, cxContainer,
  cxTextEdit, cxCurrencyEdit, cxLabel, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Vcl.Menus, cxCheckBox, Vcl.StdCtrls,
  cxButtons, cxNavigator, CashInterface, IniFIles, cxImageComboBox;

type
  TMainCashForm = class(TAncestorBaseForm)
    MainGridDBTableView: TcxGridDBTableView;
    MainGridLevel: TcxGridLevel;
    MainGrid: TcxGrid;
    BottomPanel: TPanel;
    CheckGridDBTableView: TcxGridDBTableView;
    CheckGridLevel: TcxGridLevel;
    CheckGrid: TcxGrid;
    AlternativeGridDBTableView: TcxGridDBTableView;
    AlternativeGridLevel: TcxGridLevel;
    AlternativeGrid: TcxGrid;
    cxSplitter1: TcxSplitter;
    SearchPanel: TPanel;
    cxSplitter2: TcxSplitter;
    MainPanel: TPanel;
    CheckGridColCode: TcxGridDBColumn;
    CheckGridColName: TcxGridDBColumn;
    CheckGridColPrice: TcxGridDBColumn;
    CheckGridColAmount: TcxGridDBColumn;
    CheckGridColSumm: TcxGridDBColumn;
    AlternativeGridColGoodsCode: TcxGridDBColumn;
    AlternativeGridColGoodsName: TcxGridDBColumn;
    MainColCode: TcxGridDBColumn;
    MainColName: TcxGridDBColumn;
    MainColRemains: TcxGridDBColumn;
    MainColPrice: TcxGridDBColumn;
    MainColReserved: TcxGridDBColumn;
    dsdDBViewAddOnMain: TdsdDBViewAddOn;
    spSelectRemains: TdsdStoredProc;
    RemainsDS: TDataSource;
    RemainsCDS: TClientDataSet;
    ceAmount: TcxCurrencyEdit;
    cxLabel1: TcxLabel;
    lcName: TcxLookupComboBox;
    actChoiceGoodsInRemainsGrid: TAction;
    actSold: TAction;
    PopupMenu: TPopupMenu;
    actSold1: TMenuItem;
    N1: TMenuItem;
    spNewCheck: TdsdStoredProc;
    FormParams: TdsdFormParams;
    cbSpec: TcxCheckBox;
    actCheck: TdsdOpenForm;
    btnCheck: TcxButton;
    actInsertUpdateCheckItems: TAction;
    spGoodsRemains: TdsdStoredProc;
    spSelectCheck: TdsdStoredProc;
    CheckDS: TDataSource;
    CheckCDS: TClientDataSet;
    spInsertUpdateCheckItems: TdsdStoredProc;
    MainColMCSValue: TcxGridDBColumn;
    cxLabel2: TcxLabel;
    lblTotalSumm: TcxLabel;
    dsdDBViewAddOnCheck: TdsdDBViewAddOn;
    actPutCheckToCash: TAction;
    AlternativeGridColLinkType: TcxGridDBColumn;
    AlternativeCDS: TClientDataSet;
    AlternativeDS: TDataSource;
    spSelect_Alternative: TdsdStoredProc;
    dsdDBViewAddOnAlternative: TdsdDBViewAddOn;
    spComplete_Movement_Check: TdsdStoredProc;
    actSetVIP: TAction;
    VIP1: TMenuItem;
    spUpdateMovementVIP: TdsdStoredProc;
    AlternativeGridColTypeColor: TcxGridDBColumn;
    AlternativeGridDColPrice: TcxGridDBColumn;
    AlternativeGridColRemains: TcxGridDBColumn;
    actDeferrent: TAction;
    N2: TMenuItem;
    btnVIP: TcxButton;
    actOpenCheckVIP: TOpenChoiceForm;
    actLoadVIP: TMultiAction;
    btnLoadDeferred: TcxButton;
    actOpenCheckDeferred: TOpenChoiceForm;
    actLoadDeferred: TMultiAction;
    actSetTrueRemains: TAction;
    actCalcTotalSumm: TAction;
    actCashWork: TAction;
    N3: TMenuItem;
    spMovementSetErased: TdsdStoredProc;
    actClearAll: TAction;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    spGet_Object_CashRegister_By_Serial: TdsdStoredProc;
    lblMoneyInCash: TcxLabel;
    actClearMoney: TAction;
    N7: TMenuItem;
    actGetMoneyInCash: TAction;
    N8: TMenuItem;
    spGetMoneyInCash: TdsdStoredProc;
    spGet_Password_MoneyInCash: TdsdStoredProc;
    actSpec: TAction;
    N9: TMenuItem;
    spSelectRemains_Lite: TdsdStoredProc;
    Remains_LiteCDS: TClientDataSet;
    actRefreshLite: TdsdDataSetRefresh;
    spGet_User_IsAdmin: TdsdStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure actChoiceGoodsInRemainsGridExecute(Sender: TObject);
    procedure lcNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actSoldExecute(Sender: TObject);
    procedure actInsertUpdateCheckItemsExecute(Sender: TObject);
    procedure ceAmountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ceAmountExit(Sender: TObject);
    procedure actPutCheckToCashExecute(Sender: TObject);
    procedure ParentFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actSetVIPExecute(Sender: TObject);
    procedure RemainsCDSAfterScroll(DataSet: TDataSet);
    procedure actDeferrentExecute(Sender: TObject);
    procedure actSetTrueRemainsExecute(Sender: TObject);
    procedure actCalcTotalSummExecute(Sender: TObject);
    procedure MainColReservedGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure actCashWorkExecute(Sender: TObject);
    procedure actClearAllExecute(Sender: TObject);
    procedure actClearMoneyExecute(Sender: TObject);
    procedure actGetMoneyInCashExecute(Sender: TObject);
    procedure actSpecExecute(Sender: TObject);
    procedure ParentFormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FSoldRegim: boolean;
    fShift: Boolean;
    FTotalSumm: Real;
    Cash: ICash;
    SoldParallel: Boolean;
    SourceClientDataSet: TClientDataSet;
    procedure SetSoldRegim(const Value: boolean);
    // ���������� �������
    function GetGoodsPropertyRemains(GoodsId: integer): real;
    // ���������� ���-�� ����������� ������� ������� ����
    function GetGoodsAmountInCurrenyCheck(GoodsId: Integer): real;
    // ��������� ��������� ��������� ��� �������� ������ ����
    procedure NewCheck;
    // ��������� ���� ����
    procedure InsertUpdateBillCheckItems;
    // ������ ����������� ������� �� �������
    procedure UpdateQuantityInQuery(GoodsId: integer); overload;
    procedure UpdateQuantityInQuery(GoodsId: integer; Remains: Real); overload;

    // ��������� ����� �� ����
    procedure CalcTotalSumm;
    // ��������� ��� ����� ����
    function PutCheckToCash(SalerCash: real; PaidType: TPaidType): boolean;
    //  ��������� ������� �� ������� ��������
    procedure UpdateRemains;

    property SoldRegim: boolean read FSoldRegim write SetSoldRegim;
  public
    { Public declarations }
  end;

var
  MainCashForm: TMainCashForm;

implementation

{$R *.dfm}

uses CashFactory, IniUtils, CashCloseDialog, VIPDialog, CashWork, MessagesUnit;

procedure TMainCashForm.actCalcTotalSummExecute(Sender: TObject);
begin
  CalcTotalSumm;
end;

procedure TMainCashForm.actCashWorkExecute(Sender: TObject);
begin
  inherited;
  with TCashWorkForm.Create(Cash, RemainsCDS) do begin
    ShowModal;
    Free;
  end;
end;

procedure TMainCashForm.actChoiceGoodsInRemainsGridExecute(Sender: TObject);
begin
  if MainGrid.IsFocused then
  Begin
    if RemainsCDS.isempty then exit;
    if RemainsCDS.FieldByName('Remains').AsFloat>0 then begin
       SourceClientDataSet := RemainsCDS;
       SoldRegim := true;
       lcName.Text := RemainsCDS.FieldByName('GoodsName').asString;
       ceAmount.Enabled := true;
       ceAmount.Value := 1;
       ActiveControl := ceAmount;
    end
  end
  else
  if AlternativeGrid.IsFocused then
  Begin
    if AlternativeCDS.isempty then exit;
    if AlternativeCDS.FieldByName('Remains').AsFloat>0 then begin
       SourceClientDataSet := AlternativeCDS;
       SoldRegim := true;
       lcName.Text := AlternativeCDS.FieldByName('GoodsName').asString;
       ceAmount.Enabled := true;
       ceAmount.Value := 1;
       ActiveControl := ceAmount;
    end
  End
  else
  Begin
    if CheckCDS.isEmpty then exit;
    if CheckCDS.FieldByName('Amount').AsFloat>0 then begin
       SourceClientDataSet := CheckCDS;
       SoldRegim := False;
       lcName.Text := CheckCDS.FieldByName('GoodsName').asString;
       ceAmount.Enabled := true;
       ceAmount.Value := -1;
       ActiveControl := ceAmount;
    end;
  End;
end;

procedure TMainCashForm.actClearAllExecute(Sender: TObject);
begin
  if CheckCDS.IsEmpty then exit;
  if MessageDlg('�������� ���?',mtConfirmation,mbYesNo,0)<>mrYes then exit;
  spMovementSetErased.Execute;
  NewCheck;
end;

procedure TMainCashForm.actClearMoneyExecute(Sender: TObject);
begin
  lblMoneyInCash.Caption := '0.00';
end;

procedure TMainCashForm.actDeferrentExecute(Sender: TObject);
begin
  if MessageDlg('�������� ��� ����������?',mtConfirmation,mbYesNo,0)<>mrYes then exit;
  With spUpdateMovementVIP do
  Begin
    ParamByName('inManagerId').Value := 0;
    ParamByName('inBayerName').Value := '';
    execute;
  End;
  NewCheck;
end;

procedure TMainCashForm.actGetMoneyInCashExecute(Sender: TObject);
begin
  spGet_Password_MoneyInCash.Execute;
  if InputBox('������','������� ������:','') <> spGet_Password_MoneyInCash.ParamByName('outPassword').AsString then exit;
  spGetMoneyInCash.ParamByName('inDate').Value := Date;
  spGetMoneyInCash.Execute;
  lblMoneyInCash.Caption := FormatFloat(',0.00',spGetMoneyInCash.ParamByName('outTotalSumm').AsFloat);
end;

procedure TMainCashForm.actInsertUpdateCheckItemsExecute(Sender: TObject);
begin
  if ceAmount.Value <> 0 then begin //���� ��������� ���-�� 0 �� ������ ��������� � ���������� ����
    if not Assigned(SourceClientDataSet) then
      SourceClientDataSet := RemainsCDS;

    if SoldRegim AND (SourceClientDataSet.FieldByName('Price').AsFloat = 0) then begin
       ShowMessage('������ ������� ����� � 0 �����! ��������� � ����������');
       exit;
    end;
    InsertUpdateBillCheckItems;
  end;
  SoldRegim := true;
  ActiveControl := lcName;
end;

procedure TMainCashForm.actPutCheckToCashExecute(Sender: TObject);
var ASalerCash{,ASdacha}: real;
    PaidType: TPaidType;
begin
  PaidType:=ptMoney;
  if (CheckCDS.RecordCount>0) then
  begin
    if not fShift then
    begin// ���� � Shift, �� �������, ��� ���� ��� �����
      if not CashCloseDialogExecute(FTotalSumm,ASalerCash,PaidType) then
      Begin
        if Self.ActiveControl <> ceAmount then
          Self.ActiveControl := MainGrid;
        exit;
      End;
    end
    else
    begin
      ASalerCash:=FTotalSumm;
//      ASdacha:=0;
    end;
//    rlGiveSaler.Caption:=FormatFloat(_fmtBookKeeper,ASalerCash);
//    rlSdacha.Caption:=FormatFloat(_fmtBookKeeper,ASdacha);
    // �������� ��� ����� ����
    if PutCheckToCash(ASalerCash, PaidType) then
    begin
      //������� �������� ��������� ��������
      if not Cash.AlwaysSold then
      Begin
        spGet_Object_CashRegister_By_Serial.ParamByName('inSerial').Value := Cash.FiscalNumber;
        spGet_Object_CashRegister_By_Serial.Execute;
        spComplete_Movement_Check.ParamByName('inCashRegisterId').Value := spGet_Object_CashRegister_By_Serial.ParamByName('outId').Value
      End
      else
        spComplete_Movement_Check.ParamByName('inCashRegisterId').Value := 0;
    // �������� ���
      spComplete_Movement_Check.ParamByName('inPaidType').Value := Integer(PaidType);
      spComplete_Movement_Check.Execute;
       NewCheck;// ��������� ��������� ��������� ��� �������� ������ ����
    end;
  end;
end;

procedure TMainCashForm.actSetTrueRemainsExecute(Sender: TObject);
var
  ExecuteGoodsRemains: Boolean;
begin
  CheckCDS.DisableControls;
  RemainsCDS.DisableControls;
  RemainsCDS.AfterScroll := nil;
  AlternativeCDS.DisableControls;
  AlternativeCDS.Filtered := False;
  try
    CheckCDS.First;
    while Not CheckCDS.EOF do
    Begin
      ExecuteGoodsRemains:=False;
      if RemainsCDS.Locate('Id',CheckCDS.FieldByName('GoodsId').asInteger,[]) then
      Begin
        spGoodsRemains.ParamByName('inGoodsId').Value := CheckCDS.FieldByName('GoodsId').asInteger;
        spGoodsRemains.Execute;
        ExecuteGoodsRemains := True;
        RemainsCDS.Edit;
        RemainsCDS.FieldByName('Remains').AsFloat := spGoodsRemains.ParamByName('outRemains').asFloat - CheckCDS.FieldByName('Amount').AsFloat;
        RemainsCDS.Post;
      End;
      AlternativeCDS.Filter := 'Id = '+CheckCDS.FieldByName('GoodsId').asString;
      AlternativeCDS.Filtered := True;
      AlternativeCDS.First;
      while Not AlternativeCDS.eof do
      Begin
        if not ExecuteGoodsRemains then
        Begin
          spGoodsRemains.ParamByName('inGoodsId').Value := CheckCDS.FieldByName('GoodsId').asInteger;
          spGoodsRemains.Execute;
          ExecuteGoodsRemains := True;
        End;
        AlternativeCDS.Edit;
        AlternativeCDS.FieldByName('Remains').AsFloat := spGoodsRemains.ParamByName('outRemains').asFloat - CheckCDS.FieldByName('Amount').AsFloat;
        AlternativeCDS.Post;
        AlternativeCDS.Next;
      End;
      CheckCDS.Next;
    end;
  finally
    CheckCDS.EnableControls;
    RemainsCDS.EnableControls;
    RemainsCDS.AfterScroll := RemainsCDSAfterScroll;
    RemainsCDSAfterScroll(RemainsCDS);
    AlternativeCDS.filtered := True;
    AlternativeCDS.EnableControls;
  end;
end;

procedure TMainCashForm.actSetVIPExecute(Sender: TObject);
var
  ManagerID:Integer;
  BayerName: String;
begin
  If Not VIPDialogExecute(ManagerID,BayerName) then exit;
  With spUpdateMovementVIP do
  Begin
    ParamByName('inManagerId').Value := ManagerId;
    ParamByName('inBayerName').Value := BayerName;
    execute;
  End;
  NewCheck;
end;

procedure TMainCashForm.actSoldExecute(Sender: TObject);
begin
  SoldRegim:= not SoldRegim;
  ceAmount.Enabled := false;
  lcName.Text := '';
  Activecontrol := lcName;
end;

procedure TMainCashForm.actSpecExecute(Sender: TObject);
begin
  Cash.AlwaysSold := actSpec.Checked;
end;

procedure TMainCashForm.ceAmountExit(Sender: TObject);
begin
  ceAmount.Enabled := false;
  lcName.Text := '';
end;

procedure TMainCashForm.ceAmountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then
     actInsertUpdateCheckItems.Execute
end;

procedure TMainCashForm.FormCreate(Sender: TObject);
var
  F: String;
begin
  inherited;
  if NOT GetIniFile(F) then
  Begin
    Application.Terminate;
    exit;
  End;
  UserSettingsStorageAddOn.LoadUserSettings;
  try
    Cash:=TCashFactory.GetCash(iniCashType);
  except
    Begin
      ShowMessage('��������! ��������� �� ����� ����������� � ����������� ��������.'+#13+
                  '���������� ������ ��������� �������� ������ � ������������ ������!');
    End;
  end;
  spGet_User_IsAdmin.Execute;
  if spGet_User_IsAdmin.ParamByName('gpGet_User_IsAdmin').Value = True then
    actCheck.FormNameParam.Value := 'TCheckJournalForm'
  Else
    actCheck.FormNameParam.Value := 'TCheckJournalUserForm';

  SoldParallel:=iniSoldParallel;
  NewCheck;
  OnCLoseQuery := ParentFormCloseQuery;
end;

function TMainCashForm.GetGoodsPropertyRemains(GoodsId: integer): real;
begin
  spGoodsRemains.ParamByName('inGoodsId').Value := GoodsId;
  spGoodsRemains.Execute;
  result := spGoodsRemains.ParamByName('outRemains').asFloat - GetGoodsAmountInCurrenyCheck(GoodsId);
end;

function TMainCashForm.GetGoodsAmountInCurrenyCheck(GoodsId: Integer): real;
var
  B:TBookmark;
Begin
  Result := 0;
  WITH CheckCDS DO
  Begin
    if IsEmpty then
      exit;
    B:= GetBookmark;
    DisableControls;
    try
      First;
      while Not Eof do
      Begin
        if (FieldByName('goodsid').asInteger = goodsid) then
          Result := Result + FieldByName('amount').AsFloat;
        Next;
      End;
      GotoBookmark(B);
      FreeBookmark(B);
    finally
      EnableControls;
    end;
  End;
End;

procedure TMainCashForm.InsertUpdateBillCheckItems;
begin
  if ceAmount.Value = 0 then
     exit;
  if not assigned(SourceClientDataSet) then
    SourceClientDataSet := RemainsCDS;
  if SoldRegim
     and (ceAmount.Value > SourceClientDataSet.FieldByName('Remains').AsFloat) then
  begin
    ShowMessage('�� ������� ���������� ��� �������!');
    exit;
  end;
  if (not SoldRegim) and
     (abs(ceAmount.Value) > abs(CheckCDS.FieldByName('Amount').asFloat)) then
  begin
      ShowMessage('�� ������� ���������� ��� ��������!');
      exit;
  end;
  with spInsertUpdateCheckItems do begin
     ParamByName('inAmount').Value := ceAmount.Value;
     ParamByName('inPrice').Value := SourceClientDataSet.FieldByName('Price').asFloat;
     if ceAmount.Value > 0 then
        ParamByName('inGoodsId').Value := SourceClientDataSet.FieldByName('Id').asInteger
     else
        ParamByName('inGoodsId').Value := CheckCDS.FieldByName('GoodsId').asInteger;
     Execute;
     //�������� ������ ����
     try //���� ��� �� ������ �� ��� - �� ������ ������ ���� �� ��� � ����
       if CheckCDS.Locate('Id',ParamByName('outMovementItemId').Value,[]) then
       begin
         CheckCDS.Edit;
         CheckCDS.FieldByName('Amount').AsFloat := ParamByName('outAmount').AsFloat;
         CheckCDS.FieldByName('Summ').AsFloat := ParamByName('outSumm').AsFloat;
         CheckCDS.Post;
       end
       else
       begin
         CheckCDS.Append;
         CheckCDS.FieldByName('Id').AsInteger := ParamByName('outMovementItemId').Value;
         CheckCDS.FieldByName('GoodsId').AsInteger := SourceClientDataSet.FieldByName('Id').asInteger;
         CheckCDS.FieldByName('GoodsCode').AsInteger := SourceClientDataSet.FieldByName('GoodsCode').asInteger;
         CheckCDS.FieldByName('GoodsName').AsString := SourceClientDataSet.FieldByName('GoodsName').AsString;
         CheckCDS.FieldByName('Amount').AsFloat := ParamByName('outAmount').AsFloat;
         CheckCDS.FieldByName('Price').AsFloat := SourceClientDataSet.FieldByName('Price').asFloat;
         CheckCDS.FieldByName('Summ').AsFloat := ParamByName('outSumm').AsFloat;
         CheckCDS.FieldByName('NDS').AsFloat := ParamByName('outNDS').AsFloat;
         CheckCDS.FieldByName('isErased').AsBoolean := False;
         CheckCDS.Post;
       end;
       //�������� ������� � ��. ��
       //�������� ������ � ������������
       UpdateQuantityInQuery(SourceClientDataSet.FieldByName('Id').asInteger,
         ParamByName('outRemains').AsFloat);
       //�������� ����� ���������
       FTotalSumm := ParamByName('outTotalSummCheck').AsFloat;
       lblTotalSumm.Caption := FormatFloat(',0.00',ParamByName('outTotalSummCheck').AsFloat);
     Except ON E: Exception DO
       begin
         spSelectCheck.Execute;
         CalcTotalSumm;// ����������� �������� ����� � TotalPanel
         UpdateQuantityInQuery(ParamByName('inGoodsId').Value);
         raise Exception.Create(E.Message);
       end;
     end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TMainCashForm.UpdateQuantityInQuery(GoodsId: integer);
begin
  UpdateQuantityInQuery(GoodsId, GetGoodsPropertyRemains(GoodsId));
end;

procedure TMainCashForm.UpdateQuantityInQuery(GoodsId: integer; Remains: Real);
begin
  RemainsCDS.DisableControls;
  RemainsCDS.AfterScroll := nil;
  AlternativeCDS.DisableControls;
  AlternativeCDS.Filtered := False;
  try
    if RemainsCDS.Locate('Id', GoodsId, []) AND (RemainsCDS.FieldByName('Remains').AsFloat <> Remains) then
    begin
       RemainsCDS.Edit;
       RemainsCDS.FieldByName('Remains').AsFloat := Remains;
       RemainsCDS.Post;
    end;

    AlternativeCDS.Filter := 'Id = '+CheckCDS.FieldByName('GoodsId').asString;
    AlternativeCDS.Filtered := True;
    AlternativeCDS.First;
    while Not AlternativeCDS.eof do
    Begin
      AlternativeCDS.Edit;
      AlternativeCDS.FieldByName('Remains').AsFloat := Remains;
      AlternativeCDS.Post;
      AlternativeCDS.Next;
    End;
  finally
    RemainsCDS.AfterScroll := RemainsCDSAfterScroll;
    RemainsCDSAfterScroll(RemainsCDS);
    AlternativeCDS.Filtered := True;
    RemainsCDS.EnableControls;
    AlternativeCDS.EnableControls;
  end;
end;

procedure TMainCashForm.UpdateRemains;
var
  B: TBookmark;
begin
  if not RemainsCDS.Active or not Remains_LiteCDS.Active  then exit;
  
  B := RemainsCDS.GetBookmark;
  RemainsCDS.DisableControls;
  RemainsCDS.Filtered := False;
  RemainsCDS.AfterScroll := Nil;
  AlternativeCDS.DisableControls;
  AlternativeCDS.Filtered := False;
  Remains_LiteCDS.DisableControls;
  try
    RemainsCDS.First;
    while Not RemainsCDS.eof do
    Begin
      if Remains_LiteCDS.locate('Id',RemainsCDS.fieldByName('Id').AsInteger,[]) then
      Begin
        if RemainsCDS.FieldByName('Remains').AsFloat <> Remains_LiteCDS.FieldByName('Remains').AsFloat then
        Begin
          RemainsCDS.Edit;
          RemainsCDS.FieldByName('Remains').AsFloat := Remains_LiteCDS.FieldByName('Remains').AsFloat;
          RemainsCDS.Post;
        End;
      End
      else
      if RemainsCDS.FieldByName('Remains').AsFloat <> 0 then
      Begin
        RemainsCDS.Edit;
        RemainsCDS.FieldByName('Remains').AsFloat := 0;
        RemainsCDS.Post;
      End;
      RemainsCDS.Next;
    End;

    AlternativeCDS.First;
    while Not AlternativeCDS.eof do
    Begin
      if Remains_LiteCDS.locate('Id',AlternativeCDS.fieldByName('Id').AsInteger,[]) then
      Begin
        if AlternativeCDS.FieldByName('Remains').AsFloat <> Remains_LiteCDS.FieldByName('Remains').AsFloat then
        Begin
          AlternativeCDS.Edit;
          AlternativeCDS.FieldByName('Remains').AsFloat := Remains_LiteCDS.FieldByName('Remains').AsFloat;
          AlternativeCDS.Post;
        End;
      End
      else
      if AlternativeCDS.FieldByName('Remains').AsFloat <> 0 then
      Begin
        AlternativeCDS.Edit;
        AlternativeCDS.FieldByName('Remains').AsFloat := 0;
        AlternativeCDS.Post;
      End;
      AlternativeCDS.Next;
    End;
    try
      RemainsCDS.GotoBookmark(B);
    except
    end;
    try
      RemainsCDS.FreeBookmark(B);
    except
    end;
  finally
    RemainsCDS.Filtered := True;
    RemainsCDS.EnableControls;
    RemainsCDS.AfterScroll := RemainsCDSAfterScroll;
    RemainsCDSAfterScroll(RemainsCDS);
    AlternativeCDS.Filtered := true;
    AlternativeCDS.EnableControls;
    Remains_LiteCDS.EnableControls;
  end;
end;

procedure TMainCashForm.CalcTotalSumm;
var
  B:TBookmark;
Begin
  FTotalSumm := 0;
  WITH CheckCDS DO
  Begin
    B:= GetBookmark;
    DisableControls;
    try
      First;
      while Not Eof do
      Begin
        FTotalSumm := FTotalSumm + FieldByName('Summ').AsFloat;
        Next;
      End;
      GotoBookmark(B);
      FreeBookmark(B);
    finally
      EnableControls;
    end;
  End;
  lblTotalSumm.Caption := FormatFloat(',0.00',FTotalSumm);
End;

procedure TMainCashForm.lcNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_Return)
     and
     (
       (
         SoldRegim
         AND
         (lcName.Text = RemainsCDS.FieldByName('GoodsName').AsString)
       )
       or
       (
         not SoldRegim
         AND
         (lcName.Text = CheckCDS.FieldByName('GoodsName').AsString)
       )
     ) then begin
     ceAmount.Enabled := true;
     if SoldRegim then
        ceAmount.Value := 1
     else
        ceAmount.Value := - 1;
     ActiveControl := ceAmount;
  end;
  if (Key=VK_Tab) then
     ActiveControl := MainGrid
end;

procedure TMainCashForm.MainColReservedGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if AText = '0' then
    AText := '';
end;

// ��������� ��������� ��������� ��� �������� ������ ����
procedure TMainCashForm.NewCheck;
begin
  SoldRegim := true;
  actSpec.Checked := false;
  spNewCheck.Execute;
  if Self.Visible then
  Begin
    actRefreshLite.Execute;
    UpdateRemains;
  End
  else
    actRefresh.Execute;
  CalcTotalSumm;
  ceAmount.Value := 0;
  ceAmount.Enabled := true;
end;

procedure TMainCashForm.ParentFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if not CheckCDS.IsEmpty then
  Begin
    CanClose := False;
    ShowMessage('������� �������� ���.');
  End
  else
    CanClose := MessageDlg('�� ������������� ������ �����?',mtConfirmation,[mbYes,mbCancel], 0) = mrYes;
  if CanClose then
    spMovementSetErased.Execute;
end;

procedure TMainCashForm.ParentFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ADD) or ((Key = VK_Return) AND (ssShift in Shift)) then
  Begin
    fShift := ssShift in Shift;
    actPutCheckToCashExecute(nil);
    Key := 0;
  End;
end;

function TMainCashForm.PutCheckToCash(SalerCash: real;
  PaidType: TPaidType): boolean;
{------------------------------------------------------------------------------}
  function PutOneRecordToCash: boolean; //������� ������ ������������
  begin
     // �������� ������ � ����� � ���� ��� OK, �� ������ ����� � �������
     if Cash.AlwaysSold then
        result := true
     else
       if not SoldParallel then
         with CheckCDS do begin
            result := Cash.SoldFromPC(FieldByName('GoodsCode').asInteger,
                                      AnsiUpperCase(FieldByName('GoodsName').Text),
                                      FieldByName('Amount').asFloat,
                                      FieldByName('Price').asFloat,
                                      FieldByName('NDS').asFloat)
         end
       else result:=true;
  end;
{------------------------------------------------------------------------------}
begin
  try
    result := Cash.AlwaysSold or Cash.OpenReceipt;
    with CheckCDS do
    begin
      First;
      while not EOF do
      begin
        if result then
           begin
             if CheckCDS.FieldByName('Amount').asFloat > 0.009 then
                result := PutOneRecordToCash;//������� ������ � �����
           end;
        Next;
      end;
      if not Cash.AlwaysSold then
      begin
        Cash.SubTotal(true, true, 0, 0);
        Cash.TotalSumm(SalerCash, PaidType);
        result := Cash.CloseReceipt; //������� ���
      end;
    end;
  except
    result := false;
    raise;
  end;
end;

procedure TMainCashForm.RemainsCDSAfterScroll(DataSet: TDataSet);
begin
  if RemainsCDS.FieldByName('AlternativeGroupId').AsInteger = 0 then
    AlternativeCDS.Filter := 'Remains > 0 AND MainGoodsId='+RemainsCDS.FieldByName('Id').AsString
  else
    AlternativeCDS.Filter := '(Remains > 0 AND MainGoodsId='+RemainsCDS.FieldByName('Id').AsString +
      ') or (Remains > 0 AND AlternativeGroupId='+RemainsCDS.FieldByName('AlternativeGroupId').AsString+
           ' AND Id <> '+RemainsCDS.FieldByName('Id').AsString+')';
end;

procedure TMainCashForm.SetSoldRegim(const Value: boolean);
begin
  FSoldRegim := Value;
  if SoldRegim then begin
     actSold.Caption := '�������';
     ceAmount.Value := 1;
  end
  else begin
     actSold.Caption := '�������';
     ceAmount.Value := -1;
  end;
end;


initialization
  RegisterClass(TMainCashForm)

end.
