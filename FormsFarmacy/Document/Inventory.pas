unit Inventory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorDocument, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu,
  dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, Data.DB, cxDBData, cxCurrencyEdit, cxContainer,
  Vcl.ComCtrls, dxCore, cxDateUtils, dsdAddOn, ExternalLoad, dsdAction,
  dsdGuides, dsdDB, Vcl.Menus, dxBarExtItems, dxBar, cxClasses,
  Datasnap.DBClient, Vcl.ActnList, cxPropertiesStore, cxButtonEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxLabel, cxTextEdit, Vcl.ExtCtrls, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxPC;

type
  TInventoryForm = class(TAncestorDocumentForm)
    cxLabel3: TcxLabel;
    edUnit: TcxButtonEdit;
    GuidesUnit: TdsdGuides;
    colCode: TcxGridDBColumn;
    colName: TcxGridDBColumn;
    colAmount: TcxGridDBColumn;
    actGoodsKindChoice: TOpenChoiceForm;
    spSelectPrint: TdsdStoredProc;
    N2: TMenuItem;
    N3: TMenuItem;
    RefreshDispatcher: TRefreshDispatcher;
    actRefreshPrice: TdsdDataSetRefresh;
    PrintHeaderCDS: TClientDataSet;
    PrintItemsCDS: TClientDataSet;
    colPrice: TcxGridDBColumn;
    colSumm: TcxGridDBColumn;
    actUnitChoice: TOpenChoiceForm;
    actStorageChoice: TOpenChoiceForm;
    actAssetChoice: TOpenChoiceForm;
    spInsertUpdateMIAmount: TdsdStoredProc;
    actInsertUpdateMIAmount: TdsdExecStoredProc;
    bbInsertUpdateMIAmount: TdxBarButton;
    bbPrint1: TdxBarButton;
    spGetImportSettingId: TdsdStoredProc;
    actStartLoad: TMultiAction;
    actGetImportSettingId: TdsdExecStoredProc;
    actDoLoad: TExecuteImportSettingsAction;
    dxBarButton1: TdxBarButton;
    spInsertUpdate_MovementItem_Inventory_Set_Zero: TdsdStoredProc;
    actInsertUpdate_MovementItem_Inventory_Set_Zero: TdsdExecStoredProc;
    colRemains_Amount: TcxGridDBColumn;
    colDeficit: TcxGridDBColumn;
    colDeficitSumm: TcxGridDBColumn;
    colProicit: TcxGridDBColumn;
    colProicitSumm: TcxGridDBColumn;
    colDiff: TcxGridDBColumn;
    colDiffSumm: TcxGridDBColumn;
    colMIComment: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TInventoryForm);

end.
