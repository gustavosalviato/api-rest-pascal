unit Providers.Register;

interface

uses
  System.SysUtils, System.Classes, Providers.Connection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, System.JSON, System.Generics.Collections,
  FireDAC.VCLUI.Wait;

type
  TProvidersRegister = class(TProvidersConnection)
    qRegister: TFDQuery;
    qSelect: TFDQuery;
    qRecordCount: TFDQuery;
    qRecordCountCOUNT: TLargeintField;
  private
    { Private declarations }
  public
    { Public declarations }
    function Append(const AJson: TJSONObject): Boolean; virtual;
    function Update(const AJson: TJSONObject): Boolean; virtual;
    function Delete: Boolean; virtual;
    function ListAll(const AParams: TDictionary<String, String>)
      : TFDQuery; virtual;
    function GetById(const AId: String): TFDQuery; virtual;
    function GetRecordCount: Int64; virtual;
  end;

var
  ProvidersRegister: TProvidersRegister;

implementation

uses DataSet.Serialize;

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}
{ TProvidersRegister }

function TProvidersRegister.Append(const AJson: TJSONObject): Boolean;
begin
  qRegister.SQL.Add('WHERE 1 <> 1');
  qRegister.Open();
  qRegister.LoadFromJSON(AJson, False);
  Result := qRegister.ApplyUpdates(0) = 0;
end;

function TProvidersRegister.Delete: Boolean;
begin
  qRegister.Delete;
  Result := qRegister.ApplyUpdates(0) = 0;
end;

function TProvidersRegister.GetById(const AId: String): TFDQuery;
begin
  qRegister.SQL.Add('WHERE id = :id');
  qRegister.ParamByName('id').AsLargeInt := AId.ToInt64;
  qRegister.Open();
  Result := qRegister;
end;

function TProvidersRegister.GetRecordCount: Int64;
begin
  qRecordCount.Open();
  Result := qRecordCountCOUNT.AsLargeInt;
end;

function TProvidersRegister.ListAll(const AParams: TDictionary<String, String>): TFDQuery;
begin
  if (AParams.ContainsKey('limit')) then
  begin
    qSelect.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    qSelect.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
  end;
  if (AParams.ContainsKey('offset')) then
  begin
    qSelect.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
  end;
  qSelect.Open();
  Result := qSelect;
end;

function TProvidersRegister.Update(const AJson: TJSONObject): Boolean;
begin
  qRegister.MergeFromJSONObject(AJson, False);
  Result := qRegister.ApplyUpdates(0) = 0;
end;

end.
