unit PingThread;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, PingSend;

{type TIPAddress = record
                    Oct1,
                    Oct2,
                    Oct3,
                    Oct4:Byte;
                   end;

function StrToIP(const Value:String):TIPAddress;
function IPToStr(const Address:TIPAddress):String;
function IPToCardinal(const Address:TIPAddress):Cardinal;
function CardinalToIP(const Value:Cardinal):TIPAddress;
function IsIPAddress(const Value:String):Boolean;
Function IntToIPV4(LInt : LongInt) : AnsiString;
Function IPV4ToInt(IP : WideString) : integer;   }

type
     PPingResult = ^TPingResult;
     TPingResult = Record
                     IPAddress:String;
                     Exists:Boolean;
                   end;


type
  TPingThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    PingResult:TPingResult;
    Ready:Boolean;
    constructor Create(Ping:TPingResult);
  end;

implementation

 constructor TPingThread.Create(Ping:TPingResult);
 begin
   PingResult.IPAddress := Ping.IPAddress;
  inherited Create(False);
 end;

 procedure TPingThread.Execute;
 var
   Ping:TPingSend;
 begin
   Ready := false;
   Ping  := TPingSend.Create;
   Ping.Timeout := 3000;
   PingResult.Exists := Ping.Ping(PingResult.IPAddress);
   PingResult.Exists := Ping.Ping(PingResult.IPAddress);
   PingResult.Exists := Ping.Ping(PingResult.IPAddress);
   Ping.Free;
   Ready := true;

 end;
{
 function IPToCardinal(const Address:TIPAddress):Cardinal;
begin
  Result :=  (Address.Oct1*16777216)
            +(Address.Oct2*65536)
            +(Address.Oct3*256)
            +(Address.Oct4);
end;

function CardinalToIP(const Value:Cardinal):TIPAddress;
begin
  Result.Oct1 := Value div 16777216;
  Result.Oct2 := Value div 65536;
  Result.Oct3 := Value div 256;
  Result.Oct4 := Value mod 256;
end;

function IPToStr(const Address:TIPAddress):String;
begin
  Result := IntToStr(Address.Oct1) + '.' +
            IntToStr(Address.Oct2) + '.' +
            IntToStr(Address.Oct3) + '.' +
            IntToStr(Address.Oct4);
end;

function StrToIP(const Value:String):TIPAddress;
var
  n,x: Integer;
  Posi:array[1..4] of Integer;
  Octet:array[1..4] of String;
begin
  x := 0;
  for n := 1 to Length(Value) do
    begin
      if Value[n] = '.'
        then
          begin
            Inc(x);
            Posi[x] := n;
          end
        else Octet[x+1] := Octet[x+1] + Value[n];
    end;
  Result.Oct1 := StrToInt(Octet[1]);
  Result.Oct2 := StrToInt(Octet[2]);
  Result.Oct3 := StrToInt(Octet[3]);
  Result.Oct4 := StrToInt(Octet[4]);
end;

function IsIPAddress(const Value:String):Boolean;
var
  n,x,i: Integer;
  Posi:array[1..4] of Integer;
  Octet:array[1..4] of String;
begin
  Result := true;
  x := 0;

  for n := 1 to Length(Value) do
    if not (Value[n] in ['0'..'9','.'])
      then
        begin
          Result := false;
          break;
        end
      else
        begin
          if Value[n] = '.'
            then
              begin
                Inc(x);
                Posi[x] := n;
              end
            else
              begin
                 Octet[x+1] := Octet[x+1] + Value[n];
              end;
        end;

  for i := 1 to 4 do
    if (StrToInt(Octet[i])>255)then Result := false;
  if x <> 3
    then
      begin
        Result := false;
      end;
end;

Function CopyStrEx(SourceStr : WideString; JGZF : WideChar; Index : integer) : WideString;
var
  P : PChar;
  i : integer;
begin
  Result := '';
  P := Pointer(SourceStr);
  for i:=0 to Length(SourceStr)-1 do begin
    if P^ = JGZF then
      begin
        Dec(Index);
        if Index=0 then Break;
        Result := '';
      end
    else if Index<=1 then Result := Result + P^;
    inc(P);
  end;
end;

Function IPV4ToInt(IP : WideString) : integer;
begin
  Result := StrToInt(CopyStrEx(IP , '.' , 1));
  Result := Result SHL 8;
  Result := Result + StrToInt(CopyStrEx(IP , '.' , 2));
  Result := Result SHL 8;
  Result := Result + StrToInt(CopyStrEx(IP , '.' , 3));
  Result := Result SHL 8;
  Result := Result + StrToInt(CopyStrEx(IP , '.' , 4));
end;

Function IntToIPV4(LInt : LongInt) : AnsiString;
begin
  Result := IntToStr((Lint SHR 24) and $FF) + '.';
  Result := Result + IntToStr((Lint SHR 16) and $FF) + '.';
  Result := Result + IntToStr((Lint SHR 8) And $FF) + '.';
  Result := Result + IntToStr(Lint AND $FF);
end;
}

end.

