unit U_EtiquetaParaArticulos;

{$MODE Delphi}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, DBAccess, Uni,  RxToolEdit, RxCurrEdit,
  Vcl.Imaging.jpeg,
  MemDS, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  U_Globas, U_data_c, Vcl.DBCtrls, frxClass, frxBarcode, frxDBSet,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormEtiPEs = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    UniDataSource1: TUniDataSource;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label8: TLabel;
    PvP: TCurrencyEdit;
    CurrencyEdit2: TCurrencyEdit;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    DBImage1: TDBImage;
    Button3: TButton;
    DBNavigator1: TDBNavigator;
    frxDBDataset1: TfrxDBDataset;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxReport1: TfrxReport;
    CheckBox1: TCheckBox;
    Button8: TButton;
    DataSourceStudies: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    PROCEDURE GetTiquetsList;
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit5KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit6KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PvPKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CurrencyEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure DBGrid1DrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure Button8Click(Sender: TObject);
    function GetOneGoods(str: string):boolean;
    function GetInCodeAuxiliar(str:string): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEtiPEs: TFormEtiPEs;
  ATiqueteProduct:TTIQUETEARTICULO;
   aGoods: TGoods;

implementation
USES
U_MultiGoods, U_FindGoods_Spu;



{$R *.lfm}
PROCEDURE TFormEtiPEs.GetTiquetsList;
begin
  with UniQuery1 do
  begin
    Connection:=DataModule1.UniConn;
     Active:=false;
     SQL.Clear;
     sql.Text:='SELECT * FROM GoodsLabel_Shelves ORDER BY ID ASC';
     OPEN;
  end;
end;

function TFormEtiPEs.GetOneGoods(str: string):boolean;
var
 LeerArticulo:boolean;
 aSKU_NO:string;
begin
   GetOneGoods:=False;
   with dbTrabajo do
  begin
   Connection:=DataModule1.UniConn;
    Active:=false;
    SQL.Clear;
   { sql.Text:='SELECT  T1.GOODS_ID, T1.GOODS_NAME, T1.ENA, T1.CODE, T3.IVA, T3.REQ, '
              +'T2.COST, T2.PVP1C, T2.PVP2C, T2.PVP3C, T2.LOWPRICE, T2.WHOLESALE  '
              +'FROM GOODS_SPU AS T1 '
              +'LEFT JOIN GOODS_SPU_PRICE AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
              +'LEFT JOIN GOODS_TAXRATE AS T3 ON T1.TAXRATE_ID = T3.ID '
              +'WHERE 1=1 '
              +'AND T1.ENA = '''+str+''' ';  }
   SQL.Text:='select T1.SKU_NO, concat(T2.GOODS_NAME, T1.SKU_NAME) as ITEM_NAME, T2.ENA, T2.CODE,T1.COMMODITY_UNIT, T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
              +'T2.brand_id, T2.taxrate_id, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ from goods_sku as t1 left join goods_spu as t2 on T1.GOODS_ID = T2.GOODS_ID '
              +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID  '
              +'WHERE 1=1 '
              +'AND T2.ENA = '''+str+''' ';
    OPEN;
  end;

  if dbTrabajo.RecordCount>1 then
  begin
    aSKU_NO:=FormMultiGoods.doSelection(dbTrabajo);
      with dbArti do
    begin
    Connection:=DataModule1.UniConn;
    Active:=false;
    SQL.Clear;
    SQL.Text:='select T1.SKU_NO, concat(T2.GOODS_NAME, T1.SKU_NAME) as ITEM_NAME, T2.ENA, T2.CODE,T1.COMMODITY_UNIT, T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
              +'T2.brand_id, T2.taxrate_id, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ from goods_sku as t1 left join goods_spu as t2 on T1.GOODS_ID = T2.GOODS_ID '
              +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID  '
              +'WHERE 1=1 '
              +'AND T1.SKU_NO = '''+aSKU_NO+''' ';
    Active:=True;
    end;
  end
  else
  begin
    if dbTrabajo.RecordCount=1 then
    begin
    aSKU_NO:= dbTrabajo.FieldByName('SKU_NO').AsString;
    with dbArti do
    begin
    Connection:=DataModule1.UniConn;
    Active:=false;
    SQL.Clear;
    SQL.Text:='select T1.SKU_NO, concat(T2.GOODS_NAME, T1.SKU_NAME) as ITEM_NAME, T2.ENA, T2.CODE, T1.COMMODITY_UNIT, T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
              +'CONCAT(T2.weigth, T2.volume) AS Scalar, '
              +'T2.brand_id, T4.BRAND_NAME,  T2.taxrate_id, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ from goods_sku as t1 left join goods_spu as t2 on T1.GOODS_ID = T2.GOODS_ID '
              +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID  '
              +'LEFT JOIN GOODS_BRANDS AS T4 ON T2.brand_id = T4.BRAND_ID '
              +'WHERE 1=1 '
              +'AND T1.SKU_NO = '''+aSKU_NO+''' ';
    Active:=True;
    end;
    end
    else
    begin
    GetOneGoods:=False;
    exit;
    end;
  end;



   if dbArti.RecordCount<>0 then
    begin GetOneGoods:=True;  end
  else GetOneGoods:=False;

end;

function TFormEtiPEs.GetInCodeAuxiliar(str:string): Boolean;
var
  aStr, aSKU_NO: string;
begin
aStr:='';
aSKU_NO:='';
GetInCodeAuxiliar:=False;
  with dbTrabajo do
  begin
   Connection:=DataModule1.UniConn;
    Active:=false;
    SQL.Clear;
   { sql.Text:='SELECT  T1.GOODS_ID, T1.GOODS_NAME, T1.ENA, T1.CODE, T3.IVA, T3.REQ, '
              +'T2.COST, T2.PVP1C, T2.PVP2C, T2.PVP3C, T2.LOWPRICE, T2.WHOLESALE  '
              +'FROM GOODS_SPU AS T1 '
              +'LEFT JOIN GOODS_SPU_PRICE AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
              +'LEFT JOIN GOODS_TAXRATE AS T3 ON T1.TAXRATE_ID = T3.ID '
              +'WHERE 1=1 '
              +'AND T1.CODE = '''+str+''' '; }
    SQL.Text:='select T1.SKU_NO, concat(T2.GOODS_NAME, T1.SKU_NAME) as ITEM_NAME, T2.ENA, T2.CODE, T1.COMMODITY_UNIT, T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
              //+'CONCAT(T2.weigth, T2.volume) AS Scalar, '
              +'T2.brand_id, T2.taxrate_id, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ from goods_sku as t1 left join goods_spu as t2 on T1.GOODS_ID = T2.GOODS_ID '
              +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID  '
              +'WHERE 1=1 '
              +'AND T2.CODE  = '''+str+''' ';
    Active:=True;
  end;
  if dbTrabajo.RecordCount>1 then
  begin
   // aStr:=FormMultiGoods.doSelection(dbTrabajo);
    aSKU_NO:=FormMultiGoods.doSelection(dbTrabajo);
  end;



  if aSKU_NO='' then
  begin
    dbTrabajo.Close;
    result:=False;
    exit;
  end;
   with dbArti do
  begin
   Connection:=DataModule1.UniConn;
    Active:=false;
    SQL.Clear;
    {sql.Text:='SELECT  T1.GOODS_ID, T1.GOODS_NAME, T1.ENA, T1.CODE, T3.IVA, T3.REQ, '
              +'T2.COST, T2.PVP1C, T2.PVP2C, T2.PVP3C, T2.LOWPRICE, T2.WHOLESALE  '
              +'FROM GOODS_SPU AS T1 '
              +'LEFT JOIN GOODS_SPU_PRICE AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
              +'LEFT JOIN GOODS_TAXRATE AS T3 ON T1.TAXRATE_ID = T3.ID '
              +'WHERE 1=1 '
              +'AND T1.GOODS_ID = '''+aStr+''' '; }
    SQL.Text:='select T1.SKU_NO, concat(T2.GOODS_NAME, T1.SKU_NAME) as ITEM_NAME, T2.ENA, T2.CODE, T1.COMMODITY_UNIT, T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
              +'CONCAT(T2.weigth, T2.volume) AS Scalar, '
              +'T2.brand_id, T4.BRAND_NAME, T2.taxrate_id, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ from goods_sku as t1 left join goods_spu as t2 on T1.GOODS_ID = T2.GOODS_ID '
              +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID  '
              +'LEFT JOIN GOODS_BRANDS AS T4 ON T2.brand_id = T4.BRAND_ID '
              +'WHERE 1=1 '
              +'AND T1.SKU_NO = '''+aSKU_NO+''' ';
    Active:=True;
    Active:=True;
  end;
  if dbArti.RecordCount<>0 then
    begin GetInCodeAuxiliar:=True;  end
  else GetInCodeAuxiliar:=False;

end;


procedure TFormEtiPEs.PvPKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_return then
 begin
 PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
 end;
end;

procedure TFormEtiPEs.Button2Click(Sender: TObject);
begin
if trim(Edit1.Text)='' then edit1.SetFocus;
if trim(Edit2.Text)='' then edit2.SetFocus;
if CurrencyEdit2.Value=0 then CurrencyEdit2.SetFocus;
showmessage(dbarti.FieldByName('SKU_NO').AsString);
showmessage(dbArti.FieldByName('Item_NAME').AsString);

TRY
  with UniQuery1 do
  begin
    Append;
    FieldByName('SKU_NO').AsString:=dbArti.FieldByName('SKU_NO').AsString;
    FieldByName('GOODS_ID').AsString:=dbArti.FieldByName('GOODS_ID').AsString;
    FieldByName('ENA').AsString:=Trim(Edit1.Text);
    FieldByName('GOODS_NAME').AsString:=Edit2.Text;
    FieldByName('BRAND_NAME').AsString:=dbArti.FieldByName('BRAND_NAME').AsString;
    FieldByName('Scalar').AsString:= dbArti.FieldByName('Scalar').AsString;
    FieldByName('UNIT').AsString:=Edit5.Text;
    FieldByName('FECHA_FABRICA').AsString:=Edit6.Text;
    FieldByName('PVP').AsFloat:=PvP.Value;
    FieldByName('CANTIDAD').Value:=CurrencyEdit2.Value;
    FieldByName('MULTIPLE').Value:=0;
    Post;
  end;
  except
   application.MessageBox('Error, 纪录重复(Ya existe)！','提示',0+64) ;
   UniQuery1.RefreshRecord;
  end;
  EDIT1.TEXT:='';
  EDIT2.TEXT:='';
        EDIT3.TEXT:='';
        EDIT4.TEXT:='';
        EDIT5.TEXT:='';
        EDIT6.TEXT:='';
        PvP.VALUE:=0;
        CurrencyEdit2.VALUE:=0;
  edit1.SetFocus;
end;

procedure TFormEtiPEs.Button3Click(Sender: TObject);
begin
try
if UniQuery1.State in [dsEdit, dsInsert] then
    begin

    UniQuery1.post;

    end;
except
   application.MessageBox('Error, 纪录重复(Ya existe)！','提示',0+64) ;
   UniQuery1.RefreshRecord;
  end;
end;

procedure TFormEtiPEs.Button4Click(Sender: TObject);
begin
if Application.MessageBox('确定删除吗?', '询问', MB_ICONQUESTION + MB_YESNO) = ID_YES then begin
dbgrid1.DataSource.DataSet.Delete;
end;
edit1.SetFocus;
end;

procedure TFormEtiPEs.Button5Click(Sender: TObject);

begin
    UniQuery1.First;
    While Not UniQuery1.Eof do
    begin
        UniQuery1.Delete;
    end;
   showmessage('记录清空完毕. (Todo list esta eliminado! )');
   edit1.SetFocus;
end;

procedure TFormEtiPEs.Button6Click(Sender: TObject);
begin
  UniQuery1.RefreshRecord;
  edit1.SetFocus;
end;

procedure TFormEtiPEs.Button7Click(Sender: TObject);
VAR
I, j, k: integer;
begin

BufDatasetStudies.Close;
BufDatasetStudies.CreateDataset;
    try
      BufDatasetStudies.Open;
      BufDatasetStudies.DisableControls;
      UniQuery1.DisableControls;
      UniQuery1.First;
    for I := 0 to UniQuery1.RecordCount-1 do
    BEGIN
       k:= UniQuery1.FieldByName('CANTIDAD').AsInteger;
       for J := 0 to k-1 do
       begin
      with BufDatasetStudies do
        begin
          Insert;
          BufDatasetStudiesSKU_NO.AsString:= UniQuery1.FieldByName('SKU_NO').AsString;
          BufDatasetStudiesGOODS_ID.AsString := UniQuery1.FieldByName('GOODS_ID').AsString;
          BufDatasetStudiesENA.AsString:= UniQuery1.FieldByName('ENA').AsString;
          BufDatasetStudiesGOODS_NAME.AsString := UniQuery1.FieldByName('GOODS_NAME').AsString;
          BufDatasetStudiesBRAND_NAME.AsString := UniQuery1.FieldByName('BRAND_NAME').AsString;
          BufDatasetStudiesSCALAR.AsString:= UniQuery1.FieldByName('SCALAR').AsString;
          BufDatasetStudiesUNIT.AsString := UniQuery1.FieldByName('UNIT').AsString;
          BufDatasetStudiesFECHA_FABRICA.AsString := UniQuery1.FieldByName('FECHA_FABRICA').AsString;
          BufDatasetStudiesPVP.AsFloat := UniQuery1.FieldByName('PVP').AsFloat;

        end;
       end;
       UniQuery1.Next;
    END;
    finally
     BufDatasetStudies.EnableControls;
     UniQuery1.EnableControls;
    end;

    BufDatasetStudies.First;

frxReport1.Clear;
//showmessage(ReportPath+'EtiqutaEstanteria.fr3');
frxReport1.LoadFromFile(ReportPath+'EtiquetaSabateria40x25.fr3');

frxReport1.DesignReport();
  frxReport1.PrepareReport();
  frxReport1.ShowPreparedReport;
   BufDatasetStudies.ClearDetails;
   BufDatasetStudies.Close;
  edit1.SetFocus;
end;

procedure TFormEtiPEs.Button8Click(Sender: TObject);
begin
  GetTiquetsList;
end;

procedure TFormEtiPEs.CurrencyEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_return then
 begin
 PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
 end;
end;

procedure TFormEtiPEs.DBGrid1DrawDataCell(Sender: TObject; const Rect: TRect;
  Field: TField; State: TGridDrawState);
begin
if Field.Name = 'PVP' then
    TFloatField(Field).DisplayFormat := '0.00';
end;

procedure TFormEtiPEs.Edit1Exit(Sender: TObject);
begin
if (TRIM(EDIT1.Text)='') then exit;
if GetOneGoods(trim(Edit1.Text)) or GetInCodeAuxiliar(trim(Edit1.Text)) then
begin
  EDIT2.Text:=dbArti.FieldByName('Item_NAME').AsString;
  EDIT3.TEXT:=dbArti.FieldByName('BRAND_NAME').AsString;
  EDIT4.TEXT:=dbArti.FieldByName('Scalar').AsString;
  EDIT5.TEXT:=dbArti.FieldByName('COMMODITY_UNIT').AsString;
  PvP.VALUE:=dbArti.FieldByName('SELLING_P1C').AsFloat;
  EDIT6.TEXT:='';
  CurrencyEdit2.VALUE:=1;
  if  CheckBox1.Checked then button2.OnClick(self);
  { aGoods.SKU_NO:= dbArti.FieldByName('SKU_NO').AsString;
   aGoods.GOODS_ID:= dbArti.FieldByName('GOODS_ID').AsString;
   aGoods.ENA:= dbArti.FieldByName('ENA').AsString;
   aGoods.ITEM_NAME:= dbArti.FieldByName('Item_NAME').AsString;
   aGoods.QUANTITY:=0;
   aGoods.COMMODITY_UNIT:=dbArti.FieldByName('COMMODITY_UNIT').AsString;
   aGoods.PRICE:=dbArti.FieldByName('SELLING_P1C').AsFloat;
   aGoods.DISCOUNT:=0;
   aGoods.TAXRATE:=dbArti.FieldByName('IVA').AsFloat;  }
end;


end;

procedure TFormEtiPEs.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_return then
 begin
 PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
 end;
end;

procedure TFormEtiPEs.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_return then
 begin
 PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
 end;
end;

procedure TFormEtiPEs.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_return then
 begin
 PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
 end;
end;

procedure TFormEtiPEs.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_return then
 begin
 PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
 end;
end;

procedure TFormEtiPEs.Edit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_return then
 begin
 PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
 end;
end;

procedure TFormEtiPEs.Edit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_return then
 begin
 PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
 end;
end;

procedure TFormEtiPEs.FormShow(Sender: TObject);
begin
GetTiquetsList;
Edit1.SetFocus;
end;

procedure TFormEtiPEs.Button1Click(Sender: TObject);
begin
close;
end;

end.
