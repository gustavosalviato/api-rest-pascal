inherited ServiceClient: TServiceClient
  inherited qRegister: TFDQuery
    SQL.Strings = (
      'SELECT C.ID, C.NOME, C.STATUS FROM CLIENTE C')
    object qRegisterid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qRegisternome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object qRegisterstatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
  end
  inherited qSelect: TFDQuery
    SQL.Strings = (
      'SELECT C.ID, C.NOME, C.STATUS FROM CLIENTE C WHERE 1 = 1')
    object qSelectid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qSelectnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object qSelectstatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
  end
  inherited qRecordCount: TFDQuery
    SQL.Strings = (
      'SELECT COUNT(C.ID) FROM CLIENTE C WHERE 1 = 1')
  end
end
