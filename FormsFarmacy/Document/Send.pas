unit Send;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorDocument, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, dxSkinsdxBarPainter, dsdAddOn,
  dsdGuides, dsdDB, Vcl.Menus, dxBarExtItems, dxBar, cxClasses,
  Datasnap.DBClient, dsdAction, Vcl.ActnList, cxPropertiesStore, cxButtonEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel, cxTextEdit, Vcl.ExtCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxPC, cxCurrencyEdit, cxCheckBox, frxClass, frxDBSet,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, dxBarBuiltInMenu,
  cxNavigator, cxCalc;

type
  TSendForm = class(TAncestorDocumentForm)
    cxLabel3: TcxLabel;
    edFrom: TcxButtonEdit;
    edTo: TcxButtonEdit;
    cxLabel4: TcxLabel;
    GuidesFrom: TdsdGuides;
    GuidesTo: TdsdGuides;
    GoodsCode: TcxGridDBColumn;
    GoodsName: TcxGridDBColumn;
    Amount: TcxGridDBColumn;
    actGoodsKindChoice: TOpenChoiceForm;
    spSelectPrint: TdsdStoredProc;
    N2: TMenuItem;
    N3: TMenuItem;
    RefreshDispatcher: TRefreshDispatcher;
    actRefreshPrice: TdsdDataSetRefresh;
    PrintHeaderCDS: TClientDataSet;
    PrintItemsCDS: TClientDataSet;
    PrintItemsSverkaCDS: TClientDataSet;
    actUnitChoiceForm: TOpenChoiceForm;
    actStorageChoiceForm: TOpenChoiceForm;
    actPartionGoodsChoiceForm: TOpenChoiceForm;
    actGoodsChoiceForm: TOpenChoiceForm;
    AmountRemains: TcxGridDBColumn;
    PriceIn: TcxGridDBColumn;
    PriceUnitFrom: TcxGridDBColumn;
    PriceUnitTo: TcxGridDBColumn;
    SumPriceIn: TcxGridDBColumn;
    cxLabel7: TcxLabel;
    edComment: TcxTextEdit;
    edIsAuto: TcxCheckBox;
    ActionList1: TActionList;
    dsdDataSetRefresh1: TdsdDataSetRefresh;
    dsdGridToExcel1: TdsdGridToExcel;
    actOpenPartionReport: TdsdOpenForm;
    actRefreshPartionPrice: TdsdDataSetRefresh;
    actRefreshIsPartion: TdsdDataSetRefresh;
    ExecuteDialog: TExecuteDialog;
    actSend: TdsdExecStoredProc;
    macSend: TMultiAction;
    ActionList2: TActionList;
    dsdDataSetRefresh2: TdsdDataSetRefresh;
    dsdGridToExcel2: TdsdGridToExcel;
    dsdOpenForm1: TdsdOpenForm;
    dsdDataSetRefresh3: TdsdDataSetRefresh;
    dsdDataSetRefresh4: TdsdDataSetRefresh;
    ExecuteDialog1: TExecuteDialog;
    dsdExecStoredProc1: TdsdExecStoredProc;
    MultiAction1: TMultiAction;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    edPeriod: TcxCurrencyEdit;
    edDay: TcxCurrencyEdit;
    ceChecked: TcxCheckBox;
    ChoiceReasonDifferences: TOpenChoiceForm;
    edisComplete: TcxCheckBox;
    MinExpirationDate: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TSendForm);

end.
