unit Controllers.Order;

interface

uses Horse;

procedure Registry;

implementation

uses
  Services.Order, System.JSON, DataSet.Serialize, Data.DB;

procedure ListAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FService : TServiceOrder;
  FReturn : TJSONObject;
begin
  FService := TServiceOrder.Create();

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
  FService : TServiceOrder;
  FOrderID : String;
begin
  FService := TServiceOrder.Create();
try
  FOrderID := Req.Params['id'];
  if (FService.GetById(FOrderID).IsEmpty) then
  begin
    raise EHorseException.Create(THTTPStatus.NotFound, 'record not found');
  end;
  Res.Send(FService.qRegister.ToJSONObject());
finally
  FService.Free;
end;

end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FService : TServiceOrder;
  FOrderID : String;
begin
  FService := TServiceOrder.Create();
  FOrderID := Req.Params['id'];
try
  if (FService.GetById(FOrderID).IsEmpty) then
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

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FService : TServiceOrder;
  FReturn : TJSONObject;
  FOrderID : String;
begin
  FService := TServiceOrder.Create();
try
  FOrderID := Req.Params['id'];
  if (FService.GetById(FOrderID).IsEmpty) then
  begin
    raise EHorseException.Create(THTTPStatus.NotFound, 'record not found');
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

procedure Append(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FService : TServiceOrder;
  FReturn : TJSONObject;
begin
  FService := TServiceOrder.Create();
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

procedure Registry;
begin
  THorse.Get('/orders', ListAll);
  THorse.Get('/orders/:id', GetById);
  THorse.Delete('/orders/:id', Delete);
  THorse.Put('/orders/:id', Update);
  THorse.Post('/orders', Append);
end;

end.
