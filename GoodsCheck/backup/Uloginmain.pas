unit Uloginmain;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes,  Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ZDataset, rxcurredit, Global, connect, UItem, UItemList,Udata,
  U_Conn_Indy, LCLIntf,  ShellAPI, Register,
  IdException, ZAbstractRODataset, ZAbstractDataset,
  ZAbstractConnection, ZConnection;

type

  { TFormLogin }

  TFormLogin = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    PasswdEdit: TEdit;
    USEREdit: TEdit;
    Button3: TButton;
    Label4: TLabel;
    Label5: TLabel;
    MyConnection: TZConnection;
    LoginQuery: TZQuery;
    procedure ComboBox1Select(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure USEREditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PasswdEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1CloseUp(Sender: TObject);
  private
    { Private declarations }
    tvStore: TConects;
    tvData: TCollection;
    tvChanged: Boolean;
    procedure UpdateGridRowCount;

   // procedure NotFound;
  public
    { Public declarations }
    procedure DoConection;
    procedure DoIndyConection;
    procedure DoStopIndy;
    function IniciaLogin() : Boolean;
    function CheckUserInfo(AUserName, APassword: string): Boolean;
  end;

  procedure ShowFormLogin;
  function aLogin(): Boolean;

var
  FormLogin: TFormLogin;
  //ci: TConectItem; 移到全局
  zhuti1,zhuti2,zhuti3:string;
  Hecho:boolean;

implementation
{ uses
U_Main_Shoping; }

 
function aLogin(): Boolean;
begin
  //动态创建登录窗口
  with TFormLogin.Create(nil) do
  begin
    //只有返回OK的时候认为登录成功
    Result := ShowModal() = mrOk;
    Free;
  end;
end;

procedure ShowFormLogin;
begin
  with TFormLogin.Create(Application) do
    begin
      ShowModal;
    end;
end;

{$R *.lfm}

function TFormLogin.IniciaLogin() : Boolean;
begin
  ShowFormLogin;
  Result:=Hecho;

end;

function TFormLogin.CheckUserInfo(AUserName, APassword: string): Boolean;
begin

WITH LoginQuery DO
BEGIN
  Connection:=MyConnection;
  Active:=False;
  SQL.Text:='Select * from '+EMID+'LOGIN'
               + ' where Nombre=''' +AUserName
               + ''' and Passwd=md5(''' + APassword+ ''') LIMIT 1;';
  Active:=True;
END;
if LoginQuery.RecordCount<1 then
  begin
    result:=False

  end
  ELSE
  BEGIN
    USER_DERECHO:=Loginquery.FieldByName('DERECHO').AsInteger;
    UseDBC.DBHost:=MyConnection.HostName;
    UseDBC.DBDataBase:=MyConnection.Database;
    UseDBC.DBUser:=MyConnection.User;
    UseDBC.DBPasswd:=MyConnection.Password;
    UseDBC.DBPort:=MyConnection.Port;
    UseDBC.Protocol:=MyConnection.Protocol;
    DBHost:=MyConnection.HostName;
    DBDataBase:=MyConnection.Database;
    DBUsuario:=MyConnection.User;
    DBPasswd:=MyConnection.Password;
    DBProtocolo:=MyConnection.Protocol;
    DBPort:=MyConnection.Port;
    UseDBC.EMID:= EMID;
    LOGIN:=AUserName;
    LoginQuery.Active:=False;
    LoginQuery.SQL.Text:='INSERT INTO '+EMID+'INFOLOGINTERMINAL (ID_TERMINAL, IP_TERMINAL, '
    +'USER )'
    +'VALUES ('''+UseDBC.PCID+''', '+'''127.0.0.1'', '''+LOGIN+''')';     ///ip 地址要修改 2014 0701
    LoginQuery.ExecSQL;
    DataModule2.DoUniConn;
    LoginQuery.Close;
    TAG:=1;
    PCIP:=Ci.dbHost;
    hecho:=True;
    Result :=True;
   // CLOSE;
  END;
   //(AUserName = 'lihd' ) and (APassword = 'P@ssw0rd');
end;

procedure TFormLogin.Button1Click(Sender: TObject);
begin
    if  Self.tvData.Count = 0 then
begin
ComboBox1.SetFocus;
exit;
end;
if TRIM(UserEdit.Text)='' then
BEGIN
  UserEDIT.SetFocus;
  EXIT;
END;

   if CheckUserInfo(Trim(USEREdit.Text), PasswdEdit.Text) then
  begin
    //如果通过检查，返回OK
    Self.ModalResult := mrOk;
  end
   else
   begin
     showmessage(nMSN17);
  USEREdit.Text:='';
  PasswdEdit.Text:='';
  USEREdit.SetFocus;
  exit;
   end;

end;

procedure TFormLogin.Button2Click(Sender: TObject);
begin
 self.modalresult:=mrcancel;
 hecho:=false;
 close;
end;

procedure TFormLogin.Button3Click(Sender: TObject);
begin

{if TfrmItem.Execute(Self.tvData, -1) then
    begin
      Self.tvChanged := True;
      Self.UpdateGridRowCount;
      if Self.tvChanged then
      Self.tvStore.SaveItems;
    end;   }
   { FormItemlist:= TFormItemlist.Create(FormLogin);
    FormItemlist.ShowModal;
    Self.tvStore.LoadItems;
    Self.tvData := Self.tvStore.Items;
    UpdateGridRowCount;
    FormItemlist.Free;
    }
    if FormItemlist.IniciaData() = true then
    begin

    Self.tvStore.LoadItems;
    Self.tvData := Self.tvStore.Items;
    UpdateGridRowCount;
    end;
end;

procedure TFormLogin.ComboBox1Change(Sender: TObject);

begin

 // showmessage(ci.dbHost);
 // DoConection;
end;

procedure TFormLogin.ComboBox1CloseUp(Sender: TObject);
begin

end;

procedure TFormLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{if Tag=0 then
 begin
// Application.Terminate;
 end;
 LoginFrmClose:=True;  }

 Self.tvStore.Free;
end;

procedure TFormLogin.FormCreate(Sender: TObject);
begin
//SetWindowLong(self.Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
{if  ConData.Count > 0 then
  begin
    ci := TConectItem(ConData.Items[0]);
 TCPServer.Server:=ci.S_Server;
  TCPServer.Port:=ci.S_Port;
  TCPServer.PCID:=ci.PCID;
  DoIndyConection;
  end;  }
TAG:=0;
Hecho:=False;

Logined:=true;
Label3.Caption:=nLBN49;
UserEdit.Enabled:=True;
PasswdEdit.Enabled:=True;
UseDBC.PCID:=PCID;
Self.tvStore := TConects.Create;

ComboBox1.Clear;
zhuti1:='各类超市, 存储仓库管理软件'  ;
zhuti2:= 'TPV PARA LA GESTIÓN DE TU TIENDA O COMERCIO';
zhuti3:='Tel: 675 113 787'+'    '+'Email: wyldon@gmail.com';
Label4.Caption:=zhuti1+#13#10+zhuti2+#13#10+zhuti3;
end;

procedure TFormLogin.ComboBox1Select(Sender: TObject);
var
  url:string;
  password:string;
  respJson:string;
begin
  MyConnection.Disconnect;
  ci := TConectItem(Self.tvData.Items[ComboBox1.ItemIndex]);
  //showmessage(inttostr(ci.S_Port));
  if ci.S_Port=8888 then
  begin
  TCPServer.Server:=ci.S_Server;
  TCPServer.Port:=ci.S_Port;
  TCPServer.PCID:=ci.PCID;
  DoStopIndy;
  sleep(1000);
  Label3.Caption:='重新定向新服务器';
  DoIndyConection;
  end;

  if ci.S_Port=8887 then
  begin
       DoStopIndy;
    url:=Format('http://%s:%d/register', [ci.S_Server,ci.S_Port]);
    password:='weidong';
    try
    respJson:=GetRegisterData(url, password);
    SetGlobalData(respJson, aRegisterDB, ReGisted);
    Label3.Caption:='已经连接到端口:'+inttostr(ci.S_Port);
    DoConection;
    except on E: Exception do
     begin
     Label3.Caption:='服务端错误,可能地址错误或者没有启动,请联系管理员.';
     exit;
     end;
    end;
  end;

 // DoConection;
end;

procedure TFormLogin.FormDestroy(Sender: TObject);
begin
//Self.tvStore.Free;
end;

procedure TFormLogin.FormShow(Sender: TObject);
var
PdfToTextPathName:string;
begin
Self.tvStore.LoadItems;
Self.tvData := Self.tvStore.Items;
//showmessage(ChangeFileExt(ParamStr(0), '.cdb'));
if  Self.tvData.Count = 0 then
begin
  if TfrmItem.Execute(Self.tvData, -1) then
    begin
      Self.tvChanged := True;

      //Self.grdMain.Row := Self.grdMain.RowCount - 1;
      //Self.grdMain.Invalidate//.InvalidateRow(Self.grdMain.Row);
      if Self.tvChanged then
      Self.tvStore.SaveItems;
      Self.UpdateGridRowCount;
    end;
end else
begin
ci := TConectItem(Self.tvData.Items[0]);
 //TCPServer.Server:=ci.S_Server;
 // TCPServer.Port:=ci.S_Port;
//  TCPServer.PCID:=ci.PCID;
 // DoIndyConection;
 // sleep(1000);

Self.UpdateGridRowCount;

end;


end;

procedure TFormLogin.PasswdEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_return then
     begin
      Button1Click(self);
     end;
end;

procedure TFormLogin.UpdateGridRowCount;
var
i:integer;
conectiones: TConectItem;
  url:string;
  password:string;
  respJson:string;
begin
  ComboBox1.Clear;

 for I := 0 to (Self.tvData.Count-1) do
 begin
 conectiones:=TConectItem(Self.tvData.Items[i]);
 //ComboBox1.Items.Add(conectiones.dbHost)
  ComboBox1.Items.Add(conectiones.S_Server+':'+inttostr(conectiones.S_Port));

 end;
 ComboBox1.ItemIndex:=0;
 ci := TConectItem(Self.tvData.Items[ComboBox1.ItemIndex]);
 if ci.S_Port = 8888 then
 begin
 TCPServer.Server:=ci.S_Server;
  TCPServer.Port:=ci.S_Port;
  TCPServer.PCID:=ci.PCID;
  DoStopIndy;
  sleep(1000);
  DoIndyConection;
  DoConection;

 end;
 if ci.S_Port=8887 then
  begin
   DoStopIndy;
    url:=Format('http://%s:%d/register', [ci.S_Server,ci.S_Port]);
    password:='weidong';
    try
    respJson:=GetRegisterData(url, password);
    SetGlobalData(respJson, aRegisterDB, ReGisted);
    Label3.Caption:='已经连接到端口:'+inttostr(ci.S_Port);
    DoConection;
    except on E: Exception do
     begin
     Label3.Caption:='服务端错误,可能地址错误或者没有启动,请联系管理员.';
     exit;
     end;
    end;
  end;
end;


procedure TFormLogin.USEREditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_return then
     begin
      if Key=VK_Return then SelectNext(ActiveControl,True,True);
      //PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
     end;
end;


procedure TFormLogin.DoIndyConection;
var
server:string;
port:integer;
begin
//showmessage('do'+inttostr(TCPServer.Port));

 if IsConected=False then
  begin

  try
     
   // DMindy.IdTCPClient1.ReuseSocket := rsTrue;
   server:=TCPServer.Server;
      DMindy.IdTCPClient1.Host:=server;
      DMindy.IdTCPClient1.Port:=TCPServer.Port;
      DMindy.IdTCPClient1.Connect;
      writelog('sys','Login', 'You are Connected.');
    //  Label3.Caption:='已连接indy服务';
      IsConected:=True;
    except
      on E: Exception do
      begin

      DMindy.IdTCPClient1.Disconnect;
      IsConected:=False;
        SHOWMESSAGE('indy服务器错误');

      end;
      on F: EIdConnClosedGracefully do
      begin

         ShowMessage('Gracefully disconnected');
      end ;
  end;

  end;
end;

procedure TFormLogin.DoStopIndy;
begin
  try
      DMindy.IdTCPClient1.Disconnect;
      IsConected:=False;
    except
      on E: Exception do
      begin
        SHOWMESSAGE('错误:连接无法停止,请联系管理员.');
      end;

  end;
end;

procedure TFormLogin.DoConection;
begin

writelog('sys','Login', 'You Do a Connected.');
 if Logined=true then
begin
//Label5.Caption:='3层沟通没问题';
//showmessage('b1');
MyConnection.Disconnect;
MyConnection.LibraryLocation:=RutaSqlLib+'libmysql.dll';
MyConnection.HostName:=ci.dbHost;// DBLookupComboBox1.ListSource.DataSet.FieldByName('HOST').AsString;
MyConnection.Protocol:=ci.dbProtocolo; //.ListSource.DataSet.FieldByName('Protocolo').AsString;
MyConnection.Port:=ci.Port; // DBLookupComboBox1.ListSource.DataSet.FieldByName('Port').AsInteger;
MyConnection.User:=ci.dbUser;    ///DBLookupComboBox1.ListSource.DataSet.FieldByName('USER').AsString;
MyConnection.Password:=ci.dbPasswd; //  DBLookupComboBox1.ListSource.DataSet.FieldByName('PASSWD').AsString;
MyConnection.Database:=ci.dbDataBase;  //  DBLookupComboBox1.ListSource.DataSet.FieldByName('DataBase').AsString;
EMID:=ci.EMID; //   DBLookupComboBox1.ListSource.DataSet.FieldByName('EMID').AsString;

TRY

 MyConnection.Connect;
 Label3.Caption:=nLBN50;
 Label5.Caption:=aRegisterDb.CompanyName;
 //Panel1.Visible:=False;
UserEdit.Enabled:=True;
PasswdEdit.Enabled:=True;
 UserEdit.SetFocus;
EXCEPT
 Label3.Caption:=nLBN49;
END;
end;
end;

end.
