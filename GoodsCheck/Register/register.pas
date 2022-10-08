unit Register;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IdHTTP, fpjson, jsonparser, global, Dialogs;

function GetRegisterData(url:string; password:string): string;
function SetGlobalData(jsonStr:string; out aRegisterDb:TRegPack; Out rgted:boolean):boolean;

implementation

function GetRegisterData(url:string; password:string): string;
var
  lHTTP: TIdHTTP;
  ReqJson: TStringStream;
  respJson:string;
begin

  ReqJson := TStringStream.Create('{"password":"'+password+'"}', TEncoding.UTF8);
  ReqJson.Position:=0;
  lHTTP := TIdHTTP.Create;
  lHTTP.ReadTimeout:=5000;
  lHTTP.ConnectTimeout:=5000;
  lHTTP.Request.ContentType := 'application/json';
  lHTTP.Request.CharSet := 'utf-8';
  try
    respJson := lHTTP.Post(url, ReqJson);
    result:=respJson;
  finally
    lHTTP.Free;

    ReqJson.Free;
  end;
end;
function SetGlobalData(jsonStr:string; out aRegisterDb:TRegPack; Out rgted:boolean):boolean;
var
  J: TJSONData;

begin
     rgted:=False;
    J:=GetJSON(jsonStr);
    aRegisterDb.CompanyName:=J.FindPath('register.company_name').AsString;
    aRegisterDb.FachadaName:=J.FindPath('register.fiscal_name').AsString;
    aRegisterDb.Cif:=J.FindPath('register.cif').AsString;
    aRegisterDb.Address:=J.FindPath('register.address').AsString;
    aRegisterDb.PostCode:=J.FindPath('register.post_code').AsString;

    aRegisterDb.City:=J.FindPath('register.city').AsString;
    aRegisterDb.Provincia:=J.FindPath('register.province').AsString;
    aRegisterDb.Tel:=J.FindPath('register.tel').AsString;
    aRegisterDb.Version:=J.FindPath('register.version').AsString;
    aRegisterDb.IniDate:='';

    aRegisterDb.FinDate:=J.FindPath('register.fin_date').AsString;

    aRegisterDb.PcNumber:=J.FindPath('register.pc_number').AsInteger ;

    if ((aRegisterDb.Version='PcWork') or (aRegisterDb.Version='NetWork')) and (aRegisterDb.cif <> '') then
     begin
    rgted:=True;
     end;
    result:=rgted;
end;
end.

