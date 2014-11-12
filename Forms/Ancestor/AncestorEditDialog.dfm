inherited AncestorEditDialogForm: TAncestorEditDialogForm
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited bbOk: TcxButton
    Action = InsertUpdateGuides
  end
  inherited bbCancel: TcxButton
    Action = FormClose
  end
  inherited ActionList: TActionList
    inherited actRefresh: TdsdDataSetRefresh
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end>
    end
    object FormClose: TdsdFormClose
      Category = 'DSDLib'
      MoveParams = <>
    end
    object InsertUpdateGuides: TdsdInsertUpdateGuides
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = #1054#1082
    end
  end
  inherited FormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = '0'
        ParamType = ptInput
      end>
  end
  object spInsertUpdate: TdsdStoredProc
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = '0'
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end>
    PackSize = 1
    Left = 264
    Top = 248
  end
  object spGet: TdsdStoredProc
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'Id'
        Value = '0'
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 224
    Top = 248
  end
end
