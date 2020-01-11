unit ReadDBfile;

{$mode objfpc}{$H+}

interface

uses
  {$IFNDEF LCL} Windows, Messages, {$ELSE} LclIntf, LMessages, LclType, LResources, {$ENDIF}
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, ZConnection, ZDataset, cyEditInteger, fpspreadsheetctrls,
  fpspreadsheetgrid, fpsallformats, fpsTypes, typinfo, fpsutils, math, Proveedor,
  connect, global, DateTimePicker, db;

const
  OK = 0;

type

  { TFormImportXLS }

  TFormImportXLS = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    CheckBox1: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    DataSource2: TDataSource;
    Edit3: TEdit;
    Label1: TLabel;
    Label18: TLabel;
    ProDataSource: TDataSource;
    ProvQuery: TZQuery;
    PuntoC: TComboBox;
    cyEditInteger1: TcyEditInteger;
    cyEditInteger2: TcyEditInteger;
    cyEditInteger3: TcyEditInteger;
    cyEditInteger4: TcyEditInteger;
    cyEditInteger5: TcyEditInteger;
    cyEditInteger6: TcyEditInteger;
    cyEditInteger7: TcyEditInteger;
    cyEditInteger8: TcyEditInteger;
    cyEditInteger9: TcyEditInteger;
    DataSource1: TDataSource;
    DateTimePicker1: TDateTimePicker;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DocDataSource: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Label11: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    StaffDBLookupComboBox: TDBLookupComboBox;
    STAFFQuery: TZQuery;
    sWorkbookSource1: TsWorkbookSource;
    sWorksheetGrid1: TsWorksheetGrid;
    ZCon1: TZConnection;
    ExecutQuery: TZQuery;
    DocQuery: TZQuery;
    StockListQuery: TZQuery;
    ChangeConfQuery: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure cyEditInteger1KeyPress(Sender: TObject; var Key: char);
    procedure cyEditInteger2KeyPress(Sender: TObject; var Key: char);
    procedure cyEditInteger3KeyPress(Sender: TObject; var Key: char);
    procedure cyEditInteger4KeyPress(Sender: TObject; var Key: char);
    procedure cyEditInteger5KeyPress(Sender: TObject; var Key: char);
    procedure cyEditInteger6KeyPress(Sender: TObject; var Key: char);
    procedure cyEditInteger7KeyPress(Sender: TObject; var Key: char);
    procedure cyEditInteger8KeyPress(Sender: TObject; var Key: char);
    procedure cyEditInteger9KeyPress(Sender: TObject; var Key: char);
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure DBLookupComboBox2Click(Sender: TObject);
    procedure DBLookupComboBox2CloseUp(Sender: TObject);
    procedure DBLookupComboBox3KeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GetSTAFFList;
    procedure DoGetProveedor;
    procedure PuntoCKeyPress(Sender: TObject; var Key: char);
    procedure sWorksheetGrid1GetColHeaderText(Sender: TObject;
  AIndex: Integer; var AText: String);
  private
    function IsCheckItemOk(): integer;
    procedure  GetStockList;

  public

  end;

var
  FormImportXLS: TFormImportXLS;
  Cols,Rows,i,x,y,K,L:integer;
  ct:boolean;
  COLOFCODING, COLOFBARCODE, COLOFNAMEITEM, COLOFQUANTITY, COLOFPRICE_SIN, COLOFPRICE_CON: integer;
  COLOFTAXRATE, COLOFDISCOUNT, COLOFPVPOPTION: integer;
  ID_TMPLIST, Read_Col:string;

implementation

{$R *.lfm}

{ TFormImportXLS }
function TFormImportXLS.IsCheckItemOk():integer;
begin
  if (CheckBox1.Checked) and (trim(cyEditInteger1.Text) = '') or (trim(cyEditInteger1.Text) = '0') then
 begin
   result:=1;
 end
 else
 if (CheckBox2.Checked) and (trim(cyEditInteger2.Text) = '') or (trim(cyEditInteger2.Text) = '0') then
 begin
   result:=2;
 end
 else
 if (CheckBox3.Checked) and (trim(cyEditInteger3.Text) = '') or (trim(cyEditInteger3.Text) = '0') then
 begin
   result:=3;
 end
 else
 if (trim(cyEditInteger4.Text) = '') or (trim(cyEditInteger4.Text) = '0') then
 begin
   result:=4;
 end
 else
 if (CheckBox5.Checked) and (trim(cyEditInteger5.Text) = '') or (trim(cyEditInteger5.Text) = '0') then
 begin
   result:=5;
 end
 else
 if (CheckBox7.Checked) and (trim(cyEditInteger7.Text) = '') or (trim(cyEditInteger7.Text) = '0') then
 begin
   result:=7;
 end
 else
 if (CheckBox6.Checked) and (trim(cyEditInteger6.Text) = '') or (trim(cyEditInteger6.Text) = '0') then
 begin
   result:=6;
 end
 else
 if (CheckBox8.Checked) and (trim(cyEditInteger8.Text) = '') or (trim(cyEditInteger8.Text) = '0') then
 begin
  result:=7;
 end
 else
 if (CheckBox9.Checked) and (trim(cyEditInteger9.Text) = '') or (trim(cyEditInteger9.Text) = '0') then
 begin
   result:=8;
 end
 else
 result:=OK;

end;

procedure TFormImportXLS.sWorksheetGrid1GetColHeaderText(Sender: TObject;
  AIndex: Integer; var AText: String);
begin
 // AText := 'Col ' + IntToStr(AIndex);
  AText :=  IntToStr(AIndex);
end;

procedure TFormImportXLS.Button1Click(Sender: TObject);
var
  FileEx:string;
  mm:string;
begin
  if OpenDialog1.Execute then
  begin
  FileEx:=ExtractFileExt(OpenDialog1.FileName);
  edit1.Text:= OpenDialog1.FileName;
  sWorkbookSource1.LoadFromSpreadsheetFile(OpenDialog1.FileName);
   Button2.Enabled:=True;
   Cols:=sWorksheetGrid1.ColCount;
   Rows:=sWorksheetGrid1.RowCount;

  end;
end;

procedure TFormImportXLS.Button2Click(Sender: TObject);
var
  x :integer;

  ds,dc:string;
  ipos:integer;
  Formula:String;
  ContentType: string;
  ACell: PCell;
  Lanjie, Ena:TStringArray;
  KeyText:string;
  EnaText:string;
begin
  KeyText:=Edit3.Text;
  Lanjie:=KeyText.Split([';',',', ' ']);
  sWorksheetGrid1.Workbook.FormatSettings.DecimalSeparator := PuntoC.Text[1];
  if DBLookupComboBox1.KeyValue=NULL then
   begin
   DBLookupComboBox1.Color:=CLYELLOW;
   DBLookupComboBox1.SetFocus;
   exit;
   end;
if DBLookupComboBox2.KeyValue=NULL then
   begin
   DBLookupComboBox2.Color:=CLYELLOW;
   DBLookupComboBox2.SetFocus;
   exit;
   end;
if DBLookupComboBox3.KeyValue=NULL then
   begin
   DBLookupComboBox3.Color:=CLYELLOW;
   DBLookupComboBox3.SetFocus;
   exit;
   end;
if StaffDBLookupComboBox.KeyValue=null then
     begin
     StaffDBLookupComboBox.Color:=CLyellow;
     StaffDBLookupComboBox.SetFocus;
     EXIT;
     end;

if (PuntoC.Text='') or (PuntoC.ItemIndex < 0) then PuntoC.SetFocus;
   x:=IsCheckItemOK();
   case x of
    1, 2, 3,4,5,6,7: begin
      showmessage('导入格式设置不对.');
      case x of
       1: cyEditInteger1.SetFocus;
       2: cyEditInteger2.SetFocus;
       3: cyEditInteger3.SetFocus;
       4: cyEditInteger4.SetFocus;
       5: cyEditInteger5.SetFocus;
       6: cyEditInteger6.SetFocus;
       7: cyEditInteger7.SetFocus;
      end;
      exit;
    end;
    else
     // showmessage('go');

   end;
    if (NOT (CheckBox1.Checked)) and (NOT (CheckBox2.Checked)) and (NOT (CheckBox3.Checked)) then
    BEGIN
    showmessage('至少要包含货品编码,条形码或货品名称中的一项.');
    exit;
    END;
    if NOT (CheckBox5.Checked) and NOT (CheckBox7.Checked) then
    begin
    showmessage('没有进价项啊.无法继续.');
    exit;
    end;

   //初始化数据
  K:=0;
  L:=0;
  if (CheckBox2.Checked) then             //条形码
  begin
    Read_Col:='CODBARRA';
  end
  else if (CheckBox1.Checked) then
    Read_Col:='CODING'
  else if (CheckBox3.Checked) then
    Read_Col:='NAMEITEM';

  COLOFCODING:=cyEditInteger1.Value-1;
  COLOFBARCODE:=cyEditInteger2.Value-1;
  COLOFNAMEITEM:=cyEditInteger3.Value-1;
  COLOFQUANTITY:=cyEditInteger4.Value-1;
  COLOFPRICE_SIN:=cyEditInteger5.Value-1;
  COLOFPRICE_CON:=cyEditInteger7.Value-1;
  COLOFTAXRATE:=cyEditInteger6.Value-1;
  COLOFDISCOUNT:=cyEditInteger8.Value-1;
  COLOFPVPOPTION:=cyEditInteger9.Value-1;



  //如果是新单
  if not ct then
   begin
      with ExecutQuery do
      begin
      Connection:=zcon1;
      Active:=false;
      SQL.Clear;
      //SQL.Text:='INSERT INTO '+UseDBC.EmID+'TMPLISTCTOPS '
      SQL.Text:='INSERT INTO CHECKLIST_ORDERS '
       +'(ID_PROVEEDOR, NAME_PROVEEDOR, DOCUMENT, N_DOCUMENT, STAFF, READ_COL, '
       +'FECHA_C, FECHA_I, EMPLEADO, ISIVAINCLUIDO, ISREQINCLUIDO, TOTAL, ISCHECKED, ID_STOCK) '
       +' VALUES (:ID_PROVEEDOR, :NAME_PROVEEDOR, :DOCUMENT, :N_DOCUMENT, :STAFF, :READ_COL, :FECHA_C, :FECHA_I, '
       +':EMPLEADO, :ISIVAINCLUIDO, :ISREQINCLUIDO, :TOTAL, :ISCHECKED, :ID_STOCK) ';
       ParamByName('ID_PROVEEDOR').AsString:=DBLookupComboBox1.KeyValue;
       ParamByName('NAME_PROVEEDOR').AsString:=DBLookupComboBox1.Text;
       ParamByName('DOCUMENT').AsString:=DBLookupComboBox2.KeyValue;
       ParamByName('N_DOCUMENT').AsString:=Edit2.Text;
       ParamByName('STAFF').AsString:=StaffDBLookupComboBox.Text;
       ParamByName('READ_COL').AsString:=READ_COL;
       ParamByName('FECHA_C').AsDate:=DateTimePicker1.Date;
       ParamByName('FECHA_I').AsDate:=date;
       ParamByName('EMPLEADO').AsString:=LOGIN; //LoginUser;
       if CheckBox7.Checked then
       begin
       ParamByName('ISIVAINCLUIDO').AsString:='Y';
       ParamByName('ISREQINCLUIDO').AsString:='Y';
       end
       else
       begin
        ParamByName('ISIVAINCLUIDO').AsString:='N';
       ParamByName('ISREQINCLUIDO').AsString:='N';
       end;
       ParamByName('TOTAL').AsCurrency:=0;
       ParamByName('ISCHECKED').AsString:='N';
       ParamByName('ID_STOCK').AsString:=DBLookupComboBox3.KeyValue;

       ExecSQL;
       SQL.Clear;
       SQL.Text:='select max(ID_TMPLIST) as ID_TMPLIST from CHECKLIST_ORDERS ';
       open;
       ID_TMPLIST:=FieldByName('ID_TMPLIST').AsString;
       Close;
      end;
   end;  //no ct


  //////////////////////////////////////////////////////////////////
  ////开始转换数据
  ////MyWorkbook.FormatSettings.DecimalSeparator := '.';
  //////////////////////////////////////////////////////////////////

  WITH EXECUTQUERY DO
        BEGIN
        ACTIVE:=FALSE;
        SQL.CLEAR;
        SQL.TEXT:='INSERT INTO CHECKLIST_ITEMS '
        +'(SUCODIGO, CDBARRA, DESCRIPCION, AMOUNT, PRECIO_sin, PRECIO_con, DISCOUNT, IVA,  '
        +'ID_TMPLIST,  PVPOPTION, status) '
        +'VALUES (:SUCODIGO, :CDBARRA,:DESCRIPCION, :AMOUNT, :PRECIO_sin, :PRECIO_con, :DISCOUNT, :IVA, '
        +':ID_TMPLIST,  :PVPOPTION,  :status) '
        +'ON DUPLICATE KEY UPDATE '
        +'AMOUNT=AMOUNT+:AMOUNT ';
        END;
  ZCon1.AutoCommit:=true;
  try
    ZCon1.StartTransaction;
    FOR Y:=1 TO Rows DO
    BEGIN
      if (CheckBox1.Checked) then             //货品编码
      begin
      AEXCELLINE.CODING:=TRIM(sWorksheetGrid1.Worksheet.ReadAsText(Y,COLOFCODING));
      end
      else AEXCELLINE.CODING:='';
      if (CheckBox2.Checked)  then             //条形码
      begin
      EnaText:=TRIM(sWorksheetGrid1.Worksheet.ReadAsText(Y,COLOFBARCODE));
      if EnaText='' then  AEXCELLINE.CODBARRA:=''
      else begin
       Ena:=EnaText.Split(Lanjie);
       if length(Ena)=0 then AEXCELLINE.CODBARRA:='' else
       AEXCELLINE.CODBARRA:=Ena[0];
         if CheckBox4.Checked then begin
             AEXCELLINE.CODBARRA:=LeftStr(Ena[0],13);
          end;

         end
      end
      else AEXCELLINE.CODBARRA:='';
      if (CheckBox3.Checked) then             //货品名称
      begin
      AEXCELLINE.NAMEITEM:=TRIM(sWorksheetGrid1.Worksheet.ReadAsText(Y,COLOFNAMEITEM));
      end
      else AEXCELLINE.NAMEITEM:='';

      //数量
      ACell:=sWorksheetGrid1.Worksheet.GetCell(Y,COLOFQUANTITY);
      ContentType:= GetEnumName(TypeInfo(TCellContentType), ord(ACell^.ContentType));
      if (ContentType='cctNumber') or (ContentType='cctUTF8String') then
      begin
        AEXCELLINE.AMOUNT:=sWorksheetGrid1.Worksheet.ReadAsNumber(Y,COLOFQUANTITY);
        if isNan(AEXCELLINE.AMOUNT) then AEXCELLINE.AMOUNT := 0;
      end
      else AEXCELLINE.AMOUNT:=0.0;
      if (AEXCELLINE.AMOUNT=0)  then
      begin
        AEXCELLINE.CODING:=''; AEXCELLINE.CODBARRA:=''; AEXCELLINE.NAMEITEM:='';
      end;


      //单价无税
      if (CheckBox5.Checked) then
      begin
        ACell:=sWorksheetGrid1.Worksheet.GetCell(Y,COLOFPRICE_SIN);
      ContentType:= GetEnumName(TypeInfo(TCellContentType), ord(ACell^.ContentType));
      if (ContentType='cctNumber') or (ContentType='cctUTF8String') then
        begin
          AEXCELLINE.PRICE_SIN:=sWorksheetGrid1.Worksheet.ReadAsNumber(Y,COLOFPRICE_SIN);
          if isNan(AEXCELLINE.PRICE_SIN) then AEXCELLINE.PRICE_SIN := 0;
        end
        else AEXCELLINE.PRICE_SIN:=0;

      end
      else AEXCELLINE.PRICE_SIN:=0;


      //单价含税
      if (CheckBox7.Checked) then             //单价含税
      begin
      ACell:=sWorksheetGrid1.Worksheet.GetCell(Y,COLOFPRICE_CON);
      ContentType:= GetEnumName(TypeInfo(TCellContentType), ord(ACell^.ContentType));
      if (ContentType='cctNumber') or (ContentType='cctUTF8String')  then
        begin
          AEXCELLINE.PRICE_CON:=sWorksheetGrid1.Worksheet.ReadAsNumber(Y,COLOFPRICE_CON);
          if isNan(AEXCELLINE.PRICE_CON) then AEXCELLINE.PRICE_CON := 0;
        end
        else AEXCELLINE.PRICE_CON:=0;
      end
      else AEXCELLINE.PRICE_CON:=0;

      //税率(含百分比)
      if (CheckBox6.Checked) then
      begin
      ACell:=sWorksheetGrid1.Worksheet.GetCell(Y,COLOFTAXRATE);
      ContentType:= GetEnumName(TypeInfo(TCellContentType), ord(ACell^.ContentType));
      if (ContentType='cctNumber') or (ContentType='cctUTF8String')  then
       BEGIN
        iF CHECKBOX18.CHECKED then     //含百分比符号
        begin
            AEXCELLINE.IVA:=sWorksheetGrid1.Worksheet.ReadAsNumber(Y,COLOFTAXRATE)*100;
        end
        ELSE
        begin
        AEXCELLINE.IVA:=sWorksheetGrid1.Worksheet.ReadAsNumber(Y,COLOFTAXRATE);
        END;
         if isNan(AEXCELLINE.IVA) then AEXCELLINE.IVA := 0;

       END else AEXCELLINE.IVA:=0;
      end
      else AEXCELLINE.IVA:=0;

      //折扣
      if (CheckBox8.Checked) then
      begin
      ACell:=sWorksheetGrid1.Worksheet.GetCell(Y,COLOFDISCOUNT);
      ContentType:= GetEnumName(TypeInfo(TCellContentType), ord(ACell^.ContentType));
      if (ContentType='cctNumber') or (ContentType='cctUTF8String')  then
        begin
        AEXCELLINE.DISC:=sWorksheetGrid1.Worksheet.ReadAsNumber(Y,COLOFDISCOUNT);
        END else AEXCELLINE.DISC:=0;
        if isNan(AEXCELLINE.DISC) then AEXCELLINE.DISC := 0;
      END
      ELSE AEXCELLINE.DISC:=0;

       //建议价
      if (CheckBox9.Checked) then
      BEGIN
        ACell:=sWorksheetGrid1.Worksheet.GetCell(Y,COLOFPVPOPTION);
        ContentType:= GetEnumName(TypeInfo(TCellContentType), ord(ACell^.ContentType));
        if (ContentType='cctNumber') or (ContentType='cctUTF8String')  then
        begin
        AEXCELLINE.PVPOPTION:=sWorksheetGrid1.Worksheet.ReadAsNumber(Y,COLOFPVPOPTION);
        END else AEXCELLINE.PVPOPTION:=0;
        if isNan(AEXCELLINE.PVPOPTION) then AEXCELLINE.PVPOPTION := 0;
      END
      ELSE AEXCELLINE.PVPOPTION:=0;

       //开始输入
  // ShowMessage(AEXCELLINE.CODING+':'+AEXCELLINE.CODBARRA+':'+AEXCELLINE.NAMEITEM);
      ///如果数量为0,那么没必要输入
      if AEXCELLINE.AMOUNT=0 then
      begin
      AEXCELLINE.CODING:=''; AEXCELLINE.CODBARRA:=''; AEXCELLINE.NAMEITEM:='';
      end;

      IF NOT (AEXCELLINE.CODING='') or NOT (AEXCELLINE.CODBARRA='') or NOT (AEXCELLINE.NAMEITEM='')  THEN
      BEGIN
        WITH EXECUTQUERY DO
        BEGIN
        //CONNECTION:=UNICON;
       { ACTIVE:=FALSE;
        SQL.CLEAR;
        SQL.TEXT:='INSERT INTO '+USEDBC.EMID+'REPASOLISTDETALLES '
        +'(SUCODIGO, CDBARRA, DESCRIPCION, UNIDAD, PRECIO_sin, PRECIO_con, DESCUENTO, IVA, '
        +'ID_TMPLIST, ID_PROVEEDOR, DOCUMENT, N_DOCUMENT, PVPOPTION) '
        +'VALUES (:SUCODIGO, :CDBARRA,:DESCRIPCION, :UNIDAD, :PRECIO_sin, :PRECIO_con, :DESCUENTO, :IVA, '
        +':ID_TMPLIST, :ID_PROVEEDOR, :DOCUMENT, :N_DOCUMENT, :PVPOPTION);'; }
        PARAMBYNAME('SUCODIGO').ASSTRING:=AEXCELLINE.CODING;
        PARAMBYNAME('CDBARRA').ASSTRING:=AEXCELLINE.CODBARRA;
        PARAMBYNAME('DESCRIPCION').ASSTRING:=AEXCELLINE.NAMEITEM;
        PARAMBYNAME('AMOUNT').ASFLOAT:=AEXCELLINE.AMOUNT;
        PARAMBYNAME('PRECIO_sin').ASFLOAT:=AEXCELLINE.PRICE_Sin;
        PARAMBYNAME('PRECIO_con').ASFLOAT:=AEXCELLINE.PRICE_CON;
        PARAMBYNAME('DISCOUNT').ASFLOAT:=AEXCELLINE.DISC;
        PARAMBYNAME('IVA').ASFLOAT:=AEXCELLINE.IVA;
        PARAMBYNAME('ID_TMPLIST').ASSTRING:=ID_TMPLIST;
        PARAMBYNAME('PVPOPTION').ASFLOAT:=AEXCELLINE.PVPOPTION;
        if AEXCELLINE.AMOUNT<0  then PARAMBYNAME('status').AsInteger:=1
        else PARAMBYNAME('status').AsInteger:=0;
        ExecSQL;
        END;
      L:=L+1;
      END
      ELSE K:=K+1;
    end;
    ZCon1.Commit;
      if k=Rows then
      begin
      with ExecutQuery do
      begin
      Connection:=Zcon1;
      Active:=false;
      SQL.Clear;
      SQL.Text:='delete from CHECKLIST_ORDERS '
      +'where ID_TMPLIST = :ID_TMPLIST';
      ParamByName('ID_TMPLIST').AsString:=ID_TMPLIST;
      end;
      ShowMessage('没有转换成功');
      end
      else
      begin
     // PostMessage(Form_L_bay.Handle, WM_DoChange, 2, 0);
      showmessage('共有( '+inttostr(Rows) +' )行, 已成功转换了( '+inttostr(L)+' )行数据.');
      if Application.MessageBox( //'共有( '+inttostr(n) +' )行, 已成功转换了( '+inttostr(L)+' )行数据.'+#13#10
	        '连续导入吗?',
	        '信息',
	        MB_YESNO Or MB_ICONQUESTION) = IDNO then
      begin
      ct:=False;
      Button2.Enabled:=False;
      DBLookupComboBox1.Enabled:=True;
      DBLookupComboBox1.KeyValue:=NULL;
      DBLookupComboBox2.KeyValue:=NULL;
      edit1.Text:='';
      sWorksheetGrid1.Clear;

      end
      else
      begin
      ct:=true;
      edit1.Text:='';
      DBLookupComboBox1.Enabled:=False;
      sWorksheetGrid1.Clear;

      end;


      end;
  except
  ZCon1.Rollback;
  ShowMessage('No se pudo guardar la compra');
  end;


end;

procedure TFormImportXLS.Button3Click(Sender: TObject);
var
  Formula, ContentType, str: string;
  x, y :integer;
  ACell: PCell;
  mm:double;
begin
  sWorksheetGrid1.Workbook.FormatSettings.DecimalSeparator := '.';
  for y:=17 to 27 do
  for x:=0 to 13 do
  begin
  ACell:=sWorksheetGrid1.Worksheet.GetCell(y,x);
  ContentType:= GetEnumName(TypeInfo(TCellContentType), ord(ACell^.ContentType));
 // showmessage(ContentType);
  if HasFormula(ACell) then
         showmessage(' Formula: '+ sWorksheetGrid1.Worksheet.ReadFormulaAsString(ACell));
  if (ContentType='cctNumber')  then
        begin
        mm:=sWorksheetGrid1.Worksheet.ReadAsNumber(y,x)*100;
        showmessage('s:'+floattostr(mm));
        end
      else
      begin
      if (x=10) or (x=13) then begin mm:=sWorksheetGrid1.Worksheet.ReadAsNumber(y,x); showmessage('ss:'+floattostr(mm));
        end  else begin
      str:=sWorksheetGrid1.Worksheet.ReadAsText(y,x);
      showmessage(str);

        end;
      end;

  end;
end;

procedure TFormImportXLS.Button4Click(Sender: TObject);
begin
    if DBLookupComboBox1.KeyValue=NULL then
   begin
   DBLookupComboBox1.Color:=CLYELLOW;
   DBLookupComboBox1.SetFocus;
   exit;
   end;
  if DBLookupComboBox2.KeyValue=NULL then
   begin
   DBLookupComboBox2.Color:=CLYELLOW;
   DBLookupComboBox2.SetFocus;
   exit;
   end;
 with ExecutQuery do
 begin
  Connection:=ZCon1;
  Active:=false;
  SQL.Clear;
  SQL.Text:='INSERT INTO '+UseDBC.EMID+'FILEDBCONFIG '
            +'(ID_PROVEEDOR, TYPE_DOC, INCLUID_CODING, INCLUID_BARCODE, INCLUID_NAMEITEM, '
            +'INCLUID_PRICE_SIN, INCLUID_PRICE_CON, INCLUID_TAX_RATE, INCLUID_DISCOUNT, '
             +'INCLUID_PORCIEN, INCLUID_ZIFU, INCLUID_PVPOPTION, '
            +'ROWOFCODING, ROWOFBARCODE, ROWOFNAMEITEM, ROWOFQUANTITY, ROWOFPRICE_SIN, ROWOFPRICE_CON, '
            +'ROWOFTAXRATE, ROWOFDISCOUNT,  ROWOFPVPOPTION )'
            +'VALUES (:ID_PROVEEDOR, :TYPE_DOC, :INCLUID_CODING, :INCLUID_BARCODE, :INCLUID_NAMEITEM, '
            +':INCLUID_PRICE_SIN, :INCLUID_PRICE_CON, :INCLUID_TAX_RATE, :INCLUID_DISCOUNT, '
            +':INCLUID_PORCIEN, :INCLUID_ZIFU, :INCLUID_PVPOPTION, '
            +':ROWOFCODING, :ROWOFBARCODE, :ROWOFNAMEITEM, :ROWOFQUANTITY, :ROWOFPRICE_SIN, :ROWOFPRICE_CON, '
            +':ROWOFTAXRATE, :ROWOFDISCOUNT,  :ROWOFPVPOPTION ) ON DUPLICATE KEY UPDATE '
            +'INCLUID_CODING=:INCLUID_CODING, INCLUID_BARCODE=:INCLUID_BARCODE, INCLUID_NAMEITEM=:INCLUID_NAMEITEM, '
            +'INCLUID_PRICE_SIN=:INCLUID_PRICE_SIN, INCLUID_PRICE_CON=:INCLUID_PRICE_CON, '
            +'INCLUID_TAX_RATE=:INCLUID_TAX_RATE, INCLUID_DISCOUNT=:INCLUID_DISCOUNT, '
             +'INCLUID_PORCIEN=:INCLUID_PORCIEN, INCLUID_ZIFU=:INCLUID_ZIFU, INCLUID_PVPOPTION=:INCLUID_PVPOPTION, '
            +'ROWOFCODING=:ROWOFCODING, ROWOFBARCODE=:ROWOFBARCODE, ROWOFNAMEITEM=:ROWOFNAMEITEM, '
            +'ROWOFQUANTITY=:ROWOFQUANTITY, ROWOFPRICE_SIN=:ROWOFPRICE_SIN, ROWOFPRICE_CON=:ROWOFPRICE_CON, '
            +'ROWOFTAXRATE=:ROWOFTAXRATE, ROWOFDISCOUNT=:ROWOFDISCOUNT,  ROWOFPVPOPTION=:ROWOFPVPOPTION';
   ParamByName('ID_PROVEEDOR').AsString:=DBLookupComboBox1.KeyValue;
   ParamByName('TYPE_DOC').AsString:=DBLookupComboBox2.KeyValue;
   if CheckBox1.Checked then
   (ParamByName('INCLUID_CODING').AsString:='Y')
   ELSE (ParamByName('INCLUID_CODING').AsString:='N');
   if CheckBox2.Checked then
   ParamByName('INCLUID_BARCODE').AsString:='Y'
   ELSE ParamByName('INCLUID_BARCODE').AsString:='N';
   if CheckBox3.Checked then
   ParamByName('INCLUID_NAMEITEM').AsString:='Y'
   ELSE ParamByName('INCLUID_NAMEITEM').AsString:='N';
   if CheckBox5.Checked then
   ParamByName('INCLUID_PRICE_SIN').AsString:='Y'
   ELSE ParamByName('INCLUID_PRICE_SIN').AsString:='N';
   if CheckBox7.Checked then
   ParamByName('INCLUID_PRICE_CON').AsString:='Y'
   ELSE ParamByName('INCLUID_PRICE_CON').AsString:='N';
   if CheckBox6.Checked then
   ParamByName('INCLUID_TAX_RATE').AsString:='Y'
   ELSE ParamByName('INCLUID_TAX_RATE').AsString:='N';
   if CheckBox8.Checked then
   ParamByName('INCLUID_DISCOUNT').AsString:='Y'
   ELSE ParamByName('INCLUID_DISCOUNT').AsString:='N';
   if CheckBox18.Checked then
   ParamByName('INCLUID_PORCIEN').AsString:='Y'
   ELSE ParamByName('INCLUID_PORCIEN').AsString:='N';
   if CheckBox19.Checked then
   ParamByName('INCLUID_ZIFU').AsString:='Y'
   ELSE ParamByName('INCLUID_ZIFU').AsString:='N';
   if CheckBox9.Checked then
   ParamByName('INCLUID_PVPOPTION').AsString:='Y'
   ELSE ParamByName('INCLUID_PVPOPTION').AsString:='N';
   ParamByName('ROWOFCODING').AsString:=cyEditInteger1.Text;
   ParamByName('ROWOFBARCODE').AsString:=cyEditInteger2.Text;
   ParamByName('ROWOFNAMEITEM').AsString:=cyEditInteger3.Text;
   ParamByName('ROWOFQUANTITY').AsString:=cyEditInteger4.Text;
   ParamByName('ROWOFPRICE_SIN').AsString:=cyEditInteger5.Text;
   ParamByName('ROWOFPRICE_CON').AsString:=cyEditInteger7.Text;
   ParamByName('ROWOFTAXRATE').AsString:=cyEditInteger6.Text;
   ParamByName('ROWOFDISCOUNT').AsString:=cyEditInteger8.Text;
   ParamByName('ROWOFPVPOPTION').AsString:=cyEditInteger9.Text;

   ExecSQL;

 end;

end;

procedure TFormImportXLS.Button5Click(Sender: TObject);
var
  result: integer;
  Sqltable:string;
begin

 Sqltable:= EMID+'PROVEEDORLIST';
  Result:=FormProveedor.IniciaMExcute(Sqltable);
  if (Result >0 ) then DataModule2.ProvQuery.Refresh;
end;

procedure TFormImportXLS.Button6Click(Sender: TObject);
begin
  Close;
end;

procedure TFormImportXLS.CheckBox1Click(Sender: TObject);
begin
  cyEditInteger1.Enabled:=CheckBox1.Checked;
  if cyEditInteger1.Enabled then cyEditInteger1.Color:=clYellow  else cyEditInteger1.Color:=clWindow;
end;

procedure TFormImportXLS.CheckBox2Click(Sender: TObject);
begin
  cyEditInteger2.Enabled:=CheckBox2.Checked;
  if cyEditInteger2.Enabled then cyEditInteger2.Color:=clYellow  else
    begin
     cyEditInteger2.Color:=clWindow;
     cyEditInteger2.Text:='';
    end;
end;

procedure TFormImportXLS.CheckBox3Click(Sender: TObject);
begin
  cyEditInteger3.Enabled:=CheckBox3.Checked;
  if cyEditInteger3.Enabled then cyEditInteger3.Color:=clYellow  else
    begin
     cyEditInteger3.Color:=clWindow;
     cyEditInteger3.Text:='';
    end;

end;

procedure TFormImportXLS.CheckBox5Click(Sender: TObject);
begin
   cyEditInteger5.Enabled:=CheckBox5.Checked;
  if cyEditInteger5.Enabled then cyEditInteger5.Color:=clYellow  else
    begin
     cyEditInteger5.Color:=clWindow;
     cyEditInteger5.Text:='';
    end;
end;

procedure TFormImportXLS.CheckBox6Click(Sender: TObject);
begin
  cyEditInteger6.Enabled:=CheckBox6.Checked;
  if cyEditInteger6.Enabled then cyEditInteger6.Color:=clYellow  else
    begin
     cyEditInteger6.Color:=clWindow;
     cyEditInteger6.Text:='';
    end;
end;

procedure TFormImportXLS.CheckBox7Click(Sender: TObject);
begin
  cyEditInteger7.Enabled:=CheckBox7.Checked;
  if cyEditInteger7.Enabled then cyEditInteger7.Color:=clYellow  else
    begin
     cyEditInteger7.Color:=clWindow;
     cyEditInteger7.Text:='';
    end;
end;

procedure TFormImportXLS.CheckBox8Click(Sender: TObject);
begin
  cyEditInteger8.Enabled:=CheckBox8.Checked;
  if cyEditInteger8.Enabled then cyEditInteger8.Color:=clYellow  else
    begin
     cyEditInteger8.Color:=clWindow;
     cyEditInteger8.Text:='';
    end;
end;

procedure TFormImportXLS.CheckBox9Click(Sender: TObject);
begin
  cyEditInteger9.Enabled:=CheckBox9.Checked;
  if cyEditInteger9.Enabled then cyEditInteger9.Color:=clYellow  else
    begin
     cyEditInteger9.Color:=clWindow;
     cyEditInteger9.Text:='';
    end;
end;



procedure TFormImportXLS.cyEditInteger1KeyPress(Sender: TObject; var Key: char);
begin
  if (Key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure TFormImportXLS.cyEditInteger2KeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure TFormImportXLS.cyEditInteger3KeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure TFormImportXLS.cyEditInteger4KeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure TFormImportXLS.cyEditInteger5KeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure TFormImportXLS.cyEditInteger6KeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure TFormImportXLS.cyEditInteger7KeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure TFormImportXLS.cyEditInteger8KeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure TFormImportXLS.cyEditInteger9KeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure TFormImportXLS.DBLookupComboBox1Click(Sender: TObject);
begin

end;

procedure TFormImportXLS.DBLookupComboBox1CloseUp(Sender: TObject);
var
doc:string;
begin
  if DBLookupComboBox1.KeyValue=null then Exit;
if DBLookupComboBox2.KeyValue=null then doc:=''
 else doc:=DBLookupComboBox2.KeyValue;
with ChangeConfQuery do
begin
 Connection:=Zcon1;
  Active:=false;
  SQL.Clear;
  SQL.Text:='SELECT * FROM '+UseDBC.EMID+'FILEDBCONFIG '
          +'WHERE ID_PROVEEDOR=:ID_PROVEEDOR and TYPE_DOC=:TYPE_DOC ';
  ParamByName('ID_PROVEEDOR').AsString:=DBLookupComboBox1.KeyValue;
  ParamByName('TYPE_DOC').AsString:=doc;
  Open;
   CheckBox1.Checked:=FieldByName('INCLUID_CODING').AsBoolean;
   CheckBox2.Checked:=FieldByName('INCLUID_BARCODE').AsBoolean;
   CheckBox3.Checked:=FieldByName('INCLUID_NAMEITEM').AsBoolean;
   CheckBox5.Checked:=FieldByName('INCLUID_PRICE_SIN').AsBoolean;
   CheckBox7.Checked:=FieldByName('INCLUID_PRICE_CON').AsBoolean;
   CheckBox6.Checked:=FieldByName('INCLUID_TAX_RATE').AsBoolean;
   CheckBox8.Checked:=FieldByName('INCLUID_DISCOUNT').AsBoolean;
   CheckBox18.Checked:=FieldByName('INCLUID_PORCIEN').AsBoolean;
   CheckBox19.Checked:=FieldByName('INCLUID_ZIFU').AsBoolean;
   CheckBox9.Checked:=FieldByName('INCLUID_PVPOPTION').AsBoolean;
   if CheckBox1.Checked then
         begin
         cyEditInteger1.Text:=FieldByName('ROWOFCODING').AsString;
         cyEditInteger1.Enabled:=True;
         end
         else begin
         cyEditInteger1.Text:='';
         cyEditInteger1.Enabled:=False;
         end;
    if CheckBox2.Checked then
         begin
         cyEditInteger2.Text:=FieldByName('ROWOFBARCODE').AsString;
         cyEditInteger2.Enabled:=True;
         end
         else begin
         cyEditInteger2.Text:='';
         cyEditInteger2.Enabled:=False;
         end;
    if CheckBox3.Checked then
         begin
         cyEditInteger3.Text:=FieldByName('ROWOFNAMEITEM').AsString;
         cyEditInteger3.Enabled:=True;
         end
         else begin
         cyEditInteger3.Text:='';
         cyEditInteger3.Enabled:=False;
         end;
    cyEditInteger4.Text:=FieldByName('ROWOFQUANTITY').AsString;
   if CheckBox5.Checked then
         begin
         cyEditInteger5.Text:=FieldByName('ROWOFPRICE_SIN').AsString;
         cyEditInteger5.Enabled:=True;
         end
         else begin
         cyEditInteger5.Text:='';
         cyEditInteger5.Enabled:=False;
         end;
   if CheckBox6.Checked then
         begin
         cyEditInteger6.Text:=FieldByName('ROWOFTAXRATE').AsString;
         cyEditInteger6.Enabled:=True;
         end
         else begin
         cyEditInteger6.Text:='';
         cyEditInteger6.Enabled:=False;
         end;
   if CheckBox7.Checked then
         begin
         cyEditInteger7.Text:=FieldByName('ROWOFPRICE_CON').AsString;
         cyEditInteger7.Enabled:=True;
         end
         else begin
         cyEditInteger7.Text:='';
         cyEditInteger7.Enabled:=False;
         end;
    if CheckBox8.Checked then
         begin
         cyEditInteger8.Text:=FieldByName('ROWOFDISCOUNT').AsString;
         cyEditInteger8.Enabled:=True;
         end
         else begin
         cyEditInteger8.Text:='';
         cyEditInteger8.Enabled:=False;
         end;
    if CheckBox9.Checked then
         begin
         cyEditInteger9.Text:=FieldByName('ROWOFPVPOPTION').AsString;
         cyEditInteger9.Enabled:=True;
         end
         else begin
         cyEditInteger9.Text:='';
         cyEditInteger9.Enabled:=False;
         end;

end;

end;

procedure TFormImportXLS.DBLookupComboBox2Click(Sender: TObject);
var
doc:string;
begin



end;

procedure TFormImportXLS.DBLookupComboBox2CloseUp(Sender: TObject);
var
doc:string;
begin
  if DBLookupComboBox1.KeyValue=null then Exit;
if DBLookupComboBox2.KeyValue=null then doc:=''
 else doc:=DBLookupComboBox2.KeyValue;
with ChangeConfQuery do
begin
 Connection:=Zcon1;
  Active:=false;
  SQL.Clear;
  SQL.Text:='SELECT * FROM '+UseDBC.EMID+'FILEDBCONFIG '
          +'WHERE ID_PROVEEDOR=:ID_PROVEEDOR and TYPE_DOC=:TYPE_DOC ';
  ParamByName('ID_PROVEEDOR').AsString:=DBLookupComboBox1.KeyValue;
  ParamByName('TYPE_DOC').AsString:=doc;
  Open;
   CheckBox1.Checked:=FieldByName('INCLUID_CODING').AsBoolean;
   CheckBox2.Checked:=FieldByName('INCLUID_BARCODE').AsBoolean;
   CheckBox3.Checked:=FieldByName('INCLUID_NAMEITEM').AsBoolean;
   CheckBox5.Checked:=FieldByName('INCLUID_PRICE_SIN').AsBoolean;
   CheckBox7.Checked:=FieldByName('INCLUID_PRICE_CON').AsBoolean;
   CheckBox6.Checked:=FieldByName('INCLUID_TAX_RATE').AsBoolean;
   CheckBox8.Checked:=FieldByName('INCLUID_DISCOUNT').AsBoolean;
   CheckBox18.Checked:=FieldByName('INCLUID_PORCIEN').AsBoolean;
   CheckBox19.Checked:=FieldByName('INCLUID_ZIFU').AsBoolean;
   CheckBox9.Checked:=FieldByName('INCLUID_PVPOPTION').AsBoolean;
   if CheckBox1.Checked then
         begin
         cyEditInteger1.Text:=FieldByName('ROWOFCODING').AsString;
         cyEditInteger1.Enabled:=True;
         end
         else begin
         cyEditInteger1.Text:='';
         cyEditInteger1.Enabled:=False;
         end;
    if CheckBox2.Checked then
         begin
         cyEditInteger2.Text:=FieldByName('ROWOFBARCODE').AsString;
         cyEditInteger2.Enabled:=True;
         end
         else begin
         cyEditInteger2.Text:='';
         cyEditInteger2.Enabled:=False;
         end;
    if CheckBox3.Checked then
         begin
         cyEditInteger3.Text:=FieldByName('ROWOFNAMEITEM').AsString;
         cyEditInteger3.Enabled:=True;
         end
         else begin
         cyEditInteger3.Text:='';
         cyEditInteger3.Enabled:=False;
         end;
    cyEditInteger4.Text:=FieldByName('ROWOFQUANTITY').AsString;
   if CheckBox5.Checked then
         begin
         cyEditInteger5.Text:=FieldByName('ROWOFPRICE_SIN').AsString;
         cyEditInteger5.Enabled:=True;
         end
         else begin
         cyEditInteger5.Text:='';
         cyEditInteger5.Enabled:=False;
         end;
   if CheckBox6.Checked then
         begin
         cyEditInteger6.Text:=FieldByName('ROWOFTAXRATE').AsString;
         cyEditInteger6.Enabled:=True;
         end
         else begin
         cyEditInteger6.Text:='';
         cyEditInteger6.Enabled:=False;
         end;
   if CheckBox7.Checked then
         begin
         cyEditInteger7.Text:=FieldByName('ROWOFPRICE_CON').AsString;
         cyEditInteger7.Enabled:=True;
         end
         else begin
         cyEditInteger7.Text:='';
         cyEditInteger7.Enabled:=False;
         end;
    if CheckBox8.Checked then
         begin
         cyEditInteger8.Text:=FieldByName('ROWOFDISCOUNT').AsString;
         cyEditInteger8.Enabled:=True;
         end
         else begin
         cyEditInteger8.Text:='';
         cyEditInteger8.Enabled:=False;
         end;
    if CheckBox9.Checked then
         begin
         cyEditInteger9.Text:=FieldByName('ROWOFPVPOPTION').AsString;
         cyEditInteger9.Enabled:=True;
         end
         else begin
         cyEditInteger9.Text:='';
         cyEditInteger9.Enabled:=False;
         end;


end;

end;

procedure TFormImportXLS.DBLookupComboBox3KeyPress(Sender: TObject;
  var Key: char);
begin
   if (Key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure TFormImportXLS.FormCreate(Sender: TObject);
VAR
 TBSTR:string;
begin
  Conectate(ZCon1);
  DateTimePicker1.DateTime:=Now;
   {
  if not ExisteTB(ZCon1, UseDBC.EMID+'FileDBConfig') then
  begin

 with ExecutQuery do
 begin
  Connection:=ZCon1;
  Active:=false;
  SQL.Clear;

  TBSTR:='CREATE TABLE IF NOT EXISTS '+UseDBC.EMID+'FILEDBCONFIG ('
            +'ID INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, '
            +'ID_PROVEEDOR VARCHAR(25) NOT NULL DEFAULT '''', '
            +'TYPE_DOC VARCHAR(50) NOT NULL DEFAULT '''', '
            +'INCLUID_CODING ENUM (''Y'',''N'') DEFAULT ''N'', '
            +'INCLUID_BARCODE ENUM (''Y'',''N'') DEFAULT ''N'', '
            +'INCLUID_NAMEITEM ENUM (''Y'',''N'') DEFAULT ''N'', '
            +'INCLUID_PRICE_SIN ENUM (''Y'',''N'') DEFAULT ''N'', '
            +'INCLUID_PRICE_CON ENUM (''Y'',''N'') DEFAULT ''N'', '
            +'INCLUID_TAX_RATE ENUM (''Y'',''N'') DEFAULT ''N'', '
            +'INCLUID_DISCOUNT ENUM (''Y'',''N'') DEFAULT ''N'', '
            +'COLOFCODING VARCHAR(4) NOT NULL DEFAULT '''', '
            +'COLOFBARCODE VARCHAR(4) NOT NULL DEFAULT '''', '
            +'COLOFNAMEITEM VARCHAR(4) NOT NULL DEFAULT '''', '
            +'COLOFQUANTITY VARCHAR(4) NOT NULL DEFAULT '''', '
            +'COLOFPRICE_SIN VARCHAR(4) NOT NULL DEFAULT '''', '
            +'COLOFPRICE_CON VARCHAR(4) NOT NULL DEFAULT '''', '
            +'COLOFTAXRATE VARCHAR(4) NOT NULL DEFAULT '''', '
            +'COLOFDISCOUNT VARCHAR(4) NOT NULL DEFAULT '''', '
            +'COLOFPVPOPTION VARCHAR(4) NOT NULL DEFAULT '''',  '
            +'PRIMARY KEY (ID),UNIQUE INDEX (ID_PROVEEDOR, TYPE_DOC))ENGINE=InnoDB DEFAULT CHARSET=utf8 ';


  SQL.Text:=TBSTR;
  ExecSQL;
 end;
 end;   }


DocQuery.Connection:=ZCon1;
DocQuery.Close;
DocQuery.SQL.Text:='select * from ' + UseDBC.EMID+'TYPEDOC';
DocQuery.Open;
GetStockList;
GetSTAFFList;
DoGetProveedor;
ct:=false;

end;

procedure TFormImportXLS.FormShow(Sender: TObject);
begin
  DBLookupComboBox3.KeyValue:= DBLookupComboBox3.ListSource.DataSet.FieldByName(DBLookupComboBox3.KeyField).Value;
  StaffDBLookupComboBox.KeyValue:= StaffDBLookupComboBox.ListSource.DataSet.FieldByName(StaffDBLookupComboBox.KeyField).Value;
end;

procedure TFormImportXLS.PuntoCKeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure  TFormImportXLS.GetStockList;
begin
  with StockListQuery do
  begin
  Connection:=zcon1;
  Active:=false;
  SQL.Clear;
  Sql.Text:='Select * from '+UseDBC.EMID+'STOCKLIST';
  open;

  end;
end;

procedure TFormImportXLS.DoGetProveedor;
 begin
 ProvQuery.Connection:=ZCon1;
ProvQuery.Close;
ProvQuery.SQL.Text := 'select * from '+UseDBC.EMID+'PROVEEDORLIST';
ProvQuery.Open;
 end;

procedure  TFormImportXLS.GetSTAFFList;
begin
  with STAFFQuery do
  begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.Clear;
  Sql.Text:='Select * from STAFF';
  open;
  end;
end;

end.

