unit Report_GoodsMI_Defroster;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorReport, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxPCdxBarPopupMenu, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, cxContainer, Vcl.ComCtrls,
  dxCore, cxDateUtils, dxSkinsdxBarPainter, dsdAddOn, ChoicePeriod,
  dxBarExtItems, dxBar, cxClasses, dsdDB, Datasnap.DBClient, dsdAction,
  Vcl.ActnList, cxPropertiesStore, cxLabel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC,
  dsdGuides, cxButtonEdit, cxCurrencyEdit, Vcl.Menus;

type
  TReport_GoodsMI_DefrosterForm = class(TAncestorReportForm)
    GoodsCode: TcxGridDBColumn;
    GoodsName: TcxGridDBColumn;
    Amount_Separate_in: TcxGridDBColumn;
    cxLabel4: TcxLabel;
    edGoodsGroup: TcxButtonEdit;
    GoodsGroupGuides: TdsdGuides;
    FormParams: TdsdFormParams;
    Amount_diff: TcxGridDBColumn;
    Amount_Send_in: TcxGridDBColumn;
    Amount_Loss: TcxGridDBColumn;
    Amount_Production: TcxGridDBColumn;
    MeasureName: TcxGridDBColumn;
    cxLabel3: TcxLabel;
    UnitGuides: TdsdGuides;
    edUnit: TcxButtonEdit;
    Amount_Separate_out: TcxGridDBColumn;
    Tax_diff: TcxGridDBColumn;
    Amount_Send_out: TcxGridDBColumn;
    actPrint: TdsdPrintAction;
    actPrintByGoods: TdsdPrintAction;
    bbPrint: TdxBarButton;
    bbPrintByGoods: TdxBarButton;
    PartionGoodsName: TcxGridDBColumn;
    GoodsGroupName: TcxGridDBColumn;
    PartnerCode: TcxGridDBColumn;
    PartnerName: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
initialization
  RegisterClass(TReport_GoodsMI_DefrosterForm);

end.
