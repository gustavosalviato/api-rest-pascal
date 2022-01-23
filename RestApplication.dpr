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
  Controllers.Product in 'src\controllers\Controllers.Product.pas',
  Services.Client in 'src\services\Services.Client.pas' {ServiceClient: TDataModule},
  Controllers.Client in 'src\controllers\Controllers.Client.pas';

begin
  THorse
  .Use(HandleException)
  .Use(Jhonson());

  Controllers.Product.Registry;
  Controllers.Client.Registry;

  THorse.Listen(9000);

end.
