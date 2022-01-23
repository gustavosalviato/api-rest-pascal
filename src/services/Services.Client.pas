unit Services.Client;

interface

uses
  System.SysUtils, System.Classes, Providers.Register, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Generics.Collections;

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
    function ListAll(const AParams: TDictionary<String, String>): TFDQuery; override;
  end;

var
  ServiceClient: TServiceClient;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceClient }

function TServiceClient.ListAll(const AParams: TDictionary<String, String>): TFDQuery;
begin
  if (AParams.ContainsKey('id')) then
  begin
    qSelect.SQL.Add('AND ID = :id');
    qSelect.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
    qRecordCount.SQL.Add('AND ID = :id');
    qRecordCount.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
  end;

  if (AParams.ContainsKey('nome')) then
  begin
    qSelect.SQL.Add('AND LOWER(NOME) LIKE :nome');
    qSelect.ParamByName('nome').AsString := '%' + AParams.Items['nome'] + '%';
    qRecordCount.SQL.Add('AND LOWER(NOME) LIKE :nome');
    qRecordCount.ParamByName('nome').AsString := '%' + AParams.Items['nome'] + '%';
  end;

  if (AParams.ContainsKey('status')) then
  begin
    qSelect.SQL.Add('AND STATUS = :status');
    qSelect.ParamByName('status').AsSmallInt := AParams.Items['status'].ToInteger;
    qRecordCount.SQL.Add('AND STATUS = :status');
    qRecordCount.ParamByName('status').AsSmallInt := AParams.Items['status'].ToInteger;
  end;
  qSelect.SQL.Add('ORDER BY ID');
  Result := inherited ListAll(AParams);
end;

end.
