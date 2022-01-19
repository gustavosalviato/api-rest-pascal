program RestApplication;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  System.SysUtils,
  Providers.Connection in 'src\providers\Providers.Connection.pas' {ProvidersConnection: TDataModule},
  Providers.Register in 'src\providers\Providers.Register.pas' {ProvidersRegister: TDataModule},
  Services.Product in 'src\services\Services.Product.pas' {ServiceProduct: TDataModule};

begin
  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('pong');
    end);

  THorse.Listen(9000);

end.
