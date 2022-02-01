object ProvidersConnection: TProvidersConnection
  OldCreateOrder = True
  Height = 352
  Width = 688
  object FDConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=curso_polled')
    Connected = True
    Left = 48
    Top = 40
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorHome = 'D:\Projetos\api-rest-pascal'
    Left = 136
    Top = 40
  end
end
