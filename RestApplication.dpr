program RestApplication;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  System.SysUtils,
  Horse.Jhonson,
  Horse.HandleException,
  Providers.Connection in 'src\providers\Providers.Connection.pas' {ProvidersConnection: TDataModule},
  Providers.Register in 'src\providers\Providers.Register.pas' {ProvidersRegister: TDataModule},
  Services.Product in 'src\services\Services.Product.pas' {ServiceProduct: TDataModule},
  Controllers.Product in 'src\controllers\Controllers.Product.pas';

begin
  THorse
  .Use(HandleException)
  .Use(Jhonson());

  Controllers.Product.Registry;

  THorse.Listen(9000);

end.
