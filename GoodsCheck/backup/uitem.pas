unit UItem;

{$mode objfpc}{$H+}

interface

uses
    {$IFNDEF LCL} Windows, Messages, {$ELSE} LclIntf, LMessages, LclType, LResources, {$ENDIF}
  Classes, SysUtils, Forms,  Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, Buttons,blcksock, Variants,   PingThread, winsock, SyncObjs, IcmpThread,
    Udata;

Const
 WM_THREAD_MSG           = WM_USER + $1;
 WM_THREAD_MSG_W_RunOver = 1;
 WM_THREAD_MSG_W_OneSucc = 2;
 WM_THREAD_MSG_W_Test = 3;
 WM_THREAD_MSG_W_IPSucc = 4;



 {$IFDEF LCL}
type
  TMessage = TLMessage;
{$ENDIF}

  type
  TStringArray = array of string;

  TTryIPPortThread = class(TThread)    //端口扫描线程
  private
  FIP:string;
  IpListView: TListView;
    procedure TryIPPortsByIP(IP:Ansistring);
    procedure TryIPPorts(IP:Ansistring);

    Function GetNextIPPort( var Port : integer) : Boolean;
  protected
    procedure Execute; override;
  end;

  { TfrmItem }

  TfrmItem = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LanList: TListBox;
    LanRang: TGroupBox;
    ListViewIp: TListView;
    MSGBox: TMemo;
    Panel1: TPanel;
    PB: TProgressBar;
    Timer: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure LabeledEdit1Exit(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GetLanRange();
    procedure DoLanIPScan();
    procedure DoIpPortScan();
    procedure TimerTimer(Sender: TObject);
  private
   // WM_MY_MESSAGE: UINT;
   // procedure OnThreadMsg(var Msg : TMessage); message WM_THREAD_MSG;
    procedure WndProc(var Msg: TLMessage); message WM_THREAD_MSG;
  procedure SetItem(avItem: TConectItem);
    procedure GetItem(avItem: TConectItem);

    // 取 VT 节点数据
   // function GetPTarget(aPNode: PVirtualNode): PICMPTarget;
    // 增加日志节点
    procedure AddPTarget(aPTarget: PICMPTarget);
    // 增加成功的节点
    procedure AddSuccess(aPTarget: PICMPTarget);
  public
    { Public declarations }
    class function Execute(avData: TCollection; avIndex: LongInt): Boolean;
     procedure DoICMPRequestTarget(Sender: TObject; var aPTarget: PICMPTarget);
    procedure DoICMPSuccess(Sender: TObject);
    procedure DoICMPFail(Sender: TObject);

  end;

var
  frmItem: TfrmItem;
  piStartIP , piEndIP , piIPIndex : DWORD;      //要扫描的IP范围
  paPortArray : array of integer;               //端口列表
  piPortIndex , piPortArrayHigh : DWORD;        //端口取值及，列表High
  piThreadBusyCount : integer;                  //工作中的线程记数
  pbRuning : Boolean;                           //控制运行标记
  piProcSel : integer;                          //扫描方式选择
  piTimeOut : integer;                          //设置连接超时
  prLock : TRTLCriticalSection;                 //列表锁
  pbSendaChar : Boolean;                        //是否发送一个字符
  FormHandle : THandle;                         //主窗口句柄
  IpCount: integer;
  Lock: TCriticalSection;

  LPTargetArray: PICMPTargetArray;
  aList:Tlist;  //用于记录ip地址

implementation

{$R *.lfm}

function ClonePTarget(aPTarget: PICMPTarget): PICMPTarget;
begin
  New(Result);
  Result^ := aPTarget^;
end;
{
function SplitString(Text: String; Delimiter:string): TStringArray;
var
   intIdx: Integer;
   intIdxOutput: Integer;
//const
  // Delimiter = '.';
begin
   intIdxOutput := 0;
   SetLength(Result, 1);
   Result[0] := '';

   for intIdx := 1 to Length(Text) do
   begin
      if Text[intIdx] = Delimiter then
      begin
         intIdxOutput := intIdxOutput + 1;
         SetLength(Result, Length(Result) + 1);
      end
      else
         Result[intIdxOutput] := Result[intIdxOutput] + Text[intIdx];
   end;
end;
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
{ TTryIPPortThread }
 {
procedure LockInc(Adr : PDWORD);
asm
  LOCK INC DWORD PTR [EAX];
end;

procedure LockDec(Adr : PDWORD);
asm
  LOCK DEC DWORD PTR [EAX];
end;

Function LockXInc(Adr : PDWORD) : DWORD;
asm
  MOV  EDX , Adr;
  MOV  EAX , 1;
  LOCK XADD DWORD PTR [EDX] , EAX;
end;
}

procedure LockInc(Adr : PDWORD);
begin
  Lock.Acquire;
  try
    inc(Adr);
  finally
    Lock.Release;
  end;
end;

procedure LockDec(Adr : PDWORD);
begin
  Lock.Acquire;
  try
    Dec(Adr);
  finally
    Lock.Release;
  end;
end;

Function LockXInc(Adr : word) : word;
begin
 Lock.Acquire;
  try
   Result:= Adr+1;
  finally
    Lock.Release;
  end;
end;

procedure TTryIPPortThread.Execute;
begin
  LockInc(@piThreadBusyCount);
  if piProcSel=0 then TryIPPortsByIP(FIP)
  else TryIPPorts(FIP);
  LockDec(@piThreadBusyCount);
  if piThreadBusyCount=0 then // pbRuning := False;
    PostMessage(FormHandle , WM_THREAD_MSG , WM_THREAD_MSG_W_RunOver , $111);
end;

Function TryIPPort(Const IP : AnsiString; Port : integer) : Boolean;
var
  Sock : TSocket;
  SA   : TSockaddr;
  n , ul : integer;
  TV : TTimeVal;
  FDSet : TFDSet;
begin
  FillChar(SA , SizeOf(SA) , 0);
  SA.sin_family      := AF_INET;
  SA.sin_port        := htons(Port);
  SA.sin_addr.S_addr := inet_addr(Pointer(IP));
  Sock               := Socket(AF_INET , SOCK_STREAM , IPPROTO_IP);
  Result             := Sock<>invalid_socket;
  if Result then begin
    n := piTimeOut * 1000;
    ul := 1;
    if (SetSockopt(Sock , SOL_SOCKET , SO_SNDTIMEO , @n , SizeOf(n))<>SOCKET_ERROR) and
       (SetSockopt(Sock , SOL_SOCKET , SO_RCVTIMEO , @n , SizeOf(n))<>SOCKET_ERROR) and
       (ioctlsocket(Sock, FIONBIO, ul)<>SOCKET_ERROR) then begin
      Connect(Sock , SA , SizeOf(SA));
      FD_ZERO(FDSet);
      FD_SET(Sock , FDSet);
      TV.tv_sec := piTimeOut;
      TV.tv_usec := 0;
      Result := select(0, NIL , @FDSet , NIL , @TV)>0;

      if Result and pbSendaChar then
        Result := Send(Sock , SA , 1 , 0) = 1;
    end;
    CloseSocket(Sock);
  end;
end;


//获取扫描的任务
function TTryIPPortThread.GetNextIPPort(
  var Port: integer): Boolean;
var
  i : integer;
  nIP : DWORD;
begin
  Result := True;
  EnterCriticalSection(prLock);
  if piPortIndex=piPortArrayHigh then
    begin
      inc(piIPIndex);
      //Result := piIPIndex <= piEndIP;
      result:= piIPIndex <=IpCount;
      if Result then piPortIndex := 0;
    end
  else inc(piPortIndex);
  i := piPortIndex;
  LeaveCriticalSection(prLock);
  if Result then begin
   // IP := IntToIPV4(nIP);
    Port := paPortArray[i];
  end;
  //inc(piPortIndex)
end;

//扫描总循环
procedure TTryIPPortThread.TryIPPorts(ip:ansistring);
var
  aIP : AnsiString;
  Port : integer;
  PS, PSTest : PAnsiString;
  i,x:integer;
begin
  while pbRuning and GetNextIPPort(Port) do begin
  New(PSTest);
  PSTest^ := IP + ':'+IntToStr(Port);
  PostMessage(FormHandle , WM_THREAD_MSG , WM_THREAD_MSG_W_Test , integer(PSTest));
   // frmItem.MSGBox.Lines.Add('扫描:'+IP+' 端口'+Inttostr(Port));
    if TryIPPort(IP , Port) then begin
      New(PS);
      PS^ := IP + ':'+IntToStr(Port);
      PostMessage(FormHandle , WM_THREAD_MSG , WM_THREAD_MSG_W_OneSucc , integer(PS));

    end;
  end;
end;

//这是我喜欢的方式，比如扫描一个D段的1433端口，那将很快
procedure TTryIPPortThread.TryIPPortsByIP(IP:Ansistring);
var
  nIP : DWORD;
  //IP : AnsiString;
  i , Port, x, m : integer;
  PS, PSTest : PAnsiString;
begin
m:=0;
  while pbRuning do begin
    nIP := LockXInc(piIPIndex);
    if nIP>IpCount then Break;
    if m > piPortArrayHigh then break;

    for i := 0 to piPortArrayHigh do begin
     inc(m);
      Port := paPortArray[i];
      New(PSTest);
        PSTest^ := IP + ':'+IntToStr(Port);
        PostMessage(FormHandle , WM_THREAD_MSG , WM_THREAD_MSG_W_Test , integer(PSTest));

      sleep(100);
      if TryIPPort(IP , Port) then begin
        New(PS);
        PS^ := IP + ':'+IntToStr(Port);
        PostMessage(FormHandle , WM_THREAD_MSG , WM_THREAD_MSG_W_OneSucc , integer(PS));


      end;
    end;
  end;
end;


procedure TfrmItem.FormShow(Sender: TObject);
begin
  FormHandle:=Self.Handle;

  //DoLanIPScan();
end;

procedure TfrmItem.GetLanRange();
var
  TcpSock: TTCPBlockSocket;
  ipList: TStringList;
  i: integer;
  IP:String;
  Range: TStringArray;
begin
 // Result := '';
LanList.Clear;
 LanList.Items.Add(Format('%s.%s.%s.',['127','0','0']));
  ipList := TStringList.Create;
  try
    TcpSock := TTCPBlockSocket.create;
    try
      TcpSock.ResolveNameToIP(TcpSock.LocalName, ipList);
     // Result := ipList.CommaText;
      if IPList.Count =0  then
    begin MSGBox.Lines.Add('什么都没有发现.你确定你安装了网络卡并且已经联网?');
    exit;
    end;

    for I := 0 to IPList.Count - 1 do
       begin
       Ip:= IPList.Strings[I];
       MSGBox.Lines.Add('发现本机IP: '+IP);
      // Range:=SplitString(IP, '.');
       Range :=IP.Split('.');
       if Length(Range) <> 4 then continue ;

       LanList.Items.Add(Format('%s.%s.%s.',[Range[0],Range[1],Range[2]]));
       end;

    finally
      TcpSock.Free;
    end;
  finally
    ipList.Free;
  end;
end;

procedure TfrmItem.DoLanIPScan();
var
 ScanStart:String;// = '192.168.1.1'; {Change these addresses to suit your network}
 ScanEnd:String; // = '192.168.1.254';

 i,j:Cardinal;
 PingStart:Cardinal;
 PingEnd:Cardinal;
 PingCount:Cardinal;
 PingResults:array of TPingResult;
 PingThreads:array of TPingThread;
 ThreadsComplete:Boolean;
 IPRange:string;
 X:integer;
 PS :PAnsiString;
begin
  sleep(1000);
  ListViewIp.Items.Clear;
  for X := 0 to LanList.Count-1 do
  begin
   {清空}
   SetLength(PingResults,0);
   SetLength(PingThreads,0);
   IPRange:=LanList.Items[X];
   {本地}
   if IPRange='127.0.0.' then
   begin
     {Initialize arrays}
   PingCount:=1;
   SetLength(PingResults,PingCount);
   SetLength(PingThreads,PingCount);
   PingResults[0].IPAddress:='127.0.0.1';   //IPToStr(CardinalToIP(i));
   PingResults[0].Exists:=False;
   PingThreads[0]:=TPingThread.Create(PingResults[0]);
   repeat
    ThreadsComplete:=True;
    Sleep(100);
    if not PingThreads[0].Ready then
    begin
    ThreadsComplete:=False;
    Break;
    end;
   until ThreadsComplete;
    {Dislay results}

    if PingThreads[0].PingResult.Exists then
    begin
    New(PS);
    PS^ := PingThreads[0].PingResult.IPAddress;
    PostMessage(FormHandle , WM_THREAD_MSG , WM_THREAD_MSG_W_IPSucc , integer(PS));
    //SendMessage(FormHandle, WM_THREAD_MSG, WM_THREAD_MSG_W_IPSucc , integer(PS));
   // MSGBox.Lines.add(IntToStr(i + 1) + '  ' + PingThreads[i].PingResult.IPAddress);
    end;


    {Free threads}

    PingThreads[0].Free;

   end
   else
   begin
   PingStart:=1;  //IPToCardinal(StrToIP(IPRange+inttostr(1)));
   PingEnd:=254;   //IPToCardinal(StrToIP(IPRange+inttostr(254)));
   {Get count}
   PingCount:=(PingEnd - PingStart) + 1;
   SetLength(PingResults,PingCount);
   SetLength(PingThreads,PingCount);
   j:=0;
   for i:=PingStart to PingEnd do
    begin
     PingResults[j].IPAddress:=IPRange+inttostr(i); //IPToStr(CardinalToIP(i));
     PingResults[j].Exists:=False;
     Inc(j);
    end;

   {Create one thread for each ping}
   for i:=0 to PingCount - 1 do
    begin
     PingThreads[i]:=TPingThread.Create(PingResults[i]);
    end;

   {Wait till all threads are executed}
   repeat
    ThreadsComplete:=True;

    Sleep(100);
    for i:=0 to PingCount - 1 do
     begin
      if not PingThreads[i].Ready then
       begin
        ThreadsComplete:=False;
        Break;
       end;
     end;
   until ThreadsComplete;

   {Dislay results}
   for i:=0 to PingCount - 1 do
    begin
     if PingThreads[i].PingResult.Exists then
      begin
      // MSGBox.Lines.add(IntToStr(i + 1) + '  ' + PingThreads[i].PingResult.IPAddress);
        New(PS);
      PS^ := PingThreads[i].PingResult.IPAddress;
      PostMessage(FormHandle , WM_THREAD_MSG , WM_THREAD_MSG_W_IPSucc , integer(PS));
     //  SendMessage(FormHandle, WM_THREAD_MSG, WM_THREAD_MSG_W_IPSucc , integer(PS));

      end;
    end;

   {Free threads}
   for i:=0 to PingCount - 1 do
    begin
     PingThreads[i].Free;
    end;
  end;

  end;
end;

procedure AppendToPorts(Port : integer);
var
  n : integer;
begin
  if Port>0 then begin
    n := Length(paPortArray);
    SetLength(paPortArray , n+1);
    paPortArray[n] := Port;
  end;
end;


procedure TfrmItem.DoIpPortScan();
var
  i , n : integer;
  ip:string;
begin
SetLength(paPortArray,0);
AppendToPorts(3306);
AppendToPorts(8888);

  pbSendaChar := true;                        //是否发送一个字符
  piProcSel := 0;   //按照IP分配任务（适合于IP多，端口少的情况）
  pbRuning := True;
  piTimeOut := 2;
  piThreadBusyCount:=0;
  piPortIndex := DWORD(-1);
  piPortArrayHigh := High(paPortArray);
  piStartIP:=0;
  Button1.Caption := '停止扫描';
  Button1.OnClick := @StopBtnClick;
  piIPIndex := 0;
  n:=ListViewIp.Items.Count;
  IpCount:= ListViewIp.Items.Count;

  if piTimeOut<=0 then piTimeOut := 2;
  PB.Max := n - piStartIP + 1;
  PB.Position := 0;

  MSGBox.Lines.Add('开始扫描... ');
  for i := 0 to n-1 do begin
    ip:=ListViewIp.Items[i].Caption;
    MSGBox.Lines.Add('载入IP: '+ip);
    with TTryIPPortThread.Create(True) do begin
      FreeOnTerminate := True;
      Fip:=ip;
      Resume;
    end;
  end;
  Timer.Enabled    := True;
end;

procedure TfrmItem.TimerTimer(Sender: TObject);
begin
  PB.Position := piIPIndex - piStartIP;
end;

procedure TfrmItem.StopBtnClick(Sender: TObject);
begin
  Button1.Enabled := False;
  pbRuning := False;
end;


procedure TfrmItem.FormCreate(Sender: TObject);
begin
  aList:=TList.Create;
  GetLanRange();
end;

procedure TfrmItem.Button2Click(Sender: TObject);
var
  n:integer;
begin
n:=(LanList.Count-1) *254 ;
  piStartIP:=0;
 PB.Max := n - piStartIP + 1;
  PB.Position := 0;
  Timer.Enabled    := True;
  piIPIndex:=n;
  DoLanIPScan();
end;

function StrToSimpleAddress(const aStr: string; out aAddress: TSimpleAddress): boolean;
var
  LArray: TStringArray;
  LCount: integer;
  LA1, LA2, LA3, LA4: longint;
begin
  LArray := aStr.Split(['.']);
  LCount := Length(LArray);

  Result := (LCount = 4) and (TryStrToInt(LArray[0], LA1)) and
    (TryStrToInt(LArray[1], LA2)) and (TryStrToInt(LArray[2], LA3)) and
    (TryStrToInt(LArray[3], LA4));

  with aAddress do
  begin
    a1 := LA1;
    a2 := LA2;
    a3 := LA3;
    a4 := LA4;
  end;

end;

function BuildPTargetArray(aFrom, aTo: string;
  out aTargetArray: PICMPTargetArray): boolean;
var
  LFrom, LTo: TSimpleAddress;
  i: byte;
  LLen: integer;
begin
 // SetLength(aTargetArray, 0);
  Result := StrToSimpleAddress(aFrom, LFrom) and StrToSimpleAddress(aTo, LTo);
  if not Result then
    exit;
  Result := (LFrom.a1 = LTo.a1) and (LFrom.a2 = LTo.a2) and (LFrom.a3 = LTo.a3);

  if not Result then
  begin
    raise Exception.Create('当前 地址段不一致');
    Exit;
  end;
 //  frmItem.MSGBox.Lines.Add(aFrom+'++++++'+aTO);
  for i := LFrom.a4 to LTo.a4 do
  begin
    LLen := Length(aTargetArray);
    SetLength(aTargetArray, LLen + 1);
    New(aTargetArray[LLen]);
    aTargetArray[LLen]^.IP := Concat(LFrom.a1.ToString, '.',
      LFrom.a2.ToString, '.', LFrom.a3.ToString, '.', i.ToString);
    aTargetArray[LLen]^.State := S_Ready;
    aTargetArray[LLen]^.StateText := '就绪';
  end;
  // frmItem.MSGBox.Lines.add('nn');
end;

procedure TfrmItem.Button3Click(Sender: TObject);
var
  LTimeOut, LWorkerCount: longint;
  LCount, i, X: integer;
  LP: PICMPTarget;
  IPRange: String;
  Lst:Tlistitem;
begin
  // 清理 成功和日志列表
  ListViewIp.Clear;
  sleep(100);
  Lst:= ListViewIp.Items.Add;
      Lst.Caption := '127.0.0.1';
      Lst.SubItems.Add('');
      Lst.SubItems.Add('');

  aList.Clear;
  LTimeOut := 4000;
  LWorkerCount := 40;
  SetLength(LPTargetArray, 0);
  // 构造目标数组
  for X := 0 to LanList.Count-1 do
  begin
  IPRange:=LanList.Items[X];
   {本地}
   if IPRange='127.0.0.' then
   begin
    if not BuildPTargetArray('127.0.0.1', '127.0.0.1', LPTargetArray) then
    begin
    raise Exception.Create('解析目标失败!');
    Exit;
    end;
   end
   else
   begin
   if not BuildPTargetArray(IPRange+inttostr(1), IPRange+inttostr(254), LPTargetArray) then
    begin
    raise Exception.Create('解析目标失败!');
    Exit;
    end;
   end;
  end;

  MSGBox.Lines.Add(inttostr(length(LPTargetArray))) ;
  // 丢进日志列表

  try
    for LP in LPTargetArray do
    begin
      AddPTarget(LP);
    end;
  finally
  end;
  SetLength(LPTargetArray, 0);

  // 构造工作线程
  for i := 1 to LWorkerCount do
  begin
    MSGBox.Lines.Add('线程'+inttostr(i)+'>>开始工作 ');
    with TICMPThread.Create(LTimeOut) do
    begin
      OnRequestTarget := @DoICMPRequestTarget;
      OnSuccess := @DoICMPSuccess;
      OnFail := @DoICMPFail;
      Start;
    end;
   // iStart(LTimeOut);
  end;

end;

procedure TfrmItem.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  aList.Clear;
end;

procedure TfrmItem.LabeledEdit1Exit(Sender: TObject);
begin

end;

procedure TfrmItem.Button1Click(Sender: TObject);
begin
  Lock:=TCriticalSection.Create;
  DoIpPortScan();
end;


procedure TfrmItem.BitBtn1Click(Sender: TObject);
begin
if LabeledEdit1.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit2.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit3.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit4.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit5.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit6.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit7.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit8.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit9.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit10.Text='' then begin LabeledEdit8.SetFocus; exit; end;



end;

procedure TfrmItem.BitBtn2Click(Sender: TObject);
begin
  close;
end;

class function TfrmItem.Execute(avData: TCollection; avIndex: LongInt): Boolean;
begin
  with Self.Create(nil) do
    try
      if avIndex < 0 then
        Caption := '添加'
      else
        begin
          Caption := '编辑';
          SetItem(TConectItem(avData.Items[avIndex]));
        end;
      Result := (ShowModal = mrOk);
      if Result then
        if avIndex < 0 then
          GetItem(TConectItem(avData.Add))
        else
          GetItem(TConectItem(avData.Items[avIndex]));
    finally
      Destroy;
    end;
end;

procedure TfrmItem.SetItem(avItem: TConectItem);
begin
  Self.LabeledEdit1.Text := avItem.dbHost;
  Self.LabeledEdit2.Text := avItem.dbUser;
  Self.LabeledEdit3.Text := avItem.dbPasswd;
  Self.LabeledEdit4.Text := avItem.dbProtocolo;
  Self.LabeledEdit5.Text := avItem.dbDataBase;
  Self.LabeledEdit6.Text := inttostr(avItem.Port);
  Self.LabeledEdit7.Text := avItem.EMID;
  Self.LabeledEdit8.Text := avItem.PCID;
  Self.LabeledEdit9.Text := avItem.S_Server;
  Self.LabeledEdit10.Text := inttostr(avItem.S_Port);
end;

procedure TfrmItem.GetItem(avItem: TConectItem);
begin
  avItem.dbHost:=Self.LabeledEdit1.Text ;
  avItem.dbUser:= Self.LabeledEdit2.Text ;
  avItem.dbPasswd:= Self.LabeledEdit3.Text;
  avItem.dbProtocolo:= Self.LabeledEdit4.Text;
  avItem.dbDataBase:= Self.LabeledEdit5.Text;
  avItem.Port:= strtoint(Self.LabeledEdit6.Text);
  avItem.EMID:= Self.LabeledEdit7.Text;
  avItem.PCID:= Self.LabeledEdit8.Text;
  avItem.S_Server:= Self.LabeledEdit9.Text;
  avItem.S_Port:= strtoint(Self.LabeledEdit10.Text);
end;

procedure TfrmItem.WndProc(var Msg: TLMessage);
var
  s : WideString;
  buf, PSTest: PAnsiString; //PChar;
  Ip:String;
  x, port:integer;
  Ms: TStringArray;
  Lst : TListItem;
  str:AnsiString;
begin
 // inherited WndProc(Msg);
  case Msg.wParam of
     WM_THREAD_MSG_W_RunOver :
    begin
      Button1.Caption := '开始扫描';
      Button1.OnClick := @Button1Click;
      Button1.Enabled := True;
      Timer.Enabled    := False;
      PB.Position      := 0;
    end;
    WM_THREAD_MSG_W_OneSucc :
    begin
       try
      buf := PAnsiString(Msg.lParam);
     // Ms:=SplitString(buf^, ':');
     //str:=Buf^;
      Ms:=Buf^.Split(':');
        if length(Ms) <> 2 then exit;
        port:=strtoint(Ms[1]);
        MSGBox.Lines.Add('>>>获取>>>'+buf^+'>>>>成功');    //PS^
        for x := 0 to ListViewIp.Items.Count-1 do
        begin
          if ListViewIp.Items[x].Caption=Ms[0] then
          begin
            case Port of
            3306:
            BEGIN
            ListViewIp.Items[x].SubItems.Strings[0]:='OK';
            END;
             8888:
             ListViewIp.Items[x].SubItems.Strings[1]:='OK';
            end;
          end;
        end;
    finally
      //FreeMem(buf);
      Dispose(buf);
    end;
    end;
    WM_THREAD_MSG_W_Test :
    begin
    PSTest :=PAnsiString(Msg.LParam);
      try
      MSGBox.Lines.Add('扫描:'+PSTest^);
      finally
       Dispose(PSTest);
      end;
    end;
    WM_THREAD_MSG_W_IPSucc:
    begin
    buf := PAnsiString(Msg.lParam);
      try
      //frmItem.MSGBox.Lines.Add('扫描:'+PS^);
      Lst:= ListViewIp.Items.Add;
      Lst.Caption := buf^;
      Lst.SubItems.Add('');
      Lst.SubItems.Add('');
      finally
       Dispose(buf);
      end;

    end;

  end;
  {if Msg.Msg = LM_USER then begin
    s := IntToStr(LongWord(ThreadID));
    Memo1.Lines.add(s);   }
 // end;
end;

procedure TfrmItem.DoICMPRequestTarget(Sender: TObject; var aPTarget: PICMPTarget);
var
  LEnum: TListEnumerator; //TVTVirtualNodeEnumerator;
  i:integer;
begin
LEnum := aList.GetEnumerator;
  while LEnum.MoveNext do
  begin
    aPTarget :=LEnum.getCurrent;
    if Assigned(aPTarget) and (aPTarget^.State = S_Ready) then
    begin
      aPTarget^.State := S_Working;
      aPTarget^.StateText := '工作中...';
      Exit;
    end;

  end;
  aPTarget := nil;
  Panel1.Enabled := True;
end;

procedure TfrmItem.DoICMPSuccess(Sender: TObject);
var
  LThread: TICMPThread;
begin
  LThread := TICMPThread(Sender);
  LThread.PTarget^.State := S_Success;
  LThread.PTarget^.StateText :=
    Concat('成功 来自 ', LThread.ReplyFrom, ' 延迟: ',
    LThread.PingTime.ToString, ' TTL: ', LThread.TTL.ToString);
  LThread.PTarget^.State := S_Success;
  AddSuccess(ClonePTarget(LThread.PTarget));
  MSGBox.Lines.Add('检测 >>>'+LThread.ReplyFrom+'>>>失败.');

end;


procedure TfrmItem.DoICMPFail(Sender: TObject);
var
  LThread: TICMPThread;
begin
  LThread := TICMPThread(Sender);
  LThread.PTarget^.State := S_Fail;
  LThread.PTarget^.StateText := '失败!';
  MSGBox.Lines.Add('成功接收 来自<<<'+LThread.ReplyFrom+'<<<信号');
end;
 {
function TfrmItem.GetPTarget(aPNode: PVirtualNode): PICMPTarget;
begin
  Result := PICMPTarget(Pointer(@aPNode^.Data)^);
end;
}
procedure TfrmItem.AddPTarget(aPTarget: PICMPTarget);
begin
  aList.Add(aPTarget);
end;

procedure TfrmItem.AddSuccess(aPTarget: PICMPTarget);
var
Lst:TlistItem;
begin

  Lst:= ListViewIp.Items.Add;
      Lst.Caption := aPTarget^.IP;
      Lst.SubItems.Add('');
      Lst.SubItems.Add('');
end;

{
procedure TfrmItem.OnThreadMsg(var Msg: TMessage);
var
  PS, PSTest : PAnsiString;
  buf: PAnsiChar;
  str:AnsiString;
  Ip:String;
  x, port:integer;
  Ms: TStringArray;
  Lst : TListItem;
begin
  Case Msg.WParam of
    WM_THREAD_MSG_W_RunOver :
    begin
      Button1.Caption := '开始扫描';
      //Button1.OnClick := Button1Click;
      Button1.Enabled := True;
     // Timer.Enabled    := False;
     // PB.Position      := 0;
    end;
    WM_THREAD_MSG_W_OneSucc :
    begin
       try
      buf := PAnsiChar(Msg.lParam);
      //Ms:=SplitString(buf, ':');
      str:=Buf^;
       Ms:=str.Split(':');
        if length(Ms) <> 2 then exit;
        port:=strtoint(Ms[1]);
        MSGBox.Lines.Add('>>>获取>>>'+PS^+'>>>>成功');
        for x := 0 to ListViewIp.Items.Count-1 do
        begin
          if ListViewIp.Items[x].Caption=Ms[0] then
          begin
            case Port of
            3306:
            BEGIN
            ListViewIp.Items[x].SubItems.Strings[0]:='OK';
            END;
             8888:
             ListViewIp.Items[x].SubItems.Strings[1]:='OK';
            end;
          end;
        end;
    finally
      FreeMem(buf);
    end;


    {  PS := @(Msg.LParam);
      try
        Ms:=SplitString(PS^, ':');
        if length(Ms) <> 2 then exit;

        port:=strtoint(Ms[1]);
        MSGBox.Lines.Add('>>>获取>>>'+PS^+'>>>>成功');
        for x := 0 to ListViewIp.Items.Count-1 do
        begin
          if ListViewIp.Items[x].Caption=Ms[0] then
          begin
            case Port of
            3306:
            BEGIN
            ListViewIp.Items[x].SubItems.Strings[0]:='OK';
            END;
             8888:
             ListViewIp.Items[x].SubItems.Strings[1]:='OK';
            end;
          end;

        end;
        Dispose(PS);
      finally
      end; }
    end;
    WM_THREAD_MSG_W_Test :
    begin
    PSTest := @(Msg.LParam);
      try
      MSGBox.Lines.Add('扫描:'+PSTest^);
      finally
       Dispose(PSTest);
      end;
    end;
    WM_THREAD_MSG_W_IPSucc:
    begin
    PS := @(Msg.LParam);
      try
      //frmItem.MSGBox.Lines.Add('扫描:'+PS^);
      Lst:= ListViewIp.Items.Add;
      Lst.Caption := PS^;
      Lst.SubItems.Add('');
      Lst.SubItems.Add('');
      finally
       Dispose(PS);
      end;

    end;
  end;
end;
}
end.

