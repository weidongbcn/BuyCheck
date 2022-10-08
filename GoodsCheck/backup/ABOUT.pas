unit ABOUT;

{$MODE Delphi}

interface

uses
Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, connect,
  LCLType,Variants, Global, LCLIntf, lmessages,
  DefaultTranslator, LResources,
  StdCtrls, Buttons, DbCtrls,
   U_Conn_Indy, IdGlobal;

type

  { TAboutBox }

  TAboutBox = class(TForm)
    Button2: TButton;
    Panel1: TPanel;
    ProductName: TLabel;
    ProgramIcon: TImage;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WMUSERMSG(var msg: TLMessage); message LM_NCHITTEST;  //message WM_USERMSG;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.lfm}

procedure copyfile(sourcefilename,targetfilename:string);
var f1,f2: tfilestream ;
begin

f1:=Tfilestream.Create(sourcefilename,fmopenread);
try
f2:=Tfilestream.Create(targetfilename,fmopenwrite or fmcreate);
try
f2.CopyFrom(f1,f1.size);
finally
f2.Free;
end;
finally
f1.Free;
end;
end;

procedure TAboutBox.WMUSERMSG(var msg: TLMessage);
begin
  case msg.WParam of
    1:
     ShowMessage(Format(MsgReg8, [msg.LParam]));
    2:
    begin
    Edit1.Text:=aRegisterDb.CompanyName;
    Edit2.Text:=aRegisterDb.Cif;
    Edit3.Text:=aRegisterDb.Version;
    Edit4.Text:=IntToStr(aRegisterDb.PcNumber);
    if ReGisted then
    AboutBox.Tag:=1
    else
      AboutBox.Tag:=0;
    end;
   // 3:
   //   ProgressBar1.Position := msg.LParam;
   // 4:
    //  ProgressBar1.Max := msg.LParam;
    5:
    begin
      //idtcpclient1.OnDisconnected(Self);
      IsConected:=False;
    end;
    6:
      ShowMessage(DlgExcept);
   // 7:
   //   ShowProgressBar(False);
  end;
end;

procedure TAboutBox.Button1Click(Sender: TObject);
var
FStream : TFileStream;
filesize:integer;
StrSend, StrSendHex:string;
begin
Transferred:=False;
 if OpenDialog1.Execute then
 begin
  //copyfile(OpenDialog1.FileName, Regfile);
  //ShowMessage(MsgReg7);
  if DMindy.IdTCPClient1.Connected  then
  begin

  try
  FStream:=TFileStream.Create(OpenDialog1.FileName,FmOpenRead);
  FStream.Position:=0;
  FStream.Seek(0,0);
  filesize:=Fstream.Size;
  StrSendHex:=toHEXSTRING('regdat@'+TCPServer.PCID+'|regfile#'+inttostr(filesize),2);
  DMindy.IdTCPClient1.IOHandler.Writeln(StrSendHex, IndyTextEncoding_UTF8);
  DMindy.IdTcpClient1.IOHandler.LargeStream := True;
  DMindy.IdTcpClient1.IOHandler.WriteBufferOpen;
  DMindy.IdTcpClient1.IOHandler.Write(FStream,filesize, False);
  DMindy.IdTcpClient1.IOHandler.WriteBufferFlush;

  //DMindy.IdTcpClient1.IOHandler.Write(FStream,filesize, True);    //此句会有包头
  Finally
  FStream.Free;

  DMindy.IdTcpClient1.IOHandler.WriteBufferClose;
  end;
  end
  else
  begin
   MessageBox(Handle,'没有连接服务器','Error',MB_Ok);
  end;


 end;
end;

procedure TAboutBox.FormShow(Sender: TObject);
begin
  Edit1.Text:=aRegisterDb.CompanyName;
Edit2.Text:=aRegisterDb.Cif;
Edit3.Text:=aRegisterDb.Version;
Edit4.Text:=IntToStr(aRegisterDb.PcNumber);
end;

procedure TAboutBox.FormCreate(Sender: TObject);
begin


end;

procedure TAboutBox.Button2Click(Sender: TObject);
var
StrSend, StrSendHex:string;
begin

  //StrSendHex:=toHEXSTRING('regdat@'+TCPServer.PCID+'|regfile#'+inttostr(filesize),2);
  StrSendHex:=toHEXSTRING('RigisterDb@'+TCPServer.PCID+'|Venta#',2);
  //  IdTCPClient1.IOHandler.Writeln(StrSendHex, IndyTextEncoding_UTF8);
  DMindy.IdTCPClient1.IOHandler.Writeln(StrSendHex, IndyTextEncoding_UTF8);
  writelog('sys','About', 'You Want to get RegisterDB.');
end;

procedure TAboutBox.Button3Click(Sender: TObject);
begin
  Edit1.Text:=aRegisterDb.CompanyName;
Edit2.Text:=aRegisterDb.Cif;
Edit3.Text:=aRegisterDb.Version;
Edit4.Text:=IntToStr(aRegisterDb.PcNumber);
end;

end.
 
