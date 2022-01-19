object ProvidersConnection: TProvidersConnection
  Height = 352
  Width = 688
  PixelsPerInch = 96
  object FDConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=API_polled')
    Connected = True
    Left = 48
    Top = 40
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorHome = 'D:\Projetos\API Rest'
    Left = 136
    Top = 40
  end
end
