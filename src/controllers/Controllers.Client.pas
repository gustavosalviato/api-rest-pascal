unit Controllers.Client;

interface

uses Horse;

procedure Registry;

implementation

uses Services.Client, System.JSON, DataSet.Serialize, Data.DB;

procedure ListAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FReturn : TJSONObject;
  FService: TServiceClient;
begin
  FService := TServiceClient.Create();
  try
    FReturn := TJSONObject.Create;
    FReturn.AddPair('data', FService.ListAll(Req.Query).ToJSONArray());
    FReturn.AddPair('records', TJSONNumber.Create(FService.GetRecordCount));
    Res.Send(FReturn);
  finally
    FService.Free;
  end;

end;

procedure GetById(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FService: TServiceClient;
  FClientID : String;
begin
  FService := TServiceClient.Create();
  FClientID := Req.Params['id'];
  try
    if (FService.GetById(FClientID).IsEmpty) then
    begin
      raise EHorseException.Create(THTTPStatus.NotFound,'record not found');
    end;
    Res.Send(FService.qRegister.ToJSONObject());
  finally
    FService.Free;
  end;

end;

procedure RegisterClient(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FReturn : TJSONObject;
  FService: TServiceClient;
begin
  FService := TServiceClient.Create();
  FReturn := Req.Body<TJSONObject>;
  try
    if (FService.Append(FReturn)) then
    begin
      Res.Send(FService.qRegister.ToJSONObject()).Status(THTTPStatus.Created);
    end;
  finally
    FService.Free;
  end;

end;

procedure UpdateClient(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FClientID: String;
  FService: TServiceClient;
  FReturn :TJSONObject;
begin
  FService := TServiceClient.Create();
  FClientID := Req.Params['id'];
  try
    if (FService.GetById(FClientID).IsEmpty) then
    begin
      raise EHorseException.Create(THTTPStatus.NotFound,'record not found');
    end;

    FReturn := Req.Body<TJSONObject>;
    if (FService.Update(FReturn)) then
    begin
      Res.Status(THTTPStatus.NoContent);
    end;
  finally
    FService.Free;
  end;

end;

procedure DeleteClient(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FService: TServiceClient;
  FClientID : String;
begin
  FService := TServiceClient.Create();
  FClientID := Req.Params['id'];
  try
    if (FService.GetById(FClientID).IsEmpty) then
    begin
      raise EHorseException.Create(THTTPStatus.NotFound, 'record not found');
    end;

    if (FService.Delete) then
    begin
      Res.Status(THTTPStatus.NoContent);
    end;
  finally
    FService.Free;
  end;

end;

procedure Registry;
begin
  THorse.Get('/clients', ListAll);
  THorse.Get('/clients/:id', GetById);
  THorse.Post('/clients', RegisterClient);
  THorse.Put('/clients/:id', UpdateClient);
  THorse.Delete('/clients/:id', DeleteClient);
end;

end.
