inherited ProvidersRegister: TProvidersRegister
  inherited FDPhysPgDriverLink: TFDPhysPgDriverLink
    Left = 152
  end
  object qRegister: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 248
    Top = 40
  end
  object qSelect: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 328
    Top = 40
  end
  object qRecordCount: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 424
    Top = 40
    object qRecordCountCOUNT: TLargeintField
      FieldName = 'COUNT'
    end
  end
end
