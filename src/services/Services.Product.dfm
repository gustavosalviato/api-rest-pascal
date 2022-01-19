inherited ServiceProduct: TServiceProduct
  PixelsPerInch = 96
  inherited qRegister: TFDQuery
    SQL.Strings = (
      
        'SELECT P.ID, P.NOME, P.VALOR, P.STATUS, P.ESTOQUE '#10'FROM PRODUTO ' +
        'P')
    Left = 256
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
    object qRegistervalor: TFMTBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 20
      Size = 4
    end
    object qRegisterstatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
    object qRegisterestoque: TFMTBCDField
      FieldName = 'estoque'
      Origin = 'estoque'
      Precision = 20
      Size = 4
    end
  end
  inherited qSelect: TFDQuery
    SQL.Strings = (
      
        'SELECT P.ID, P.NOME, P.VALOR, P.STATUS, P.ESTOQUE '#10'FROM PRODUTO ' +
        'P WHERE 1 = 1')
    Left = 336
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
    object qSelectvalor: TFMTBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 20
      Size = 4
    end
    object qSelectstatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
    object qSelectestoque: TFMTBCDField
      FieldName = 'estoque'
      Origin = 'estoque'
      Precision = 20
      Size = 4
    end
  end
  inherited qRecordCount: TFDQuery
    SQL.Strings = (
      'SELECT COUNT(P.ID) FROM PRODUTO P WHERE 1 = 1')
  end
end
