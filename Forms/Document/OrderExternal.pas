unit OrderExternal;

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
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter;

type
  TOrderExternalForm = class(TAncestorDocumentForm)
    colCode: TcxGridDBColumn;
    colName: TcxGridDBColumn;
    colGoodsKindName: TcxGridDBColumn;
    colPartionGoods: TcxGridDBColumn;
    colAmount: TcxGridDBColumn;
    actGoodsKindChoice: TOpenChoiceForm;
    spSelectPrint: TdsdStoredProc;
    N2: TMenuItem;
    N3: TMenuItem;
    RefreshDispatcher: TRefreshDispatcher;
    actRefreshPrice: TdsdDataSetRefresh;
    PrintHeaderCDS: TClientDataSet;
    bbPrintTax: TdxBarButton;
    PrintItemsCDS: TClientDataSet;
    bbTax: TdxBarButton;
    bbPrintTax_Client: TdxBarButton;
    bbPrint_Bill: TdxBarButton;
    PrintItemsSverkaCDS: TClientDataSet;
    colAmountSecond: TcxGridDBColumn;
    cxLabel5: TcxLabel;
    edInvNumberOrder: TcxTextEdit;
    cxLabel3: TcxLabel;
    edOperDateMark: TcxDateEdit;
    cxLabel10: TcxLabel;
    edOperDatePartner: TcxDateEdit;
    cxLabel4: TcxLabel;
    edFrom: TcxButtonEdit;
    cxLabel6: TcxLabel;
    edPaidKind: TcxButtonEdit;
    cxLabel9: TcxLabel;
    edContract: TcxButtonEdit;
    cxLabel13: TcxLabel;
    edRouteSorting: TcxButtonEdit;
    PaidKindGuides: TdsdGuides;
    ContractGuides: TdsdGuides;
    GuidesRouteSorting: TdsdGuides;
    GuidesFrom: TdsdGuides;
    cxLabel7: TcxLabel;
    edRoute: TcxButtonEdit;
    GuidesRoute: TdsdGuides;
    cxLabel16: TcxLabel;
    edPersonal: TcxButtonEdit;
    GuidesPersonal: TdsdGuides;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TOrderExternalForm);

end.
