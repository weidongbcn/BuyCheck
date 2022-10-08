unit connect;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset, Dialogs, db, fn_mysql, LCLType, Graphics, Global, Process, IniFiles,
  LazUTF8,LResources, Translations;
type
  TStringArray = array of string;

  TDBCStruct = record                  //数据库配置信息包
       DBHost: string[100];
       DBDataBase: String[100];
       DBUser: String[100];
       DBPasswd:String[100];
       DBPort:Integer;
       Protocol:String[100];
       EMID:String[100];
       PCID:String[100];
       ReportLutu:String[100];
 end;

 TConfSet = packed record
       DOCUMENTO: String[30];      //票据类别
       SERIA:String[30];      //票据系列
       CODIGO_ACTUAL:String[30];    //haoma
       ID_STOCKDEFAULT:String[20];      //默认仓库编号
       ID_IMPUESTO: string[4];
       IVA_DEFAULT:Double;
       REQ_DEFAULT:Double;
       SELLWITHUNITE:Boolean;        //输入设置(是否合并)
       WITHCANTDEFAULT:Boolean;      //数量栏输入关闭
       SELLWITHPVP:Boolean;       //价格含税
       EDITWITHPVP:BOOLEAN;
       WITHCLIENTDEFAULT:Boolean;          //客户默认
       AVISOCANTIDAD:Boolean;
       AVISOALMACEN:Boolean;
       CANCHANGEPRICE:Boolean;
       QuantityWithFloat:Boolean;
       EmRec:Boolean;
       AutoClient:Boolean;    //客户自动编号
       INFORMEREAL:Boolean;
       USEPUNTO:Boolean;      //punto 系统
       PUNTOSIMPLE:Boolean;
       USERETURN:Boolean;
       PROPORTION:Double;
       USERIMAGEPANEL:Boolean;
       PVPDIRECTO:Boolean;
end;

 TSYSPUNTO = RECORD            //PUNTO
  S1GASTO,
  S1PUNTO,
  C1GASTO,
  C1PUNTO,
  VT,
  VI,
  C2GASTO,
  C2PUNTO,
  C3GASTO,
  C3PUNTO:DOUBLE;
END;
   procedure Conectate(dbConect:  TZConnection);
   function ExisteTB(MiConexion: TZConnection; MiTB: string): Boolean;

type

  { TDataModule2 }

  TDataModule2 = class(TDataModule)
    CategDataSource: TDataSource;
    CategQuery: TZQuery;
    GetPcConfig: TZQuery;
    ProDataSource: TDataSource;
    ProvQuery: TZQuery;
    IVADataSource: TDataSource;
    IVAQuery: TZQuery;
    GetCommuQuery: TZQuery;
    CalPuntoQuery: TZQuery;
    ZCon1: TZConnection;
    procedure DataModuleCreate(Sender: TObject);


  private

  public
    procedure DoGetCATEGORIAS;
    procedure DoGetIvas;
    procedure DoGetProveedor;
    procedure GetConfigCommu;
    procedure DoUniConn;
    procedure GetPcPrintConfig;

  end;

var
  DataModule2: TDataModule2;
  UseConf,DefaultConf, AConfSet: TConfSet;
  LoginDBC, UseDBC, mDBC, RecordDBC:TDBCStruct;
  SYSPUNTO:TSYSPUNTO;
  DBinit:boolean=false;


implementation

{$R *.lfm}




procedure TranslateLCL;

var
 AProcess: TProcess;
 AStringList: TStringList;
 Conffile: Tinifile;

begin

 LazGetLanguageIDs(Lang,FallbackLang); // in unit LCLProc
 if lang = 'ch_CH' then lang:='zh';
 if lang = 'zh_CN.UTF-8' then lang:='zh';
 if FallbackLang = 'ch' then FallbackLang:='zh';
 if FileExists(fileconf) then
 begin
  Conffile := TInifile.Create(fileconf) ;
  try
    lang:= Conffile.ReadString(Environment,'Lang',lang);   //ReadString(表段,常量名,赋值所给的文本);
    FallbackLang:= Conffile.ReadString(Environment,'FallbackLang',FallbackLang);
  finally
    Conffile.Free;
  end;

  //  Translations.TranslateUnitResourceStrings('Global',
  //                   LangLu+'multilang.%s.po',Lang,FallbackLang);
 end;
 if Lang = 'Default' then
 begin

   LazGetLanguageIDs(Lang,FallbackLang);
   if lang = 'ch_CH' then lang:='zh';
   if FallbackLang = 'ch' then FallbackLang:='zh';
 end;

  Translations.TranslateUnitResourceStrings('Global',
                     RutaLang+'Articulo.%s.po',Lang,FallbackLang);

end;

procedure TDataModule2.DoUniConn;
begin
  Conectate(ZCon1);
  DoGetProveedor;
 // DataModule2.GetConfigCommu;
 // DataModule2.DoGetCATEGORIAS;
  DataModule2.DoGetIvas;
end;

procedure TDataModule2.DoGetIvas;
   begin
   with ivaQuery do
   begin
   Connection:=ZCon1;
      Active:=false;
      SQL.Clear;
      SQL.Text:='SELECT * FROM GOODS_TAXRATE';
      Open;
   end;

   end;


procedure TDataModule2.DataModuleCreate(Sender: TObject);
begin

   {
   {$IFDEF LINUX}
     DecimalSeparator:='.';

     // Comprobamos si la aplicación es para desarrollo o en producción.
     if ExtractFilePath(ParamStr(0))='/usr/bin/' then
                begin
                   RutaIni:=GetEnvironmentVariable('HOME')+'/.TPV/';
                   RutaSql:='/usr/share/TPV/';
                   RutaBin:='/usr/bin/';
                   RutaIconos:=RutaSql+'Icons/';
                   RutaReports:='/usr/share/facturlinex2/Report/';
                   RutaModulos:=RutaSql+'Extras/';
                   RutaSqlLib:=RutaIni+'Sqllib/';
                   RutaLang:=RutaIni+'locale/';
                   fileconf:=RutaIni+'Conf.ini';
                end else
                begin
                   RutaIni:=ExtractFilePath(ParamStr(0));
                   RutaSql:=RutaIni;
                   RutaBin:=RutaIni;
                   RutaIconos:=RutaBin+'Imagenes/';
                   RutaReports:=RutaIni+'Report/';
                   RutaModulos:=RutaIni+'Extras/';
                   RutaSqlLib:=RutaIni+'Sqllib/';
                   RutaLang:=RutaIni+'locale/';
                   fileconf:=RutaIni+'Conf.ini';
                end;

    //----------------- Carga de la variable AbrirAchivo
    //Descubrir que escritorio está utilizando el usuario
    if AbrirAchivo = '' then AbrirAchivo:=GetEnvironmentVariable('DESKTOP_SESSION')+'-open';

  {$ELSE}
     RutaIni:=ExtractFilePath(ParamStr(0));
     RutaSql:= RutaIni+'Tablas\';
     RutaSqlLib:=RutaIni+'Sqllib\';
     RutaLang:=RutaIni+'locale\';
     RutaIconos:=RutaIni;
     RutaBin:= RutaIni;
     RutaReports:= RutaIni+'Report\';
     RutaModulos:= RutaIni+'Extras\';
     fileconf:=RutaIni+'Conf.ini';
     DecimalSeparator:='.';
     if AbrirAchivo= '' then AbrirAchivo:= 'explorer.exe';
     ZCon1.LibraryLocation:=RutaSqlLib+'libmysql.dll';
  {$ENDIF}
  }

  //{$IFDEF WIN64}
   ZCon1.LibraryLocation:=RutaSqlLib+'libmysql.dll';
  //{$ENDIF}

  ShortDateFormat:='DD/MM/YYYY';
  DateSeparator := '/';
  DecimalSeparator:='.';
  ThousandSeparator:=',';
  boxstyle :=  MB_ICONQUESTION + MB_YESNO;
  //TranslateLCL;


//



    if (DbHost='') or (EmID='') or (DBUsuario='') or (DBPasswd='') then
    DBinit:=False else DBinit:=True;
    if (DBinit=True) then
    begin
    UseDBC.DBHost:=DBHost;
    UseDBC.DBDataBase:=DBDataBase;
    UseDBC.DBUser:=DBUsuario;
    UseDBC.DBPasswd:=DBPasswd;
    UseDBC.DBPort:=strtoint(DBPuerto);
    UseDBC.Protocol:='mysql';
    UseDBC.EMID:=EmID;

  Conectate(ZCon1);

  if DataModule2.Zcon1.Connected then
  begin
 // self.Caption:='CONECTADO';
  DataModule2.GetConfigCommu;
  DataModule2.DoGetCATEGORIAS;
  DataModule2.DoGetIvas;
  DataModule2.DoGetProveedor;
  DataModule2.GetPcPrintConfig;
  //GetAllGoods;
  //showmessage('f');
  end;

  end;
end;

procedure Conectate(dbConect:  TZConnection);
var
   port: integer;
begin
    //port:= StrToInt(DBPuerto);
    //----------------- CONEXION -----------------


    mysql_conectar(dbConect, DBHost, DBDataBase, DBUsuario, DBPasswd, DBProtocolo, DBPort);

//  dbConect.HostName:=DBHost;
//  dbConect.Database:=DBDataBase;
//  dbConect.User:=DBUsuario;
//  dbConect.Password:=DBPasswd;
//  dbConect.Port:=StrToInt(DBPuerto);
//  dbConect.Protocol:=DBProtocolo;
//  dbConect.Connected:=True;
end;

procedure TDataModule2.DoGetCATEGORIAS;
  begin
  with CategQuery do
  begin
  Connection:=ZCon1;
  Active:=false;
  SQL.Clear;
     //SQL.Text:='SELECT * FROM '+EmID+'CATEGORIASLIST WHERE 1=1 AND CONTRONL=''00'' ';
    // SQL.Text:='SELECT * FROM '+EmID+'CATEGORYS WHERE 1=1 ';
    sql.Text:=' SELECT * FROM CATEGORYS';
     Open;
  end;
  end;


 procedure TDataModule2.DoGetProveedor;
 begin
 ProvQuery.Connection:=ZCon1;
ProvQuery.Close;
ProvQuery.SQL.Text := 'select * from '+EMID+'PROVEEDORLIST';
ProvQuery.Open;
 end;

  procedure TDataModule2.GetConfigCommu;
 begin
    UseConf.PROPORTION:=0;
    with GetCommuQuery do
  begin
    Connection:=ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT * FROM '+UseDBC.EmID+'CONFIGCOMMU WHERE EMID='''+UseDBC.EmID+''' ';
     Open;

    IF RecordCount = 1 THEN
      BEGIN
      UseConf.DOCUMENTO:=UpperCase(FieldByName('DOCUMENT').AsString);
      UseConf.SERIA:=FieldByName('SERIES').AsString;
      UseConf.WITHCLIENTDEFAULT:=FieldByName('WITHCLIENTDEFAULT').ASBOOLEAN;

      UseConf.ID_STOCKDEFAULT:=FieldByName('ID_STOCKDEFAULT').AsString;
      UseConf.ID_IMPUESTO:=FieldByName('ID_IMPUESTODEFAULT').AsString;
      UseConf.IVA_DEFAULT:=FieldByName('IVA_DEFAULT').AsCurrency;
      UseConf.REQ_DEFAULT:=FieldByName('REQ_DEFAULT').AsCurrency;
      UseConf.SELLWITHPVP:=FieldByName('SELLWITHPVP').ASBOOLEAN;
      UseConf.AVISOALMACEN:=FieldByName('AVISOALMACEN').ASBOOLEAN;
      UseConf.AVISOCANTIDAD:=FieldByName('AVISOCANTIDAD').ASBOOLEAN;
      UseConf.QuantityWithFloat:=FieldByName('QuantityWithFloat').ASBOOLEAN;

      UseConf.WITHCANTDEFAULT:=FieldByName('WITHCANTIDADDEFAULT').ASBOOLEAN;
      UseConf.CANCHANGEPRICE:=FieldByName('CANCHANGEPRICE').ASBOOLEAN;
      UseConf.AutoClient:=FieldByName('IDCLIENTAUTO').ASBOOLEAN;

      UseConf.SELLWITHUNITE:=FieldByName('SELLWITHUNITE').ASBOOLEAN;
      UseConf.EDITWITHPVP:=FieldByName('EDITWITHPVP').ASBOOLEAN;
      UseConf.INFORMEREAL:=FieldByName('INFORMEREAL').ASBOOLEAN;
      UseConf.USEPUNTO:=FieldByName('USEPUNTO').ASBOOLEAN;
      UseConf.PUNTOSIMPLE:=FieldByName('PUNTOSIMPLE').ASBOOLEAN;
      UseConf.USERETURN:=FieldByName('USERETURN').ASBOOLEAN;
      UseConf.USERIMAGEPANEL:=FieldByName('USERIMAGEPANEL').ASBOOLEAN;
      UseConf.PVPDIRECTO:=FieldByName('PVPDIRECTO').ASBOOLEAN;
      UseConf.CODIGO_ACTUAL:='';
      //UseConf.EmRec:=EMDATO.EM_CAL_REQ;
      DefaultConf:= UseConf;            //备份用
      AConfSet:= UseConf;
      end;

  end;


    {
      if UseConf.USEPUNTO then
      BEGIN
      with CalPuntoQuery  do
      begin
      Connection:=ZCon1;
      Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT * FROM '+UseDBC.EmID+'PUNTOREGLAS ';
     OPEN;
      Filter:=' CODIGO=''S1'' ';
      Filtered:=true;
      SYSPUNTO.S1GASTO:=FieldByName('GASTO').AsFloat;
      SYSPUNTO.S1PUNTO:=FieldByName('PUNTO').AsFloat;
      Filter:=' CODIGO=''C1'' ';
      Filtered:=true;
      SYSPUNTO.C1GASTO:=FieldByName('GASTO').AsFloat;
      SYSPUNTO.C1PUNTO:=FieldByName('PUNTO').AsFloat;
      SYSPUNTO.VT:=FieldByName('VT').AsFloat;
      Filter:=' CODIGO=''C2'' ';
      Filtered:=true;
      SYSPUNTO.C2GASTO:=FieldByName('GASTO').AsFloat;
      SYSPUNTO.C2PUNTO:=FieldByName('PUNTO').AsFloat;

      Filter:=' CODIGO=''C3'' ';
      Filtered:=true;
      SYSPUNTO.C3GASTO:=FieldByName('GASTO').AsFloat;
      SYSPUNTO.C3PUNTO:=FieldByName('PUNTO').AsFloat;
      SYSPUNTO.VI:=FieldByName('VI').AsFloat;
      end;

      END;

     if UseConf.USERETURN then
      BEGIN
      with CalPuntoQuery  do
      begin
        Connection:=ZCon1;
      Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT * FROM '+UseDBC.EmID+'RETURNREGLAS ';
     OPEN;
      Filter:=' CODIGO=''R1'' ';
      UseConf.PROPORTION:= FieldByName('PROPORTION').AsFloat;
      end;
      END;
       }
 end;

  function ExisteTB(MiConexion: TZConnection; MiTB: string): Boolean;
  var
  RC: integer;
  MiQuery:TZQuery;
  begin
    MiQuery:=TZQuery.Create(nil);
    MiQuery.Connection:= MiConexion;
    MiQuery.Active:=False;
    MiQuery.SQL.Clear;
    MiQuery.SQL.Add('SHOW TABLES LIKE :MiTB');
    MiQuery.ParamByName('MiTB').AsString:=MiTB;
    MiQuery.ExecSQL;

    rc:=MiQuery.RecordCount;
    MiQuery.Close;
    MiQuery.Free;
    if RC=0 then Result := False else Result := True;
  end;


  procedure TDataModule2.GetPcPrintConfig;
begin
  PCCONFIG.ID_PC:= UseDBC.PCID;
  with GetPcConfig do
  begin
    Connection:=ZCon1;
     Active:=false;
    SQL.Clear;
    SQL.Text:='SELECT * FROM '+UseDBC.EmID+'LOCALPRINTCONFIG '
            +'WHERE ID_PC=:ID_PC';
    ParamByName('ID_PC').AsString:=UseDBC.PCID;            //ע��Ͷ�     PCID; //
    Open;
    if RecordCount > 0 then
    begin
      PCCONFIG.LABELSIZEX:=FieldByName('LABELSIZEX').AsFloat;
      PCCONFIG.LABELSIZEY:=FieldByName('LABELSIZEY').AsFloat;
      PCCONFIG.LABELMODE:=FieldByName('LABELMODE').AsInteger;

      PCCONFIG.LABELPRINTNAME:=(FieldByName('LABELPRINTNAME').AsString);
      PCCONFIG.LABELPAPERDM:=(FieldByName('LABELPAPERDM').AsInteger);
      PCCONFIG.LABELPRINTPAPER:=(FieldByName('LABELPRINTPAPER').AsString);
      if FieldByName('ISMANUEL').AsString='Y' then
       begin
         PCCONFIG.ISMANUEL:=True;
       end
       else
       BEGIN
        PCCONFIG.ISMANUEL:=False;
       END;
      PCCONFIG.LABELPAPERSIZEX:=FieldByName('LABELPAPERSIZEX').AsFloat;
      PCCONFIG.LABELPAPERSIZEY:=FieldByName('LABELPAPERSIZEY').AsFloat;

     PCCONFIG.LABELPAPERCOLUMN:=FieldByName('LABELPAPERCOLUMN').AsInteger;

     PCCONFIG.TICKETERANAME:=FieldByName('TICKETERANAME').AsString;
     PCCONFIG.TICKETPRINTPAPER:= FieldByName('TICKETPRINTPAPER').AsString;
     PCCONFIG.TICKETPAPERDM:= FieldByName('TICKETPAPERDM').AsInteger;
     PCCONFIG.TICKETPAPERSIZEX:= FieldByName('TICKETPAPERSIZEX').AsFloat;
     PCCONFIG.TICKETPAPERSIZEY:= FieldByName('TICKETPAPERSIZEY').AsFloat;
     PCCONFIG.A4PRINTNAME:=FieldByName('A4PRINTNAME').AsString;
     PCCONFIG.A4PRINTPAPER:=FieldByName('A4PRINTPAPER').AsString;
     PCCONFIG.A4PAPERDM:= FieldByName('A4PAPERDM').AsInteger;
     PCCONFIG.A4PAPERSIZEX:= FieldByName('A4PAPERSIZEX').AsFloat;
     PCCONFIG.A4PAPERSIZEY:= FieldByName('A4PAPERSIZEY').AsFloat;
     PCCONFIG.CMDOPENCAJA:=FieldByName('CMDOPENCAJA').AsString;
     PCCONFIG.CMDCUTPAPER:=FieldByName('CMDCUTPAPER').AsString;
     PCCONFIG.VISOR_PORT:=FieldByName('VISOR_PORT').AsString;

     Close;

    end;
  end;
end;


end.

