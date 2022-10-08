unit SimpleAdd;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, LCLType,
  DBCtrls, Buttons, ZDataset, rxcurredit, connect, Global;

type

  { TFsimple }

  TFsimple = class(TForm)
    AvisoLimit: TComboBox;
    BitBtn12: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    BrandDBBox: TDBLookupComboBox;
    BrandDS: TDataSource;
    BrandQuery: TZQuery;
    Button1: TButton;
    CanDiscount: TComboBox;
    CategoryDBBox: TDBLookupComboBox;
    CategoryDS: TDataSource;
    CategoryQuery: TZQuery;
    ClasseQuery: TZQuery;
    CodingEdit: TEdit;
    DBCost: TCurrencyEdit;
    DBDISCOUNT: TCurrencyEdit;
    DBGoodsQuery: TZQuery;
    DBImage1: TDBImage;
    DBPvP1c: TCurrencyEdit;
    dbTrabajo: TZQuery;
    dbUuid: TZQuery;
    Edit4: TEdit;
    ENAEdit: TEdit;
    IvaDBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label43: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label68: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LowLimit: TCurrencyEdit;
    NameEdit: TEdit;
    NameEdit2: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SpecQuery: TZQuery;
    TaxRateDS: TDataSource;
    TaxRateZQuery: TZQuery;
    TypeBox: TComboBox;
    Unidades: TEdit;
    UUIDEdit: TEdit;
    VolumeEdit: TEdit;
    WeigthEdit: TEdit;
    procedure AvisoLimitKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AvisoLimitSelect(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BrandDBBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure CanDiscountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CategoryDBBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CodingEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBCostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBDISCOUNTKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBPvP1cKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ENAEditExit(Sender: TObject);
    procedure ENAEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
     function ExistGoods(CDBarra: string):boolean;
     procedure DoGetTaxRates;
     procedure FormCreate(Sender: TObject);
     PROCEDURE GetCategorys();
     Procedure GetClasse();
     Procedure GetBrand();
    function GetCategorySpec(Category_id: integer):boolean;
    procedure IvaDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LowLimitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure NameEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NameEditExit(Sender: TObject);
    procedure NameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure TypeBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure UnidadesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure VolumeEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WeigthEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
     FFlag:boolean;
  public
     function Created(new:TGOODS):boolean;

  end;

  procedure ShowSimpleForm(new:TGOODS);

var
  Fsimple: TFsimple;
   NewGoods:TGOODS;
   Uid: TGuid;
  UResult: HResult;
  GOODS_ID, SKUUUID: string;
  IsNewGoods, HaveSkuItems, HaveNewSkuItem: Boolean;
  Hecho:boolean;
  aProveedor:TStringArray;

implementation
uses
   Goods_Marca,Categorys_Spec, U_FindGoods_Spu, findout;

{$R *.lfm}


procedure ShowSimpleForm(new:TGOODS);
begin
  with TFsimple.Create(Application) do
    begin
      ENAEdit.Text:=new.ENA;
      ENAEditExit(Fsimple);
      ENAEdit.Enabled:=False;
      NameEdit.Text:=new.ITEM_NAME;
      DBCost.Value:=new.COST;
      FFlag:=True;
      ShowModal;
      //ENAEditExit(FormGoodsSpu);
    end;
end;

{ TFormGoodsSpu }

procedure TFsimple.ENAEditExit(Sender: TObject);
begin
  if Trim(ENAEdit.Text)='' then exit;
  with dbUuid do
      begin
      Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.CLEAR;
      SQL.TEXT:='SELECT UUID() AS UUID';
      open;

      end;

if ExistGoods(Trim(ENAEdit.Text)) then
begin
  /////
  GOODS_ID:=DBGoodsQuery.FieldByName('GOODS_ID').AsString;
  ///这里的sku编码是本身的编码, 不是属性商品.
  SKUUUID:=DBGoodsQuery.FieldByName('SKU_NO').AsString;
  ///
  UUIDEdit.Text:= DBGoodsQuery.FieldByName('GOODS_ID').AsString;
  CodingEdit.Text:=DBGoodsQuery.FieldByName('CODE').AsString;
  NameEdit.Text:= DBGoodsQuery.FieldByName('GOODS_NAME').AsString;
  NameEdit2.Text:= DBGoodsQuery.FieldByName('GOODS_NAME2').AsString;
  //DateMod.Text:=  DBGoodsQuery.FieldByName('UPDATED_AT').AsString;
  CategoryDBBox.KeyValue:= DBGoodsQuery.FieldByName('CATEGORY_ID').Value;

  if DBGoodsQuery.FieldByName('BRAND_ID').AsInteger <> 0 then
  BrandDBBox.KeyValue:= DBGoodsQuery.FieldByName('BRAND_ID').Value;
  //CombinaDS.DataSet:=DBCOMBINA;
  TypeBox.ItemIndex:=DBGoodsQuery.FieldByName('TYPE').Value;
 // TypeBoxSelect(self);
  Unidades.Text:=DBGoodsQuery.FieldByName('UNIT').AsString;
  IvaDBLookupComboBox1.KeyValue:= DBGoodsQuery.FieldByName('TAXRATE_ID').Value;
  WeigthEdit.Text:=DBGoodsQuery.FieldByName('Weigth').AsString;
  VolumeEdit.Text:=DBGoodsQuery.FieldByName('Volume').AsString;
  AvisoLimit.ItemIndex:=DBGoodsQuery.FieldByName('STOCKAVISO').AsInteger;
  LOWLIMIT.Value:=DBGoodsQuery.FieldByName('LOWLIMIT').Value;
  CanDiscount.ItemIndex:=DBGoodsQuery.FieldByName('CAN_DISCount').AsInteger;
  //Edit4.Text:=formatfloat('#,##0.00',  DBGoodsQuery.FieldByName('Points').AsFloat);
  DBCost.Value:=DBGoodsQuery.FieldByName('COST').Value;
  DBPvP1c.Value:=DBGoodsQuery.FieldByName('SELLING_P1C').Value;
  DBDISCOUNT.Value:=DBGoodsQuery.FieldByName('DISCOUNT').Value;



  IsNewGoods:=False;
end
else
begin
  GOODS_ID:=Get36UUID();
  UUIDEdit.Text:=GOODS_ID;
  IsNewGoods:=True;
 // btnClonar.Enabled:=True;

  //TabSheet1.Visible:=True;
  CodingEdit.Text:=RightStr(ENAEdit.Text, 6);


end;
end;

procedure TFsimple.ENAEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.Button1Click(Sender: TObject);
begin
    if (Trim(ENAEdit.Text)='') or (Trim(CodingEdit.Text)='') then
  begin
  ShowMessage('No se puede guardar.');
  if ENAEdit.Enabled then
  ENAEdit.SetFocus;
  Exit;
  end;

  if (Trim(NameEdit.Text)='') then
  begin
    NameEdit.SetFocus;
  Exit;
  end;

  if CategoryDBBox.KeyValue=null then
  begin
    CategoryDBBox.SetFocus;
  Exit;
  end;

  if BrandDBBox.KeyValue=null then
  begin
    BrandDBBox.SetFocus;
  Exit;
  end;

  if IvaDBLookupComboBox1.KeyValue=null then
  begin
    IvaDBLookupComboBox1.SetFocus;
  Exit;
  end;

   with dbTrabajo do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU '
       +'(GOODS_ID, GOODS_NAME, GOODS_NAME2,  ENA, CODE, CLASS_ID, CATEGORY_ID, BRAND_ID, TYPE, UNIT,  TAXRATE_ID, WEIGTH, VOLUME, IS_ACTIVE, PARENT_ID, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points)'
       +'VALUES (:GOODS_ID, :GOODS_NAME, :GOODS_NAME2, :ENA, :CODE, :CLASS_ID, :CATEGORY_ID, :BRAND_ID, :TYPE, :UNIT, :TAXRATE_ID, :WEIGTH, :VOLUME, :IS_ACTIVE, :PARENT_ID, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points) '
       +'ON DUPLICATE KEY UPDATE '
       +'GOODS_NAME=:GOODS_NAME, GOODS_NAME2=:GOODS_NAME2, CODE=:CODE, CLASS_ID=:CLASS_ID, CATEGORY_ID=:CATEGORY_ID, '
       +'TYPE=:TYPE, UNIT=:UNIT, '
       +'BRAND_ID=:BRAND_ID, TAXRATE_ID=:TAXRATE_ID, WEIGTH=:WEIGTH, VOLUME=:VOLUME, IS_ACTIVE=:IS_ACTIVE, STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('GOODS_NAME').AsString:=NAMEEdit.Text;
    ParamByName('GOODS_NAME2').AsString:=NAMEEdit2.Text;
    ParamByName('ENA').AsString:=ENAEdit.Text;
    ParamByName('CODE').AsString:=CodingEdit.Text;
    ParamByName('CLASS_ID').AsInteger:=0;
    ParamByName('CATEGORY_ID').AsInteger:=CategoryDBBox.KeyValue;
    ParamByName('BRAND_ID').AsInteger:=BrandDBBox.KeyValue;
    ParamByName('TYPE').AsInteger:=TypeBox.ItemIndex;
    ParamByName('UNIT').AsString:=Unidades.Text;
    ParamByName('TAXRATE_ID').AsInteger:=IvaDBLookupComboBox1.KeyValue;
    ParamByName('WEIGTH').AsString:=WEIGTHEdit.Text;
    ParamByName('VOLUME').AsString:=VOLUMEEdit.Text;
    ParamByName('IS_ACTIVE').AsInteger:=1;
    ParamByName('PARENT_ID').AsInteger:=0;
    if AvisoLimit.ItemIndex=1 then ParamByName('STOCKAVISO').AsInteger:=1
       else ParamByName('STOCKAVISO').AsInteger:=0;
    ParamByName('LOWLIMIT').AsFloat:=LowLimit.Value;
    if CanDiscount.ItemIndex=1 then ParamByName('CAN_DISCount').AsInteger:=1
       else ParamByName('CAN_DISCount').AsInteger:=0;
    ParamByName('Points').AsFloat:=strtofloat(Trim(Edit4.Text));
    ExecSQL;

    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU_PRICE (GOODS_ID, COST, PVP1C, PVP2C, PVP3C, LOWPRICE, WHOLESALE, DISCOUNT) '
          +'VALUES (:GOODS_ID, :COST, :PVP1C, :PVP2C, :PVP3C, :LOWPRICE, :WHOLESALE, :DISCOUNT) '
          +'ON DUPLICATE KEY UPDATE '
          +'COST=:COST, PVP1C=:PVP1C, PVP2C=:PVP2C, PVP3C=:PVP3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT ';
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('COST').AsCurrency:=DBCost.Value;
    ParamByName('PVP1C').AsCurrency:=DBPvP1c.Value;
    ParamByName('PVP2C').AsCurrency:=DBPvP1c.Value;
    ParamByName('PVP3C').AsCurrency:=DBPvP1c.Value;
    ParamByName('LOWPRICE').AsCurrency:=0;
    ParamByName('WHOLESALE').AsCurrency:=0;
    ParamByName('DISCOUNT').AsCurrency:=DBDISCOUNT.Value;
    ExecSQL;

    SQL.Clear;

    sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO,LOWLIMIT, CAN_DISCount, Points ) '
    +'VALUES (:SKU_NO, :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points )'
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD, '
    +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
       ParamByName('SKU_NO').AsString:=dbUuid.FieldByName('UUID').AsString;
       ParamByName('SKU_NAME').AsString:='';     //只允许spec的商品用有SKU_NAME.
       ParamByName('COST').AsCurrency:=DBCost.Value;
       ParamByName('SELLING_P1C').AsCurrency:=DBPvP1c.Value;
       ParamByName('SELLING_P2C').AsCurrency:=DBPvP1c.Value;
       ParamByName('SELLING_P3C').AsCurrency:=DBPvP1c.Value;
       ParamByName('LOWPRICE').AsCurrency:=0;
       ParamByName('WHOLESALE').AsCurrency:=0;
       ParamByName('DISCOUNT').AsFloat:=DBDISCOUNT.Value;
       ParamByName('GOODS_ID').AsString:=GOODS_ID;
       ParamByName('SKU_CODING').AsString:=ENAEdit.Text;
       ParamByName('ISCHILD').AsInteger:=0;
       if AvisoLimit.ItemIndex=1 then ParamByName('STOCKAVISO').AsInteger:=1
       else ParamByName('STOCKAVISO').AsInteger:=0;
       ParamByName('LOWLIMIT').AsFloat:=LowLimit.Value;
       if CanDiscount.ItemIndex=1 then ParamByName('CAN_DISCount').AsInteger:=1
       else ParamByName('CAN_DISCount').AsInteger:=0;
       ParamByName('Points').AsFloat:=strtofloat(Trim(Edit4.Text));
       ExecSQL;
       end;
    Hecho:=True;
    close;

end;

procedure TFsimple.CanDiscountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.CategoryDBBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.CodingEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.DBCostKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.DBDISCOUNTKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.DBPvP1cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.AvisoLimitSelect(Sender: TObject);
begin
  if AvisoLimit.ItemIndex = 1 then
  LowLimit.Enabled:=true else  LowLimit.Enabled:=False;
end;

procedure TFsimple.BitBtn20Click(Sender: TObject);
begin
  FormMarca.IniciaMExcute('GOODS_BRANDS', ['CODE','BRAND_NAME'], ['CODE','BRAND_NAME']);
  BrandQuery.Refresh;
end;

procedure TFsimple.BitBtn21Click(Sender: TObject);
begin
  if FormCategorys.IniciaCategory() then
  CategoryQuery.Refresh;
end;

procedure TFsimple.BitBtn22Click(Sender: TObject);
var
  Result: TStringArray;
  table:string;
begin
 table:=EMID+'QUANTIFIER';
  Result:=FormFindout.IniciaBusquedas( table, ['CODE','UNIDAD'], ['CODE', 'UNIDADES VENTA'] );
  Unidades.Text:=Result[1];
  if ((Unidades.Text='-') or (Unidades.Text='-1')) then
  begin
  Unidades.Text:='';
  end;
  Unidades.Focused;
end;

procedure TFsimple.AvisoLimitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.BrandDBBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

Procedure TFsimple.GetClasse();
begin
  with ClasseQuery do
begin
Connection:=DataModule2.ZCon1;
  Active:=false;
  SQL.Clear;
  sql.Text:='SELECT * FROM  CLASSES';
  open;
end;
end;

function TFsimple.Created(new:TGOODS):boolean;
begin
  Hecho:=False;
  NewGoods:=new;
 ShowSimpleForm(NewGoods);
  Result:=Hecho;
end;



procedure TFsimple.DoGetTaxRates;
   begin
   with TaxRateZQuery do
   begin
   Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.Clear;
      SQL.Text:='SELECT * FROM GOODS_TAXRATE';
      Open;
   end;

   end;

procedure TFsimple.FormCreate(Sender: TObject);
begin
  //NewDoc:=False;
  FFlag:=True;
  DoGetTaxRates;
GetCategorys();
GetBrand();
GetClasse();
end;

 PROCEDURE TFsimple.GetCategorys();
 begin
    with CategoryQuery do
     begin
     Connection:=DataModule2.ZCon1;
        Active:=false;
        SQL.Clear;
        sql.Text:='SELECT T1.ID, T1.PARENT_ID, T1.CATEGORY, T1.DESCRIPCION, T3.NAME FROM CATEGORYS  AS T1 '
        +'LEFT JOIN CATEGORYS_ATTRIBUTE AS T2 ON T1.ID = T2.CATEGORY_ID '
        +'LEFT JOIN GOODS_ATTRIBUTE_KEY AS T3 ON T3.ATTIBUTE_ID= T2.ATTIBUTE_ID';
        open;
     end;
 end;

 function TFsimple.GetCategorySpec(Category_id: integer):boolean;
begin
  with SpecQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT T3.attibute_id, T3.name FROM CategorysTree as T1 '
              +'INNER JOIN categorys_attribute AS T2 ON T2.CATEGORY_ID = T1.ancestor '
              +'left join goods_attribute_key as T3 on T2.attibute_id = T3.attibute_id '
              +'WHERE descendant=:descendant ';
    ParamByName('descendant').AsInteger:= Category_id;
    ExecSQL;
  end;
  if SpecQuery.RecordCount <> 0 then
  result:=True else result:=False;

end;

procedure TFsimple.IvaDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.LowLimitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.NameEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.NameEditExit(Sender: TObject);
begin
  if TRIM(NameEdit2.Text)='' then
  NameEdit2.Text:=NameEdit.Text;
end;

procedure TFsimple.NameEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.TypeBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.UnidadesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.VolumeEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFsimple.WeigthEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

 Procedure TFsimple.GetBrand();
 begin
    with BrandQuery do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT * FROM  GOODS_BRANDS';
    open;
 end;
 end;

 function TFsimple.ExistGoods(CDBarra: string):boolean;
 begin
     with DBGoodsQuery do
     begin
        Connection:=DataModule2.ZCon1;
        Active:=false;
        SQL.Clear;
       {SQL.TEXT:='SELECT T1.GOODS_ID, T1.GOODS_NAME, T1.GOODS_NAME2, T1.ENA, T1.CODE, T1.CATEGORY_ID, T1.BRAND_ID, T1.TYPE, T1.UNIT, T1.TAXRATE_ID, T1.WEIGTH, T1.VOLUME, T1.IS_ACTIVE, T1.PARENT_ID, T1.CLASS_ID, '
        +' T2.COST, T2.PVP1C, T2.PVP2C, T2.PVP3C, T2.LOWPRICE, T2.WHOLESALE, T2.DISCOUNT '
        +'FROM GOODS_SPU AS T1 LEFT JOIN GOODS_SPU_PRICE T2 ON T2.GOODS_ID = T1.GOODS_ID '
        +'WHERE 1=1 AND ENA=:ENA ';
       }
       SQL.Text:='SELECT T1.GOODS_ID, T1.GOODS_NAME, T1.GOODS_NAME2, T1.ENA, T1.CODE, T1.CATEGORY_ID, T1.BRAND_ID, T1.TYPE, T1.UNIT, T1.TAXRATE_ID, T1.WEIGTH, T1.VOLUME, T1.IS_ACTIVE, '
       +'T1.PARENT_ID, T1.CLASS_ID, T1.STOCKAVISO, T1.LOWLIMIT, T1.CAN_DISCount, T1.UPDATED_AT, '
         +'T2.COST, T2.SELLING_P1C, T2.SELLING_P2C, T2.SELLING_P3C, T2.LOWPRICE, T2.WHOLESALE, T2.DISCOUNT, T2.Points, T2.SKU_NO '
         +'FROM GOODS_SPU AS T1 LEFT JOIN GOODS_SKU AS T2 ON T2.GOODS_ID = T1.GOODS_ID '
         +'WHERE 1=1 AND T2.ISCHILD = 0 '
         +'AND T1.ENA=:ENA ';
        ParamByName('ENA').AsString:=CDBarra;
        OPEN;
     end;
   if DBGoodsQuery.RecordCount <>0 then
     RESULT := TRUE
     ELSE RESULT := FALSE;
 end;
end.

