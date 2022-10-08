unit Global;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Inifiles, DBGrids, printers, Controls,StdCtrls, ExtCtrls, db, BufDataset;


const
  Environment='Environment';        // 表段常量名
  Messages='Messages';
  PCID = 'C1000';

type

    TCommand = (CmdRegister,RegExito, RegFaild, CmdLogin, LoginExito, LoginFaild, CmdDisconect,CmdMsgPriva, CmdNoticia,
  cmdRegSoft, cmdSetName,cmdSendConn, cmdVive, GivemeName, cmdSetConn, cmdUserbreak,cmdGetClientInfo);

  TTerminal= (Venta,Almacen);

   TGOODS = record
   SKU_NO, GOODS_ID, ENA, ITEM_NAME, COMMODITY_UNIT:STRING;
   QUANTITY, COST, PRICE, DISCOUNT, TAXRATE :DOUBLE;
   FECHA_CADUCA: TDate;
  end;

  TTCPServer = packed record
      Server :string[40];
      Port :INTEGER;
      PCID :string[20];
  end;
  TClientInfo = packed record
    ClientName        : array[0..49] of Char;
    ClientIP          : array[0..14] of Char;      //ipv4
    PCID              : array[0..20] of Char;
    ClientACTIP       : array[0..17] of Char;
    ClientStatus      : array[0..9] of Char;
    IdleTime          : TTime;
    Terminal          : TTerminal;
  end;

  TDBCStruct = record                  //数据库配置信息包
       DBHost: string[100];
       DBDataBase: String[100];
       DBUser: String[100];
       DBPasswd:String[100];
       DBPort:Integer;
       DBProvider:String[100];
       EMID:String[100];
       PCID:String[100];
       ReportLutu:String[100];
 end;

  TExecelRowStruct = record
    CODING:string[20];
    CODBARRA:string[20];
    NAMEITEM:string[100];
    AMOUNT:Double;
    PRICE_Sin:Double;
    PRICE_Con:Double;
    DISC: Double;
    IVA: Double;
    REQ: Double;
    TOTAL, PVPOPTION:Double;
    end;

   TDocCheckStruct = record
   ID_TMPLIST,
   ID_PROVEEDOR,
   DOCUMENT: String[24];      //票据类别
   NAME_PROVEEDOR:String[80];
   N_DOCUMENT:String[30];
   READ_COL:String[30];
   FECHA_COMP:Tdate;
   EMPLEADO:String[30];
   ID_STOCK:String[10];
   ISIVAINCLUIDO,
   ISREQINCLUIDO,
   ReadOnly:Boolean;
end;

   TDocCompStruct = record
   DOCUMENT: String[30];      //票据类别
   SERIE:String[30];      //票据系列
   ID_BUY:String[30];
   N_DOCUMENT,
   ID_PROVEEDOR:String[24];
   NAME_PROVEEDOR:String[80];
   //FECHA_COMP:String[30];
   ID_STOCK:String[20];
   FECHA_COMP:Tdate;
   EMPLEADO:String[30];
   ISIVAINCLUIDO,
   ISREQINCLUIDO:Boolean;
end;

   TBuyDocStruct = record
   B_UUID:string;
   DOCUMENT: String[30];      //票据类别
   N_DOCUMENT,
   ID_PROVEEDOR:String[24];
   NAME_PROVEEDOR:String[80];
   Staff:string[30];
   ID_STOCK:String[20];
   BUY_DATE:Tdate;
   end;

   type
  TRegPack = packed record
   IDPC,
   CompanyName,
   FachadaName,
   Address,
   PostCode,
   City,
   Provincia:string[100];
                    //Country:string[100];
   Tel,
   Cif:string[32];
   Version,
   IniDate,
   FinDate:string[16];
   PcNumber:Integer;
  end;
  TMSG =  packed record
    MSGproperty:array[0..8] of Char;     //@a公开信息， @p，发送私人信息
    Usuario,
    Recividor:array[0..64] of Char;
    Noticias    :   array[0..128] of Char;
  end;

  TDataPack  = packed record
    Command     :   string[16]; //TCommand;
    REGISTED    :   Boolean;
    ClientInfo  :   TClientInfo;
    DBCONNData  :   TDBCStruct;// TDBCONNData;
    RegBag      :   TRegPack;
    MSG         :   TMSG;

  end;

  TPRODUCTOST = record
        ID:string[31];
        REFERENCIA:string[20];
        ENA:string[20];
        LANG1:string[100];
        LANG2:string[100];
        UNIDAD:String[8];
        PRECIO_COMPRAs: Double;
        PRECIO_COMPRAc: Double;
        PVPs: Double;
        PVPc: Double;
        IVA: Double;
        REQ: Double;
        MAXSTOCK,
        MINISTOCK,
        STOCK:Double;
        ID_CATE:STRING[10];
        CATEGORIA:string[50];   //XIUGAI
        ID_SUBCATE:STRING[10];
        SUBCATEGORIA:string[50];
        CAN_DESC:Boolean;
        DESCUENTO:Double;
        CANTIDAD:Double;
        CONTADO:Double;
        ID_STOCK:String[20];
        IsTempItem:Boolean;
        IsPASSED:Boolean;
        SuCODIGO:string[20];
        PVPOPTION:currency;
        ID_IMPUESTO:string[20];
       // Picture : TJPEGImage ;
        ID_selected:string[31];
       // procedure SaveToStream(const aStream: TStream);
       // procedure LoadFromStream(const aStream: TMemoryStream);
       END;

  TPCCONFIG = packed record
    ID_PC :string[40];
   { TICKETERA :string[60];
    PORT_T :string[16];
    PapelModel :string[20];
    CMDCAJON :string[60];
    CMDPAPEL :string[60];
    IMPRESORA :string[60];
    PORT_I :string[16];
    PORT_V :string[16];
    ImpresoraBarra :string[60];
    PORT_B :string[16];     }
    LABELSIZEX,
    LABELSIZEY:Double;
    LABELMODE :Integer;
    LABELPRINTNAME :string[60];
    LABELPAPERDM :Integer;
    LABELPRINTPAPER:string[60];
    LABELPAPERSIZEX,
    LABELPAPERSIZEY :Double;
    ISMANUEL:Boolean;
    LABELPAPERCOLUMN :Integer;
    TICKETERANAME :string[60];
    TICKETPAPERDM :Integer;
    TICKETPRINTPAPER :string[60];
    TICKETPAPERSIZEX,
    TICKETPAPERSIZEY :Double;
    CMDOPENCAJA:string[60];
    CMDCUTPAPER:string[60];
    A4PRINTNAME:string[60];
    A4PAPERDM :Integer;
    A4PRINTPAPER:string[60];
    A4PAPERSIZEX,
    A4PAPERSIZEY:Double;
    VISOR_PORT:string[16];
  end;

procedure BlancoGrid(Grid: TDBGrid);
procedure ImprimirCodigoEsc(S:String);
procedure AbirCajon();
procedure OpenCashEspon;
Function GetFileList(aFiles: TStringList; sPath, extname: string):string;
function CreateUUID():string;
function Get36UUID():string;
function ToHexString(s: string; encode: Integer): string;
function HexToString(H: String): String;
procedure ClearAllRecords(ADataset: TDataset);
procedure writelog(logtype, section, message: string);
function GetNumbers(const aString: string): string;


var
  Lang, FallbackLang: String;
  PCCONFIG:TPCCONFIG;
  DBHost,DBDataBase,DBUsuario,DBPasswd,DBPuerto,DBProtocolo: String;
  DBPort:integer;
  DirConf, POSfileconf, Lutu,ReportPath, LibPath, teststr, LogDir, sLogFile :string;
  EmID: String;
  LOGIN: string;
  PCIP:String;
  Transferred:boolean;
  aRegisterDb:TRegPack;
  PcAmout:integer;
  Logined, ReGisted, indyConected:Boolean;
  Empresa, Representante, Direccion, Localidad, Nif, CP, Provincia, LogoEmpresa: String;
  fileconf:string;
  RutaReports, RutaIni, RutaSql, RutaSqlLib, RutaIconos, RutaBin, RutaModulos, RutaLang: String;
  AbrirAchivo: String;
  boxstyle:Integer;
  USER_DERECHO:INTEGER;

  TCPServer:TTCPServer;
  passwordhash: string ='21232f297a57a5a743894a0e4a801fc3';

  IniReader : TIniFile;

  AExcelLine:TExecelRowStruct;

  ACHECKDOC:TDocCheckStruct;

  gUid: TGuid;
  gUResult: HResult;

  resourcestring
  es = 'Español';
  zh = '中文';
  en = 'inglish';
  nDefault = 'Default';
  nMSG0 = 'No esta conectado...No se puede trabajar; ';
  nMsg1 = 'Tecla % en Edidor de CodigoBarra significa para buscar.';
  nMSG2 = 'NOTA: '+#13#10+'Tasa de impuesto del libro de solo el 4%.';
  nMSG3 = 'Copia detalles desde otro articulo: ';
  nMSG4 = 'Introducir Codigo de Barra';
  nMSG5 = 'Buscar codigo barra o nombre del articulo: ';
  nMSG6 = 'Introducir Conception';
  nMSG7 = 'Error: Formato de Codigo de Barra incorrect!';
  nMSG8 = 'Tienes que selecionar un node Primero!';
  nMSG9 = 'Tienes que elegir un record en table primero!';
  nMSG10 = 'Tienes que acabar el trabajo que esta haciendo!';
  nMSG11 = 'Trabajo Echo. Ha modificado el database.';
  nMSG12 = '没有密码, 操作取消';
  nMSG13 = '密码:';
  nMSG14 = '密码错误';
  nMSG15 = '此操作需要密码才能进行';
  nMSG16 = '密码错误, 操作取消.';


  StaInitText             = '服务器未开启';
  StaText                 = '客户端连接数:%d个';
  StaConnected            = '已链接到服务器';
  StaDisconnected         = '已从服务器断开';
  StaServerStart          = '服务器开启成功';
  StaError                = '软件使用的端口被占用';
  StaServerClose          = '服务器关闭';
  StaServerClosing        = '服务器关闭着';
  StaReceivedPersent      = '接收文件：%s--(%u%%)';
  LogTxt                  = '------服务器操作日志------'+#13+#10;
  LogServerStart          = '【服务器开启--%s】';
  LogServerClose          = '【服务器关闭--%s】';
  LogClientdisConnected   = '【客户端：%s,%s】从服务器断开--%s';
  LogClientConnected      = '【客户端：%s,%s】连接到服务器--%s';
  DlgNoConnected          = '未连接服务器';
  DlgConnectFailed        = '连接被拒绝，可能服务器没有开启';
  DlgExcept               = '服务器端异常断开，工作将停止!';

  MsgReg1 = '版本已注册';
  MsgReg1a = '已注册';
  MsgReg2 = '未注册版本';
  MsgReg3 = '(网络版)';
  MsgReg4 = '(单机版)';
  MsgReg5 = '请注册,联系邮箱: wyldon@gmail.com 或电话: 675113787';
  MsgReg6 = '注册单位: ';
  MsgReg7 =  '注册文件成功导入, 请您退出程序重启!';
  MsgReg8 = '使用到';

  nMSN14= '没有连接信息!';
  nMSN15= '没有连接信息,请先添加.';
  nMSN16= '没有连接信息,您将无法操作,请注意添加.';
  nMSN17= '用户不存在或密码错误';
  nMSN18= '保存成功.'+#13#10
         +'您需要重新登入才可以获取新资料,通知客户端重新登入.';
  nMSN19= '您的权限不够,无法打开!';

  nLBN49='No Esta Connectado.(还未连接到任何数据库)';
  nLBN50='Ya Esta Connectado a Database:(已经连接到数据库:)';


  nMSN49= '全部';//'Todos';
  nMSN50= '已经清点'; // 'Estado Chequeado';
  nMSN51= '没有清点'; //'No Esta Chequeado';
  nMSN52= '退货'; //'Articulo Develvecion';
  nMSN53= '购买数量不等于已清点'; // 'Cantidad <> Contado';
  nMSN54= '没有任何东西..'; //'No hay nada..';


  nFun0 = 'F2: 建立类别;';
  nFun1 = 'F3: 打开钱箱';//'F3: Abrir Cajon;';
  nFun2 = 'F4: 商品单位设定;';
  nFun3 = 'F5: 查找'; // 'F5: Buscar;';
  nFun4 = 'F6: 加载图片;';
  nFun5 = 'F7: 供应商;';
  nFun6 = 'F8: 清空;';

  nFun7 = 'F5: 添加货品;'; //'F5: Buscar Articulo en Table;';
  nFun8 = 'F7: 添加品牌;';
  nFun9 = 'F9: 查询;';

  {**proveedor**}
  nList1 = 'Nombre Comercial';
  nList2 = 'Razón Social';
  nList3 = 'Codigo';

  nCaption1 = 'No#';
  nCaption2 = 'Importe';
  nCaption3 = 'Crear Nuevo Categoria Padre';
  nCaption4 = 'Crear Nuevo Categoria Hijo';
  nCaption5 = 'Editar la categoria';

  nCaption6 = 'Inventario completo';
  nCaption7 = 'Cambiar database';
  nCaption8 = 'Suma de cuentas';
  nCaption9 = 'Esta operación cambiará la cantidad del inventario original a la cantidad de conteo.';
  nCaption10 = 'Esta operación agrega el monto del conteo actual basado en el stock original.';
  nCaption11 = 'Número de Operación';
  nCaption12 = 'Almacén de inventario';


  nOpera1='***-所有仓库';
  nOpera2='***-所有类别';
  nOpera3='***-所有供应商';




implementation
function CreateUUID():string;
begin
CreateUUID:='';
  gUResult := CreateGuid(gUid);
if gUResult = S_OK then
   CreateUUID:=(GuidToString(gUid));
end;

function Get36UUID():string;
var
  sGUID: string;
begin
Get36UUID:='';
   sGUID:=CreateUUID();
   Delete(sGUID, 1, 1);
  Delete(sGUID, Length(sGUID), 1);  // 去掉大括号的Guid，占36位中间有减号
  Get36UUID:=sGUID;
end;

function HexToString(H: String): String;
var I: Integer;
begin
  Result:= '';
  for I := 1 to Length (H) div 2 do
    Result:= Result+Char(StrToInt('$'+Copy(H,(I-1)*2+1,2)));
end;

function ToHexString(s: string; encode: Integer): string;
var
  len:Integer;
  w:WideString;
  u:UTF8String;
begin
  Result := '';
  if encode=1 then //Unicode
  begin
    w:=s;
    Len := Length(s)*2; //这里要改，不能是 Len := Length(w); 也不能是 Len := Length(s);
    SetLength(Result, Len shl 1);
    BinToHex(PChar(w), PChar(Result), Len);
  end else
  if encode=2 then //UTF8
  begin
    u:=AnsiToUTF8(s);
    Len := Length(u);
    SetLength(Result, Len shl 1);
    BinToHex(PChar(u), PChar(Result), Len);
  end;
end;

procedure ClearAllRecords(ADataset: TDataset);
begin
  ADataset.DisableControls;
  try
    ADataset.First;
    while not ADataset.EoF do
      ADataset.Delete;
  finally
    ADataset.EnableControls;
  end;
end;


procedure writelog(logtype, section, message: string);
var
  f: TextFile;
  //sLogFile: string;
  sAppPath:string;
  version:string;
begin
 try
    {print software version}
    version:='v1.0.1.b1';
    sAppPath := ExtractFilePath(ParamStr(0));

{$IFDEF UNIX}
   {if debug param is present, then writeln to stdout}
    if (ParamStr(2) = '-d') or (ParamStr(2) = '-debug') then
    begin
      writeln(message);
    end;
{$ENDIF}


    AssignFile(f, sLogFile);
    if FileExists(sLogFile) then
      Append(f)
    else
      ReWrite(f);
    WriteLn(f, formatdatetime('yyyy-mm-dd hh:nn:ss', now) + #9 + logtype + #9 + section + #9 + message);
    //write message to file log
    if (logtype='error') or (logtype='crit') then
    begin
      DumpExceptionBackTrace(f);    //DumpExceptionBackTrace if error
    end;
    CloseFile(f);

  except
    on E: Exception do
    begin
       WriteLn(formatdatetime('yyyy_mm_dd_hh_nn_ss', now) + #9 + message);
    end;
  end;
end;

Function GetFileList(aFiles: TStringList; sPath, extname: string):string;
var
iIndex : Integer;
SearchRec : TSearchRec;
s:string;

begin
{$IFDEF LINUX}
if sPath[Length(sPath)] <> '/' then
sPath := sPath + '/';
{$ELSE}
if sPath[Length(sPath)] <> '\' then
sPath := sPath + '\';
{$ENDIF}
    if  FindFirst(sPath+'*.*', faAnyFile, SearchRec) = 0 then
      begin
         repeat
          if (SearchRec.Attr and  fadirectory=fadirectory) and (SearchRec.Name <> '..') and (SearchRec.Name <> '.') then
             begin
             end
             else
             begin
             s:=ExtractFileExt(SearchRec.Name);
              if s=extname then
                  aFiles.Add(SearchRec.Name)
             end;
         until FindNext(SearchRec) <> 0;
         FindClose(SearchRec);
      end;
end;

procedure BlancoGrid(Grid: TDBGrid);
var
  conta:integer;
begin
for conta:=0 to Grid.Columns.Count-1 do
    begin Grid.Columns[conta].Color:= $00F4E7E7 ; //clWindow;
  end;
end;

procedure ImprimirCodigoEsc(S:String);
   var Written: Integer;
   begin
     Written:=0;
     Printer.Write(S[1], Length(S), Written);
   end;

procedure AbirCajon();
var
      Written: Integer;
     S: String;
begin
     with Printer do
     begin
       PRINTER.PrinterIndex := 0;
       RawMode := True;
     BeginDoc;
          //printstring(#27+#112+#0+#25+#250+lineending);  //ABRE CAJON
          s:=#27+#112+#0+#25+#250+lineending;
          Printer.Write(S[1], Length(S), Written);
         EndDoc;
     end;

end;

procedure OpenCashEspon;

begin
{
Public Sub AbrirCajonDeDinero()
Dim MiImpresora as Printer
For Each MiImpresora In Printers
If MiImpresora.DeviceName = "Epson TM-U950" Then
' Puse TM-U950 como ejemplo debe ser como se llame tu printer
Set Printer = MiImpresora
Printer.FontSize = 10
Printer.FontName = "control"
Printer.Print "A"
printer.EndDoc
endif
next
End Sub
}


  try
   //  Printer.RawMode := true;
printer.BeginDoc;
printer.Canvas.Font.Name:='Control';
printer.Canvas.Font.Size:=9;
printer.Canvas.TextOut(0,0,'A');
printer.EndDoc;
finally
end;

end;

function GetNumbers(const aString: string): string;
var
  C: Char;
begin
  Result := '';
  for C in aString do begin
      if CharInSet(C, ['0'..'9']) then
      begin
        Result := Result + C;
      end;
    end;
end;

{ nfFixed, nfFixedTh, , nfPercentage, nfFraction,
   nfCurrency, nfCurrencyRed,   }

     {
     //数量
     ds:='';
     dc:='';
     if CheckBox19.Checked then
     begin
     ds:=TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFQUANTITY,Y));
     ipos:=pos(' ',ds);
     dc:=Copy(ds, 1,ipos-1);
     ds:=dc;
     dc:= StringReplace(ds, ',', '.', []);
     if trim(dc)='' then
     AEXCELLINE.UNIDAD:=0
     else
     begin
     TRY
         AEXCELLINE.UNIDAD:=STRTOFLOAT(TRIM(dc));
     EXCEPT
     AEXCELLINE.UNIDAD:=0;
         AEXCELLINE.CODING:=''; AEXCELLINE.CODBARRA:=''; AEXCELLINE.NAMEITEM:='';
     END;
     end;
     end
     else
     begin
     TRY
     ds:=TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFQUANTITY,Y));
     dc:= StringReplace(ds, ',', '.', []);
       AEXCELLINE.UNIDAD:=STRTOFLOAT(DC);
     EXCEPT
     AEXCELLINE.UNIDAD:=0;
       AEXCELLINE.CODING:=''; AEXCELLINE.CODBARRA:=''; AEXCELLINE.NAMEITEM:='';
     END;
     end;




     //单价无税
     ds:='';
     dc:='';
     if (CheckBox5.Checked) then
     begin
     IF TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFPRICE_SIN,Y)) = '' THEN
     AEXCELLINE.PRICE_SIN:=0
     ELSE
     BEGIN
     ds:=TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFPRICE_SIN,Y));
     dc:= StringReplace(ds, ',', '.', []);
     TRY
     AEXCELLINE.PRICE_SIN:=STRTOFLOAT(TRIM( dc));
     EXCEPT
     begin
     AEXCELLINE.PRICE_sin:=0;
     AEXCELLINE.CODING:=''; AEXCELLINE.CODBARRA:=''; AEXCELLINE.NAMEITEM:='';
     END;
     END;
     end;
     end
     else AEXCELLINE.PRICE_SIN:=0;

     //单价含税
     ds:='';
     dc:='';
     if (CheckBox7.Checked) then             //单价含税
     begin
     IF TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFPRICE_CON,Y)) = '' THEN
     AEXCELLINE.PRICE_CON:=0
     ELSE
     BEGIN
     ds:=TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFPRICE_CON,Y));
     dc:= StringReplace(ds, ',', '.', []);
     TRY
     AEXCELLINE.PRICE_CON:=STRTOFLOAT(TRIM(dc));
     EXCEPT
     begin
     AEXCELLINE.PRICE_CON:=0;
     AEXCELLINE.CODING:=''; AEXCELLINE.CODBARRA:=''; AEXCELLINE.NAMEITEM:='';
     END;
     END;
     end;
     end
     else AEXCELLINE.PRICE_CON:=0;

     //税率(含百分比)
     ds:='';
     dc:='';
     if (CheckBox6.Checked) then
     begin
     IF TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFTAXRATE,Y))='' THEN
     AEXCELLINE.IVA:=0 ELSE
     BEGIN
     iF CHECKBOX18.CHECKED then     //含百分比符号
     begin
     TRY
     ds:=TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFTAXRATE,Y));
     ipos:=Pos('%', ds);
     dc:=Copy(ds, 1,ipos-1);
       AEXCELLINE.IVA:=STRTOFLOAT(TRIM(dc));                //(STRTOFLOAT(TRIM(sWorksheetGrid1.CELLS[COLOFTAXRATE,Y]))*100);
       EXCEPT
       AEXCELLINE.IVA:=0;
       END;
     end
     else
     begin
     ds:=TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFTAXRATE,Y));
     ipos:=Pos('%', ds);
     dc:=Copy(ds, 1,ipos-1);
     TRY
     AEXCELLINE.IVA:=STRTOFLOAT(TRIM(dc));                    //;(STRTOFLOAT(TRIM(sWorksheetGrid1.CELLS[COLOFTAXRATE,Y])));
     EXCEPT
     AEXCELLINE.IVA:=0;
     END;
     end;
     end;
     END
     else AEXCELLINE.IVA:=0;

     //折扣
     if (CheckBox8.Checked) then
     begin
     IF TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFDISCOUNT,Y))='' THEN
     AEXCELLINE.DISC:=0
     ELSE
     BEGIN
     TRY
     AEXCELLINE.DISC:=STRTOFLOAT(TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFDISCOUNT,Y)));
     EXCEPT
     AEXCELLINE.DISC:=0;
     END;
     END;
     end
     else
     AEXCELLINE.DISC:=0;

     //建议价
     ds:='';
     dc:='';
     if (CheckBox9.Checked) then
     begin
     IF TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFPVPOPTION,Y))='' THEN
     AEXCELLINE.PVPOPTION:=0
     ELSE
     BEGIN
     TRY
     ds:=TRIM(sWorksheetGrid1.Worksheet.ReadAsText(COLOFPVPOPTION,Y));
     dc:= StringReplace(ds, ',', '.', []);
     AEXCELLINE.PVPOPTION:=STRTOFLOAT(dc);
     EXCEPT
     AEXCELLINE.PVPOPTION:=0;
     END;
     END;
     end
     else
     AEXCELLINE.PVPOPTION:=0;

     }

end.

