inherited ServiceOrder: TServiceOrder
  inherited qRegister: TFDQuery
    AfterInsert = qRegisterAfterInsert
    SQL.Strings = (
      
        'SELECT P.ID, P.ID_CLIENTE, P.ID_USUARIO, C.NOME AS NOME_CLIENTE,' +
        ' P.DATA '
      ' FROM PEDIDO P'
      ' INNER JOIN CLIENTE C ON C.ID = P.ID_CLIENTE ')
    object qRegisterid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qRegisterid_cliente: TLargeintField
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
    end
    object qRegisterid_usuario: TLargeintField
      FieldName = 'id_usuario'
      Origin = 'id_usuario'
    end
    object qRegisternome_cliente: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_cliente'
      Origin = 'nome_cliente'
      Size = 60
    end
    object qRegisterdata: TSQLTimeStampField
      FieldName = 'data'
      Origin = 'data'
    end
  end
  inherited qSelect: TFDQuery
    SQL.Strings = (
      
        'SELECT P.ID, P.ID_CLIENTE, P.ID_USUARIO, C.NOME AS NOME_CLIENTE,' +
        ' P.DATA  FROM PEDIDO P'
      'INNER JOIN CLIENTE C ON C.ID = P.ID_CLIENTE WHERE 1 = 1 ')
    object qSelectid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qSelectid_cliente: TLargeintField
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
    end
    object qSelectid_usuario: TLargeintField
      FieldName = 'id_usuario'
      Origin = 'id_usuario'
    end
    object qSelectnome_cliente: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_cliente'
      Origin = 'nome_cliente'
      Size = 60
    end
    object qSelectdata: TSQLTimeStampField
      FieldName = 'data'
      Origin = 'data'
    end
  end
  inherited qRecordCount: TFDQuery
    SQL.Strings = (
      'SELECT COUNT(P.ID)FROM PEDIDO P'
      'INNER JOIN CLIENTE C ON C.ID = P.ID_CLIENTE WHERE 1 = 1 ')
  end
end
