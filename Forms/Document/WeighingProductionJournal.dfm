object WeighingProductionJournalForm: TWeighingProductionJournalForm
  Left = 0
  Top = 0
  Caption = #1046#1091#1088#1085#1072#1083' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' <'#1042#1079#1074#1077#1096#1080#1074#1072#1085#1080#1077' ('#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086')>'
  ClientHeight = 427
  ClientWidth = 1240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  AddOnFormData.RefreshAction = actRefreshStart
  AddOnFormData.isSingle = False
  AddOnFormData.ExecuteDialogAction = ExecuteDialog
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1240
    Height = 31
    Align = alTop
    TabOrder = 1
    object deStart: TcxDateEdit
      Left = 101
      Top = 5
      EditValue = 42005d
      Properties.ReadOnly = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 0
      Width = 85
    end
    object deEnd: TcxDateEdit
      Left = 310
      Top = 5
      EditValue = 42005d
      Properties.ReadOnly = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
      Width = 85
    end
    object cxLabel1: TcxLabel
      Left = 10
      Top = 6
      Caption = #1053#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072':'
    end
    object cxLabel2: TcxLabel
      Left = 200
      Top = 6
      Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1087#1077#1088#1080#1086#1076#1072':'
    end
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 57
    Width = 1240
    Height = 370
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = False
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource
      DataController.Filter.Options = [fcoCaseInsensitive, fcoShowOperatorDescription]
      DataController.Filter.TranslateBetween = True
      DataController.Filter.TranslateIn = True
      DataController.Filter.TranslateLike = True
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = ',0.####'
          Kind = skSum
          Column = colTotalCount
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = colTotalCountTare
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.####'
          Kind = skSum
          Column = colTotalCount
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = colTotalCountTare
        end>
      DataController.Summary.SummaryGroups = <>
      Images = dmMain.SortImageList
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.Footer = True
      OptionsView.GroupSummaryLayout = gslAlignWithColumns
      OptionsView.HeaderAutoHeight = True
      OptionsView.Indicator = True
      Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
      object colStatus: TcxGridDBColumn
        Caption = #1057#1090#1072#1090#1091#1089
        DataBinding.FieldName = 'StatusCode'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = dmMain.ImageList
        Properties.Items = <
          item
            Description = #1053#1077' '#1087#1088#1086#1074#1077#1076#1077#1085
            ImageIndex = 11
            Value = 1
          end
          item
            Description = #1055#1088#1086#1074#1077#1076#1077#1085
            ImageIndex = 12
            Value = 2
          end
          item
            Description = #1059#1076#1072#1083#1077#1085
            ImageIndex = 13
            Value = 3
          end>
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 91
      end
      object colMovementDescNumber: TcxGridDBColumn
        Caption = #8470' '#1086#1087#1077#1088'.'
        DataBinding.FieldName = 'MovementDescNumber'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 45
      end
      object colMovementDescName: TcxGridDBColumn
        Caption = #1042#1080#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        DataBinding.FieldName = 'MovementDescName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 70
      end
      object colIsProductionIn: TcxGridDBColumn
        Caption = #1055#1088#1080#1093#1086#1076
        DataBinding.FieldName = 'isProductionIn'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 55
      end
      object colOperDate: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1076#1086#1082'.'
        DataBinding.FieldName = 'OperDate'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 91
      end
      object colOperDate_parent: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1076#1086#1082'. ('#1075#1083#1072#1074#1085#1099#1081')'
        DataBinding.FieldName = 'OperDate_parent'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 70
      end
      object colWeighingNumber: TcxGridDBColumn
        Caption = #8470' '#1074#1079#1074#1077#1096'.'
        DataBinding.FieldName = 'WeighingNumber'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 50
      end
      object colPartionGoods: TcxGridDBColumn
        Caption = #1055#1072#1088#1090#1080#1103' '#1089#1099#1088#1100#1103
        DataBinding.FieldName = 'PartionGoods'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 70
      end
      object colInvNumber: TcxGridDBColumn
        Caption = #8470' '#1076#1086#1082'.'
        DataBinding.FieldName = 'InvNumber'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 92
      end
      object colInvNumber_parent: TcxGridDBColumn
        Caption = #8470' '#1076#1086#1082'. ('#1075#1083#1072#1074#1085#1099#1081')'
        DataBinding.FieldName = 'InvNumber_parent'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 91
      end
      object colStartWeighing: TcxGridDBColumn
        Caption = #1053#1072#1095'. '#1074#1079#1074#1077#1096'.'
        DataBinding.FieldName = 'StartWeighing'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 116
      end
      object colEndWeighing: TcxGridDBColumn
        Caption = #1054#1082#1086#1085#1095'. '#1074#1079#1074#1077#1096'.'
        DataBinding.FieldName = 'EndWeighing'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 97
      end
      object colFromName: TcxGridDBColumn
        Caption = #1054#1090' '#1082#1086#1075#1086
        DataBinding.FieldName = 'FromName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 149
      end
      object colToName: TcxGridDBColumn
        Caption = #1050#1086#1084#1091
        DataBinding.FieldName = 'ToName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 136
      end
      object colDocumentKindName: TcxGridDBColumn
        Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        DataBinding.FieldName = 'DocumentKindName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 77
      end
      object colTotalCount: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086
        DataBinding.FieldName = 'TotalCount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = ',0.####;-,0.####; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 60
      end
      object colTotalCountTare: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1090#1072#1088#1099
        DataBinding.FieldName = 'TotalCountTare'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = ',0.####;-,0.####; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 60
      end
      object colUserName: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'UserName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 86
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object edJuridicalBasis: TcxButtonEdit
    Left = 691
    Top = 5
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 6
    Width = 185
  end
  object cxLabel27: TcxLabel
    Left = 586
    Top = 6
    Caption = #1043#1083#1072#1074#1085#1086#1077' '#1102#1088'. '#1083#1080#1094#1086':'
  end
  object DataSource: TDataSource
    DataSet = ClientDataSet
    Left = 24
    Top = 136
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 136
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = deEnd
        Properties.Strings = (
          'Align'
          'AlignWithMargins'
          'Anchors'
          'AutoSize'
          'BeepOnEnter'
          'BiDiMode'
          'Constraints'
          'Cursor'
          'CustomHint'
          'Date'
          'DragCursor'
          'DragKind'
          'DragMode'
          'EditValue'
          'Enabled'
          'FakeStyleController'
          'Height'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'ImeMode'
          'ImeName'
          'Left'
          'Margins'
          'Name'
          'ParentBiDiMode'
          'ParentColor'
          'ParentCustomHint'
          'ParentFont'
          'ParentShowHint'
          'PopupMenu'
          'Properties'
          'RepositoryItem'
          'ShowHint'
          'Style'
          'StyleDisabled'
          'StyleFocused'
          'StyleHot'
          'TabOrder'
          'TabStop'
          'Tag'
          'TextHint'
          'Top'
          'Touch'
          'Visible'
          'Width')
      end
      item
        Component = deStart
        Properties.Strings = (
          'Align'
          'AlignWithMargins'
          'Anchors'
          'AutoSize'
          'BeepOnEnter'
          'BiDiMode'
          'Constraints'
          'Cursor'
          'CustomHint'
          'Date'
          'DragCursor'
          'DragKind'
          'DragMode'
          'EditValue'
          'Enabled'
          'FakeStyleController'
          'Height'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'ImeMode'
          'ImeName'
          'Left'
          'Margins'
          'Name'
          'ParentBiDiMode'
          'ParentColor'
          'ParentCustomHint'
          'ParentFont'
          'ParentShowHint'
          'PopupMenu'
          'Properties'
          'RepositoryItem'
          'ShowHint'
          'Style'
          'StyleDisabled'
          'StyleFocused'
          'StyleHot'
          'TabOrder'
          'TabStop'
          'Tag'
          'TextHint'
          'Top'
          'Touch'
          'Visible'
          'Width')
      end
      item
        Component = Owner
        Properties.Strings = (
          'Action'
          'ActiveControl'
          'AddOnFormData'
          'Align'
          'AlignWithMargins'
          'AlphaBlend'
          'AlphaBlendValue'
          'Anchors'
          'AutoScroll'
          'AutoSize'
          'BiDiMode'
          'BorderIcons'
          'BorderStyle'
          'BorderWidth'
          'Caption'
          'ClientHeight'
          'ClientWidth'
          'Color'
          'Constraints'
          'Ctl3D'
          'Cursor'
          'CustomHint'
          'DefaultMonitor'
          'DockSite'
          'DoubleBuffered'
          'DragKind'
          'DragMode'
          'Enabled'
          'Font'
          'FormStyle'
          'GlassFrame'
          'Height'
          'HelpContext'
          'HelpFile'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'HorzScrollBar'
          'Icon'
          'KeyPreview'
          'Left'
          'Margins'
          'Menu'
          'Name'
          'ObjectMenuItem'
          'OldCreateOrder'
          'Padding'
          'ParentBiDiMode'
          'ParentCustomHint'
          'ParentFont'
          'PixelsPerInch'
          'PopupMenu'
          'PopupMode'
          'PopupParent'
          'Position'
          'PrintScale'
          'Scaled'
          'ScreenSnap'
          'ShowHint'
          'SnapBuffer'
          'Tag'
          'Top'
          'Touch'
          'TransparentColor'
          'TransparentColorValue'
          'UseDockManager'
          'VertScrollBar'
          'Visible'
          'Width'
          'WindowMenu'
          'WindowState')
      end>
    StorageName = 'cxPropertiesStore'
    StorageType = stStream
    Left = 16
    Top = 64
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
    Left = 48
    Top = 64
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerBar: TdxBar
      AllowClose = False
      Caption = 'Custom'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 671
      FloatTop = 8
      FloatClientWidth = 51
      FloatClientHeight = 71
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbInsert'
        end
        item
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbComplete'
        end
        item
          Visible = True
          ItemName = 'bbUnComplete'
        end
        item
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          Visible = True
          ItemName = 'bbGridToExcel'
        end>
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
    object bbInsert: TdxBarButton
      Action = actInsert
      Category = 0
      Enabled = False
      ImageIndex = 0
    end
    object bbEdit: TdxBarButton
      Action = actUpdate
      Category = 0
      ImageIndex = 1
    end
    object bbComplete: TdxBarButton
      Action = actComplete
      Category = 0
    end
    object bbUnComplete: TdxBarButton
      Action = actUnComplete
      Category = 0
    end
    object bbDelete: TdxBarButton
      Action = actSetErased
      Category = 0
    end
    object bbStatic: TdxBarStatic
      Caption = '     '
      Category = 0
      Visible = ivAlways
    end
    object bbGridToExcel: TdxBarButton
      Action = dsdGridToExcel
      Category = 0
    end
    object bbReCompleteAll: TdxBarButton
      Action = actReCompleteAll
      Category = 0
    end
  end
  object ActionList: TActionList
    Images = dmMain.ImageList
    Left = 80
    Top = 64
    object actRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = dsdStoredProc
      StoredProcList = <
        item
          StoredProc = dsdStoredProc
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
    object actInsert: TdsdInsertUpdateAction
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      FormName = 'TIncomeForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          MultiSelectSeparator = ','
        end
        item
          Name = 'ShowAll'
          Value = True
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end>
      isShowModal = False
      DataSource = DataSource
      DataSetRefresh = actRefresh
      IdFieldName = 'Id'
    end
    object actUpdate: TdsdInsertUpdateAction
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 115
      FormName = 'TWeighingProductionForm'
      FormNameParam.Value = 'TWeighingProductionForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'Id'
          MultiSelectSeparator = ','
        end
        item
          Name = 'ShowAll'
          Value = False
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end>
      isShowModal = False
      ActionType = acUpdate
      DataSource = DataSource
      DataSetRefresh = actRefresh
      IdFieldName = 'Id'
    end
    object actUnComplete: TdsdChangeMovementStatus
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spMovementUnComplete
      StoredProcList = <
        item
          StoredProc = spMovementUnComplete
        end>
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ImageIndex = 11
      Status = mtUncomplete
      DataSource = DataSource
    end
    object actComplete: TdsdChangeMovementStatus
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spMovementComplete
      StoredProcList = <
        item
          StoredProc = spMovementComplete
        end>
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090
      Hint = #1055#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090
      ImageIndex = 12
      Status = mtComplete
      DataSource = DataSource
    end
    object ExecuteDialog: TExecuteDialog
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      ImageIndex = 35
      FormName = 'TMovement_PeriodDialogForm'
      FormNameParam.Value = 'TMovement_PeriodDialogForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'StartDate'
          Value = 42005d
          Component = deStart
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 42005d
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = True
      RefreshDispatcher = RefreshDispatcher
      OpenBeforeShow = True
    end
    object actSetErased: TdsdChangeMovementStatus
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spMovementSetErased
      StoredProcList = <
        item
          StoredProc = spMovementSetErased
        end>
      Caption = #1057#1090#1072#1090#1091#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1091#1076#1072#1083#1077#1085
      Hint = #1057#1090#1072#1090#1091#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1091#1076#1072#1083#1077#1085
      ImageIndex = 13
      Status = mtDelete
      DataSource = DataSource
    end
    object actReCompleteAll: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spMovementReCompleteAll
      StoredProcList = <
        item
          StoredProc = spMovementReCompleteAll
        end>
      Caption = #1055#1077#1088#1077#1087#1088#1086#1074#1077#1089#1090#1080' '#1074#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      Hint = #1055#1077#1088#1077#1087#1088#1086#1074#1077#1089#1090#1080' '#1074#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      ImageIndex = 10
      QuestionBeforeExecute = #1044#1077#1081#1089#1090#1074#1080#1090#1077#1083#1100#1085#1086' '#1087#1077#1088#1077#1087#1088#1086#1074#1077#1089#1090#1080' '#1074#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1079#1072' '#1087#1077#1088#1080#1086#1076'?'
      InfoAfterExecute = #1042#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1079#1072' '#1087#1077#1088#1080#1086#1076' '#1087#1077#1088#1077#1087#1088#1086#1074#1077#1076#1077#1085#1099'.'
    end
    object actRefreshStart: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spGet_UserJuridicalBasis
      StoredProcList = <
        item
          StoredProc = spGet_UserJuridicalBasis
        end
        item
          StoredProc = dsdStoredProc
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
  end
  object dsdStoredProc: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_WeighingProduction'
    DataSet = ClientDataSet
    DataSets = <
      item
        DataSet = ClientDataSet
      end>
    Params = <
      item
        Name = 'inStartDate'
        Value = 41640d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inEndDate'
        Value = 41670d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inIsErased'
        Value = True
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inJuridicalBasisId'
        Value = Null
        Component = JuridicalBasisGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 48
    Top = 184
  end
  object spMovementComplete: TdsdStoredProc
    StoredProcName = 'gpComplete_Movement_WeighingProduction'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 64
    Top = 232
  end
  object PopupMenu: TPopupMenu
    Images = dmMain.ImageList
    Left = 112
    Top = 64
    object N1: TMenuItem
      Action = actComplete
    end
    object N2: TMenuItem
      Action = actUnComplete
    end
  end
  object spMovementUnComplete: TdsdStoredProc
    StoredProcName = 'gpUnComplete_Movement_WeighingProduction'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 72
    Top = 272
  end
  object spMovementSetErased: TdsdStoredProc
    StoredProcName = 'gpSetErased_Movement_WeighingProduction'
    DataSet = ClientDataSet
    DataSets = <
      item
        DataSet = ClientDataSet
      end>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 72
    Top = 320
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 240
    Top = 168
  end
  object dsdDBViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxGridDBTableView
    OnDblClickActionList = <
      item
        Action = actUpdate
      end>
    ActionItemList = <
      item
        Action = actUpdate
        ShortCut = 13
      end>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    ColorRuleList = <>
    ColumnAddOnList = <>
    ColumnEnterList = <>
    SummaryItemList = <>
    Left = 248
    Top = 216
  end
  object PeriodChoice: TPeriodChoice
    DateStart = deStart
    DateEnd = deEnd
    Left = 472
    Top = 24
  end
  object RefreshDispatcher: TRefreshDispatcher
    IdParam.Value = Null
    IdParam.MultiSelectSeparator = ','
    RefreshAction = actRefresh
    ComponentList = <
      item
        Component = PeriodChoice
      end>
    Left = 552
    Top = 24
  end
  object spMovementReCompleteAll: TdsdStoredProc
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inStartDate'
        Value = 41640d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inEndtDate'
        Value = 41670d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 256
    Top = 288
  end
  object JuridicalBasisGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edJuridicalBasis
    Key = '0'
    FormNameParam.Value = 'TJuridical_BasisForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TJuridical_BasisForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'JuridicalBasisId'
        Value = '0'
        Component = JuridicalBasisGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalBasisName'
        Value = ''
        Component = JuridicalBasisGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    Left = 768
  end
  object spGet_UserJuridicalBasis: TdsdStoredProc
    StoredProcName = 'gpGet_User_JuridicalBasis'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'JuridicalBasisId'
        Value = '0'
        Component = JuridicalBasisGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalBasisName'
        Value = ''
        Component = JuridicalBasisGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 824
    Top = 48
  end
  object FormParams: TdsdFormParams
    Params = <>
    Left = 400
    Top = 200
  end
end
