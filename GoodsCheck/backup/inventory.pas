unit Inventory;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  LCLType, DBGrids, DBCtrls, Buttons, rxcurredit, connect, db, ZDataset,
  ZSqlUpdate, Global;

type

  { TFormInventory }

  TFormInventory = class(TForm)
    Articulo: TZQuery;
    ArticuloUpdate: TZUpdateSQL;
    BitBtn5: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button6: TButton;
    Button8: TButton;
    DataSource1: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    dbTest: TZQuery;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Precio: TCurrencyEdit;
    StockCheckDetalles: TZQuery;
    StockCheckTop: TZQuery;
    Cantidad: TCurrencyEdit;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Id: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelT2: TLabel;
    LabelT1: TLabel;
    NewButton: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    StockNameDS: TDataSource;
    StockNameQuery: TZQuery;
    FinalQuery: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;
    procedure BitBtn5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure CantidadKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBLookupComboBox1Select(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IdKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure NewButtonClick(Sender: TObject);
    procedure GetDocTop;
    procedure GetDetalles;
    procedure GetStockList;
    Function ExistGoods(CDBarra: string):Boolean;
    procedure ClearInputEdit();
    procedure ClearAll();
    procedure NewButtonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PrecioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public

  end;

var
  FormInventory: TFormInventory;
  CheckDoc:TBuyDocStruct;

implementation
uses
  CreateNewInventory, addgoods, Select_SKU, goodslist;

{$R *.lfm}

{ TFormInventory }
procedure TFormInventory.ClearInputEdit();
begin
  Edit2.Text:='';
  Cantidad.Clear;
  Precio.Clear;

end;
procedure TFormInventory.ClearAll();
begin
  Edit1.Text:='';
  ClearInputEdit();
  Id.Clear;
  DBLookupComboBox1.KeyValue:=NULL;
  CheckDoc.B_UUID:='';
  CheckDoc.ID_STOCK:='';
end;

procedure TFormInventory.NewButtonKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormInventory.PrecioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormInventory.GetStockList;
begin
  with StockNameQuery do
  begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT * FROM '+UseDBC.EmID+'STOCKLIST ';
     Open;
  end;
  DBLookupComboBox1.ItemIndex:=0;
  DBLookupComboBox1.OnSelect(self);
end;

procedure TFormInventory.GetDetalles;
begin
  with StockCheckDetalles do
  begin
    Connection:=DataModule2.ZCon1;
  Active:=false;
  SQL.Clear;
  SQL.TEXT:='SELECT T1.CH_UUID, T1.GOODS_ID, T1.ENA, t3.GOODS_NAME, t2.SKU_NAME, T4.BRAND_NAME, T5.CATEGORY, T1.SKU_NO, T1.AMOUNT, T1.COST,  T1.ID_STOCK, T1.FECHA '
  +'FROM STOCKCHECKDETAILED as t1 left join goods_sku as t2 on t2.SKU_NO = t1.SKU_NO '
  +'inner join goods_spu as t3 on t2.GOODS_ID = t3.GOODS_ID '
  +'LEFT JOIN goods_brands AS T4 ON t3.brand_id = T4.BRAND_ID '
  +'LEFT JOIN categorys AS T5 ON t3.category_id = T5.ID '
  +'WHERE 1=1 '
  +'AND T1.CH_UUID=:CH_UUID ';
   PARAMBYNAME('CH_UUID').ASSTRING:=CHECKDOC.B_UUID;
   Open;
  end;
end;

procedure TFormInventory.GetDocTop;
begin
  with StockCheckTop do
  begin
  Connection:=DataModule2.ZCon1;
  Active:=false;
  SQL.Clear;
  SQL.Text:='SELECT * FROM STOCKCHECKTOPS '
  +'WHERE 1=1 '
  +'AND LOCKED<>1 LIMIT 1';
  Open;
  if RecordCount=1 then
  begin
    CheckDoc.B_UUID:=FieldByName('CH_UUID').AsString;
    CheckDoc.ID_STOCK:=FieldByName('ID_STOCK').AsString;
    DBLookupComboBox1.KeyValue:=CheckDoc.ID_STOCK;
    DBLookupComboBox2.KeyValue:=CheckDoc.ID_STOCK;
  end
  else
  begin
   CheckDoc.B_UUID:='';
   CheckDoc.ID_STOCK:='';
   DBLookupComboBox1.KeyValue:=null;
   DBLookupComboBox2.KeyValue:=null;
  end;
  ID.Text:=CheckDoc.B_UUID;
  end;
end;

Function TFormInventory.ExistGoods(CDBarra: string):Boolean;
begin
  with dbTest do
  begin
     Connection:=DataModule2.ZCon1;;
     Active:=false;
     SQL.Clear;
     SQL.Text:='select * from goods_spu where ENA =:ENA ';
     ParamByName('ENA').AsString:=CDBarra;
     Open;
     end;
  if dbTest.RecordCount > 0 then
  begin
    result := True;
  end
  else
  begin
     result :=False;
  end;
end;

procedure TFormInventory.NewButtonClick(Sender: TObject);
begin
  if CheckDoc.B_UUID <>'' then
  begin
    showmessage(nMSG10);
    exit;
  end;
  CheckDoc:=FormNewInventory.IniciaNewInventory();
  showmessage(CheckDoc.B_UUID);
  ID.Text:=CheckDoc.B_UUID;
  DBLookupComboBox1.KeyValue:=CheckDoc.ID_STOCK;
  GetDocTop;
  GetDetalles;
  Edit1.SetFocus;
end;

procedure TFormInventory.FormShow(Sender: TObject);
begin
  GetStockList;
  GetDocTop;
  GetDetalles;
  Edit1.SetFocus;
end;

procedure TFormInventory.IdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormInventory.DBLookupComboBox1Select(Sender: TObject);
begin
  DBLookupComboBox2.KeyValue:=DBLookupComboBox1.KeyValue;
end;

procedure TFormInventory.Edit1Enter(Sender: TObject);
begin
  ClearInputEdit();
end;

procedure TFormInventory.Button1Click(Sender: TObject);
var
  Bookmark: TBookmark;
begin
  If trim(Edit1.Text) = '' then
  begin
    Edit1.SetFocus;
    exit;
  end;
  IF Articulo.RecordCount = 0 THEN EXIT;;
  If Cantidad.Value = 0 then
  begin
    Cantidad.SetFocus;
    exit;
  end;
  StockCheckDetalles.UpdateObject:=ZUpdateSQL1;
  if StockCheckDetalles.Locate('SKU_NO', Articulo.FieldByName('SKU_NO').AsString, [loCaseInsensitive] ) then
  begin
       Bookmark := StockCheckDetalles.GetBookmark;
       ZUpdateSQL1.ModifySQL.Text:='UPDATE STOCKCHECKDETAILED SET '
   +'AMOUNT =:AMOUNT,  '
   +'FECHA =NOW() '+        ///用于更新 , 否则   0 records 错误.
   'WHERE CH_UUID = :CH_UUID and SKU_NO=:SKU_NO ';
       StockCheckDetalles.Edit;
       StockCheckDetalles.FieldByName('CH_UUID').AsString:=CheckDoc.B_UUID;
       StockCheckDetalles.FieldByName('AMOUNT').AsFloat:=StockCheckDetalles.FieldByName('CANTIDAD').AsFloat+Cantidad.Value;
       StockCheckDetalles.Post;
  end
  else
  begin
    Bookmark := StockCheckDetalles.GetBookmark;
    ZUpdateSQL1.InsertSQL.Text:='INSERT INTO STOCKCHECKDETAILED '
       +'( CH_UUID, GOODS_ID, ENA,  SKU_NO, AMOUNT, COST, ID_STOCK ) '
       +'VALUES( :CH_UUID, :GOODS_ID, :ENA,  :SKU_NO, :AMOUNT, :COST, :ID_STOCK )';
   // showmessage(CheckDoc.B_UUID);
    StockCheckDetalles.Edit;
    StockCheckDetalles.Append;
    StockCheckDetalles.FieldByName('CH_UUID').AsString:=CheckDoc.B_UUID;
    StockCheckDetalles.FieldByName('GOODS_ID').AsString:=Articulo.FieldByName('GOODS_ID').AsString;
    StockCheckDetalles.FieldByName('ENA').AsString:=Trim(Edit1.Text);
    StockCheckDetalles.FieldByName('SKU_NO').AsString:=Articulo.FieldByName('SKU_NO').AsString;
    StockCheckDetalles.FieldByName('AMOUNT').AsFloat:=Cantidad.Value;
    StockCheckDetalles.FieldByName('ID_STOCK').AsString:=CheckDoc.ID_STOCK;
    StockCheckDetalles.CommitUpdates;
  end;
  StockCheckDetalles.Refresh;
  StockCheckDetalles.GotoBookmark(Bookmark);
  EDIT1.Text:='';
  ClearInputEdit();
  EDIT1.SetFocus;
end;

procedure TFormInventory.BitBtn5Click(Sender: TObject);
var
Result: TStringArray;
str:string;
begin
str:=Edit1.Text;
str:=StringReplace(str, '%', '', [rfReplaceAll]);
Result:=FormGoodsList.IniciaBusquedas(str);
Edit1.Text:=Result[0];
if ((Edit1.Text='-') or (Edit1.Text='-1')) then
begin
Edit1.Text:='';
end;
Edit1.SetFocus;
end;

procedure TFormInventory.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFormInventory.Button6Click(Sender: TObject);
begin
  with FinalQuery do
 begin
  Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;

      sql.Text:='INSERT INTO STOCKGOODS (ID_STOCK, GOODS_ID, SKU_NO, AMOUNT ) '
      +'SELECT ID_STOCK, GOODS_ID, SKU_NO, AMOUNT FROM STOCKCHECKDETAILED  '
      +'AS T2 WHERE T2.CH_UUID=:CH_UUID AND AMOUNT <> 0 '
      +'ON DUPLICATE KEY UPDATE '
      +'STOCKGOODS.AMOUNT=T2.AMOUNT ';
      ParamByName('CH_UUID').AsString:=CheckDoc.B_UUID;
     //ParamByName('EMID').AsString:=UseDBC.EMID;
     ExecSQL;
     SQL.Text:='UPDATE GOODS_SKU AS T1, STOCKCHECKDETAILED AS T2 SET T1.STOCK=T2.AMOUNT '
      +'WHERE 1=1 AND T1.SKU_NO=T2.SKU_NO '
      +'AND T2.CH_UUID=:CH_UUID ';
     ParamByName('CH_UUID').AsString:=CheckDoc.B_UUID;
     ExecSQL;

     Active:=false;
     SQL.Clear;
     Sql.Text:='UPDATE STOCKCHECKTOPS SET '
           +'LOCKED=1, LOCKEDDATE=NOW() '
           +'WHERE CH_UUID=:CH_UUID';
     ParamByName('CH_UUID').AsString:=CheckDoc.B_UUID;
     ExecSQL;
 end;
 CheckDoc.ID_STOCK:='';
 CheckDoc.B_UUID:='';
 ClearAll();
 Showmessage(nMSG11);
 GetDocTop;
 GetDetalles;
end;

procedure TFormInventory.Button8Click(Sender: TObject);
begin
   with FinalQuery do
 begin
    Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO STOCKGOODS (ID_STOCK, GOODS_ID, SKU_NO, AMOUNT ) '
    +'SELECT ID_STOCK, GOODS_ID, SKU_NO, AMOUNT FROM STOCKCHECKDETAILED  '
    +'AS T2 WHERE T2.CH_UUID=:CH_UUID AND AMOUNT <> 0 '
    +'ON DUPLICATE KEY UPDATE '
    +'STOCKGOODS.AMOUNT=T1.AMOUNT+T2.AMOUNT ';
    ParamByName('CH_UUID').AsString:=CheckDoc.B_UUID;
    ExecSQL;
    SQL.Text:='UPDATE GOODS_SKU AS T1, STOCKCHECKDETAILED AS T2 SET T1.STOCK=T1.STOCK+T2.AMOUNT '
    +'WHERE 1=1 AND T1.SKU_NO=T2.SKU_NO '
    +'AND T2.CH_UUID=:CH_UUID ';
    ParamByName('CH_UUID').AsString:=CheckDoc.B_UUID;

    ExecSQL;

    Active:=false;
    SQL.Clear;
    Sql.Text:='UPDATE STOCKCHECKTOPS SET '
    +'LOCKED=1, LOCKEDDATE=NOW() '
    +'WHERE CH_UUID=:CH_UUID';
    ParamByName('CH_UUID').AsString:=CheckDoc.B_UUID;
    ExecSQL;
 end;
 CheckDoc.ID_STOCK:='';
 CheckDoc.B_UUID:='';
 ClearAll();
 Showmessage(nMSG11);
 GetDocTop;
 GetDetalles;
end;

procedure TFormInventory.CantidadKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormInventory.DBGrid1DblClick(Sender: TObject);
begin
  IF StockCheckDetalles.RecordCount < 1 THEN EXIT;
  EDIT1.Text:=StockCheckDetalles.FieldByName('ENA').AsString;
  EDIT1.SetFocus;
end;

procedure TFormInventory.Edit1Exit(Sender: TObject);
VAR
  SKU_NO:STRING;
begin
  if  Trim(Edit1.Text) <> '' then
   begin
   if CheckDoc.B_UUID ='' then
   begin
     NewButtonClick(self);
     Edit1.Text:='';
   end;
   if not ExistGoods(Trim(Edit1.Text)) then
   begin
     FormGoodsSpu:=TFormGoodsSpu.Create(Self);
     FormGoodsSpu.ENAEdit.Text:=Trim(Edit1.Text);
     FormGoodsSpu.ShowModal;
     FormGoodsSpu.Free;
     Edit1.SetFocus;
   end
   else
   begin
     with Articulo do
      begin
      Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.CLEAR;
      SQL.TEXT:='SELECT T1.SKU_NO, T2.GOODS_NAME, T2.GOODS_NAME2, T2.ENA , T2.CODE, T2.TYPE, T2.UNIT, '
      +'T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
      +'T2.CATEGORY_ID, T2.BRAND_ID, T2.TAXRATE_ID, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ '
      +'FROM GOODS_SKU AS T1 LEFT JOIN GOODS_SPU AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
      +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID '
      +'WHERE 1=1 AND T1.ISCHILD= 1 '
      +'AND T2.ENA =:ENA ';
      ParamByName('ENA').AsString:=trim(Edit1.Text);
      open;
      end;
      if Articulo.RecordCount > 1 then
      begin
      SKU_NO:=FormSelectSKU.IniciaSelection(trim(Edit1.Text));
      if SKU_NO = '' then
          begin
          Edit1.SetFocus;
          exit;
          end;
      if not (Articulo.Locate('SKU_NO', SKU_NO, [])) then
          begin
            Edit1.SetFocus;
            exit;
          end;
      end
      ELSE
      BEGIN
      with Articulo do
      begin
      Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.CLEAR;
      SQL.TEXT:='SELECT T1.SKU_NO, T2.GOODS_NAME, T2.GOODS_NAME2, T2.ENA , T2.CODE, T2.TYPE, T2.UNIT, '
      +'T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
      +'T2.CATEGORY_ID, T2.BRAND_ID, T2.TAXRATE_ID, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ '
      +'FROM GOODS_SKU AS T1 LEFT JOIN GOODS_SPU AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
      +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID '
      +'WHERE 1=1 AND T1.ISCHILD= 0 '
      +'AND T2.ENA =:ENA ';
      ParamByName('ENA').AsString:=trim(Edit1.Text);
      open;
      END;
      SKU_NO:=Articulo.FieldByName('SKU_NO').AsString;
      if SKU_NO = '' then
          begin
          Edit1.SetFocus;
          exit;
          end;
      end;

      Edit2.Text:=Articulo.FieldByName('GOODS_NAME').AsString;
      Precio.Value:=Articulo.FieldByName('COST').AsCurrency;
     // PVP1C.Value:=Articulo.FieldByName('SELLING_P1C').AsCurrency;
      Cantidad.SetFocus;
   end;

   end;
end;

procedure TFormInventory.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormInventory.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormInventory.FormCreate(Sender: TObject);
begin
  {GroupBox1.Caption:=nCaption6;
  Button6.Caption:=nCaption7;
  Button8.Caption:=nCaption8;
  Label6.Caption:=nCaption9;
  Label11.Caption:=nCaption10;
  LabelT2.Caption:=nCaption12;
  LabelT1.Caption:=nCaption11;  }
end;

end.

