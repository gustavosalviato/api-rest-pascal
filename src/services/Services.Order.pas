unit Services.Order;

interface

uses
  System.SysUtils, System.Classes, Providers.Register, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TServiceOrder = class(TProvidersRegister)
    qSelectid: TLargeintField;
    qSelectid_cliente: TLargeintField;
    qSelectid_usuario: TLargeintField;
    qSelectnome_cliente: TWideStringField;
    qSelectdata: TSQLTimeStampField;
    qRegisterid: TLargeintField;
    qRegisterid_cliente: TLargeintField;
    qRegisterid_usuario: TLargeintField;
    qRegisternome_cliente: TWideStringField;
    qRegisterdata: TSQLTimeStampField;
    procedure qRegisterAfterInsert(DataSet: TDataSet);
  private
  function GetById(const AId: String): TFDQuery; override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceOrder: TServiceOrder;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TServiceOrder.qRegisterAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qRegisterdata.AsDateTime := Now;
end;

function TServiceOrder.GetById(const AId: String): TFDQuery;
begin
  qRegister.SQL.Add('WHERE p.id = :id');
  qRegister.ParamByName('id').AsLargeInt := AId.ToInt64;
  qRegister.Open();
  Result := qRegister;
end;

end.
