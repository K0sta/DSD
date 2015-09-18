unit Report_GoodsMI_ProductionSeparateUnionDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ParentForm, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxControls,
  cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, ChoicePeriod,
  dsdGuides, cxDropDownEdit, cxCalendar, cxTextEdit, cxMaskEdit, cxButtonEdit,
  cxPropertiesStore, dsdAddOn, dsdDB, cxLabel, dxSkinsCore,
  dxSkinsDefaultPainters, cxCheckBox;

type
  TReport_GoodsMI_ProductionSeparateUnionDialogForm = class(TParentForm)
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    deEnd: TcxDateEdit;
    deStart: TcxDateEdit;
    PeriodChoice: TPeriodChoice;
    dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn;
    cxPropertiesStore: TcxPropertiesStore;
    FormParams: TdsdFormParams;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cbGroupMovement: TcxCheckBox;
    cbGroupPartion: TcxCheckBox;
    cxLabel5: TcxLabel;
    edFromGroup: TcxButtonEdit;
    FromGroupGuides: TdsdGuides;
    cxLabel8: TcxLabel;
    edToGroup: TcxButtonEdit;
    ToGroupGuides: TdsdGuides;
    cxLabel4: TcxLabel;
    edGoodsGroup: TcxButtonEdit;
    cxLabel1: TcxLabel;
    edChildGoodsGroup: TcxButtonEdit;
    GoodsGroupGuides: TdsdGuides;
    ChildGoodsGroupGuides: TdsdGuides;
    cxLabel2: TcxLabel;
    edGoods: TcxButtonEdit;
    edChildGoods: TcxButtonEdit;
    cxLabel3: TcxLabel;
    GoodsGuides: TdsdGuides;
    ChildGoodsGuides: TdsdGuides;
    cbGroupInfoMoney: TcxCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TReport_GoodsMI_ProductionSeparateUnionDialogForm);

end.
