program BuyCheck;

{$mode objfpc}{$H+}



uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  FileUtil, IniFiles, SysUtils, connect, Global, DefaultTranslator, U_Conn_Indy,Uloginmain,
  lcltranslator, LResources, LazUTF8, Forms, ReadDBfile, rxnew, datetimectrls,
  zcomponent, WorkStation, memdslaz, dblookup, virtualdbtreeexlaz,
  formdlgcaption, printer4lazarus, virtualdbgrid_package,
  StockActual, BuyInput, BuyIn01, BuyInColgada, CreateNewInventory, Inventory,
  GoodsFromProv, FindoutGoodsInPro, PayofBuy, His_Goods_Buy, his_buys, his_pays, Proveedor,
  His_buy_detalles, BuyListCheck, Select_SKU, indylaz, EtiquetasArticulos;

{$R *.res}

var
Conffile: Tinifile;
AWin32Version: Extended;
s:string;

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  if ParamCount > 1 then
  begin
  DBHost:=ParamStr(1);
  DBDataBase:=ParamStr(2);
  DBUsuario:=ParamStr(3);
  DBPasswd:=ParamStr(4);
  DBPuerto:=ParamStr(5);
  DBProtocolo:='mysql';
  EmID:=ParamStr(6);
  LOGIN:= ParamStr(7);
  end;

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
  AWin32Version := StrtoFloat(format('%d.%d' ,[Win32MajorVersion,Win32MinorVersion]));
  if (AWin32Version >= 6) then
    s:=GetEnvironmentVariable('ProgramData')+'\PosComecial\2\'
    else  s:=GetEnvironmentVariable('APPDATA')+'\PosComecial\2\';
   ForceDirectories(s);
   DirConf:=s;
    // DirConf:=GetEnvironmentVariable('APPDATA')+'\PosComecial\1\';
  ForceDirectories(DirConf);

   {$IFDEF UNIX}
 LogDir := sAppPath + 'log/';
 {$ENDIF}
 {$IFDEF WINDOWS}
 LogDir := s + 'log2\';
 {$ENDIF}

    if not DirectoryExists(LogDir) then
      ForceDirectories(LogDir);

 {$IFDEF UNIX}
 sLogFile := LogDir + 'debug.log';
 {$ENDIF}
 {$IFDEF WINDOWS}
 sLogFile := LogDir + 'debug.log';
 {$ENDIF}


 { LogDir := DirConf + 'log\';
   if not DirectoryExists(LogDir) then
      ForceDirectories(LogDir);
 sLogFile := LogDir + 'debug.log';  }
     RutaIni:=ExtractFilePath(ParamStr(0));
     RutaSql:= RutaIni+'Tablas\';
     RutaSqlLib:=RutaIni+'Sqllib\';
     RutaLang:=RutaIni+'locale\';
     RutaIconos:=RutaIni;
     RutaBin:= RutaIni;
     RutaReports:= RutaIni+'Report\';
     RutaModulos:= RutaIni+'Extras\';
     fileconf:=RutaIni+'Conf.ini';

     ReportPath:=RutaIni + 'Report\';

     //DecimalSeparator:='.';
     if AbrirAchivo= '' then AbrirAchivo:= 'explorer.exe';
     //ZCon1.LibraryLocation:=RutaSqlLib+'libmysql.dll';
  {$ENDIF}

  if FileExists(fileconf) then
  begin
   Conffile := TInifile.Create(fileconf) ;
   try
     lang:= Conffile.ReadString(Environment,'Lang',lang);   //ReadString(表段,常量名,赋值所给的文本);
     FallbackLang:= Conffile.ReadString(Environment,'FallbackLang',FallbackLang);
   finally
     Conffile.Free;
   end;

  end;

   if (lang <>'') and (Lang <> 'Default') then SetDefaultLang(lang)
   else
     begin
      LazGetLanguageIDs(Lang,FallbackLang);
     end;

  ShortDateFormat:='DD/MM/YYYY';
  DateSeparator := '/';
  DecimalSeparator:='.';
  ThousandSeparator:=',';

  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TDMindy, DMindy);
  //Application.CreateForm(TFormImportXLS, FormImportXLS);
  //Application.CreateForm(TFormCheck, FormCheck);

  //Application.CreateForm(TFormLogin, FormLogin);

  if aLogin() then

//  if FormLogin.IniciaLogin() = true then
  begin
   Application.CreateForm(TFormWork, FormWork);
  end
  else application.Terminate;
 // Application.CreateForm(TFormEtiPEs, FormEtiPEs);
 { Application.CreateForm(TFormBuy, FormBuy);
  Application.CreateForm(TFormBuyIn, FormBuyIn);
  Application.CreateForm(TFormColgada, FormColgada);
  Application.CreateForm(TFormNewInventory, FormNewInventory);
  Application.CreateForm(TFormInventory, FormInventory);
  Application.CreateForm(TFormProGoods, FormProGoods);
  Application.CreateForm(TGoodsFromProveedor, GoodsFromProveedor);
  Application.CreateForm(TFormBuyPay, FormBuyPay);
  Application.CreateForm(TFormGoodsBuyHis, FormGoodsBuyHis);
  Application.CreateForm(TForm_His_BuyFromProveedor, Form_His_BuyFromProveedor);
  Application.CreateForm(TFormPayInfo, FormPayInfo);
  Application.CreateForm(TFormBuyDetalles, FormBuyDetalles);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormSelectSKU, FormSelectSKU);   }
 // Application.CreateForm(TFormStock, FormStock);
 // Application.CreateForm(TFormCategory, FormCategory);
 //  Application.CreateForm(TfrmDlgCaption, frmDlgCaption);
  //Application.CreateForm(TFLookup, FLookup);
  Application.Run;
end.

