object DiscountPeriodItemForm: TDiscountPeriodItemForm
  Left = 0
  Top = 0
  Caption = #1057#1077#1079#1086#1085#1085#1099#1077' '#1089#1082#1080#1076#1082#1080' - '#1055#1088#1086#1089#1084#1086#1090#1088' / '#1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1086#1089#1083#1077#1076#1085#1080#1093' '#1089#1082#1080#1076#1086#1082
  ClientHeight = 398
  ClientWidth = 848
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  AddOnFormData.isSingle = False
  AddOnFormData.ExecuteDialogAction = ExecuteDialog
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 91
    Width = 848
    Height = 307
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = 'UserSkin'
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Images = dmMain.SortImageList
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 40
      OptionsView.Indicator = True
      Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
      object UnitName: TcxGridDBColumn
        Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
        DataBinding.FieldName = 'UnitName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 100
      end
      object BrandName: TcxGridDBColumn
        Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1084#1072#1088#1082#1072
        DataBinding.FieldName = 'BrandName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 65
      end
      object PeriodName: TcxGridDBColumn
        Caption = #1057#1077#1079#1086#1085
        DataBinding.FieldName = 'PeriodName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 65
      end
      object PeriodYear: TcxGridDBColumn
        Caption = #1043#1086#1076
        DataBinding.FieldName = 'PeriodYear'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 65
      end
      object PartnerName: TcxGridDBColumn
        Caption = #1055#1086'c'#1090#1072#1074#1097#1080#1082
        DataBinding.FieldName = 'PartnerName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 74
      end
      object GroupNameFull: TcxGridDBColumn
        Caption = #1043#1088#1091#1087#1087#1072
        DataBinding.FieldName = 'GroupNameFull'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 135
      end
      object GoodsGroupName: TcxGridDBColumn
        Caption = #1043#1088#1091#1087#1087#1072' ('#1090#1086#1074'.)'
        DataBinding.FieldName = 'GoodsGroupName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 93
      end
      object LabelName: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'LabelName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 155
      end
      object GoodsCode: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'GoodsCode'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 35
      end
      object Name: TcxGridDBColumn
        Caption = #1040#1088#1090#1080#1082#1091#1083
        DataBinding.FieldName = 'GoodsName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 150
      end
      object CompositionGroupName: TcxGridDBColumn
        Caption = #1043#1088#1091#1087#1087#1072' '#1089#1086#1089#1090#1072#1074#1072
        DataBinding.FieldName = 'CompositionGroupName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 170
      end
      object CompositionName: TcxGridDBColumn
        Caption = #1057#1086#1089#1090#1072#1074
        DataBinding.FieldName = 'CompositionName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 94
      end
      object GoodsInfoName: TcxGridDBColumn
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        DataBinding.FieldName = 'GoodsInfoName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 110
      end
      object LineFabricaName: TcxGridDBColumn
        Caption = #1051#1080#1085#1080#1103
        DataBinding.FieldName = 'LineFabricaName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 111
      end
      object FabrikaName: TcxGridDBColumn
        Caption = #1060#1072#1073#1088#1080#1082#1072
        DataBinding.FieldName = 'FabrikaName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 107
      end
      object GoodsSizeName: TcxGridDBColumn
        Caption = #1056#1072#1079#1084#1077#1088
        DataBinding.FieldName = 'GoodsSizeName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 97
      end
      object MeasureName: TcxGridDBColumn
        Caption = #1045#1076'. '#1080#1079#1084'.'
        DataBinding.FieldName = 'MeasureName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 99
      end
      object StartDate: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1089
        DataBinding.FieldName = 'StartDate'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object EndDate: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1087#1086
        DataBinding.FieldName = 'EndDate'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object OperDate: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1076#1086#1082'. '#1087#1072#1088#1090#1080#1080
        DataBinding.FieldName = 'OperDate'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 89
      end
      object CurrencyName: TcxGridDBColumn
        Caption = #1042#1072#1083'. '#1074#1093'.'
        DataBinding.FieldName = 'CurrencyName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 114
      end
      object OperPrice: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' '#1074#1093'.'
        DataBinding.FieldName = 'OperPrice'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 65
      end
      object ValuePrice: TcxGridDBColumn
        Caption = '% '#1089#1082'.'
        DataBinding.FieldName = 'ValuePrice'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 70
      end
      object PriceSale: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' '#1043#1056#1053
        DataBinding.FieldName = 'PriceSale'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 65
      end
      object GoodsisErased: TcxGridDBColumn
        Caption = #1059#1076#1072#1083#1077#1085
        DataBinding.FieldName = 'isErased'
        Visible = False
        Options.Editing = False
        VisibleForCustomization = False
        Width = 20
      end
      object UpdateDate: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' ('#1082#1086#1088#1088'.)'
        DataBinding.FieldName = 'UpdateDate'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 48
      end
      object UpdateName: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' ('#1082#1086#1088#1088'.)'
        DataBinding.FieldName = 'UpdateName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 80
      end
      object InsertDate: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' ('#1089#1086#1079#1076'.)'
        DataBinding.FieldName = 'InsertDate'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 48
      end
      object InsertName: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' ('#1089#1086#1079#1076'.)'
        DataBinding.FieldName = 'InsertName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 80
      end
      object ObjectId: TcxGridDBColumn
        DataBinding.FieldName = 'ObjectId'
        Visible = False
        Options.Editing = False
        VisibleForCustomization = False
        Width = 20
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object Panel: TPanel
    Left = 0
    Top = 26
    Width = 848
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object cxLabel1: TcxLabel
      Left = 4
      Top = 10
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
    end
    object edUnit: TcxButtonEdit
      Left = 92
      Top = 9
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 1
      Width = 202
    end
    object edShowDate: TcxDateEdit
      Left = 641
      Top = 9
      EditValue = 42856d
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 2
      Width = 82
    end
    object cxLabel2: TcxLabel
      Left = 531
      Top = 10
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1089#1082#1080#1076#1086#1082' '#1085#1072':'
    end
    object edPersent: TcxCurrencyEdit
      Left = 786
      Top = 36
      EditValue = '0'
      Properties.AssignedValues.MinValue = True
      Properties.DecimalPlaces = 0
      Properties.DisplayFormat = '0'
      Properties.MaxLength = 4
      TabOrder = 4
      Width = 31
    end
    object cxLabel5: TcxLabel
      Left = 4
      Top = 37
      Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1084#1072#1088#1082#1072':'
    end
    object edBrand: TcxButtonEdit
      Left = 92
      Top = 36
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 6
      Width = 202
    end
    object cxLabel6: TcxLabel
      Left = 297
      Top = 10
      Caption = #1057#1077#1079#1086#1085' :'
    end
    object edPeriod: TcxButtonEdit
      Left = 339
      Top = 9
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 8
      Width = 175
    end
    object cxLabel7: TcxLabel
      Left = 303
      Top = 37
      Caption = #1043#1086#1076' '#1089' ...'
    end
    object cxLabel8: TcxLabel
      Left = 407
      Top = 37
      Caption = #1043#1086#1076' '#1087#1086' ...'
    end
    object edStartYear: TcxButtonEdit
      Left = 349
      Top = 36
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 11
      Text = '2000'
      Width = 49
    end
    object edEndYear: TcxButtonEdit
      Left = 462
      Top = 36
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 12
      Text = '2018'
      Width = 52
    end
  end
  object cxLabel3: TcxLabel
    Left = 531
    Top = 63
    Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1089#1082#1080#1076#1082#1080' '#1089':'
  end
  object edOperDate: TcxDateEdit
    Left = 641
    Top = 62
    EditValue = 42856d
    Properties.SaveTime = False
    Properties.ShowTime = False
    TabOrder = 7
    Width = 82
  end
  object cxLabel4: TcxLabel
    Left = 729
    Top = 63
    Caption = '% '#1089#1082#1080#1076#1082#1080':'
  end
  object DataSource: TDataSource
    DataSet = ClientDataSet
    Left = 40
    Top = 104
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 160
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = edOperDate
        Properties.Strings = (
          'Date')
      end
      item
        Component = edShowDate
        Properties.Strings = (
          'Date')
      end
      item
        Component = GuidesUnit
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width')
      end
      item
        Component = edStartYear
        Properties.Strings = (
          'Text')
      end
      item
        Component = edEndYear
        Properties.Strings = (
          'Text')
      end>
    StorageName = 'cxPropertiesStore'
    StorageType = stStream
    Left = 376
    Top = 144
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmMain.ImageList
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    ShowShortCutInHint = True
    UseSystemFont = True
    Left = 224
    Top = 136
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerBar1: TdxBar
      Caption = 'Custom'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 416
      FloatTop = 259
      FloatClientWidth = 51
      FloatClientHeight = 59
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbExecuteDialog'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPriceListGoodsItem'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbShowAll'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPriceListTaxDialog'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbProtocol'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbToExcel'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end>
      NotDocking = [dsLeft]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbRefresh: TdxBarButton
      Action = actRefresh
      Category = 0
    end
    object bbToExcel: TdxBarButton
      Action = dsdGridToExcel
      Category = 0
    end
    object dxBarStatic: TdxBarStatic
      Caption = '       '
      Category = 0
      Hint = '       '
      Visible = ivAlways
    end
    object bbPriceListGoodsItem: TdxBarButton
      Action = actDiscountPeriodGoods
      Category = 0
    end
    object bbShowAll: TdxBarButton
      Action = actShowAll
      Category = 0
    end
    object bbProtocol: TdxBarButton
      Action = ProtocolOpenForm
      Category = 0
    end
    object bbPriceListTaxDialog: TdxBarButton
      Action = macUpdateAll
      Category = 0
    end
    object bbPrint: TdxBarButton
      Action = actPrint
      Category = 0
      ImageIndex = 3
      UnclickAfterDoing = False
    end
    object bbExecuteDialog: TdxBarButton
      Action = ExecuteDialog
      Category = 0
    end
  end
  object ActionList: TActionList
    Images = dmMain.ImageList
    Left = 320
    Top = 136
    object actRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 4
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object dsdGridToExcel: TdsdGridToExcel
      Category = 'DSDLib'
      MoveParams = <>
      Grid = cxGrid
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      ImageIndex = 6
      ShortCut = 16472
    end
    object actDiscountPeriodGoods: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088'/'#1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1080#1089#1090#1086#1088#1080#1080
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088'/'#1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1080#1089#1090#1086#1088#1080#1080
      ImageIndex = 28
      FormName = 'TDiscountPeriodGoodsItemForm'
      FormNameParam.Value = 'TDiscountPeriodGoodsItemForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'UnitId'
          Value = '0'
          Component = GuidesUnit
          ComponentItem = 'Key'
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitName'
          Value = ''
          Component = GuidesUnit
          ComponentItem = 'TextValue'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsId'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'GoodsId'
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsName'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'GoodsName'
          DataType = ftString
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object actUpdateDataSet: TdsdUpdateDataSet
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = 'actUpdateDataSet'
    end
    object actShowAll: TBooleanStoredProcAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099
      ImageIndex = 63
      Value = False
      HintTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1087#1091#1089#1090#1099#1077' '#1089#1082#1080#1076#1082#1080
      HintFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099
      CaptionTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1087#1091#1089#1090#1099#1077' '#1089#1082#1080#1076#1082#1080
      CaptionFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099
      ImageIndexTrue = 62
      ImageIndexFalse = 63
    end
    object ProtocolOpenForm: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
      ImageIndex = 34
      FormName = 'TProtocolForm'
      FormNameParam.Value = 'TProtocolForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'ObjectId'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = Null
          Component = GuidesUnit
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object actPrint: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = dsdStoredProcPrint
      StoredProcList = <
        item
          StoredProc = dsdStoredProcPrint
        end>
      Caption = #1055#1077#1095#1072#1090#1100' '#1087#1088#1072#1081#1089#1072
      Hint = #1055#1077#1095#1072#1090#1100' '#1087#1088#1072#1081#1089#1072
      ImageIndex = 19
      DataSets = <
        item
          DataSet = PrintItemsCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'GoodsGroupNameFull;GoodsName'
        end>
      Params = <
        item
          Name = 'PriceListUnitName'
          Value = Null
          Component = GuidesUnit
          ComponentItem = 'TextValue'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'ShowDate'
          Value = 42339d
          Component = edShowDate
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end>
      ReportName = 'PrintObjectHistory_PriceListItem'
      ReportNameParam.Name = 'PrintObjectHistory_PriceListItem'
      ReportNameParam.Value = 'PrintObjectHistory_PriceListItem'
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object spUpdatePersent: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertUpdateList
      StoredProcList = <
        item
          StoredProc = spInsertUpdateList
        end>
      Caption = #1057#1082#1080#1076#1082#1072
      Hint = #1057#1082#1080#1076#1082#1072
      ImageIndex = 74
    end
    object macUpdateAll: TMultiAction
      Category = 'DSDLib'
      MoveParams = <>
      ActionList = <
        item
          Action = macUpdatePersent
        end
        item
          Action = actRefresh
        end>
      QuestionBeforeExecute = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1082#1080#1076#1082#1091' '#1074#1099#1073#1088#1072#1085#1085#1099#1084' '#1090#1086#1074#1072#1088#1072#1084'?'
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1082#1080#1076#1082#1091
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1082#1080#1076#1082#1091
      ImageIndex = 74
    end
    object macUpdatePersent: TMultiAction
      Category = 'DSDLib'
      MoveParams = <>
      ActionList = <
        item
          Action = spUpdatePersent
        end>
      View = cxGridDBTableView
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1082#1080#1076#1082#1091
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1082#1080#1076#1082#1091
      ImageIndex = 74
    end
    object ExecuteDialog: TExecuteDialog
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
      ImageIndex = 35
      FormName = 'TDiscountPeriodItemDialogForm'
      FormNameParam.Value = 'TDiscountPeriodItemDialogForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'ShowDate'
          Value = 42736d
          Component = edShowDate
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitId'
          Value = ''
          Component = GuidesUnit
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitName'
          Value = ''
          Component = GuidesUnit
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'BrandId'
          Value = ''
          Component = GuidesBrand
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'BrandName'
          Value = ''
          Component = GuidesBrand
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'PeriodId'
          Value = '0'
          Component = GuidesPeriod
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'PeriodName'
          Value = ''
          Component = GuidesPeriod
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'StartYear'
          Value = '0'
          DataType = ftFloat
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndYear'
          Value = ''
          DataType = ftFloat
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = True
      RefreshDispatcher = RefreshDispatcher
      OpenBeforeShow = True
    end
  end
  object spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_ObjectHistory_DiscountPeriodItem'
    DataSet = ClientDataSet
    DataSets = <
      item
        DataSet = ClientDataSet
      end>
    Params = <
      item
        Name = 'inUnitId'
        Value = '0'
        Component = GuidesUnit
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inBrandId'
        Value = Null
        Component = GuidesBrand
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPeriodId'
        Value = Null
        Component = GuidesPeriod
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOperDate'
        Value = 41275d
        Component = edShowDate
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inStartYear'
        Value = Null
        Component = edStartYear
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inEndYear'
        Value = Null
        Component = edEndYear
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inShowAll'
        Value = Null
        Component = actShowAll
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 144
    Top = 128
  end
  object dsdDBViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxGridDBTableView
    OnDblClickActionList = <>
    ActionItemList = <>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = True
    ColorRuleList = <>
    ColumnAddOnList = <
      item
        Column = GoodsCode
        FindByFullValue = True
        onExitColumn.Active = False
        onExitColumn.AfterEmptyValue = False
      end>
    ColumnEnterList = <
      item
        Column = GoodsCode
      end
      item
        Column = ValuePrice
      end>
    SummaryItemList = <>
    Left = 192
    Top = 256
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 296
    Top = 200
  end
  object GuidesUnit: TdsdGuides
    KeyField = 'Id'
    LookupControl = edUnit
    Key = '0'
    FormNameParam.Value = 'TUnitForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TUnitForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = '0'
        Component = GuidesUnit
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesUnit
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 208
    Top = 32
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_ObjectHistory_DiscountPeriodItemLast'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inUnitId'
        Value = Null
        Component = GuidesUnit
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'GoodsId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOperDate'
        Value = 'NULL'
        Component = edOperDate
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inValue'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'ValuePrice'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inIsLast'
        Value = True
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outStartDate'
        Value = 'NULL'
        Component = ClientDataSet
        ComponentItem = 'StartDate'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'outEndDate'
        Value = 'NULL'
        Component = ClientDataSet
        ComponentItem = 'EndDate'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 72
    Top = 272
  end
  object RefreshDispatcher: TRefreshDispatcher
    IdParam.Value = Null
    IdParam.MultiSelectSeparator = ','
    RefreshAction = actRefresh
    ComponentList = <
      item
        Component = GuidesUnit
      end
      item
        Component = GuidesBrand
      end
      item
        Component = GuidesPeriod
      end
      item
      end
      item
      end
      item
        Component = edShowDate
      end>
    Left = 536
    Top = 168
  end
  object dsdStoredProcPrint: TdsdStoredProc
    StoredProcName = 'gpSelect_ObjectHistory_DiscountPeriodItem_Print'
    DataSet = PrintItemsCDS
    DataSets = <
      item
        DataSet = PrintItemsCDS
      end>
    Params = <
      item
        Name = 'inUnitId'
        Value = '0'
        Component = GuidesUnit
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOperDate'
        Value = 42005d
        Component = edShowDate
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 688
    Top = 144
  end
  object PrintItemsCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 708
    Top = 270
  end
  object spInsertUpdateList: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_ObjectHistory_DiscountPeriodItemLast'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inUnitId'
        Value = '0'
        Component = GuidesUnit
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'GoodsId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOperDate'
        Value = 42856d
        Component = edOperDate
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inValue'
        Value = Null
        Component = edPersent
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inIsLast'
        Value = True
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outStartDate'
        Value = 'NULL'
        Component = ClientDataSet
        ComponentItem = 'StartDate'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'outEndDate'
        Value = 'NULL'
        Component = ClientDataSet
        ComponentItem = 'EndDate'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 368
    Top = 304
  end
  object GuidesBrand: TdsdGuides
    KeyField = 'Id'
    LookupControl = edBrand
    Key = '0'
    FormNameParam.Value = 'TBrandForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TBrandForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = '0'
        Component = GuidesBrand
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesBrand
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 118
    Top = 42
  end
  object GuidesPeriod: TdsdGuides
    KeyField = 'Id'
    LookupControl = edPeriod
    Key = '0'
    FormNameParam.Value = 'TPeriodForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TPeriodForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = '0'
        Component = GuidesPeriod
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesPeriod
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 278
    Top = 26
  end
  object GuidesStartYear: TdsdGuides
    KeyField = 'Id'
    LookupControl = edStartYear
    Key = '0'
    FormNameParam.Value = 'TPeriodYear_ChoiceForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TPeriodYear_ChoiceForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'PeriodYear'
        Value = ''
        Component = edStartYear
        MultiSelectSeparator = ','
      end>
    Left = 442
    Top = 89
  end
  object GuidesEndYear: TdsdGuides
    KeyField = 'Id'
    LookupControl = edEndYear
    Key = '0'
    FormNameParam.Value = 'TPeriodYear_ChoiceForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TPeriodYear_ChoiceForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'PeriodYear'
        Value = ''
        Component = edEndYear
        MultiSelectSeparator = ','
      end>
    Left = 493
    Top = 99
  end
end
