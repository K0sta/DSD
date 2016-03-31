unit ReportMovementCheckFarm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorReport, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, dsdAddOn,
  ChoicePeriod, Vcl.Menus, dxBarExtItems, dxBar, cxClasses, dsdDB,
  Datasnap.DBClient, dsdAction, Vcl.ActnList, cxPropertiesStore, cxLabel,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxPC, dsdGuides, cxButtonEdit, cxCurrencyEdit, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxPCdxBarPopupMenu,
  dxSkinsdxBarPainter, cxCheckBox;

type
  TReportMovementCheckFarmForm = class(TAncestorReportForm)
    cxLabel3: TcxLabel;
    ceUnit: TcxButtonEdit;
    rdUnit: TRefreshDispatcher;
    UnitGuides: TdsdGuides;
    dxBarButton1: TdxBarButton;
    colGoodsId: TcxGridDBColumn;
    colGoodsCode: TcxGridDBColumn;
    colGoodsName: TcxGridDBColumn;
    colAmount: TcxGridDBColumn;
    colPrice: TcxGridDBColumn;
    colPriceSale: TcxGridDBColumn;
    colSumma: TcxGridDBColumn;
    colSummaSale: TcxGridDBColumn;
    colSummaMargin: TcxGridDBColumn;
    spGet_UserUnit: TdsdStoredProc;
    actGet_UserUnit: TdsdExecStoredProc;
    actRefreshStart: TdsdDataSetRefresh;
    clGoodsGroupName: TcxGridDBColumn;
    clNDSKindName: TcxGridDBColumn;
    JuridicalCode: TcxGridDBColumn;
    JuridicalName: TcxGridDBColumn;
    PriceWithOutVAT: TcxGridDBColumn;
    actRefreshIsPartion: TdsdDataSetRefresh;
    PartionDescName: TcxGridDBColumn;
    PartionInvNumber: TcxGridDBColumn;
    PartionOperDate: TcxGridDBColumn;
    PartionPriceDescName: TcxGridDBColumn;
    PartionPriceInvNumber: TcxGridDBColumn;
    PartionPriceOperDate: TcxGridDBColumn;
    ExecuteDialog: TExecuteDialog;
    bbExecuteDialog: TdxBarButton;
    actRefreshPartionPrice: TdsdDataSetRefresh;
    UnitName: TcxGridDBColumn;
    OurJuridicalName: TcxGridDBColumn;
    actPrint: TdsdPrintAction;
    bbPrint: TdxBarButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportMovementCheckFarmForm: TReportMovementCheckFarmForm;

implementation

{$R *.dfm}

initialization

  RegisterClass(TReportMovementCheckFarmForm)
end.