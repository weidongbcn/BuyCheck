unit BuyIn01;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids, ZDataset, ZSqlUpdate, rxcurredit, LCLType, Buttons, Variants,
  connect, db, Global, Grids, DateTimePicker;

type

  { TFormBuyIn }

  TFormBuyIn = class(TForm)
    SpuQuery: TZQuery;
    BitBtn5: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    BuyDetallesDS: TDataSource;
    CombinaQuery: TZQuery;
    Conserva: TCurrencyEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    dbTest: TZQuery;
    dbTrabajo: TZQuery;
    dbFoods: TZQuery;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label7: TLabel;
    TimePanel: TPanel;
    TotalQuery: TZQuery;
    DataSource2: TDataSource;
    Label11: TLabel;
    NewButton: TButton;
    Amount: TCurrencyEdit;
    Label10: TLabel;
    PVP1C: TCurrencyEdit;
    Total: TCurrencyEdit;
    DBGrid1: TDBGrid;
    Id: TEdit;
    N_Proveedor: TEdit;
    Importe: TCurrencyEdit;
    Descuento: TCurrencyEdit;
    Label8: TLabel;
    Label9: TLabel;
    Precio: TCurrencyEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BuyDetalles: TZQuery;
    Articulo: TZQuery;
    BuyTop: TZQuery;
    BuyHelp: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;
    ArticuloUpdate: TZUpdateSQL;
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn5KeyPress(Sender: TObject; var Key: char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BuyDetallesAfterPost(DataSet: TDataSet);
    procedure AmountExit(Sender: TObject);
    procedure AmountKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DateTimePicker1CloseUp(Sender: TObject);
    procedure DateTimePicker2CloseUp(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DescuentoExit(Sender: TObject);
    procedure DescuentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure ImporteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure NewButtonClick(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    Function ExistGoods(CDBarra: string;out aGoods_id:string; out count:integer; out GoodsType:integer):boolean;
    procedure FormCreate(Sender: TObject);
    procedure GetBuyDetalles;
    procedure PrecioExit(Sender: TObject);
    procedure PrecioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PreparaTmp();
    procedure ClearInputEdit();
    procedure ClearAll();
    procedure CalImporte();
    procedure GetTotal;
    procedure PVP1CKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function CreateSkuRecord(aGoods_id, JsonName, AttibuteValueIds: string):string;
  public

  end;

var
  FormBuyIn: TFormBuyIn;
  NewDoc:Boolean;
  ANewBUYDOC:TDocCompStruct;
  aBUYDoc:TBuyDocStruct;

  SKU_JSON_NAME, SKU_ATTIBUTE_VALUE_IDS: string;
  Count, aGoodsType: Integer; //用于记录同一码的条数, 货品的类型.

implementation
uses
  addgoods, BuyInput, BuyInColgada, goodslist, PayofBuy, select_onesku, Select_SKU, SimpleAdd, create, aGoodsSpec;

{$R *.lfm}

{ TFormBuyIn }
procedure TFormBuyIn.ClearInputEdit();
begin
  Edit2.Text:='';
  Amount.Clear;
  Precio.Clear;
  Descuento.Clear;
  Importe.Clear;
  PVP1C.Clear;
end;
procedure TFormBuyIn.ClearAll();
begin
  Edit1.Text:='';
  aGoodsType:=-1;
  ClearInputEdit();
  Id.Clear;
  N_Proveedor.Clear;
  ANewBUYDOC.ID_BUY:='';
  ANewBUYDOC.DOCUMENT:='';
  ANewBUYDOC.NAME_PROVEEDOR:='';
  ANewBUYDOC.ID_PROVEEDOR:='';
  ANewBUYDOC.SERIE:='';
end;

procedure TFormBuyIn.CalImporte();
begin
  Importe.Value:=Amount.Value * Precio.Value * (1-Descuento.Value/100);
end;

procedure TFormBuyIn.GetTotal;
begin
    with TotalQuery do
 begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.TEXT:='SELECT sum(T1.QUANTITY*T1.COST*(1-T1.DISCOUNT/100)) AS TOTALIMP FROM BUY_ITEMS as T1 '
  +'WHERE 1=1 '
     +'AND T1.B_UUID=:B_UUID ';
     ParamByName('B_UUID').AsString:=ABUYDOC.B_UUID;
    open;
 end;
    Total.Value:=TotalQuery.FieldByName('TOTALIMP').AsCurrency;
end;

procedure TFormBuyIn.PVP1CKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

Function TFormBuyIn.ExistGoods(CDBarra: string;out aGoods_id:string;  out count:integer; out GoodsType: integer):Boolean;
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
  count:=dbTest.RecordCount;
  if count < 1 then
  begin

    GoodsTYpe:= -1;
    result := False;
  end
  else
  begin
     if count = 1 then
     begin
         aGoods_id:= dbTest.FieldByName('GOODS_ID').AsString;
         GoodsType:=dbTest.FieldByName('type').AsInteger;
     end;
     result :=True;
  end;
end;



procedure TFormBuyIn.FormCreate(Sender: TObject);
begin
  NewDoc:=False;
  TimePanel.Visible:=False;
  aGoodsType:=-1;
  DateTimePicker1.Date:=now();
  DateTimePicker2.Date:=now();
end;

procedure TFormBuyIn.GetBuyDetalles;
begin
  with BuyDetalles do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    SQL.TEXT:='SELECT T1.B_UUID, T1.GOODS_ID, T1.SKU_NO, T4.SKU_NAME, T2.ENA, T2.GOODS_NAME, T1.QUANTITY, T1.COMMODITY_UNIT, T1.COST, T1.DISCOUNT, T3.IVA, '
            +'T1.QUANTITY*T1.COST*(1-T1.DISCOUNT/100) AS LINEATOTAL, T4.SELLING_P1C  '
            +'FROM BUY_ITEMS as T1 '
            +'LEFT JOIN goods_spu AS T2 ON T1.GOODS_ID = T2.GOODS_ID  '
            +'LEFT JOIN goods_taxrate AS T3 ON T2.taxrate_id = T3.ID '
            +'LEFT JOIN goods_sku AS T4 ON T4.SKU_NO = T1.SKU_NO '
     +'WHERE 1=1 '
     +'AND T1.B_UUID=:B_UUID order by T1.GOODS_ID';
     ParamByName('B_UUID').AsString:=ABUYDOC.B_UUID;
    open;

    end;
end;

procedure TFormBuyIn.PrecioExit(Sender: TObject);
begin
  CalImporte();
end;

procedure TFormBuyIn.PrecioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn.PreparaTmp();
begin

    ///
end;

//返回sku编号
function TFormBuyIn.CreateSkuRecord(aGoods_id, JsonName, AttibuteValueIds: string):string;
begin
   with dbTrabajo do
  begin
    Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, ATTIBUTE_VALUE_IDS, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO,LOWLIMIT, CAN_DISCount, Points ) '
        +'VALUES (UUID(), :SKU_NAME, :ATTIBUTE_VALUE_IDS, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points )'
        +'ON DUPLICATE KEY UPDATE '
        +'UPDATE_TIME = now() ';
        ParamByName('SKU_NAME').AsString:=JsonName;
        ParamByName('ATTIBUTE_VALUE_IDS').AsString:=AttibuteValueIds;
        ParamByName('COST').AsCurrency:=0.0;
        ParamByName('SELLING_P1C').AsCurrency:=0.0;
        ParamByName('SELLING_P2C').AsCurrency:=0.0;
        ParamByName('SELLING_P3C').AsCurrency:=0.0;
        ParamByName('LOWPRICE').AsCurrency:=0.0;
        ParamByName('WHOLESALE').AsCurrency:=0.0;
        ParamByName('DISCOUNT').AsFloat:=0.0;
        ParamByName('GOODS_ID').AsString:=aGoods_id;
        ParamByName('SKU_CODING').AsString:='';
        ParamByName('ISCHILD').AsInteger:=1;
        ParamByName('STOCKAVISO').AsInteger:=0;
        ParamByName('LOWLIMIT').AsFloat:=0;
        ParamByName('CAN_DISCount').AsInteger:=0;
        ParamByName('Points').AsFloat:=0;
    ExecSQL;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT * FROM GOODS_SKU WHERE 1=1 AND GOODS_ID=:GOODS_ID AND SKU_NAME=:SKU_NAME AND ATTIBUTE_VALUE_IDS=:ATTIBUTE_VALUE_IDS LIMIT 1';
        ParamByName('SKU_NAME').AsString:=JsonName;
        ParamByName('ATTIBUTE_VALUE_IDS').AsString:=AttibuteValueIds;
        ParamByName('GOODS_ID').AsString:=aGoods_id;
    open;
  end;
   result:=dbTrabajo.FieldByName('SKU_NO').AsString;
end;

procedure TFormBuyIn.Edit1Exit(Sender: TObject);
var
   SKU_NO:string;
   Product:TGOODS;
   aGoods_id: string;
   Flag:Boolean;
begin
  if DbGrid1.Focused then begin Edit1.Text:=''; exit; end;
  if  Trim(Edit1.Text) <> '' then
   begin
   if ABUYDOC.B_UUID = '' then
    begin
      NewButton.Click;
      exit;
    end;
   IF ExistGoods(trim(Edit1.Text),aGoods_id, Count, aGoodsType) THEN
    BEGIN
     //属性商品, 没有就创建
     if (Count = 1) and (aGoodsType=4) then
      begin
        with SpuQuery do
          begin
            Connection:=DataModule2.ZCon1;
            Active:=false;
            SQL.CLEAR;
            SQl.Text:='SELECT T1.ID, T1.GOODS_ID, T1.GOODS_NAME, T1.GOODS_NAME2, T1.ENA, T1.CODE, T1.CATEGORY_ID, T1.BRAND_ID, T1.TYPE, T1.UNIT, T1.TAXRATE_ID, T1.WEIGTH, T1.VOLUME, T1.IS_ACTIVE, '
            +'T1.PARENT_ID, T1.CLASS_ID, T1.STOCKAVISO, T1.LOWLIMIT, T1.CAN_DISCount, T1.CAPACITY, T1.DAYS_CONSERVACION, T1.DAYS_AVISO, T1.UPDATED_AT, '
            +'T2.COST, T2.SELLING_P1C, T2.SELLING_P2C, T2.SELLING_P3C, T2.LOWPRICE, T2.WHOLESALE, T2.DISCOUNT, T2.Points, T2.SKU_NO, T2.SKU_NAME, T2.ATTIBUTE_VALUE_IDS '
            +'FROM GOODS_SPU AS T1 '
            +'LEFT OUTER JOIN GOODS_SKU AS T2 ON T2.GOODS_ID = T1.GOODS_ID  '
            +'WHERE 1=1 '
            +'AND T1.GOODS_ID=:GOODS_ID '
            +'AND T1.ENA=:ENA ;';
            ParamByName('GOODS_ID').AsString:=aGoods_id;
            ParamByName('ENA').AsString:=trim(Edit1.Text);
            open;
          end;
        Flag:=SpecMatrixForm.GetMatrixValues(SpuQuery.FieldByName('GOODS_ID').AsString, SKU_JSON_NAME, SKU_ATTIBUTE_VALUE_IDS);
        if not Flag then
         begin
            Edit1.SetFocus;
            exit;
         end;
        if SpuQuery.Locate('GOODS_ID;SKU_NAME;ATTIBUTE_VALUE_IDS',VarArrayOf([aGoods_id, SKU_JSON_NAME, SKU_ATTIBUTE_VALUE_IDS]),[]) then
         begin
           SKU_NO:= SpuQuery.FieldByName('SKU_NO').AsString;
         end
         else
         begin
           SKU_NO:= CreateSkuRecord(aGoods_id, SKU_JSON_NAME, SKU_ATTIBUTE_VALUE_IDS);
         end;
         if SKU_NO = '' then
          begin
          Edit1.SetFocus;
          exit;
          end;
          with Articulo do
          begin
          Connection:=DataModule2.ZCon1;
          Active:=false;
          SQL.CLEAR;
          SQL.TEXT:='SELECT T1.SKU_NO, T2.GOODS_NAME, T2.GOODS_NAME2, T2.ENA , T2.CODE, T2.TYPE, T2.UNIT, '
          +'T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
          +'T2.CATEGORY_ID, T2.BRAND_ID, T2.TAXRATE_ID, T2.PARENT_ID, T2.CLASS_ID, T2.DAYS_CONSERVACION, T3.IVA, T3.REQ '
          +'FROM GOODS_SKU AS T1 LEFT JOIN GOODS_SPU AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
          +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID '
          +'WHERE 1=1  '              //AND T1.ISCHILD= 0
          +'AND T1.SKU_NO = :SKU_NO '
          +'AND T2.ENA =:ENA ';
          ParamByName('SKU_NO').AsString:= SKU_NO;
          ParamByName('ENA').AsString:=trim(Edit1.Text);
          open;
          END;
          showmessage(SKU_NO);
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
      +'T2.CATEGORY_ID, T2.BRAND_ID, T2.TAXRATE_ID, T2.PARENT_ID, T2.CLASS_ID, T2.DAYS_CONSERVACION, T3.IVA, T3.REQ '
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
      +'T2.CATEGORY_ID, T2.BRAND_ID, T2.TAXRATE_ID, T2.PARENT_ID, T2.CLASS_ID, T2.DAYS_CONSERVACION, T3.IVA, T3.REQ '
      +'FROM GOODS_SKU AS T1 LEFT JOIN GOODS_SPU AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
      +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID '
      +'WHERE 1=1 AND T1.ISCHILD= 0 '
      +'AND T2.ENA =:ENA ';
      ParamByName('ENA').AsString:=trim(Edit1.Text);
      open;
      END;

      SKU_NO:=Articulo.FieldByName('SKU_NO').AsString;
      end;
      END;
      if SKU_NO = '' then
          begin
          Edit1.SetFocus;
          exit;
          end;

      if BuyDetalles.Locate('ENA', Trim(Edit1.Text), [] ) then
     begin
       Precio.Value:=BuyDetalles.FieldByName('COST').AsCurrency;
       Descuento.Value:=BuyDetalles.FieldByName('DISCOUNT').AsCurrency;
     end;
      Edit2.Text:=Articulo.FieldByName('GOODS_NAME').AsString;
      Precio.Value:=Articulo.FieldByName('COST').AsCurrency;
      PVP1C.Value:=Articulo.FieldByName('SELLING_P1C').AsCurrency;
      if Articulo.FieldByName('TYPE').AsInteger = 3 then
      begin
           Conserva.Value:=Articulo.FieldByName('DAYS_CONSERVACION').AsInteger;
           Panel1.Enabled:=False;
           Panel2.Enabled:=False;
           Panel3.Enabled:=False;
           TimePanel.Visible:=True;
           exit;
      end
      else
      begin
          Amount.SetFocus;
      end;
     END
     ELSE
     BEGIN
    { FormGoodsSpu:=TFormGoodsSpu.Create(Self);
     FormGoodsSpu.ENAEdit.Text:=Trim(Edit1.Text);
     FormGoodsSpu.ShowModal;
     FormGoodsSpu.Free;  }
     Product.ENA:=Trim(Edit1.Text);
     Product.COST:=0.0;
     FAddGoods.Created(Product);
     Edit1.SetFocus;
     end;
    end;

end;

procedure TFormBuyIn.NewButtonClick(Sender: TObject);
begin
  ABUYDOC:=FormBuy.IniciaNewBuy();
  if aBUYDoc.B_UUID = '' then
  begin
    Edit1.SetFocus;
  exit;
  end;
  ID.Text:=ABUYDOC.B_UUID;
  N_Proveedor.Text:=ABUYDOC.NAME_PROVEEDOR;
  GetBuyDetalles;
  GetTotal;
  Edit1.SetFocus;
end;

procedure TFormBuyIn.Button2Click(Sender: TObject);
begin

  ABUYDOC:=FormColgada.GetOldBuyList();
  ID.Text:=ABUYDOC.B_UUID;;
  N_Proveedor.Text:=ABUYDOC.NAME_PROVEEDOR;
  GetBuyDetalles;
  GetTotal;
  Edit1.SetFocus;

end;

procedure TFormBuyIn.Button3Click(Sender: TObject);
var
  resultado:boolean;
begin
  if ABUYDOC.B_UUID = '' then
    begin
      Edit1.SetFocus;
      exit;
    end;

  resultado:=FormBuyPay.FinalBuy(ABUYDOC);
  if resultado then
    begin
    BuyTop.Close;
    BuyDetalles.Close;
    ClearAll();
  end;
  Edit1.SetFocus;
end;

procedure TFormBuyIn.Button4Click(Sender: TObject);
begin
  if DateTimePicker2.Date <= now then
  begin
  ShowMessage('商品已经过期.');
  exit;
  end;
  Panel1.Enabled:=True;
  Panel2.Enabled:=True;
  Panel3.Enabled:=True;
  Amount.SetFocus;
  TimePanel.Visible:=False;

end;

procedure TFormBuyIn.BuyDetallesAfterPost(DataSet: TDataSet);
begin
  Buydetalles.RefreshCurrentRow(false);
end;

procedure TFormBuyIn.AmountExit(Sender: TObject);
begin
  CalImporte();
end;

procedure TFormBuyIn.AmountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn.DateTimePicker1CloseUp(Sender: TObject);
begin
    DateTimePicker2.Date:=DateTimePicker1.Date + Conserva.AsInteger;
end;

procedure TFormBuyIn.DateTimePicker2CloseUp(Sender: TObject);
begin
  DateTimePicker1.Date:=DateTimePicker2.Date - Conserva.AsInteger;
end;

procedure TFormBuyIn.DBGrid1DblClick(Sender: TObject);
begin
  IF Buydetalles.RecordCount < 1 THEN EXIT;
  EDIT1.Text:=Buydetalles.FieldByName('ENA').AsString;
  EDIT1.SetFocus;
end;

procedure TFormBuyIn.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
begin


  if ([gdSelected] * AState <> []) then
  begin
    DBGrid1.Canvas.Brush.color := clBlack; //当前行以黑色显示
    DBGrid1.Canvas.pen.mode := pmmask;
  end;
end;

procedure TFormBuyIn.DescuentoExit(Sender: TObject);
begin
  CalImporte();
end;

procedure TFormBuyIn.DescuentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn.Edit1Enter(Sender: TObject);
begin
  ClearInputEdit();
end;

procedure TFormBuyIn.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_F5)  then begin key:=0; BitBtn5Click(self); Exit; End;    //buscar
end;

procedure TFormBuyIn.FormKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TFormBuyIn.ImporteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn.Button1Click(Sender: TObject);
var
  Bookmark: TBookmark;
  i:integer;
begin
  if Edit1.Text = '' then exit;
  if aGoodsType = -1 then exit;

  Bookmark := Buydetalles.GetBookmark;
  IF aGoodsType = 3 THEN
  Begin
    if (DateTimePicker2.Date <= now) or (DateTimePicker2.Date <= DateTimePicker1.Date ) then
    begin
      showmessage('过期日期错误无法保持');
      exit
    end;
  end;
  if aGoodsType = 4 THEN
  BEGIN

  end;

 with dbTrabajo do
 begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.Clear;
  SQL.Text:='INSERT INTO GOODS_OFPROVEEDOR (GOODS_ID, ENA, SUCODIGO, COST, DISCOUNT, ID_PROVEEDOR ) '
  +'values (:GOODS_ID, :ENA, :SUCODIGO, :COST, :DISCOUNT, :ID_PROVEEDOR ) '
  +'ON DUPLICATE KEY UPDATE '
  +'COST=:COST, DISCOUNT=:DISCOUNT ';
  ParamByName('GOODS_ID').AsString:=Articulo.FieldByName('GOODS_ID').AsString;
  ParamByName('ENA').AsString:=Articulo.FieldByName('ENA').AsString;
  ParamByName('SUCODIGO').AsString:='';
  ParamByName('COST').AsFloat:= Precio.Value;
  ParamByName('DISCOUNT').AsFloat:= Descuento.Value;
  ParamByName('ID_PROVEEDOR').AsString:=aBUYDoc.ID_PROVEEDOR;
  ExecSQL;
  Active:=False;
  SQL.Clear;
  SQL.Text:='INSERT INTO GOODS_SPU_PRICE (GOODS_ID, COST, pvp1c) values (:GOODS_ID, :COST, :pvp1c) '
  +'ON DUPLICATE KEY UPDATE '
  +'COST=:COST, PVP1C=:PVP1C ';
  ParamByName('GOODS_ID').AsString:=Articulo.FieldByName('GOODS_ID').AsString;
  ParamByName('COST').AsFloat:= Precio.Value;
  ParamByName('pvp1c').AsFloat:= PVP1C.Value;
  ExecSQL;
  Active:=False;
  SQL.Clear;
  SQL.Text:='UPDATE GOODS_SKU SET COST=:COST, SELLING_P1C=:SELLING_P1C, STOCK=STOCK+:STOCK '
        +'WHERE 1=1  AND SKU_NO=:SKU_NO ';                  //AND ISCHILD=0
  ParamByName('SKU_NO').AsString:=Articulo.FieldByName('SKU_NO').AsString;
  ParamByName('COST').AsFloat:= Precio.Value;
  ParamByName('SELLING_P1C').AsFloat:= PVP1C.Value;
  ParamByName('STOCK').AsFloat:= Amount.Value;
  ExecSQL;

  /////////仓库中的货品库存//////////
  sql.Clear;
  sql.Text:='INSERT INTO STOCKGOODS (ID_STOCK, GOODS_ID, SKU_NO, AMOUNT, GOODS_STATUS) '
  +'VALUES (:ID_STOCK, :GOODS_ID, :SKU_NO, AMOUNT=AMOUNT+:AMOUNT, :GOODS_STATUS) '
  +'ON DUPLICATE KEY UPDATE '
  +'AMOUNT=AMOUNT+:AMOUNT ';
  ParamByName('ID_STOCK').AsString:=aBUYDoc.ID_STOCK;
  ParamByName('GOODS_ID').AsString:=Articulo.FieldByName('GOODS_ID').AsString;
  ParamByName('SKU_NO').AsString:=Articulo.FieldByName('SKU_NO').AsString;
  ParamByName('AMOUNT').AsFloat:= Amount.Value;
  ParamByName('GOODS_STATUS').AsInteger:= 0;
  ExecSQL;

  Active:=False;
  IF Articulo.FieldByName('TYPE').AsInteger = 1 THEN
  BEGIN
    WITH CombinaQuery do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=False;
    SQL.Text:='SELECT * FROM GOODS_SKU_COMBINATION WHERE 1=1 AND SKU_NO=:SKU_NO ';
    ParamByName('SKU_NO').AsString:=Articulo.FieldByName('SKU_NO').AsString;
    OPEN;
    end;
    IF CombinaQuery.RecordCount > 0 THEN
    BEGIN
     CombinaQuery.First;
     FOR I:=0 TO CombinaQuery.RecordCount-1 DO
      BEGIN
      SQL.Clear;
      SQL.Text:='UPDATE GOODS_SKU SET STOCK=STOCK+:STOCK '
        +'WHERE 1=1 AND SKU_NO=:SKU_NO ';
        ParamByName('SKU_NO').AsString:=CombinaQuery.FieldByName('MEMBER_SKU_NO').AsString;
        ParamByName('STOCK').AsFloat:= Amount.Value*CombinaQuery.FieldByName('QUANTITY').AsFloat;
        ExecSQL;
        sql.Clear;
  sql.Text:='INSERT INTO STOCKGOODS (ID_STOCK, GOODS_ID, SKU_NO, AMOUNT, GOODS_STATUS) '
  +'VALUES (:ID_STOCK, :GOODS_ID, :SKU_NO, AMOUNT=AMOUNT+:AMOUNT, :GOODS_STATUS) '
  +'ON DUPLICATE KEY UPDATE '
  +'AMOUNT=AMOUNT+:AMOUNT ';
  ParamByName('ID_STOCK').AsString:=aBUYDoc.ID_STOCK;
  ParamByName('GOODS_ID').AsString:=CombinaQuery.FieldByName('GOODS_ID').AsString;
  ParamByName('SKU_NO').AsString:=CombinaQuery.FieldByName('MEMBER_SKU_NO').AsString;
  ParamByName('AMOUNT').AsFloat:= Amount.Value;
  ParamByName('GOODS_STATUS').AsInteger:= 0;
  ExecSQL;
      CombinaQuery.Next;
      end;
    end;
  end;
  IF Articulo.FieldByName('TYPE').AsInteger = 3 THEN
  begin
      WITH dbFoods do
      begin
      Connection:=DataModule2.ZCon1;
      Active:=False;
      SQL.Text:='INSERT INTO GOODS_SHELFLIFE_STOCK(ID_STOCK, GOODS_ID, SKU_NO, AMOUNT, FECHA_FABRICA, FECHA_CADUCA) '
       +'VALUES (:ID_STOCK, :GOODS_ID, :SKU_NO, :AMOUNT, :FECHA_FABRICA, :FECHA_CADUCA) '
      +'ON DUPLICATE KEY UPDATE '
      +'AMOUNT=AMOUNT+:AMOUNT ';
      ParamByName('ID_STOCK').AsString:=aBUYDoc.ID_STOCK;
      ParamByName('GOODS_ID').AsString:=Articulo.FieldByName('GOODS_ID').AsString;
      ParamByName('SKU_NO').AsString:=Articulo.FieldByName('SKU_NO').AsString;
      ParamByName('AMOUNT').AsFloat:= Amount.Value;
      ParamByName('FECHA_FABRICA').AsDate:=DateTimePicker1.Date;
      ParamByName('FECHA_CADUCA').AsDate:=DateTimePicker2.Date;
      ExecSQL;
      end;
  end;

  Active:=False;
  SQL.Clear;
  SQL.Text:='INSERT INTO BUY_ITEMS (B_UUID, GOODS_ID, SKU_NO, ENA, QUANTITY, COMMODITY_UNIT, COST, DISCOUNT, BUY_DATE ) '
  +'VALUES (:B_UUID, :GOODS_ID, :SKU_NO, :ENA, :QUANTITY, :COMMODITY_UNIT, :COST, :DISCOUNT, :BUY_DATE) '
  +'ON DUPLICATE KEY UPDATE '
  +'QUANTITY=QUANTITY+:QUANTITY ';
   ParamByName('B_UUID').AsString:=aBUYDOC.B_UUID;
   ParamByName('GOODS_ID').AsString:=Articulo.FieldByName('GOODS_ID').AsString;
   ParamByName('SKU_NO').AsString:=Articulo.FieldByName('SKU_NO').AsString;
   ParamByName('ENA').AsString:=trim(Edit1.Text);
   ParamByName('QUANTITY').AsFloat:= Amount.Value;
   ParamByName('COMMODITY_UNIT').AsString:=Articulo.FieldByName('UNIT').AsString;
   ParamByName('COST').AsFloat:= Precio.Value;
   ParamByName('DISCOUNT').AsFloat:= Descuento.Value;
   ParamByName('BUY_DATE').AsDateTime:=aBUYDOC.BUY_DATE;
   ExecSQL;
  end;

  Buydetalles.Refresh;
  Buydetalles.GotoBookmark(Bookmark);


  GetTotal;

  //Articulo.FieldByName('PRECIO_COMPRAS_CON').AsCurrency
  Edit1.Text:='';
  ClearInputEdit();
  EDIT1.SetFocus;
end;

procedure TFormBuyIn.BitBtn5Click(Sender: TObject);
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

procedure TFormBuyIn.BitBtn5KeyPress(Sender: TObject; var Key: char);
begin

end;

end.

