unit uFS;

//{$mode objfpc}{$H+}
//{$mode delphi}{$H+}

interface

uses
  Classes;

type
  TFileStreamUtf8 = class(THandleStream)
  public
    constructor Create(const avName: string; avMode: Word);
    destructor Destroy; override;
  end;

implementation

uses
  SysUtils;

constructor TFileStreamUtf8.Create(const avName: string; avMode: Word);
var
  h: THandle;
begin
  If (avMode and fmCreate) > 0 then
    h := FileCreate(avName)
  else
    h := FileOpen(avName, avMode);
  If h = NativeUInt(-1) then
    Abort;
  inherited Create(h);
end;

destructor TFileStreamUtf8.Destroy;
begin
  FileClose(Self.Handle);
  inherited;
end;

end.

