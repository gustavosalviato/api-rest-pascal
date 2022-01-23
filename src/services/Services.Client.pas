unit Services.Client;

interface

uses
  System.SysUtils, System.Classes, Providers.Register, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TServiceClient = class(TProvidersRegister)
    qSelectid: TLargeintField;
    qSelectnome: TWideStringField;
    qSelectstatus: TSmallintField;
    qRegisterid: TLargeintField;
    qRegisternome: TWideStringField;
    qRegisterstatus: TSmallintField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceClient: TServiceClient;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
