unit U_Conn_Indy;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, IdComponent, IdBaseComponent,
  LCLType,  Forms,
  IdTCPConnection, IdTCPClient,
  IdSync, IdGlobal,IdException,
  Global;
type

 TSysCharSet = Set of char;

{TMonitorThread}
  TMonitorThread = class(TThread)
  private
    { Private declarations }
    //FEvent: THandle;        //linux?
  protected
    fClient: TIdTCPClient;

   // FStop :dword;
   // FConn: TIdTCPConnection;
    procedure Execute; override;
  public
    constructor Create(aClient: TIdTCPClient);  //reintroduce;
   // constructor Create(AConn: TIdTCPConnection); reintroduce;
  end;

  {TLog}
  TLog = class(TIdSync)
  protected
    FMsg: string; //WideString;
    procedure DoSynchronize; override;
  public
    constructor Create(const AMsg: String);
    class procedure AddMsg(const AMsg: String);
  end;

type
  TDMindy = class(TDataModule)
    IdTCPClient1: TIdTCPClient;
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure IdTCPClient1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
  private
    { Private declarations }
  public
    { Public declarations }
     Mt: TMonitorThread;
  end;

var
  DMindy: TDMindy;
  IsConected: Boolean = False;
 // Mt: TMonitorThread = nil;
  UseName:string;

implementation
uses
Uloginmain, //U_main,
About;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{
function WordPosition(const N: Integer; const S: string; const WordDelims: TSysCharSet): Integer;

var
  PS,P,PE : PChar;
  Count: Integer;

begin
  Result:=0;
  Count:=0;
  PS:=PChar(pointer(S));
  PE:=PS+Length(S);
  P:=PS;
  while (P<PE) and (Count<>N) do
    begin
    while (P<PE) and (P^ in WordDelims) do
      inc(P);
    if (P<PE) then
      inc(Count);
    if (Count<>N) then
      while (P<PE) and not (P^ in WordDelims) do
        inc(P)
    else
      Result:=(P-PS)+1;
    end;
end;


function ExtractWordPos(N: Integer; const S: string; const WordDelims: TSysCharSet; var Pos: Integer): string;
var
  i,j,l: Integer;
begin
  j:=0;
  i:=WordPosition(N, S, WordDelims);
  Pos:=i;
  if (i<>0) then
    begin
    j:=i;
    l:=Length(S);
    while (j<=L) and not (S[j] in WordDelims) do
      inc(j);
    end;
  SetLength(Result,j-i);
  If ((j-i)>0) then
    Move(S[i],Result[1],j-i);
end;

function ExtractWord(N: Integer; const S: string; const WordDelims: TSysCharSet): string;inline;
var
  i: Integer;
begin
  Result:=ExtractWordPos(N,S,WordDelims,i);
end;
}

{TMonitorThread}
constructor TMonitorThread.Create(aClient: TIdTCPClient);
begin
inherited Create(True);
  FreeOnTerminate := True;
 // FTimeOut := aTimeOut;
 // inherited Create(False);
  fClient := aClient;
  //application.CreateForm(TForm_Conn_Terminal, Form_Conn_Terminal);
end;

procedure TMonitorThread.Execute;
var
  S: String;
  Size: integer;
    hextoRecibido,ds: string;
    Recibebuf: TIdBytes;
     xApp: TApplication;
begin
 //xApp := TApplication.Create(nil);

  //xApp.CreateForm(TForm_Conn_Terminal, Form_Conn_Terminal);
    //xApp.Run;
 //  writelog('Indy','Monitor', 'Monitor goto start');
  while not (Terminated) and fClient.Connected   do
  begin
  try

    //这里判断是否网络异常断开.  ??不能
    try
     fClient.IOHandler.CheckForDisconnect(true);
   //  TLog.AddMsg('p...');
    except
      {线程中这里的不激发}

      on E: Exception do
      begin
      Terminate;
      fClient.Disconnect;

      end;
      on F: EIdConnClosedGracefully do
      begin
      Terminate;
      fClient.Disconnect;
      end ;

    end;
     if not fClient.IOHandler.InputBufferIsEmpty then
     begin
      hextoRecibido := fClient.IOHandler.ReadLn(IndyTextEncoding_UTF8);
      ds:=HexToString(hextoRecibido);
     // ds:=ConvertUTF82CP(textoRecibido);
      TLog.AddMsg(ds);
     // writelog('Indy','Monitor', ds);
     end;
     Sleep(100);
    //  TLog.AddMsg('r...');
     except
     {线程中这里的不激发}

     on E: Exception do
      begin
        TLog.AddMsg(E.Message);
        TLog.AddMsg('10');
        writelog('sys','error1', E.Message);
        //if (FClient.Socket) then FClient.Socket.Close;
        FClient.Disconnect;
        Terminate;
      end;
     end;
    end ;

 // FClient.Disconnect;
 // Form_Conn_Terminal.Free;
  //Form_Conn_Terminal.Destroy;
end;



{TLog}
procedure TLog.DoSynchronize;


var
 i, idx,idn:integer;
 cmd:string;
 nameUser:String;
  Commandbuf: TIdBytes;
  CommandBag: TDataPack;
  HEXStrSend,StrSend:string;
  stl:Tstringlist;
  fromname, towho:string;
begin

  // FMsg:=(FMsg);
   writelog('Indy','Monitor', FMsg);
   idx:=pos('@',FMsg);
   cmd:=copy(FMsg,1,idx-1);

   if cmd='Msg' then
    begin
   // StrSend:='Msg@'+fromname+'@one#'+msg ;
      FMsg:= Copy(FMsg, idx+1, Length(FMsg)-idx);
      idn:=pos('@',FMsg);
      fromname:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+1, Length(FMsg)-idn);
      towho:=Copy(FMsg, 1,Pos('#', FMsg)-1);
      FMsg:= Copy(FMsg, Pos('#', FMsg)+1, Length(FMsg)-Pos('#', FMsg));
       {if towho='one' then
      Form_Conn_Terminal.msg.lines.add(fromname+' 跟你说: '+FMsg);
      if towho='all' then
      Form_Conn_Terminal.msg.lines.add(fromname+' 跟大家说: '+FMsg); }
    {  if towho='one' then
      DMindy.msg.lines.add(fromname+'跟你说: '+FMsg);
      if towho='all' then
      DMindy.msg.lines.add(fromname+'跟大家说: '+FMsg);  }
    end
    else
   if cmd='LoginExito' then  begin
      FMsg:= Copy(FMsg, Pos('@', FMsg)+1, Length(FMsg)-Pos('@', FMsg));
      writelog('sys','main', 'LoginExito:'+FMsg);
     { DMindy.msg.lines.add(FMsg);   }
     logined:=true;
     StrSend:='RigisterDb@'+TCPServer.PCID+'|Venta#Give me DB registered';
     HEXStrSend:=toHEXSTRING(StrSend,2);
     DMindy.IdTCPClient1.IOHandler.Writeln(HEXStrSend, IndyTextEncoding_UTF8);
     { StrSend:='list@'+UseName+'|Observador#';
       HEXStrSend:=toHEXSTRING(StrSend,2);
      // DMindy.IdTCPClient1.IOHandler.Write(Integer(Length(HEXStrSend)));
       DMindy.IdTCPClient1.IOHandler.Writeln(HEXStrSend, IndyTextEncoding_UTF8);  }
   end
   else
   if cmd='LoginFaild' then  begin
      FMsg:= Copy(FMsg, Pos('@', FMsg)+1, Length(FMsg)-Pos('@', FMsg));
      writelog('sys','main', 'LoginFaild:'+FMsg);
      logined:=False;
    //  DMindy.msg.lines.add(FMsg);

   end
   else
   if cmd='RigisterDb' then  begin
      FMsg:= Copy(FMsg, idx+1, Length(FMsg)-idx);
      idn:=Pos('@1',FMsg);
      aRegisterDb.CompanyName:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@2',FMsg);
      aRegisterDb.FachadaName:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@3',FMsg);
      aRegisterDb.Cif:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@4',FMsg);
      aRegisterDb.Address:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@5',FMsg);
      aRegisterDb.PostCode:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@6',FMsg);
      aRegisterDb.City:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@7',FMsg);
      aRegisterDb.Provincia:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@8',FMsg);
      aRegisterDb.Tel:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@9',FMsg);
      aRegisterDb.Version:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@A',FMsg);
      aRegisterDb.IniDate:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@B',FMsg);
      aRegisterDb.FinDate:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@C',FMsg);
      aRegisterDb.PcNumber:= strtoint(Copy(FMsg, 1, idn-1));              //strtoint(Copy(FMsg, idn+2, Length(FMsg)-idn-1));
      writelog('sys','main1', 'Registed PC: '+inttostr(aRegisterDb.PcNumber));
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@D',FMsg);
      PcAmout:=strtoint(Copy(FMsg, 1, idn-1));
      writelog('sys','main1', 'Conected Pc Amount: '+inttostr(PcAmout));

      writelog('sys','main1', 'Connected to server.');
      if (aRegisterDb.Version='PcWork') or (aRegisterDb.Version='NetWork') then
       begin
      ReGisted:=True;
      writelog('sys','main1', 'ReGisted is True.');
       end else
       begin
      ReGisted:=False;
      writelog('sys','main1', 'ReGisted is False.');
       end;

     // FormLogin.DoConection;
      if PcAmout > aRegisterDb.PcNumber then
      begin
      writelog('sys','main1', 'Too Many Pc To Connected. You are going to disconnect.');
      DMindy.IdTCPClient1.Disconnect;
      end
      else
      begin
       writelog('sys','main1', 'You are Connected.');
      end;
   end
   else
   if cmd='list' then  begin
      FMsg:= Copy(FMsg, Pos('@', FMsg)+1, Length(FMsg)-Pos('@', FMsg));

     { Form_Conn_Terminal.lnames.Clear;
      Form_Conn_Terminal.edTo.Clear;
      Form_Conn_Terminal.edTo.Items.Add('所有人');
      i := 0;
      Repeat
         i := i + 1;
         nameUser := ExtractWord(i,FMsg, ['|']);
         if nameUser <> '' then begin
            Form_Conn_Terminal.lnames.Items.Add(ExtractWord(i,FMsg, ['|']));
            Form_Conn_Terminal.edTo.Items.Add(ExtractWord(i,FMsg, ['|']));
         end;
      until ExtractWord(i,FMsg, ['|']) = '' ;
      Form_Conn_Terminal.edTo.ItemIndex:=0;    }


    {  DMindy.lnames.Clear;
      DMindy.edTo.Clear;
      stl:=Tstringlist.Create;
     ExtractStrings(['|'],['|',' '],PChar(FMsg),stl);
     //第一个参数是分隔符; 第二个参数是开头被忽略的字符
      i := 0;
      Repeat
       DMindy.lnames.Items.Add(stl[i]);
       DMindy.edTo.Items.Add((stl[i]));
         i := i + 1;
      until i=stl.Count ;
      stl.Free;    }
   end
   else
   if cmd = 'sync' then begin
   FMsg:= copy(FMsg, Pos('@', FMsg)+1, Length(FMsg)-pos('@', FMsg));
   {   Form_Conn_Terminal.msg.lines.add(FMsg);  }
    {  FMsg:= Copy(FMsg, Pos('@', FMsg)+1, Length(FMsg)-Pos('@', FMsg));
       DMindy.msg.lines.add(FMsg);
       StrSend:='list@'+UseName+'|Observador#';
       HEXStrSend:=toHEXSTRING(StrSend,2);
    //   DMindy.IdTCPClient1.IOHandler.Write(Integer(Length(HEXStrSend)));
       DMindy.IdTCPClient1.IOHandler.Writeln(HEXStrSend, IndyTextEncoding_UTF8);    }
   end
   else
   if cmd = 'Regsync' then begin
    FMsg:= Copy(FMsg, idx+1, Length(FMsg)-idx);
      idn:=Pos('@1',FMsg);
      aRegisterDb.CompanyName:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@2',FMsg);
      aRegisterDb.FachadaName:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@3',FMsg);
      aRegisterDb.Cif:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@4',FMsg);
      aRegisterDb.Address:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@5',FMsg);
      aRegisterDb.PostCode:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@6',FMsg);
      aRegisterDb.City:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@7',FMsg);
      aRegisterDb.Provincia:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@8',FMsg);
      aRegisterDb.Tel:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@9',FMsg);
      aRegisterDb.Version:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@A',FMsg);
      aRegisterDb.IniDate:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@B',FMsg);
      aRegisterDb.FinDate:=Copy(FMsg, 1, idn-1);
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@C',FMsg);
      aRegisterDb.PcNumber:= strtoint(Copy(FMsg, 1, idn-1));              //strtoint(Copy(FMsg, idn+2, Length(FMsg)-idn-1));
      writelog('sys','main2', 'Registed PC: '+inttostr(aRegisterDb.PcNumber));
      FMsg:= Copy(FMsg, idn+2, Length(FMsg)-idn-1);
      idn:=Pos('@D',FMsg);
      PcAmout:=strtoint(Copy(FMsg, 1, idn-1));
      writelog('sys','main2', 'Conected Pc Amount: '+inttostr(PcAmout));
      writelog('sys','main2', 'Do sync RegisterDB .');
      if (aRegisterDb.Version='PcWork') or (aRegisterDb.Version='NetWork') then
       begin
     ReGisted:=True;
       end else
      ReGisted:=False;
     //PostMessage(AboutBox.Handle, WM_USERMSG, 2, 0);
     if PcAmout > aRegisterDb.PcNumber then
      begin
      writelog('sys','main', 'Too Many Pc To Connected. You are going to disconnect.');
      DMindy.IdTCPClient1.Disconnect;
      end
      else
      begin
       writelog('sys','main', 'You are Connected.');
      end;
    // PostMessage(Form_Main.Handle, WM_USERMSG, 2, 0);
   end
   else
   if cmd = 'filedata' then begin

      FMsg:= Copy(FMsg, Pos('@', FMsg)+1, Length(FMsg)-Pos('@', FMsg));
      if FMsg='ok' then
      begin
      Transferred:=true;
      StrSend:='syncReg@'+TCPServer.PCID+'|Venta#Give me DB registered';
      //StrSend:='RigisterDb@'+TCPServer.PCID+'|Venta#Give me DB registered';
       HEXStrSend:=toHEXSTRING(StrSend,2);
    //   DMindy.IdTCPClient1.IOHandler.Write(Integer(Length(HEXStrSend)));
       DMindy.IdTCPClient1.IOHandler.Writeln(HEXStrSend, IndyTextEncoding_UTF8);
     // PostMessage(AboutBox.Handle, WM_USERMSG, 1, 0);
      end;
   end
   else
   if cmd = 'exit' then begin
      FMsg:= Copy(FMsg, Pos('@', FMsg)+1, Length(FMsg)-Pos('@', FMsg));
     // DMindy.msg.lines.add(FMsg);
     { Form_Conn_Terminal.lnames.Clear;
      Form_Conn_Terminal.edTo.Clear;
      Form_Conn_Terminal.msg.lines.add(FMsg);  }
      DMindy.IdTCPClient1.Disconnect;
   end
   else begin
     // Form_Conn_Terminal.msg.lines.add(FMsg);
      // Form_Conn_Terminal.msg.lines.add(fromname+' 跟大家说额: '+FMsg);
     // DMindy.msg.lines.add(FMsg);
     // DMindy.WindowState := wsNormal;
   end;
end;

constructor TLog.Create(const AMsg: String);
begin
   FMsg := AMsg;
   inherited Create;
end;

class procedure TLog.AddMsg(const AMsg: String);
var
s:string;
begin

   with Create(AMsg) do
      try
       //FMsg:=Amsg;
        // writelog('sys','error', S);
         Synchronize;
      finally
         Free;
      end;
end;


{$R *.lfm}

procedure TDMindy.IdTCPClient1Connected(Sender: TObject);
var
StrSend, StrSendHex:string;

begin
   IsConected:=True;
  // Logined:=True;
    Mt:=TmonitorThread.Create(IdTCPClient1);
    Mt.Start;
    StrSendHex:=toHEXSTRING('login@'+TCPServer.PCID+'|Venta#',2);
    IdTCPClient1.IOHandler.Writeln(StrSendHex, IndyTextEncoding_UTF8);
    mt.FreeOnTerminate:=True;
    writelog('Indy','Login', 'You Want to Login');

  //  Form_Conn_Terminal:=TForm_Conn_Terminal.Create(DMindy);

end;

procedure TDMindy.IdTCPClient1Disconnected(Sender: TObject);
begin
IsConected:=False;
Logined:=False;
//Form_Conn_Terminal.FreeInstance;
end;

procedure TDMindy.IdTCPClient1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
{if AStatus=hsConnecting then
  begin
   Form_Conn_Terminal.msg.lines.add(Formatdatetime('yyyy-mm-dd hh:nn:ss', now())+': '+ansistring(AStatusText));
  end;
  if AStatus=hsConnected then
  begin
   Form_Conn_Terminal.msg.lines.add(Formatdatetime('yyyy-mm-dd hh:nn:ss', now())+': '+ansistring(AStatusText));

  end;
         }
//网络异常断开, onDisconnected事件不会被激发.
   if AStatus=hsDisconnected then
    begin
    IsConected:=False;
    Logined:=False;

   // Form_Conn_Terminal.lnames.Clear;
   // Form_Conn_Terminal.edTo.Clear;
   // Form_Conn_Terminal.msg.lines.add(Formatdatetime('yyyy-mm-dd hh:nn:ss', now())+': '+ansistring(AStatusText));
    end;
end;

end.
