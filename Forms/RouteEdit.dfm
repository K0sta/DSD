﻿inherited RouteEditForm: TRouteEditForm
  Caption = #1053#1086#1074#1099#1081' '#1084#1072#1088#1096#1088#1091#1090
  ClientHeight = 332
  ClientWidth = 380
  ExplicitWidth = 396
  ExplicitHeight = 367
  PixelsPerInch = 96
  TextHeight = 13
  object edMeasureName: TcxTextEdit
    Left = 32
    Top = 86
    TabOrder = 0
    Width = 273
  end
  object cxLabel1: TcxLabel
    Left = 32
    Top = 63
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object cxButton1: TcxButton
    Left = 72
    Top = 288
    Width = 75
    Height = 25
    Action = dsdInsertUpdateGuides
    Default = True
    ModalResult = 8
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 216
    Top = 288
    Width = 75
    Height = 25
    Action = dsdFormClose1
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 8
    TabOrder = 3
  end
  object Код: TcxLabel
    Left = 32
    Top = 19
    Caption = #1050#1086#1076
  end
  object ceCode: TcxCurrencyEdit
    Left = 32
    Top = 42
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 5
    Width = 273
  end
  object ceUnit: TcxButtonEdit
    Left = 32
    Top = 138
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 6
    Width = 273
  end
  object cxLabel7: TcxLabel
    Left = 32
    Top = 115
    Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
  end
  object cxLabel2: TcxLabel
    Left = 32
    Top = 165
    Caption = #1058#1080#1087' '#1084#1072#1088#1096#1088#1091#1090#1072
  end
  object ceRouteKind: TcxButtonEdit
    Left = 32
    Top = 188
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 9
    Width = 273
  end
  object cxLabel3: TcxLabel
    Left = 32
    Top = 221
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1079#1072
  end
  object ceFreight: TcxButtonEdit
    Left = 32
    Top = 244
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 11
    Width = 273
  end
  object ActionList: TActionList
    Left = 320
    Top = 96
    object dsdDataSetRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ShortCut = 116
    end
    object dsdFormClose1: TdsdFormClose
    end
    object dsdInsertUpdateGuides: TdsdInsertUpdateGuides
      Category = 'DSDLib'
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = #1054#1082
    end
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Route'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Component = dsdFormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInputOutput
        Value = '0'
      end
      item
        Name = 'inCode'
        Component = ceCode
        DataType = ftInteger
        ParamType = ptInput
        Value = 0.000000000000000000
      end
      item
        Name = 'inName'
        Component = edMeasureName
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'inUnit'
        Component = ceUnit
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'inRouteKind'
        Component = ceRouteKind
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'inFreight'
        Component = ceFreight
        DataType = ftInteger
        ParamType = ptInput
      end>
    Left = 320
    Top = 40
  end
  object dsdFormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        DataType = ftInteger
        ParamType = ptInputOutput
        Value = '0'
      end>
    Left = 168
    Top = 72
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_Route'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'Id'
        Component = dsdFormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInput
        Value = '0'
      end
      item
        Name = 'Code'
        Component = ceCode
        DataType = ftInteger
        ParamType = ptOutput
        Value = 0.000000000000000000
      end
      item
        Name = 'Name'
        Component = edMeasureName
        DataType = ftString
        ParamType = ptOutput
        Value = ''
      end>
    Left = 224
    Top = 88
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width')
      end>
    StorageName = 'cxPropertiesStore'
    StorageType = stStream
    Left = 96
    Top = 72
  end
  object dsdUserSettingsStorageAddOn1: TdsdUserSettingsStorageAddOn
    Left = 128
  end
  object UnitGuides: TdsdGuides
    Key = '0'
    LookupControl = ceUnit
    FormName = 'TUnitForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Component = UnitGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        Value = '0'
      end
      item
        Name = 'TextValue'
        Component = UnitGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    Left = 127
    Top = 135
  end
  object RouteKindGuides: TdsdGuides
    Key = '0'
    LookupControl = ceRouteKind
    FormName = 'TRouteKindForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Component = RouteKindGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        Value = '0'
      end
      item
        Name = 'TextValue'
        Component = RouteKindGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    Left = 175
    Top = 183
  end
  object FreightGuides: TdsdGuides
    Key = '0'
    LookupControl = ceFreight
    FormName = 'TFreightForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Component = FreightGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        Value = '0'
      end
      item
        Name = 'TextValue'
        Component = FreightGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    Left = 167
    Top = 239
  end
end
