unit IcmpThread;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, pingsend;

type
  // 节点状态
  TState = (S_Ready, S_Working, S_Success, S_Fail);
  // 节点绑定数据
  PICMPTarget = ^TICMPTarget;

  TICMPTarget = record
    IP: string;
    State: TState;
    StateText: string;
  end;

  PIpList =^TipList;
  TIpList = record
    Data: TICMPTarget;
    Next:PIPList;
  end;

  PICMPTargetArray = array of PICMPTarget;

  // 小型的ip结构
  TSimpleAddress = record
    a1, a2, a3, a4: byte;
  end;





  { TICMPThread }
  TRequestTargetEvent = procedure(Sender: TObject; var aPTarget: PICMPTarget) of object;

  TICMPThread = class(TThread)
  private
    FPTarget: PICMPTarget;
    FPingTime: integer;
    FReplyCode: byte;
    FReplyErrorDesc: string;
    FReplyFrom: string;
    FTimeOut: cardinal;
    //.
    FOnFail: TNotifyEvent;
    FOnSuccess: TNotifyEvent;
    //.
    FOnRequestTarget: TRequestTargetEvent;
    FTTL: integer;
    //.
    procedure SetOnFail(AValue: TNotifyEvent);
    procedure SetOnSuccess(AValue: TNotifyEvent);
    procedure SetTimeOut(AValue: cardinal);

    procedure SetOnRequestTarget(AValue: TRequestTargetEvent);
    //.
    procedure DoRequestTargetSync;
    procedure DoSuccess;
    procedure DoFail;

  public
    constructor Create(aTimeOut: cardinal);
    destructor Destroy; override;
    //.
    procedure Execute; override;
    //.
    property TimeOut: cardinal read FTimeOut write SetTimeOut;
    //. 工作线程的环境
    property PTarget: PICMPTarget read FPTarget;
    property TTL: integer read FTTL;
    property ReplyCode: byte read FReplyCode;
    property PingTime: integer read FPingTime;
    property ReplyFrom: string read FReplyFrom;
    property ReplyErrorDesc: string read FReplyErrorDesc;
    //.
    property OnRequestTarget: TRequestTargetEvent
      read FOnRequestTarget write SetOnRequestTarget;
    property OnSuccess: TNotifyEvent read FOnSuccess write SetOnSuccess;
    property OnFail: TNotifyEvent read FOnFail write SetOnFail;
  end;

  procedure iStart(TimeOut:longint);

  //  var
 // LHost32Gray, LHost32High, LHost32Success, LHost32Fail: TGraphic;

implementation
uses
  Uitem;




function ClonePTarget(aPTarget: PICMPTarget): PICMPTarget;
begin
  New(Result);
  Result^ := aPTarget^;
end;

{ TICMPThread }

procedure TICMPThread.SetOnRequestTarget(AValue: TRequestTargetEvent);
begin
  if FOnRequestTarget = AValue then
    Exit;
  FOnRequestTarget := AValue;

end;

procedure TICMPThread.DoRequestTargetSync;
begin
  if Assigned(FOnRequestTarget) then
    begin
    FOnRequestTarget(Self, FPTarget);

    end;

end;

procedure TICMPThread.DoSuccess;
begin
  if Assigned(FOnSuccess) then
    FOnSuccess(Self);
 // frmItem.MSGBox.Lines.Add('ss1');
end;

procedure TICMPThread.DoFail;
begin
  if Assigned(FOnFail) then
    FOnFail(Self);
end;

procedure TICMPThread.SetTimeOut(AValue: cardinal);
begin
  if FTimeOut = AValue then
    Exit;
  FTimeOut := AValue;
end;

procedure TICMPThread.SetOnSuccess(AValue: TNotifyEvent);
begin
  if FOnSuccess = AValue then
    Exit;
  FOnSuccess := AValue;
end;

procedure TICMPThread.SetOnFail(AValue: TNotifyEvent);
begin
  if FOnFail = AValue then
    Exit;
  FOnFail := AValue;
end;

constructor TICMPThread.Create(aTimeOut: cardinal);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FTimeOut := aTimeOut;
 // FOnRequestTarget:= @aEvent;
end;

destructor TICMPThread.Destroy;
begin
  inherited Destroy;
end;

procedure TICMPThread.Execute;
var
  LPing: TPINGSend;
begin
  LPing := TPINGSend.Create;

  try
    LPing.Timeout := FTimeOut;

    while (not Terminated) do
    begin
      Synchronize(@DoRequestTargetSync);

      if not Assigned(FPTarget) then
        Break;
      //frmItem.MSGBox.Lines.Add(FPTarget^.IP);
      Uitem.MSGBox.Lines.Add('检查ip>>>'+FPTarget^.IP+'>>>');
      if LPing.Ping(FPTarget^.IP) then
      begin
        if LPing.ReplyError = IE_NoError then
        begin
          FPingTime := LPing.PingTime;
          FReplyCode := LPing.ReplyCode;
          FReplyFrom := LPing.ReplyFrom;
          FTTL := LPing.TTL;
          FReplyErrorDesc := LPING.ReplyErrorDesc;
          Synchronize(@DoSuccess);
        end
        else
          Synchronize(@DoFail);
      end
      else
        Synchronize(@DoFail);

    end;
  finally
    LPing.Free;
  end;
end;

procedure iStart(TimeOut:longint);
begin
 { with TICMPThread.Create(TimeOut) do
    begin
      OnRequestTarget := @frmItem.DoICMPRequestTarget;
      OnSuccess := @frmItem.DoICMPSuccess;
      OnFail := @frmItem.DoICMPFail;
      Start;
    end;  }
end;

end.

