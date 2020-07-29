unit AddGoods;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, DBCtrls, Buttons, ComCtrls, DBGrids, ZConnection, LCLType,  printers,
  ExtDlgs, ZDataset, rxcurredit, connect, Global, fpjson, jsonparser;

type

  { TFormGoodsSpu }

  TFormGoodsSpu = class(TForm)
    CanDiscount: TComboBox;
    BfCOST: TCurrencyField;
    BfGOODS_ID: TStringField;
    BfLOWPRICE: TCurrencyField;
    BfMERCHANT_CODING: TStringField;
    BfSELLING_P1C: TCurrencyField;
    BfSELLING_P2C: TCurrencyField;
    BfSELLING_P3C: TCurrencyField;
    BfSKU_NAME: TWideStringField;
    BfSTOCK: TFloatField;
    BfWHOLESALE: TCurrencyField;
    BitBtn12: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    BitBtn3: TBitBtn;
    BrandDBBox: TDBLookupComboBox;
    BrandDS: TDataSource;
    btnClonar: TBitBtn;
    Button13: TButton;
    CombinaBD: TBufDataset;
    BufDatasetStudies: TBufDataset;
    BfDISCOUNT: TFloatField;
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    CButton: TButton;
    CategoryDBBox: TDBLookupComboBox;
    CategoryDS: TDataSource;
    CDBCost: TCurrencyEdit;
    Cantidad: TCurrencyEdit;
    CDBLOWPRICE: TCurrencyEdit;
    CDBPvP1c: TCurrencyEdit;
    CDBPvP2c: TCurrencyEdit;
    CDBPvP3c: TCurrencyEdit;
    CDBWHOLESALE: TCurrencyEdit;
    CDBDISCOUNT: TCurrencyEdit;
    CodingEdit: TEdit;
    ClasseDS: TDataSource;
    CombinaBDCOMMODITY_UNIT: TStringField;
    CombinaBDCOST: TFloatField;
    CombinaBDITEM_NAME: TStringField;
    CombinaBDMEMBER_SKU_NO: TStringField;
    CombinaBDQUANTITY: TFloatField;
    CombinaBDSELLING_P1C: TFloatField;
    Label59: TLabel;
    LowLimit: TCurrencyEdit;
    dbClonar: TZQuery;
    DBCost: TCurrencyEdit;
    DBDISCOUNT: TCurrencyEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Memo2: TMemo;
    OpenPictureDialog1: TOpenPictureDialog;
    AvisoLimit: TComboBox;
    SkuQuery: TZQuery;
    DBLOWPRICE: TCurrencyEdit;
    DBPvP1c: TCurrencyEdit;
    DBPvP2c: TCurrencyEdit;
    DBPvP3c: TCurrencyEdit;
    DBWHOLESALE: TCurrencyEdit;
    Edit4: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label43: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel10: TPanel;
    Panel16: TPanel;
    PricePanel: TPanel;
    TypeBox: TComboBox;
    CombinaDS: TDataSource;
    DBGrid3: TDBGrid;
    dbCombina: TZQuery;
    dbTrabajo: TZQuery;
    dbInsert: TZQuery;
    Sku_NoEdit: TEdit;
    ItemName: TEdit;
    IvaDBLookupComboBox1: TDBLookupComboBox;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label7: TLabel;
    MaxDesc1: TCurrencyEdit;
    MaxDesc2: TCurrencyEdit;
    NameEdit2: TEdit;
    CombinationPanel: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel7: TPanel;
    Panel9: TPanel;
    SKUListDS: TDataSource;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TaxRateDS: TDataSource;
    DataSourceStudies: TDataSource;
    DateAdd: TEdit;
    DateMod: TEdit;
    DBEdit0: TDBEdit;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBImage1: TDBImage;
    WeigthEdit: TEdit;
    VolumeEdit: TEdit;
    ENAEdit: TEdit;
    IdProv: TEdit;
    Label1: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label4: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    NameEdit: TEdit;
    NewSkuPanel: TPanel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    SkuPanel: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TempListDS: TDataSource;
    Unidades: TEdit;
    UProveedor: TEdit;
    UUIDEdit: TEdit;
    ZConnection1: TZConnection;
    DBGoodsQuery: TZQuery;
    CategoryQuery: TZQuery;
    BrandQuery: TZQuery;
    ClasseQuery: TZQuery;
    SKUListQuery: TZQuery;
    SpecQuery: TZQuery;
    TaxRateZQuery: TZQuery;
    procedure AvisoLimitKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BrandDBBoxChange(Sender: TObject);
    procedure BrandDBBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnClonarClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CanDiscountExit(Sender: TObject);
    procedure CanDiscountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CategoryDBBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CButtonClick(Sender: TObject);
    procedure CodingEditEnter(Sender: TObject);
    procedure CodingEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBCostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBDISCOUNTKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLOWPRICEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBPvP1cKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBPvP2cKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBPvP3cKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBWHOLESALEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit4Exit(Sender: TObject);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit4KeyPress(Sender: TObject; var Key: char);
    procedure ENAEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure IvaDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Label57Click(Sender: TObject);
    procedure Label58Click(Sender: TObject);
    procedure LowLimitExit(Sender: TObject);
    procedure LowLimitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure NameEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure Sku_NoEditExit(Sender: TObject);
    procedure TypeBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure TypeBoxSelect(Sender: TObject);
    function CreateUUID():string;
    procedure ENAEditExit(Sender: TObject);
    function Get36UUID():string;
    Function ExistGoods(CDBarra: string):Boolean;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    PROCEDURE GetCategorys();
    Procedure GetBrand();
    Procedure GetClasse();
    procedure ItemsClear();
    procedure DoGetTaxRates;
    Function GetGoodsSKUitems(aGOODS_ID:STRING):Boolean;
     function GetCategorySpec(Category_id: integer):boolean;
     procedure GetCombination(aSKU_NO:STRING);
     Function GetCombinacionCost():Double;
     procedure NameEditExit(Sender: TObject);
     procedure UnidadesKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure UProveedorExit(Sender: TObject);
     procedure UProveedorKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure VolumeEditKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure WeigthEditKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure AbirCajones();
  private
    FFlag:boolean;

  public
     function Created(new:TGOODS):boolean;
  end;

  procedure ShowFormGoodsSpu(new:TGOODS);

var
  FormGoodsSpu: TFormGoodsSpu;
  NewGoods:TGOODS;
   Uid: TGuid;
  UResult: HResult;
  GOODS_ID, SKUUUID: string;
  IsNewGoods, HaveSkuItems, HaveNewSkuItem: Boolean;
  Hecho:boolean;
  aProveedor:TStringArray;

implementation
uses
Spec_Select, Goods_Marca, U_FindGoods_Spu, findout, Categorys_Spec, select_onesku; //, U_FindGoods_Spu, findout, U_Marca;

{$R *.lfm}

procedure ShowFormGoodsSpu(new:TGOODS);
begin
  with TFormGoodsSpu.Create(Application) do
    begin
      ENAEdit.Text:=new.ENA;
      ENAEditExit(FormGoodsSpu);
      ENAEdit.Enabled:=False;
      NameEdit.Text:=new.ITEM_NAME;
      DBCost.Value:=new.COST;
      FFlag:=True;
      ShowModal;
      //ENAEditExit(FormGoodsSpu);
    end;
end;

{ TFormGoodsSpu }

function TFormGoodsSpu.Created(new:TGOODS):boolean;
begin
  Hecho:=False;
  NewGoods:=new;
  ShowFormGoodsSpu(NewGoods);
  Result:=Hecho;
end;

procedure TFormGoodsSpu.DoGetTaxRates;
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

 PROCEDURE TFormGoodsSpu.GetCategorys();
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

 function TFormGoodsSpu.GetCategorySpec(Category_id: integer):boolean;
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

procedure TFormGoodsSpu.NameEditExit(Sender: TObject);
begin
  if TRIM(NameEdit2.Text)='' then
  NameEdit2.Text:=NameEdit.Text;
end;

procedure TFormGoodsSpu.UnidadesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.UProveedorExit(Sender: TObject);
begin

  // DBcost.SetFocus;
end;

procedure TFormGoodsSpu.UProveedorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);

end;

procedure TFormGoodsSpu.VolumeEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.WeigthEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

 Procedure TFormGoodsSpu.GetBrand();
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

  Procedure TFormGoodsSpu.GetClasse();
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

{
procedure JsonToDataSet(AJson: string; ADataset: TDataSet);
var
jDataSet: TJSONArray;
jRecord: TJSONObject;
i, j: Integer;
begin
if (AJson = '') or (ADataset = nil) or (not ADataset.Active) then
Exit;
jDataSet := TJSONObject.Create.ParseJSONValue(AJson, True) as TJSONArray;
while not ADataset.Eof do
ADataset.Delete;
for i := 0 to jDataSet.Size - 1 do
begin
ADataset.Append;
jRecord := jDataSet.Get(i) as TJSONObject;
for j := 0 to ADataset.FieldCount - 1 do
ADataset.Fields[j].Text := jRecord.GetValue(ADataset.Fields[j].FieldName).ToString;
ADataset.Post;
end;
end;
 }
function TFormGoodsSpu.CreateUUID():string;
begin
CreateUUID:='';
  UResult := CreateGuid(Uid);
if UResult = S_OK then
   CreateUUID:=(GuidToString(Uid));
end;

procedure TFormGoodsSpu.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFormGoodsSpu.ItemsClear();
begin
  GOODS_ID:='';
  UUIDEdit.Text:= '';
  CodingEdit.Text:='';
  NameEdit.Text:= '';
  NameEdit2.Text:= '';
  //CategoryDBBox.KeyValue:= DBGoodsQuery.FieldByName('CATEGORY_ID').Value;
  //BrandDBBox.KeyValue:= DBGoodsQuery.FieldByName('BRAND_ID').Value;
  TypeBox.ItemIndex:=0;
  TypeBoxSelect(self);
  Unidades.Text:='';
  //IvaDBLookupComboBox1.KeyValue:= DBGoodsQuery.FieldByName('TAXRATE_ID').Value;
  WeigthEdit.Text:='';
  VolumeEdit.Text:='';
  DBCost.Value:=0;
  DBPvP1c.Value:=0;
  DBPvP2c.Value:=0;
  DBPvP3c.Value:=0;
  DBLOWPRICE.Value:=0;
  DBWHOLESALE.Value:=0;
  DBDISCOUNT.Value:=0;
  CDBCost.Value:=0;
  CDBPvP1c.Value:=0;
  CDBPvP2c.Value:=0;
  CDBPvP3c.Value:=0;
  CDBLOWPRICE.Value:=0;
  CDBWHOLESALE.Value:=0;
  CDBDISCOUNT.Value:=0;
  SKUListQuery.Close;
  DBGoodsQuery.Close;
  BufDatasetStudies.Close;
  IsNewGoods:=True;
  PricePanel.Parent:=PageControl1.Pages[0];
  PricePanel.Align:=alClient;
  PricePanel.Visible:=True;
  PageControl1.Pages[0].TabVisible:=True;
  PageControl1.Pages[0].Show;
  CombinationPanel.Visible:=False;
  dbCombina.Close;
  CombinaBD.Close;
end;

procedure TFormGoodsSpu.Button3Click(Sender: TObject);
var
  I: integer;
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
    ParamByName('PVP2C').AsCurrency:=DBPvP2c.Value;
    ParamByName('PVP3C').AsCurrency:=DBPvP3c.Value;
    ParamByName('LOWPRICE').AsCurrency:=DBLOWPRICE.Value;
    ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
    ParamByName('DISCOUNT').AsCurrency:=DBDISCOUNT.Value;
    ExecSQL;
    if not (IdProv.Text='') then
        begin
       SQL.Clear;
       SQL.Text:='INSERT INTO GOODS_OFPROVEEDOR (GOODS_ID, ENA, SUCODIGO, COST, DISCOUNT, ID_PROVEEDOR ) '
        +'values (:GOODS_ID, :ENA, :SUCODIGO, :COST, :DISCOUNT, :ID_PROVEEDOR ) '
        +'ON DUPLICATE KEY UPDATE '
        +'COST=:COST, DISCOUNT=:DISCOUNT ';
        ParamByName('GOODS_ID').AsString:=GOODS_ID;
        ParamByName('ENA').AsString:=ENAEdit.Text;
        ParamByName('SUCODIGO').AsString:='';
        ParamByName('COST').AsFloat:= CDBCost.Value;
        ParamByName('DISCOUNT').AsFloat:= 0;
        ParamByName('ID_PROVEEDOR').AsString:=aProveedor[0];
        ExecSQL;

        end;

    sql.Clear;
    if HaveSkuItems then
    begin
    if SKUListDS.DataSet.Modified then
    SKUListQuery.ApplyUpdates;
    //dataset.HasChanges()
    end;
   // else
    begin
          if HaveNewSkuItem then
          begin

          SQL.Clear;
          sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO,LOWLIMIT, CAN_DISCount, Points ) '
        +'VALUES (UUID(), :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points )'
        +'ON DUPLICATE KEY UPDATE '
        +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD, '
        +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';

        DataSourceStudies.DataSet.First;
        for I := 0 to DataSourceStudies.DataSet.RecordCount-1 do
          begin

           ParamByName('SKU_NAME').AsString:=DataSourceStudies.DataSet.FieldByName('SKU_NAME').AsString;     //只允许spec的商品用有SKU_NAME.
           ParamByName('COST').AsCurrency:=DataSourceStudies.DataSet.FieldByName('COST').AsFloat;
           ParamByName('SELLING_P1C').AsCurrency:=DataSourceStudies.DataSet.FieldByName('SELLING_P1C').AsFloat;
           ParamByName('SELLING_P2C').AsCurrency:=DataSourceStudies.DataSet.FieldByName('SELLING_P2C').AsFloat;
           ParamByName('SELLING_P3C').AsCurrency:=DataSourceStudies.DataSet.FieldByName('SELLING_P3C').AsFloat;
           ParamByName('LOWPRICE').AsCurrency:=DataSourceStudies.DataSet.FieldByName('LOWPRICE').AsFloat;
           ParamByName('WHOLESALE').AsCurrency:=DataSourceStudies.DataSet.FieldByName('WHOLESALE').AsFloat;
           ParamByName('DISCOUNT').AsFloat:=DataSourceStudies.DataSet.FieldByName('DISCOUNT').AsFloat;
           ParamByName('GOODS_ID').AsString:=GOODS_ID;
           ParamByName('SKU_CODING').AsString:=TempListDS.DataSet.FieldByName('MERCHANT_CODING').AsString;
           ParamByName('ISCHILD').AsInteger:=1;
           if AvisoLimit.ItemIndex=1 then ParamByName('STOCKAVISO').AsInteger:=1
           else ParamByName('STOCKAVISO').AsInteger:=0;
           ParamByName('LOWLIMIT').AsFloat:=LowLimit.Value;
           if CanDiscount.ItemIndex=1 then ParamByName('CAN_DISCount').AsInteger:=1
           else ParamByName('CAN_DISCount').AsInteger:=0;
           ParamByName('Points').AsFloat:=strtofloat(Trim(Edit4.Text));
           ExecSQL;
           DataSourceStudies.DataSet.Next;
          end;

          end
          else
          begin
          SQL.Clear;
        sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO,LOWLIMIT, CAN_DISCount, Points ) '
        +'VALUES (UUID(), :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points )'
        +'ON DUPLICATE KEY UPDATE '
        +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD, '
        +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
           ParamByName('SKU_NAME').AsString:='';     //只允许spec的商品用有SKU_NAME.
           ParamByName('COST').AsCurrency:=DBCost.Value;
           ParamByName('SELLING_P1C').AsCurrency:=DBPvP1c.Value;
           ParamByName('SELLING_P2C').AsCurrency:=DBPvP2c.Value;
           ParamByName('SELLING_P3C').AsCurrency:=DBPvP3c.Value;
           ParamByName('LOWPRICE').AsCurrency:=DBLOWPRICE.Value;
           ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
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
    end;
 end;
   ItemsClear();
   Hecho:=True;
   btnClonar.Enabled:=False;
   if FFlag = true then Close else
   begin
   ENAEdit.Text:='';
   ENAEdit.SetFocus;

   end;

end;

procedure TFormGoodsSpu.Button7Click(Sender: TObject);
begin
  if Trim(Sku_NoEdit.Text) = '' then
  begin
  Sku_NoEdit.SetFocus;
  exit;
  end;
  if Trim(ItemName.Text) = '' then exit;
  IF NOT ISNEWGOODS THEN
  BEGIN
  with dbInsert do
  begin
    Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SKU_COMBINATION (SKU_NO, GOODS_ID, MEMBER_SKU_NO, QUANTITY) '
    +'VALUES (:SKU_NO, :GOODS_ID, :MEMBER_SKU_NO, :QUANTITY) '
    +'ON DUPLICATE KEY UPDATE '
    +'QUANTITY=:QUANTITY ';
    ParamByName('SKU_NO').AsString:=DBGoodsQuery.FieldByName('SKU_NO').AsString;
    ParamByName('GOODS_ID').AsString:=DBGoodsQuery.FieldByName('GOODS_ID').AsString;
    ParamByName('MEMBER_SKU_NO').AsString:=SkuQuery.FieldByName('SKU_NO').AsString;
    ParamByName('QUANTITY').AsFloat:=Cantidad.Value;
    ExecSQL;
  end;
  dbCombina.Refresh;
  end
  ELSE
  BEGIN
    ///内存表

    with CombinaBD do
        begin
          Insert;
          CombinaBDITEM_NAME.AsString:=SkuQuery.FieldByName('ITEM_NAME').AsString;
          CombinaBDCOST.AsFloat:=SkuQuery.FieldByName('COST').AsFloat;
          CombinaBDSELLING_P1C.AsFloat:=SkuQuery.FieldByName('SELLING_P1C').AsFloat;
          CombinaBDQUANTITY.AsFloat:=Cantidad.Value;
          CombinaBDMEMBER_SKU_NO.AsString:=SkuQuery.FieldByName('SKU_NO').AsString;
          CombinaBDCOMMODITY_UNIT.AsString:=SkuQuery.FieldByName('COMMODITY_UNIT').AsString;
          Post;
        end;
  end;
  CDBCost.Value:= GetCombinacionCost();
  Sku_NoEdit.Text:='';
  ItemName.Text:='';
  Cantidad.Value:=0;
end;

procedure TFormGoodsSpu.Button8Click(Sender: TObject);
begin
  ItemsClear();
   ENAEdit.Text:='';
   ENAEdit.SetFocus;
end;

procedure TFormGoodsSpu.Button9Click(Sender: TObject);
begin
  if SKUListDS.DataSet.Modified then
  SKUListQuery.ApplyUpdates;
end;

procedure TFormGoodsSpu.CanDiscountExit(Sender: TObject);
begin
  if PageControl1.Pages[0].TabVisible then DBcost.SetFocus;
  if PricePanel.Visible=True then DBcost.SetFocus;

end;

procedure TFormGoodsSpu.CanDiscountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.CategoryDBBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.CButtonClick(Sender: TObject);
var
  I: integer;
  NewSKU_NO:string;
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
       +'VALUES (:GOODS_ID, :GOODS_NAME, :GOODS_NAME2, :ENA, :CODE, :CLASS_ID, :CATEGORY_ID, :BRAND_ID, :TYPE, :UNIT, :TAXRATE_ID, :WEIGTH, :VOLUME, :IS_ACTIVE, :PARENT_ID, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points ) '
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
    ParamByName('COST').AsCurrency:=CDBCost.Value;
          ParamByName('PVP1C').AsCurrency:=CDBPvP1c.Value;
          ParamByName('PVP2C').AsCurrency:=CDBPvP2c.Value;
          ParamByName('PVP3C').AsCurrency:=CDBPvP3c.Value;
          ParamByName('LOWPRICE').AsCurrency:=CDBLOWPRICE.Value;
          ParamByName('WHOLESALE').AsCurrency:=CDBWHOLESALE.Value;
          ParamByName('DISCOUNT').AsCurrency:=CDBDISCOUNT.Value;
    ExecSQL;


    //组合商品没有规格属性分类.
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points ) '
    +'VALUES (UUID(), :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points)'
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD '
    +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
     ParamByName('SKU_NAME').AsString:='';     //只允许spec的商品用有SKU_NAME.
     ParamByName('COST').AsCurrency:=CDBCost.Value;
     ParamByName('SELLING_P1C').AsCurrency:=CDBPvP1c.Value;
     ParamByName('SELLING_P2C').AsCurrency:=CDBPvP2c.Value;
     ParamByName('SELLING_P3C').AsCurrency:=CDBPvP3c.Value;
     ParamByName('LOWPRICE').AsCurrency:=CDBLOWPRICE.Value;
     ParamByName('WHOLESALE').AsCurrency:=CDBWHOLESALE.Value;
     ParamByName('DISCOUNT').AsFloat:=CDBDISCOUNT.Value;
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


     IF ISNEWGOODS THEN
     BEGIN
      SQL.Clear;
      sql.Text:='SELECT SKU_NO FROM GOODS_SKU WHERE 1=1 AND ISCHILD=0 AND GOODS_ID=:GOODS_ID ';
      ParamByName('GOODS_ID').AsString:=GOODS_ID;
      OPEN;
      NewSKU_NO:=dbTrabajo.FieldByName('SKU_NO').AsString;
      close;
      Active:=false;

      SQL.Clear;
      sql.Text:='INSERT INTO GOODS_SKU_COMBINATION (SKU_NO, GOODS_ID, MEMBER_SKU_NO, QUANTITY) '
                 +'VALUES (:SKU_NO, :GOODS_ID, :MEMBER_SKU_NO, :QUANTITY)';
      CombinaBD.First;
      for I := 0 to CombinaBD.RecordCount-1 do
        begin
         PARAMBYNAME('SKU_NO').AsString:=NewSKU_NO;
         ParamByName('GOODS_ID').AsString:=GOODS_ID;
         ParamByName('MEMBER_SKU_NO').AsString:=CombinaBD.FieldByName('MEMBER_SKU_NO').AsString;     //只允许spec的商品用有SKU_NAME.
         ParamByName('QUANTITY').AsFloat:=CombinaBD.FieldByName('QUANTITY').AsFloat;
         ExecSQL;
         CombinaBD.Next;
        end;
     end
     else
     begin
       if CombinaDS.DataSet.Modified then
       dbCombina.ApplyUpdates;
     end;

     if not (IdProv.Text='') then
        begin
       SQL.Clear;
       SQL.Text:='INSERT INTO GOODS_OFPROVEEDOR (GOODS_ID, ENA, SUCODIGO, COST, DISCOUNT, ID_PROVEEDOR ) '
        +'values (:GOODS_ID, :ENA, :SUCODIGO, :COST, :DISCOUNT, :ID_PROVEEDOR ) '
        +'ON DUPLICATE KEY UPDATE '
        +'COST=:COST, DISCOUNT=:DISCOUNT ';
        ParamByName('GOODS_ID').AsString:=GOODS_ID;
        ParamByName('ENA').AsString:=ENAEdit.Text;
        ParamByName('SUCODIGO').AsString:='';
        ParamByName('COST').AsFloat:= CDBCost.Value;
        ParamByName('DISCOUNT').AsFloat:= 0;
        ParamByName('ID_PROVEEDOR').AsString:=aProveedor[0];
        ExecSQL;

        end;

 end;
   ItemsClear();
   ENAEdit.Text:='';
   btnClonar.Enabled:=False;
   ENAEdit.SetFocus;

   Hecho:=True;

end;

procedure TFormGoodsSpu.CodingEditEnter(Sender: TObject);
begin
  if not IsNewGoods then TabSheet2.Show;
end;

procedure TFormGoodsSpu.CodingEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.DBCostKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.DBDISCOUNTKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.DBLOWPRICEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.DBPvP1cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.DBPvP2cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.DBPvP3cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.DBWHOLESALEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.Edit4Exit(Sender: TObject);
begin
  if Trim(Edit4.Text)='' then Edit4.Text:='-1';
  if button3.Visible = true then button3.SetFocus;
end;

procedure TFormGoodsSpu.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.Edit4KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in [#8, '0'..'9', '-', DecimalSeparator]) then begin
    //ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if ((Key = DecimalSeparator) or (Key = '-')) and
      (Pos(Key, Edit4.Text) > 0) then begin
    //ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end
  else if (Key = '-') and (Edit4.SelStart <> 0) then begin
    //ShowMessage('Only allowed at beginning of number: ' + Key);
    Key := #0;
  end;
end;

procedure TFormGoodsSpu.ENAEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_F2)  then begin key:=0; BitBtn21Click(self); Exit; End;
  if (key=VK_F3)  then begin key:=0;    AbirCajones();  Exit; End;
  if (key=VK_F4)  then begin key:=0; BitBtn22Click(self); Exit; End;
   if (key=VK_F5)  then begin key:=0; BitBtn2Click(self); Exit; End;    //buscar
   if (key=VK_F6)  then begin key:=0; BitBtn12Click(self); Exit; End;   //picture
   if (key=VK_F7)  then begin key:=0; BitBtn19Click(self); Exit; End;
   if (key=VK_F8)  then begin key:=0; Button8Click(self); Exit; End;
   if (key=VK_F10) and (btnClonar.Enabled) then begin key:=0; btnClonarClick(self); Exit; End;
  if key=VK_ESCAPE then close;
end;

procedure TFormGoodsSpu.FormShow(Sender: TObject);
begin
  BrandDBBox.KeyValue:= BrandDBBox.ListSource.DataSet.FieldByName(BrandDBBox.KeyField).Value;
  IvaDBLookupComboBox1.KeyValue:=IvaDBLookupComboBox1.ListSource.DataSet.FieldByName(IvaDBLookupComboBox1.KeyField).Value;
end;

procedure TFormGoodsSpu.IvaDBLookupComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.Label57Click(Sender: TObject);
begin

end;

procedure TFormGoodsSpu.Label58Click(Sender: TObject);
begin

end;

procedure TFormGoodsSpu.LowLimitExit(Sender: TObject);
begin
//  if PageControl1.Pages[0].TabVisible then DBcost.SetFocus;
//  if PricePanel.Visible=True then DBcost.SetFocus;
end;

procedure TFormGoodsSpu.LowLimitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
  //if PageControl1.Pages[0].TabVisible then DBcost.SetFocus;
end;

procedure TFormGoodsSpu.NameEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.NameEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

Function TFormGoodsSpu.GetCombinacionCost():Double;
var
  i:integer;
  C_COST:Double;
begin
  C_COST:=0;
   if IsNewGOODS then
   begin
     CombinaBD.First;
      for I := 0 to CombinaBD.RecordCount-1 do
        begin
          C_COST:=C_COST+CombinaBD.FieldByName('QUANTITY').AsFloat*CombinaBD.FieldByName('COST').AsFloat;
          CombinaBD.Next;
        end;

   end
   else
   begin
     dbCombina.First;
     for I := 0 to dbCombina.RecordCount-1 do
        begin
          C_COST:=C_COST+dbCombina.FieldByName('QUANTITY').AsFloat*dbCombina.FieldByName('COST').AsFloat;
          dbCombina.Next;
        end;
   end;
   result:=C_COST;
end;

procedure TFormGoodsSpu.Sku_NoEditExit(Sender: TObject);
var
  sku_no:string;
begin
   if Trim(Sku_NoEdit.Text)='' then exit;
 with SkuQuery do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT T1.SKU_NO, CONCAT(T2.GOODS_NAME, T1.SKU_NAME) AS ITEM_NAME, T2.ENA , T2.CODE, T1.COMMODITY_UNIT, '
    +'T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
    +'T2.CATEGORY_ID, T4.CATEGORY,  T2.BRAND_ID, T5.BRAND_NAME, T2.TAXRATE_ID, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ '
    +'FROM GOODS_SKU AS T1 '
    +'LEFT JOIN GOODS_SPU AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
    +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID '
    +'LEFT JOIN CATEGORYS AS T4 ON T4.ID = T2.CATEGORY_ID '
    +'LEFT JOIN GOODS_BRANDS AS T5 ON T5.BRAND_ID = T2.BRAND_ID '
    +'WHERE 1=1 AND ISCHILD <> 0 AND T2.ENA =:ENA ';
    ParamByName('ENA').AsString:=Trim(Sku_NoEdit.Text);
    open;
 end;
 if SkuQuery.RecordCount > 1 then
 begin
   sku_no:=FormSelectOneSKU.IniciaSelection(SkuQuery);
   if sku_no = '' then
   begin
     Sku_NoEdit.SetFocus;
     exit;
   end;
   SkuQuery.Locate('SKU_NO', sku_no, []);
 end;
 if SkuQuery.RecordCount =0 then
 BEGIN
   SkuQuery.Close;
  with SkuQuery do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT T1.SKU_NO, CONCAT(T2.GOODS_NAME, T1.SKU_NAME) AS ITEM_NAME, T2.ENA , T2.CODE, T1.COMMODITY_UNIT, '
    +'T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
    +'T2.CATEGORY_ID, T2.BRAND_ID, T2.TAXRATE_ID, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ '
    +'FROM GOODS_SKU AS T1 '
    +'LEFT JOIN GOODS_SPU AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
    +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID '
    +'WHERE 1=1 AND ISCHILD = 0 AND T2.ENA =:ENA ';
    ParamByName('ENA').AsString:=Trim(Sku_NoEdit.Text);
    open;
 end;

  IF SkuQuery.RecordCount =0 then
  BEGIN
   SHOWMESSAGE('商品不存在.');
    Sku_NoEdit.SetFocus;
    exit;
  end;
 end;

 ItemName.Text:=SkuQuery.FieldByName('ITEM_NAME').AsString;

end;

procedure TFormGoodsSpu.TypeBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.TypeBoxSelect(Sender: TObject);
begin
  if TypeBox.ItemIndex=1 then
  begin
  if not IsNewGoods then
  BEGIN
  GetCombination(SKUUUID);
  CombinaDS.DataSet:=dbCombina;
  END
  ELSE
  BEGIN
  CombinaBD.Close;
  CombinaBD.CreateDataset;
  CombinaBD.Open;
  CombinaDS.DataSet:=CombinaBD;
  END;
  CombinationPanel.Visible:=True;
  PageControl1.Visible:=False;
  CButton.Visible:=True;
  Button3.Visible:=False;
  end
  else
  begin
   CombinationPanel.Visible:=False;
  PageControl1.Visible:=True;
  CButton.Visible:=False;
  Button3.Visible:=True;
  end;
end;

procedure TFormGoodsSpu.BitBtn20Click(Sender: TObject);
begin
  FormMarca.IniciaMExcute('GOODS_BRANDS', ['CODE','BRAND_NAME'], ['CODE','BRAND_NAME']);
  BrandQuery.Refresh;
end;

procedure TFormGoodsSpu.BitBtn21Click(Sender: TObject);
begin
  if FormCategorys.IniciaCategory() then
  CategoryQuery.Refresh;
  {
  FormCategorys:=TFormCategorys.Create(self);
  FormCategorys.ShowModal;
  FormCategorys.Free;  }
end;

procedure TFormGoodsSpu.BitBtn22Click(Sender: TObject);
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

procedure TFormGoodsSpu.BitBtn19Click(Sender: TObject);
var
  Result: TStringArray;
  table:string;
begin
  table:=EMID+'PROVEEDORLIST';

  Result:=FormFindout.IniciaBusquedas(table, ['ID_PROVEEDOR','NAME_COMERCIO'], ['Código','Nombre Comercio'] );
  UProveedor.Text:=Result[1];
  IdProv.Text:=Result[0];
  aProveedor:=Result;
  if ((UProveedor.Text='-') or (UProveedor.Text='-1')) then
  begin
  UProveedor.Text:='';  // else Edit1Exit(WeigthEdit);
  IdProv.Text:='';

  end;
  UProveedor.Focused;

end;

procedure TFormGoodsSpu.BitBtn12Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
   begin
     if FileExists(OpenPictureDialog1.FileName) then
       DbImage1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
       Codingedit.Focused;
   end;
end;

procedure TFormGoodsSpu.AvisoLimitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.BitBtn2Click(Sender: TObject);
var
   Goods_Ena:string;
begin
Goods_Ena:='';
  if FormFindGoods_Spu.IniciaBusquedas(Goods_Ena) then
  begin
    ENAEdit.Text:=Goods_Ena;
    ENAEdit.SetFocus;
  end;

end;

procedure TFormGoodsSpu.BitBtn3Click(Sender: TObject);
var
   Goods_Ena:string;
begin
Goods_Ena:='';
  if FormFindGoods_Spu.IniciaBusquedas(Goods_Ena) then
  begin
    Sku_NoEdit.Text:=Goods_Ena;
    Sku_NoEdit.SetFocus;
  end;
end;

procedure TFormGoodsSpu.BrandDBBoxChange(Sender: TObject);
begin

end;

procedure TFormGoodsSpu.BrandDBBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormGoodsSpu.btnClonarClick(Sender: TObject);
var
  busqueda: string;
  formattedDateTime : string;
begin
  if ENAEdit.Text = '' then exit;

  // Procedimiento para clonar registros de artículos
  busqueda := InputBox(nMSG3,nMSG4,'');

    if not (busqueda = '') then begin
     dbClonar.Connection:=DataModule2.ZCon1;
     if dbClonar.Active=True then dbClonar.Active:=False;
     dbClonar.SQL.Clear;
     dbClonar.SQL.Text:='SELECT T1.GOODS_ID, T1.GOODS_NAME, T1.GOODS_NAME2, T1.ENA, T1.CODE, T1.CATEGORY_ID, T1.BRAND_ID, T1.TYPE, T1.UNIT, T1.TAXRATE_ID, T1.WEIGTH, T1.VOLUME, T1.IS_ACTIVE, T1.PARENT_ID, T1.CLASS_ID, '
         +'T2.COST, T2.SELLING_P1C, T2.SELLING_P2C, T2.SELLING_P3C, T2.LOWPRICE, T2.WHOLESALE, T2.DISCOUNT, T2.SKU_NO '
         +'FROM GOODS_SPU AS T1 LEFT JOIN GOODS_SKU AS T2 ON T2.GOODS_ID = T1.GOODS_ID '
         +'WHERE 1=1 AND T2.ISCHILD = 0 '
         +'AND T1.ENA=:ENA ';
     dbClonar.ParamByName('ENA').AsString:=busqueda;
     //dbClonar.SQL.Add('SELECT * FROM '+EmID+'PRODUCTLIST  WHERE 1=1 AND PRO_CDBARRA= '''+busqueda+'''');
     dbClonar.Open;

      if dbClonar.RecordCount>0 then
      begin
      NameEdit.Text:= dbClonar.FieldByName('GOODS_NAME').AsString;
      NameEdit2.Text:= dbClonar.FieldByName('GOODS_NAME2').AsString;;
      CategoryDBBox.KeyValue:= dbClonar.FieldByName('CATEGORY_ID').Value;

      if dbClonar.FieldByName('BRAND_ID').AsInteger <> 0 then
      BrandDBBox.KeyValue:= dbClonar.FieldByName('BRAND_ID').Value;
      CombinaDS.DataSet:=DBCOMBINA;
      TypeBox.ItemIndex:=dbClonar.FieldByName('TYPE').Value;
      TypeBoxSelect(self);
      Unidades.Text:=dbClonar.FieldByName('UNIT').AsString;
      IvaDBLookupComboBox1.KeyValue:= dbClonar.FieldByName('TAXRATE_ID').Value;
      WeigthEdit.Text:=dbClonar.FieldByName('Weigth').AsString;
      VolumeEdit.Text:=dbClonar.FieldByName('Volume').AsString;
      DBCost.Value:=dbClonar.FieldByName('COST').Value;
      DBPvP1c.Value:=dbClonar.FieldByName('SELLING_P1C').Value;
      DBPvP2c.Value:=dbClonar.FieldByName('SELLING_P2C').Value;
      DBPvP3c.Value:=dbClonar.FieldByName('SELLING_P3C').Value;
      DBLOWPRICE.Value:=dbClonar.FieldByName('LOWPRICE').Value;
      DBWHOLESALE.Value:=dbClonar.FieldByName('WHOLESALE').Value;
      DBDISCOUNT.Value:=dbClonar.FieldByName('DISCOUNT').Value;
      //组合面板
      CDBCost.Value:=dbClonar.FieldByName('COST').Value;
      CDBPvP1c.Value:=dbClonar.FieldByName('SELLING_P1C').Value;
      CDBPvP2c.Value:=dbClonar.FieldByName('SELLING_P3C').Value;
      CDBPvP3c.Value:=dbClonar.FieldByName('SELLING_P3C').Value;
      CDBLOWPRICE.Value:=dbClonar.FieldByName('LOWPRICE').Value;
      CDBWHOLESALE.Value:=dbClonar.FieldByName('WHOLESALE').Value;
      CDBDISCOUNT.Value:=dbClonar.FieldByName('DISCOUNT').Value;
      end;

    end;
     CodingEdit.SetFocus;
end;

procedure TFormGoodsSpu.Button10Click(Sender: TObject);
begin
  BufDatasetStudies.Close;
  HaveNewSkuItem:=False;
  SkuPanel.Align:=AlClient;
  SkuPanel.Visible:=True;
  NewSkuPanel.Visible:=False;
end;

procedure TFormGoodsSpu.Button11Click(Sender: TObject);
var
   I: integer;
begin
 if MessageDlg('提示', '更新会修改数据,将不可恢复,您确定要应用吗？', mtConfirmation,
   [mbYes, mbNo],0) = mrYes Then
   begin
 with dbTrabajo do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD) '
    +'VALUES (UUID(), :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD)'
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD ';

    DataSourceStudies.DataSet.First;
    for I := 0 to DataSourceStudies.DataSet.RecordCount-1 do
    begin
    ParamByName('SKU_NAME').AsString:=DataSourceStudies.DataSet.FieldByName('SKU_NAME').AsString;     //只允许spec的商品用有SKU_NAME.

    ParamByName('COST').AsFloat:=DataSourceStudies.DataSet.FieldByName('COST').AsFloat;
    ParamByName('SELLING_P1C').AsFloat:=DataSourceStudies.DataSet.FieldByName('SELLING_P1C').AsFloat;
    ParamByName('SELLING_P2C').AsFloat:=DataSourceStudies.DataSet.FieldByName('SELLING_P2C').AsFloat;
    ParamByName('SELLING_P3C').AsFloat:=DataSourceStudies.DataSet.FieldByName('SELLING_P3C').AsFloat;
    ParamByName('LOWPRICE').AsFloat:=DataSourceStudies.DataSet.FieldByName('LOWPRICE').AsFloat;
    ParamByName('WHOLESALE').AsCurrency:=DataSourceStudies.DataSet.FieldByName('WHOLESALE').AsFloat;
    ParamByName('DISCOUNT').AsFloat:=DataSourceStudies.DataSet.FieldByName('DISCOUNT').AsFloat;
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('SKU_CODING').AsString:=DataSourceStudies.DataSet.FieldByName('MERCHANT_CODING').AsString;
    ParamByName('ISCHILD').AsInteger:=1;
    ExecSQL;
    DataSourceStudies.DataSet.Next;
    end;
    showmessage('更新完毕');
    DataSourceStudies.DataSet.Close;

    HaveNewSkuItem:=False;
    SKUListQuery.Refresh;
    //NewSkuPanel.Align:=AlClient;
    SkuPanel.Align:=AlClient;
    SkuPanel.Visible:=True;
    NewSkuPanel.Visible:=False;
    end;
 end;
end;

procedure TFormGoodsSpu.Button12Click(Sender: TObject);
begin
 { if dbgrid2.SelectedRows.Count <= 0 Then
begin
Application.MessageBox('提示','请选择您要删除的记录',MB_OK);
Exit;
end; }
//If Application.MessageBox(Handle,,,mb_iconinformation+mb_YesNo)=IdYes Then
if MessageDlg('提示', '删除后数据将不可恢复，您确定要删除吗？', mtConfirmation,
   [mbYes, mbNo],0) = mrYes Then
   begin
     SKUListQuery.Delete;
   end;
end;

procedure TFormGoodsSpu.Button13Click(Sender: TObject);
begin
  CombinaDS.DataSet.Delete;
end;


function TFormGoodsSpu.Get36UUID():string;
var
  sGUID: string;
begin
Get36UUID:='';
   sGUID:=CreateUUID();
   Delete(sGUID, 1, 1);
  Delete(sGUID, Length(sGUID), 1);  // 去掉大括号的Guid，占36位中间有减号
  Get36UUID:=sGUID;
end;
procedure TFormGoodsSpu.ENAEditExit(Sender: TObject);
begin
if Trim(ENAEdit.Text)='' then exit;

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
  DateMod.Text:=  DBGoodsQuery.FieldByName('UPDATED_AT').AsString;
  CategoryDBBox.KeyValue:= DBGoodsQuery.FieldByName('CATEGORY_ID').Value;

  if DBGoodsQuery.FieldByName('BRAND_ID').AsInteger <> 0 then
  BrandDBBox.KeyValue:= DBGoodsQuery.FieldByName('BRAND_ID').Value;
  //CombinaDS.DataSet:=DBCOMBINA;
  TypeBox.ItemIndex:=DBGoodsQuery.FieldByName('TYPE').Value;
  TypeBoxSelect(self);
  Unidades.Text:=DBGoodsQuery.FieldByName('UNIT').AsString;
  IvaDBLookupComboBox1.KeyValue:= DBGoodsQuery.FieldByName('TAXRATE_ID').Value;
  WeigthEdit.Text:=DBGoodsQuery.FieldByName('Weigth').AsString;
  VolumeEdit.Text:=DBGoodsQuery.FieldByName('Volume').AsString;
  AvisoLimit.ItemIndex:=DBGoodsQuery.FieldByName('STOCKAVISO').AsInteger;
  LOWLIMIT.Value:=DBGoodsQuery.FieldByName('LOWLIMIT').Value;
  CanDiscount.ItemIndex:=DBGoodsQuery.FieldByName('CAN_DISCount').AsInteger;
  Edit4.Text:=formatfloat('#,##0.00',  DBGoodsQuery.FieldByName('Points').AsFloat);
  DBCost.Value:=DBGoodsQuery.FieldByName('COST').Value;
  DBPvP1c.Value:=DBGoodsQuery.FieldByName('SELLING_P1C').Value;
  DBPvP2c.Value:=DBGoodsQuery.FieldByName('SELLING_P2C').Value;
  DBPvP3c.Value:=DBGoodsQuery.FieldByName('SELLING_P3C').Value;
  DBLOWPRICE.Value:=DBGoodsQuery.FieldByName('LOWPRICE').Value;
  DBWHOLESALE.Value:=DBGoodsQuery.FieldByName('WHOLESALE').Value;
  DBDISCOUNT.Value:=DBGoodsQuery.FieldByName('DISCOUNT').Value;
  //组合面板
  CDBCost.Value:=DBGoodsQuery.FieldByName('COST').Value;
  CDBPvP1c.Value:=DBGoodsQuery.FieldByName('SELLING_P1C').Value;
  CDBPvP2c.Value:=DBGoodsQuery.FieldByName('SELLING_P3C').Value;
  CDBPvP3c.Value:=DBGoodsQuery.FieldByName('SELLING_P3C').Value;
  CDBLOWPRICE.Value:=DBGoodsQuery.FieldByName('LOWPRICE').Value;
  CDBWHOLESALE.Value:=DBGoodsQuery.FieldByName('WHOLESALE').Value;
  CDBDISCOUNT.Value:=DBGoodsQuery.FieldByName('DISCOUNT').Value;
  ;

  if  GetGoodsSKUitems(GOODS_ID) then
  begin
     SkuPanel.Align:=AlClient;
     SkuPanel.Visible:=True;
    NewSkuPanel.Visible:=False;
    PricePanel.Visible:=False;
  end
  else
  begin
  SkuPanel.Visible:=False;
  NewSkuPanel.Visible:=False;
  PricePanel.Parent:=TabSheet2;
  PricePanel.Align:=alClient;
  PricePanel.Visible:=True;
  end;

  IsNewGoods:=False;
  PageControl1.Pages[0].TabVisible:=False;
  TabSheet1.Visible:=False;
end
else
begin
  GOODS_ID:=Get36UUID();
  UUIDEdit.Text:=GOODS_ID;
  IsNewGoods:=True;
  btnClonar.Enabled:=True;
  PricePanel.Parent:=TabSheet1;
  PricePanel.Align:=alClient;
  PricePanel.Visible:=True;
  //TabSheet1.Visible:=True;
  CodingEdit.Text:=RightStr(ENAEdit.Text, 6);
  PageControl1.Pages[0].TabVisible:=True;
  TabSheet1.Visible:=True;
  NewSkuPanel.Align:=AlClient;
  NewSkuPanel.Visible:=True;
  //NewSkuPanel.Alignment:=AlClient;
  SkuPanel.Visible:=False;
end;
end;

function TFormGoodsSpu.ExistGoods(CDBarra: string):boolean;
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
       +'T1.PARENT_ID, T1.CLASS_ID, T1.STOCKAVISO, T1.LOWLIMIT, T1.CAN_DISCount, T.UPDATED_AT, '
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


Function TFormGoodsSpu.GetGoodsSKUitems(aGOODS_ID:STRING):Boolean;
 begin
    with SKUListQuery do
     begin
        Connection:=DataModule2.ZCon1;
        Active:=false;
        SQL.Clear;
       SQL.TEXT:='SELECT * FROM GOODS_SKU '
       +'WHERE 1=1 AND ISCHILD<>0 AND  GOODS_ID=:GOODS_ID ';
        ParamByName('GOODS_ID').AsString:=aGOODS_ID;
        OPEN;
     end;
     if SKUListQuery.RecordCount <>0 then
     RESULT := TRUE
     ELSE RESULT := FALSE;
 end;

procedure TFormGoodsSpu.GetCombination(aSKU_NO:STRING);
begin

    with dbCombina do
     begin
        Connection:=DataModule2.ZCon1;
        Active:=false;
        SQL.Clear;
       SQL.TEXT:='SELECT CONCAT(T3.GOODS_NAME, T2.SKU_NAME) AS ITEM_NAME, T2.COST, T2.SELLING_P1C, T1.QUANTITY, T2.COMMODITY_UNIT, T1.MEMBER_SKU_NO '
       +'FROM GOODS_SKU_COMBINATION as T1 LEFT JOIN goods_sku AS T2 ON T1.MEMBER_SKU_NO = T2.SKU_NO '
       +'LEFT JOIN goods_spu AS T3 ON T3.GOODS_ID = T2.GOODS_ID '
       +'WHERE 1=1 AND T2.ISCHILD = 0 AND T1.SKU_NO=:SKU_NO ';
        ParamByName('SKU_NO').AsString:=aSKU_NO;
        OPEN;
     end;

end;

procedure TFormGoodsSpu.FormCreate(Sender: TObject);
begin
DateMod.Text:=DateTimeToStr(Now);
Memo2.Lines.Clear;
memo2.Lines.Add(nMsg1);
memo2.Lines.Add('');
Memo2.Lines.Add(nFun0);
Memo2.Lines.Add(nFun1);
Memo2.Lines.Add(nFun2);
Memo2.Lines.Add(nFun3);
Memo2.Lines.Add(nFun4);
Memo2.Lines.Add(nFun5);
Memo2.Lines.Add(nFun6);
DoGetTaxRates;
GetCategorys();
GetBrand();
GetClasse();
PricePanel.Parent:=TabSheet1;
  PricePanel.Align:=alClient;
  PricePanel.Visible:=True;
  CombinationPanel.Visible:=False;
end;

procedure TFormGoodsSpu.Button2Click(Sender: TObject);
var
 Category_id:integer;
 Data:TStringArray;
 Json:String;
 I, Len:integer;
 str, str2, str3:string;
 //COST, SELLING_P1C, SELLING_P2C, SELLING_P3C:string;

 // Root:TJSONObject;
 // LJSON: TJSONArray;
 //jo: Variant;
 //Parser:TJSONParser;
 // Arr:TJSONArray;

  JsonData: TJSONData;
  Study: TJSONEnum;

begin
  if TRim(ENAEdit.Text)='' then exit;
   str:=TRim(ENAEdit.Text);
  Category_id:=CategoryDBBox.KeyValue;
  Data:=FormSelectSpec.IniciarSelect(Category_id, GOODS_ID);
  Len:=Length(Data);

  if Len<=0 then exit;
   BufDatasetStudies.Close;
    BufDatasetStudies.CreateDataset;
    try
      BufDatasetStudies.Open;
      BufDatasetStudies.DisableControls;

  Json:='[';
  for I := Low(Data) to High(Data) do
    begin
    str2:=Format('%.*d',[3, I+1]);
      if I=Len-1 then
      begin
      Json:=Json+'{"GOODS_ID":"'+GOODS_ID+'","SKU_NAME":{'+Data[I]+'},"COST":'+Floattostr(DBCost.Value)+', "SELLING_P1C":'+ Floattostr(DBPvP1c.Value)
      +', "SELLING_P2C":'+ Floattostr(DBPvP2c.Value)+', "SELLING_P3C":'+ Floattostr(DBPvP3c.Value)+', "LOWPRICE":'+ Floattostr(DBLOWPRICE.Value)
      +', "WHOLESALE":'+ Floattostr(DBWHOLESALE.Value)+', "DISCOUNT":'+ Floattostr(DBDISCOUNT.Value)+', "STOCK": 0, "MERCHANT_CODING":"'+str+Str2+'"}'
      end
      else
      Json:=Json+'{"GOODS_ID":"'+GOODS_ID+'","SKU_NAME":{'+Data[I]+'},"COST":'+ Floattostr(DBCost.Value)+', "SELLING_P1C":'+ Floattostr(DBPvP1c.Value)
      +', "SELLING_P2C":'+ Floattostr(DBPvP2c.Value)+', "SELLING_P3C":'+ Floattostr(DBPvP3c.Value)
      +', "LOWPRICE":'+ Floattostr(DBLOWPRICE.Value)+', "WHOLESALE":'+ Floattostr(DBWHOLESALE.Value)+', "DISCOUNT":'+ Floattostr(DBDISCOUNT.Value)+', "STOCK": 0, "MERCHANT_CODING":"'+str+Str2+'"}, ';

       {jo.GOODS_ID:=GOODS_ID;
       jo.SKU_NAME:= Data[I];
       jo.COST:=DBCost.Value;
       jo.SELLING_P1C:=DBPvP1c.Value;
       jo.SELLING_P2C:=DBPvP2c.Value;
       jo.SELLING_P3C:=DBPvP3c.Value;
       jo.STOCK:=0;
       jo.MERCHANT_CODING:=str+Str2;    }

       with BufDatasetStudies do
        begin
          Insert;
          BfGOODS_ID.AsString := GOODS_ID;
          BfSKU_NAME.AsString := '{'+Data[I]+'}';
          BfCOST.AsCurrency := DBCost.Value;
          BfSELLING_P1C.AsFloat:=DBPvP1c.Value;
          BfSELLING_P2C.AsFloat:=DBPvP2c.Value;
          BfSELLING_P3C.AsFloat:=DBPvP3c.Value;
          BfLOWPRICE.AsFloat:=DBLOWPRICE.Value;
          BfWHOLESALE.AsFloat:=DBWHOLESALE.Value;
          BfDISCOUNT.AsFloat:=DBDISCOUNT.Value;
          BfSTOCK.AsFloat:=0;
          BfMERCHANT_CODING.AsString:=str+Str2;
          Post;
        end;


    end;
  Json:=Json+']';
    DataSourceStudies.DataSet:= BufDatasetStudies;
    finally
      BufDatasetStudies.EnableControls;
      //free
     // JsonData.FreeInstance;
    end;


 //  Parser:=TJSONParser.Create(Json);
 // Arr := Parser.Parse as TJSONArray;

  {
  JsonData:= GetJSON(Json);


    BufDatasetStudies.Close;
    BufDatasetStudies.CreateDataset;
    try
      BufDatasetStudies.Open;
      BufDatasetStudies.DisableControls;

      for Study in JsonData do
      begin
        with BufDatasetStudies do
        begin
          Insert;
          BfGOODS_ID.AsString := Study.Value.Items[0].Value;
          BfSKU_NAME.AsString := Study.Value.Items[1].AsJSON; //;
          showmessage(Study.Value.Items[1].AsJSON);
          BfCOST.AsCurrency := Study.Value.Items[2].Value;
          BfSELLING_P1C.AsFloat:=Study.Value.Items[3].Value;
          BfSELLING_P2C.AsFloat:=Study.Value.Items[4].Value;
          BfSELLING_P3C.AsFloat:=Study.Value.Items[5].Value;
          BfLOWPRICE.AsFloat:=Study.Value.Items[6].Value;
          BfWHOLESALE.AsFloat:=Study.Value.Items[7].Value;
          BfDISCOUNT.AsFloat:=Study.Value.Items[8].Value;
          BfSTOCK.AsFloat:=Study.Value.Items[9].Value;
          BfMERCHANT_CODING.AsString:=Study.Value.Items[10].Value;
          Post;
        end;
      end;
      DataSourceStudies.DataSet:= BufDatasetStudies;
    finally
      BufDatasetStudies.EnableControls;
      //free
      JsonData.FreeInstance;
    end;
    }
 // JsonToDataSet( JSON,TempListDS.DataSet);

 // json:='{"data":'+json+'}';
  //memo1.Lines.Add(json);
  //showmessage(json);
 // TempListDS.DataSet := JSONToClientDataSet(self,JSON); //else
   //   ds1.DataSet := JSONToDataSet(self,fJSON,
  // TempListDS.DataSet := JSONToDataSet(self,JSON, // demo client-side column definition
  //      [sftUTF8Text,sftUTF8Text, sftCurrency, sftCurrency, sftCurrency, sftCurrency, sftCurrency,sftFloat, sftUTF8Text]);       //[sftInteger,sftUTF8Text,sftUTF8Text,sftBlob,sftInteger,sftInteger]
  //JsonToDataSet(ClientDataSet1,json);

  HaveNewSkuItem:=True;
  NewSkuPanel.Align:=AlClient;
  SkuPanel.Visible:=False;
  NewSkuPanel.Visible:=True;

end;

procedure TFormGoodsSpu.AbirCajones();
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

end.

