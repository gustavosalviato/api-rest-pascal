unit Controllers.Product;

interface

uses Horse;

procedure Registry;

implementation
uses
  Services.Product, System.JSON, DataSet.Serialize, Data.DB;

procedure ListAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FReturn: TJSONObject;
  FService: TServiceProduct;
begin
  FService := TServiceProduct.Create();
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
  FProductID: String;
  FService: TServiceProduct;
begin
  FService := TServiceProduct.Create();
  FProductID := Req.Params['id'];
  try
    if (FService.GetById(FProductID)).IsEmpty then
    begin
      raise EHorseException.Create(THTTPStatus.NotFound,'record not found');
    end;
    Res.Send(FService.qRegister.ToJSONObject());
  finally
    FService.Free;
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FService: TServiceProduct;
  FProductID : String;
begin
  FService := TServiceProduct.Create();
  FProductID := Req.Params['id'];
  try
    if (FService.GetById(FProductID).IsEmpty) then
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
  FProductID : String;
  FService: TServiceProduct;
  FProduct : TJSONObject;
begin
  FService := TServiceProduct.Create();
  FProductID := Req.Params['id'];
  try
    if (FService.GetById(FProductID)).IsEmpty then
    begin
      raise EHorseException.Create(THTTPStatus.NotFound, 'record not found');
    end;

    FProduct := Req.Body<TJSONObject>;

    if (FService.Update(FProduct)) then
    begin
      Res.Status(THTTPStatus.NoContent);
    end;


  finally
    FService.Free;
  end;
end;

procedure Append(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FService: TServiceProduct;
  FProduct: TJSONObject;
begin
  FService := TServiceProduct.Create();
  FProduct := Req.Body<TJSONObject>;
  try
    if (FService.Append(FProduct)) then
    begin
      Res.Send(FService.qRegister.ToJSONObject()).Status(THTTPStatus.Created);
    end;

  finally
    FService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/products', ListAll);
  THorse.Get('/products/:id', GetById);
  THorse.Delete('/products/:id', Delete);
  THorse.Put('/products/:id', Update);
  THorse.Post('/products', Append);
end;

end.
