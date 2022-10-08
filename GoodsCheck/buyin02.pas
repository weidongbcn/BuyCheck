unit buyin02;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids, ZDataset, ZSqlUpdate, rxcurredit, LCLType, Buttons, DBCtrls,  math, fpjson, jsonparser,
  ComCtrls, connect, frxClass, frxBarcode, frxDBSet, db, BufDataset, Global, Grids;

type

  { TFormBuyIn02 }

  TFormBuyIn02 = class(TForm)
    AvisoLimit: TComboBox;
    BfCOST: TCurrencyField;
    BfDISCOUNT: TFloatField;
    BfGOODS_ID: TStringField;
    BitBtn2: TBitBtn;
    BufDatasetLabelsGOODS_ID: TStringField;
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
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    BrandDBBox: TDBLookupComboBox;
    BrandDS: TDataSource;
    BrandQuery: TZQuery;
    BufDatasetLabels: TBufDataset;
    BufDatasetLabelsBRAND_NAME: TStringField;
    BufDatasetLabelsENA: TStringField;
    BufDatasetLabelsFECHA_FABRICA: TStringField;
    BufDatasetLabelsGOODS_NAME: TStringField;
    BufDatasetLabelsPVP: TCurrencyField;
    BufDatasetLabelsSCALAR: TStringField;
    BufDatasetLabelsSKU_NO: TStringField;
    BufDatasetLabelsUNIT: TStringField;
    BufDatasetStudies: TBufDataset;
    Button1: TButton;
    Button13: TButton;
    Button14: TButton;
    Button8: TButton;
    Button9: TButton;
    DataSourceLabels: TDataSource;
    eSTOCK: TCurrencyEdit;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    GetStock: TZQuery;
    dbUuid: TZQuery;
    Label69: TLabel;
    SAVE2: TButton;
    Cantidad: TCurrencyEdit;
    Amount: TCurrencyEdit;
    CategoryDS: TDataSource;
    CategoryQuery: TZQuery;
    CButton: TButton;
    CDBCost: TCurrencyEdit;
    CDBDISCOUNT: TCurrencyEdit;
    CDBLOWPRICE: TCurrencyEdit;
    CDBPvP1c: TCurrencyEdit;
    CDBPvP2c: TCurrencyEdit;
    CDBPvP3c: TCurrencyEdit;
    CDBWHOLESALE: TCurrencyEdit;
    ClasseQuery: TZQuery;
    CombinaBD: TBufDataset;
    CombinaBDCOMMODITY_UNIT: TStringField;
    CombinaBDCOST: TFloatField;
    CombinaBDITEM_NAME: TStringField;
    CombinaBDMEMBER_SKU_NO: TStringField;
    CombinaBDQUANTITY: TFloatField;
    CombinaBDSELLING_P1C: TFloatField;
    CombinaDS: TDataSource;
    CombinaQuery: TZQuery;
    CombinationPanel: TPanel;
    DataSourceStudies: TDataSource;
    dbCombina: TZQuery;
    DBCost: TCurrencyEdit;
    DBDISCOUNT: TCurrencyEdit;
    DBGoodsQuery: TZQuery;
    DBGrid4: TDBGrid;
    DBLOWPRICE: TCurrencyEdit;
    DBPvP1c: TCurrencyEdit;
    DBPvP2c: TCurrencyEdit;
    DBPvP3c: TCurrencyEdit;
    dbTrabajo: TZQuery;
    DBWHOLESALE: TCurrencyEdit;
    Descuento: TCurrencyEdit;
    Edit4: TEdit;
    imaPrior: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    imaNext: TButton;
    ImaAdd: TButton;
    BuyDetallesDS: TDataSource;
    CanDiscount: TComboBox;
    CategoryDBBox: TDBLookupComboBox;
    CodingEdit: TEdit;
    DateMod: TEdit;
    DBEdit0: TDBEdit;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBImage1: TDBImage;
    dbTest: TZQuery;
    ENAEdit: TEdit;
    IdProv: TEdit;
    Importe: TCurrencyEdit;
    ItemName: TEdit;
    IvaDBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
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
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label7: TLabel;
    LowLimit: TCurrencyEdit;
    MaxDesc1: TCurrencyEdit;
    MaxDesc2: TCurrencyEdit;
    NameEdit: TEdit;
    NameEdit2: TEdit;
    NewSkuPanel: TPanel;
    PageControl1: TPageControl;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PanelB: TPanel;
    Precio: TCurrencyEdit;
    PVP1C: TCurrencyEdit;
    SKUListDS: TDataSource;
    SKUListQuery: TZQuery;
    SkuPanel: TPanel;
    SkuQuery: TZQuery;
    Sku_NoEdit: TEdit;
    SpecQuery: TZQuery;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TaxRateDS: TDataSource;
    TaxRateZQuery: TZQuery;
    TempListDS: TDataSource;
    TotalQuery: TZQuery;
    DataSource2: TDataSource;
    NewButton: TButton;
    Label10: TLabel;
    Total: TCurrencyEdit;
    DBGrid1: TDBGrid;
    Id: TEdit;
    N_Proveedor: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BuyDetalles: TZQuery;
    Articulo: TZQuery;
    BuyTop: TZQuery;
    BuyHelp: TZQuery;
    TypeBox: TComboBox;
    Unidades: TEdit;
    UProveedor: TEdit;
    UUIDEdit: TEdit;
    VolumeEdit: TEdit;
    WeigthEdit: TEdit;
    procedure AvisoLimitKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn5KeyPress(Sender: TObject; var Key: char);
    procedure BrandDBBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button14Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure DBCostChange(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBPvP1cChange(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure PVP1CChange(Sender: TObject);
    procedure SAVE2Click(Sender: TObject);
    procedure BuyDetallesAfterPost(DataSet: TDataSet);
    procedure CanDiscountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AmountExit(Sender: TObject);
    procedure AmountKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure CategoryDBBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CButtonClick(Sender: TObject);
    procedure CodingEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DateAddKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DateModKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBCostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBDISCOUNTKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
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
    procedure DescuentoExit(Sender: TObject);
    procedure DescuentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);


    procedure ENAEditExit(Sender: TObject);
    procedure ENAEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure ImporteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure IvaDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LowLimitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure NameEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NameEditExit(Sender: TObject);
    procedure NameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure NewButtonClick(Sender: TObject);

    Function ExistGoods(CDBarra: string):boolean;
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
    procedure TypeBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure TypeBoxSelect(Sender: TObject);
    procedure UnidadesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure UProveedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VolumeEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WeigthEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    PROCEDURE GetCategorys();
    Procedure GetBrand();
    Procedure GetClasse();
    procedure ItemsClear();
    procedure DoGetTaxRates;
    Function GetGoodsSKUitems(aGOODS_ID:STRING):Boolean;
     function GetCategorySpec(Category_id: integer):boolean;
     procedure GetCombination(aSKU_NO:STRING);
     Function GetCombinacionCost():Double;
     function CreateUUID():string;
    function Get36UUID():string;
    function GetStocks(aGOODS_ID:STRING):Double;
      //function ExistGoods(CDBarra: string):boolean;

  private
     FFlag:boolean;
  public

  end;

var
  FormBuyIn02: TFormBuyIn02;
  NewDoc:Boolean;
  ANewBUYDOC:TDocCompStruct;
  aBUYDoc:TBuyDocStruct;

implementation
uses
  addgoods, BuyInput, BuyInColgada, goodslist, PayofBuy, select_onesku, Select_SKU,
  Spec_Select, Goods_Marca, U_FindGoods_Spu, findout, Categorys_Spec, SimpleAdd;

{$R *.lfm}

{ TFormBuyIn02 }

function TFormBuyIn02.GetStocks(aGOODS_ID:STRING) :Double;
 var
   STOCK:Double;
begin
STOCK:= 0.00;
   with GetStock do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT SUM(AMOUNT) as AMOUNT FROM STOCKGOODS WHERE 1=1 AND  GOODS_STATUS=1 AND GOODS_ID =:GOODS_ID ';
    ParamByName('GOODS_ID').AsString:=aGOODS_ID;
    open;
 end;
   if GetStock.RecordCount>0 then
   STOCK:=GetStock.FieldByName('AMOUNT').AsFloat;
   GetStock.Close;
   result:= STOCK;
end;

Procedure TFormBuyIn02.GetBrand();
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

  Procedure TFormBuyIn02.GetClasse();
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

  function TFormBuyIn02.CreateUUID():string;
  begin
  CreateUUID:='';
    UResult := CreateGuid(Uid);
  if UResult = S_OK then
     CreateUUID:=(GuidToString(Uid));
  end;

  function TFormBuyIn02.Get36UUID(): string;
  var
  sGUID: string;
begin
Get36UUID:='';
   sGUID:=CreateUUID();
   Delete(sGUID, 1, 1);
  Delete(sGUID, Length(sGUID), 1);  // 去掉大括号的Guid，占36位中间有减号
  Get36UUID:=sGUID;

  end;

  procedure TFormBuyIn02.ItemsClear();
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
  eSTOCK.Value:=0;
  PageControl1.Pages[0].TabVisible:=True;
  PageControl1.Pages[0].Show;
  CombinationPanel.Visible:=False;
  dbCombina.Close;
  CombinaBD.Close;
end;

  procedure TFormBuyIn02.DoGetTaxRates;
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

  Function TFormBuyIn02.GetCombinacionCost():Double;
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

procedure TFormBuyIn02.ClearInputEdit();
begin
 // Edit2.Text:='';
  Amount.Clear;
  Precio.Clear;
  Descuento.Clear;
  Importe.Clear;
  PVP1C.Clear;
end;
procedure TFormBuyIn02.ClearAll();
begin
  ENAEdit.Text:='';
  ClearInputEdit();
  Id.Clear;
  N_Proveedor.Clear;
  ANewBUYDOC.ID_BUY:='';
  ANewBUYDOC.DOCUMENT:='';
  ANewBUYDOC.NAME_PROVEEDOR:='';
  ANewBUYDOC.ID_PROVEEDOR:='';
  ANewBUYDOC.SERIE:='';
end;

procedure TFormBuyIn02.CalImporte();
begin
  Importe.Value:=Amount.Value * Precio.Value * (1-Descuento.Value/100);
end;

procedure TFormBuyIn02.GetTotal;
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

procedure TFormBuyIn02.PVP1CKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.TypeBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.TypeBoxSelect(Sender: TObject);
begin
  if TypeBox.ItemIndex=2 then
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
 // CombinationPanel.Visible:=True;
 // PageControl1.Visible:=False;
  PageControl1.Pages[1].TabVisible:=True;
  TabSheet7.Visible:=True;
  CButton.Visible:=True;
  Button3.Visible:=False;
  end
  else
  begin
   //CombinationPanel.Visible:=False;
  //PageControl1.Visible:=True;
  PageControl1.Pages[1].TabVisible:=False;
  TabSheet7.Visible:=False;
  CButton.Visible:=False;
  Button3.Visible:=True;
  end;
end;

procedure TFormBuyIn02.UnidadesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.UProveedorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.VolumeEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.WeigthEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.GetCategorys();
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

{
Function TFormBuyIn02.ExistGoods(CDBarra: string):Boolean;
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

 }

procedure TFormBuyIn02.FormCreate(Sender: TObject);
begin
  DateMod.Text:=DateTimeToStr(Now);
  NewDoc:=False;
  FFlag:=True;
  DoGetTaxRates;
GetCategorys();
GetBrand();
GetClasse();

PageControl1.Pages[1].TabVisible:=False;
 TabSheet7.Visible:=False;

 // CombinationPanel.Visible:=False;
end;

procedure TFormBuyIn02.GetBuyDetalles;
begin
  with BuyDetalles do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    SQL.TEXT:='SELECT T1.B_UUID, T1.GOODS_ID, T1.SKU_NO, T2.ENA, T2.GOODS_NAME, CONCAT( T2.WEIGTH,'' '', T2.VOLUME) AS SCALAR, T5.BRAND_NAME, T1.QUANTITY, T1.COMMODITY_UNIT, T1.COST, T1.DISCOUNT, T3.IVA, '
            +'T1.QUANTITY*T1.COST*(1-T1.DISCOUNT/100) AS LINEATOTAL, ifnull(T4.SELLING_P1C, 0) as SELLING_P1C  '
            +'FROM BUY_ITEMS as T1 '
            +'LEFT JOIN goods_spu AS T2 ON T1.GOODS_ID = T2.GOODS_ID  '
            +'LEFT JOIN goods_taxrate AS T3 ON T2.taxrate_id = T3.ID '
            +'LEFT JOIN goods_sku AS T4 ON T4.SKU_NO = T1.SKU_NO '
            +'LEFT JOIN goods_brands AS T5 ON T5.BRAND_ID = T2.BRAND_ID '
     +'WHERE 1=1 '
     +'AND T1.B_UUID=:B_UUID order by T1.id ';
     ParamByName('B_UUID').AsString:=ABUYDOC.B_UUID;
    open;

    end;
  BuyDetalles.Last;

end;

procedure TFormBuyIn02.PrecioExit(Sender: TObject);
begin
  CalImporte();
end;

procedure TFormBuyIn02.PrecioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.PreparaTmp();
begin

    ///
end;



procedure TFormBuyIn02.NewButtonClick(Sender: TObject);
begin
  ABUYDOC:=FormBuy.IniciaNewBuy();
  if ABUYDOC.B_UUID = '' then begin EnaEdit.Text:=''; EnaEdit.SetFocus; Exit; End;
  ID.Text:=ABUYDOC.B_UUID;
  N_Proveedor.Text:=ABUYDOC.NAME_PROVEEDOR;
  GetBuyDetalles;
  GetTotal;

  EnaEdit.SetFocus;
end;

procedure TFormBuyIn02.Button2Click(Sender: TObject);
begin

  ABUYDOC:=FormColgada.GetOldBuyList();
   if ABUYDOC.B_UUID = '' then begin EnaEdit.Text:=''; EnaEdit.SetFocus; Exit; End;
  ID.Text:=ABUYDOC.B_UUID;;
  N_Proveedor.Text:=ABUYDOC.NAME_PROVEEDOR;
  GetBuyDetalles;
  GetTotal;
 // EnaEdit.SetFocus;

end;

procedure TFormBuyIn02.Button3Click(Sender: TObject);
var
  resultado:boolean;
begin
  if ABUYDOC.B_UUID = '' then
    begin
      EnaEdit.SetFocus;
      exit;
    end;

  resultado:=FormBuyPay.FinalBuy(ABUYDOC);
  if resultado then
    begin
    BuyTop.Close;
    BuyDetalles.Close;
    ClearAll();
  end;
  EnaEdit.SetFocus;
end;

procedure TFormBuyIn02.Button6Click(Sender: TObject);
var
 Category_id:integer;
 Data:TStringArray;
 Json:String;
 I, Len:integer;
 str, str2, str3:string;
  JsonData: TJSONData;
  Study: TJSONEnum;

begin
  if TRim(ENAEdit.Text)='' then exit;
  if TRIM(NameEdit.text) = '' then exit;
  if CategoryDBBox.KeyValue=null then
  begin
    CategoryDBBox.SetFocus;
  Exit;
  end;
  if IvaDBLookupComboBox1.KeyValue=null then
  begin
    IvaDBLookupComboBox1.SetFocus;
  Exit;
  end;
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
    end;

  HaveNewSkuItem:=True;
  NewSkuPanel.Align:=AlClient;
  SkuPanel.Visible:=False;
  NewSkuPanel.Visible:=True;

end;

procedure TFormBuyIn02.Button9Click(Sender: TObject);
var
  i,j,k :integer;
begin
if BuyDetalles.RecordCount <=0 then exit;

BufDatasetLabels.Close;
BufDatasetLabels.CreateDataset;
BufDatasetLabels.Open;
BufDatasetLabels.DisableControls;
k:= ceil( BuyDetalles.FieldByName('QUANTITY').AsFloat);
for J := 0 to k-1 do
begin
with BufDatasetLabels do
       begin
append;
BufDatasetLabelsSKU_NO.AsString:= BuyDetalles.FieldByName('SKU_NO').AsString;
BufDatasetLabelsGOODS_ID.AsString := BuyDetalles.FieldByName('GOODS_ID').AsString;
BufDatasetLabelsENA.AsString:= BuyDetalles.FieldByName('ENA').AsString;
BufDatasetLabelsGOODS_NAME.AsString := BuyDetalles.FieldByName('GOODS_NAME').AsString;
BufDatasetLabelsBRAND_NAME.AsString := BuyDetalles.FieldByName('BRAND_NAME').AsString;
BufDatasetLabelsSCALAR.AsString:= BuyDetalles.FieldByName('SCALAR').AsString;
BufDatasetLabelsUNIT.AsString := BuyDetalles.FieldByName('COMMODITY_UNIT').AsString;
BufDatasetLabelsFECHA_FABRICA.AsString := '';
BufDatasetLabelsPVP.AsFloat := BuyDetalles.FieldByName('SELLING_P1C').AsFloat;
       end;
end;
BufDatasetLabels.EnableControls;

frxReport1.Clear;
frxReport1.LoadFromFile(ReportPath+'EtiquetaSabateria40x25.fr3');

//frxReport1.DesignReport();
  frxReport1.PrepareReport();
  if PCCONFIG.LABELPRINTNAME <> '' then
    begin
  frxReport1.PrintOptions.Printer := PCCONFIG.LABELPRINTNAME; //选择打印机名称
  end
  else frxReport1.PrintOptions.ShowDialog := True; //显示打印机选择框

 // frxReport1.PrepareReport();
 // frxReport1.ShowPreparedReport;
  frxReport1.Print;

 //  BufDatasetLabels.Clear;
//   BufDatasetLabels.Close;

end;

procedure TFormBuyIn02.DBCostChange(Sender: TObject);
begin
  Precio.Value:=DBCost.Value;
end;

procedure TFormBuyIn02.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

end;

procedure TFormBuyIn02.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
begin
    with Sender as TDBGrid do begin
if DBGrid1.DataSource.DataSet.RecNo mod 2 = 1 then
  begin
    DBGrid1.Canvas.Brush.Color := clwindow;

  end
  else
  begin
    DBGrid1.Canvas.Brush.Color := clSilver;
  end;

  if ([gdSelected] * AState <> []) then
  begin
    DBGrid1.Canvas.Brush.color := clBlack; //当前行以黑色显示
    DBGrid1.Canvas.pen.mode := pmmask;
  end;  {

   if ([gdSelected, gdFocused] * AState <> []) and (DBGrid1.SelectedColumn = Column) then
  begin
    DBGrid1.Canvas.Brush.Color := clRed;
    DBGrid1.Canvas.Font.Color := clWhite;
  end;
  }
end;
end;

procedure TFormBuyIn02.DBPvP1cChange(Sender: TObject);
begin
  PVP1C.Value:=DBPvP1c.Value;
end;

procedure TFormBuyIn02.Edit4Exit(Sender: TObject);
begin
  if TypeBox.ItemIndex=2 then
  begin
  //PageControl1.Pages[1].TabVisible:=True;
  PageControl1.Pages[1].Show;
  end;
end;

procedure TFormBuyIn02.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.FormShow(Sender: TObject);
begin
  CategoryDBBox.KeyValue:= CategoryDBBox.ListSource.DataSet.FieldByName(CategoryDBBox.KeyField).Value;
BrandDBBox.KeyValue:= BrandDBBox.ListSource.DataSet.FieldByName(BrandDBBox.KeyField).Value;
IvaDBLookupComboBox1.KeyValue:=IvaDBLookupComboBox1.ListSource.DataSet.FieldByName(IvaDBLookupComboBox1.KeyField).Value;
  ENAEdit.SetFocus;
end;

procedure TFormBuyIn02.PVP1CChange(Sender: TObject);
begin
  if DBPvP1c.Value= 0 then  DBPvP1c.Value:=PVP1C.Value;
  if IsNewGoods then
  begin
    DBPvP1c.Value:=PVP1C.Value;
    DBPvP2c.Value:=PVP1C.Value;
  end;
end;

procedure TFormBuyIn02.SAVE2Click(Sender: TObject);
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
        +'VALUES (:SKU_NO, :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points )'
        +'ON DUPLICATE KEY UPDATE '
        +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD, '
        +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
           ParamByName('SKU_NO').AsString:=dbUuid.FieldByName('UUID').AsString;
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

           Active:=False;
    sql.Clear;
    sql.Text:='INSERT INTO STOCKGOODS (ID_STOCK, GOODS_ID, SKU_NO, AMOUNT, GOODS_STATUS) '
    +'VALUES (:ID_STOCK, :GOODS_ID, :SKU_NO, 0, :GOODS_STATUS) '
    +'ON DUPLICATE KEY UPDATE '
    +'UPDATED_AT=NOW() ';
    ParamByName('ID_STOCK').AsString:=aBUYDoc.ID_STOCK;
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('SKU_NO').AsString:=dbUuid.FieldByName('UUID').AsString;
   // ParamByName('AMOUNT').AsFloat:= Amount.Value;
    ParamByName('GOODS_STATUS').AsInteger:= 0;
    ExecSQL;

     {       Active:=False;
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
    }
          end;
    end;
 end;
   //ItemsClear();
   Hecho:=True;
  // btnClonar.Enabled:=False;
  // if FFlag = true then Close else


end;

procedure TFormBuyIn02.BuyDetallesAfterPost(DataSet: TDataSet);
begin
  Buydetalles.RefreshCurrentRow(false);
end;

procedure TFormBuyIn02.CanDiscountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.AmountExit(Sender: TObject);
begin
  CalImporte();
end;

procedure TFormBuyIn02.AmountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.CategoryDBBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.CButtonClick(Sender: TObject);
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
    +'VALUES (:SKU_NO, :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points)'
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD '
    +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
    ParamByName('SKU_NO').AsString:=dbUuid.FieldByName('UUID').AsString;
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
     { SQL.Clear;
      sql.Text:='SELECT SKU_NO FROM GOODS_SKU WHERE 1=1 AND ISCHILD=0 AND GOODS_ID=:GOODS_ID ';
      ParamByName('GOODS_ID').AsString:=GOODS_ID;
      OPEN;
      NewSKU_NO:=dbTrabajo.FieldByName('SKU_NO').AsString;
      close;
      Active:=false; }
      NewSKU_NO:=dbUuid.FieldByName('UUID').AsString;

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
   //ItemsClear();
   //ENAEdit.Text:='';
  // btnClonar.Enabled:=False;
   //ENAEdit.SetFocus;

   Hecho:=True;

end;

procedure TFormBuyIn02.CodingEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.DateAddKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.DateModKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.DBCostKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.DBDISCOUNTKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.DBGrid1DblClick(Sender: TObject);
begin
  IF Buydetalles.RecordCount < 1 THEN EXIT;
  EnaEDIT.Text:=Buydetalles.FieldByName('ENA').AsString;
  EnaEDIT.SetFocus;
end;

procedure TFormBuyIn02.DBLOWPRICEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.DBPvP1cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.DBPvP2cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.DBPvP3cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.DBWHOLESALEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.DescuentoExit(Sender: TObject);
begin
  CalImporte();
end;

procedure TFormBuyIn02.DescuentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;


procedure TFormBuyIn02.ENAEditExit(Sender: TObject);
begin
  if Trim(ENAEdit.Text)='' then exit;
   if  Trim(EnaEdit.Text) <> '' then
   begin
   if ABUYDOC.B_UUID = '' then
    begin
      NewButton.Click;

      exit;
    end;

   end;

   if ABUYDOC.B_UUID = '' then
   begin
   EnaEdit.Text:='';
   EnaEdit.SetFocus;
   Exit;
   end;
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
  if DBGoodsQuery.FieldByName('TYPE').AsInteger = 1 then
   begin
   showmessage('此编码不适合在此输入');
   exit;
   end;
  GOODS_ID:=DBGoodsQuery.FieldByName('GOODS_ID').AsString;
  ///这里的sku编码是本身的编码, 不是属性商品.
  SKUUUID:=DBGoodsQuery.FieldByName('SKU_NO').AsString;
  ///
  UUIDEdit.Text:= DBGoodsQuery.FieldByName('GOODS_ID').AsString;
  CodingEdit.Text:=DBGoodsQuery.FieldByName('CODE').AsString;
  NameEdit.Text:= DBGoodsQuery.FieldByName('GOODS_NAME').AsString;
  NameEdit2.Text:= DBGoodsQuery.FieldByName('GOODS_NAME2').AsString;           //UPDATED_AT

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


  if  GetGoodsSKUitems(GOODS_ID) then
  begin
     SkuPanel.Align:=AlClient;
     SkuPanel.Visible:=True;
    NewSkuPanel.Visible:=False;
    //PricePanel.Visible:=False;
  end
  else
  begin
  SkuPanel.Visible:=False;
  NewSkuPanel.Visible:=False;
 // PricePanel.Parent:=TabSheet2;
 // PricePanel.Align:=alClient;
 // PricePanel.Visible:=True;
  end;

  IsNewGoods:=False;
 // PageControl1.Pages[0].TabVisible:=False;
 // TabSheet1.Visible:=False;

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
      ParamByName('ENA').AsString:=trim(EnaEdit.Text);
      open;
      end;
      if Articulo.RecordCount > 1 then
      begin
      SKU_NO:=FormSelectSKU.IniciaSelection(trim(EnaEdit.Text));
      if SKU_NO = '' then
          begin
          EnaEdit.SetFocus;
          exit;
          end;
      if not (Articulo.Locate('SKU_NO', SKU_NO, [])) then
          begin
            EnaEdit.SetFocus;
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
      ParamByName('ENA').AsString:=trim(EnaEdit.Text);
      open;
      END;
      SKU_NO:=Articulo.FieldByName('SKU_NO').AsString;
      if SKU_NO = '' then
          begin
          EnaEdit.SetFocus;
          exit;
          end;
      end;

      if BuyDetalles.Locate('ENA', Trim(EnaEdit.Text), [] ) then
     begin
       Precio.Value:=BuyDetalles.FieldByName('COST').AsCurrency;
       Descuento.Value:=BuyDetalles.FieldByName('DISCOUNT').AsCurrency;
     end;
     // Edit2.Text:=Articulo.FieldByName('GOODS_NAME').AsString;
      Precio.Value:=Articulo.FieldByName('COST').AsCurrency;
      PVP1C.Value:=Articulo.FieldByName('SELLING_P1C').AsCurrency;
      Amount.SetFocus;

end
else
begin
  GOODS_ID:=Get36UUID();
  UUIDEdit.Text:=GOODS_ID;
  IsNewGoods:=True;

 // btnClonar.Enabled:=True;
 // PricePanel.Parent:=TabSheet1;
 // PricePanel.Align:=alClient;
 // PricePanel.Visible:=True;
  //TabSheet1.Visible:=True;
  CodingEdit.Text:=RightStr(ENAEdit.Text, 6);
 // PageControl1.Pages[0].TabVisible:=True;
  //TabSheet1.Visible:=True;
  NewSkuPanel.Align:=AlClient;
  NewSkuPanel.Visible:=True;
  //NewSkuPanel.Alignment:=AlClient;
  SkuPanel.Visible:=False;
  CodingEdit.SetFocus;
end;

 eSTOCK.Value:=GetStocks(GOODS_ID);
end;

procedure TFormBuyIn02.ENAEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key=VK_Return then
  begin
   //if IsNewGoods=True then
   SelectNext(ActiveControl,True,True) //else Amount.Focused;

  end;
end;

function TFormBuyIn02.ExistGoods(CDBarra: string):boolean;
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
       SQL.Text:='SELECT T1.GOODS_ID, T1.GOODS_NAME, T1.GOODS_NAME2, T1.ENA, T1.CODE, T1.CATEGORY_ID, T1.BRAND_ID, T1.TYPE, T1.UNIT, T1.TAXRATE_ID, T1.WEIGTH, T1.VOLUME, T1.IS_ACTIVE, T1.PARENT_ID, T1.CLASS_ID, T1.STOCKAVISO, T1.LOWLIMIT, T1.CAN_DISCount, T1.UPDATED_AT, '
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


Function TFormBuyIn02.GetGoodsSKUitems(aGOODS_ID:STRING):Boolean;
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

function TFormBuyIn02.GetCategorySpec(Category_id: integer): boolean;
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

procedure TFormBuyIn02.GetCombination(aSKU_NO:STRING);
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


procedure TFormBuyIn02.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_F5)  then begin key:=0; BitBtn5Click(self); Exit; End;    //buscar
end;

procedure TFormBuyIn02.FormKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TFormBuyIn02.ImporteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.IvaDBLookupComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.LowLimitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.NameEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.NameEditExit(Sender: TObject);
begin
  if TRIM(NameEdit2.Text)='' then
  NameEdit2.Text:=NameEdit.Text;
end;

procedure TFormBuyIn02.NameEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.Button1Click(Sender: TObject);
var
  Bookmark: TBookmark;
  i:integer;
begin
  if ABUYDOC.B_UUID = '' then begin NewButton.SetFocus; exit; end;

  if EnaEdit.Text = '' then begin EnaEdit.SetFocus; exit; end;

  ///如果是新货品先保存
  /// 分组合货品或者普通货品的方法
   Bookmark := Buydetalles.GetBookmark;

  if IsNewGoods then
  begin
  {新货品头}
   if TypeBox.ItemIndex=2 then
begin
    CButton.Click;


    with dbTrabajo do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=False;
    SQL.Clear;
    SQL.Text:='INSERT INTO GOODS_OFPROVEEDOR (GOODS_ID, ENA, SUCODIGO, COST, DISCOUNT, ID_PROVEEDOR ) '
    +'values (:GOODS_ID, :ENA, :SUCODIGO, :COST, :DISCOUNT, :ID_PROVEEDOR ) '
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, DISCOUNT=:DISCOUNT ';
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('ENA').AsString:=Trim(ENAEdit.Text);
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
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('COST').AsFloat:= Precio.Value;
    ParamByName('pvp1c').AsFloat:= PVP1C.Value;
    ExecSQL;
    Active:=False;
    SQL.Clear;
    SQL.Text:='';


    SQL.Text:='UPDATE GOODS_SKU SET COST=:COST, SELLING_P1C=:SELLING_P1C, STOCK=STOCK+:STOCK '
    +'WHERE 1=1 AND ISCHILD=0 AND SKU_NO=:SKU_NO ';
    ParamByName('SKU_NO').AsString:=dbUuid.FieldByName('UUID').AsString;
    ParamByName('COST').AsFloat:= Precio.Value;
    ParamByName('SELLING_P1C').AsFloat:= PVP1C.Value;
    ParamByName('STOCK').AsFloat:= Amount.Value;
    ExecSQL;

    /////////仓库中的货品库存//////////
    Active:=False;
    sql.Clear;
    sql.Text:='INSERT INTO STOCKGOODS (ID_STOCK, GOODS_ID, SKU_NO, AMOUNT, GOODS_STATUS) '
    +'VALUES (:ID_STOCK, :GOODS_ID, :SKU_NO, AMOUNT=AMOUNT+:AMOUNT, :GOODS_STATUS) '
    +'ON DUPLICATE KEY UPDATE '
    +'AMOUNT=AMOUNT+:AMOUNT ';
    ParamByName('ID_STOCK').AsString:=aBUYDoc.ID_STOCK;
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('SKU_NO').AsString:=dbUuid.FieldByName('UUID').AsString;
    ParamByName('AMOUNT').AsFloat:= Amount.Value;
    ParamByName('GOODS_STATUS').AsInteger:= 0;
    ExecSQL;

    Active:=False;

    WITH CombinaQuery do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=False;
    SQL.Text:='SELECT * FROM GOODS_SKU_COMBINATION WHERE 1=1 AND SKU_NO=:SKU_NO ';
    ParamByName('SKU_NO').AsString:=dbUuid.FieldByName('UUID').AsString;
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


    Active:=False;
    SQL.Clear;
    SQL.Text:='INSERT INTO BUY_ITEMS (B_UUID, GOODS_ID, SKU_NO, ENA, QUANTITY, COMMODITY_UNIT, COST, DISCOUNT, BUY_DATE ) '
    +'VALUES (:B_UUID, :GOODS_ID, :SKU_NO, :ENA, :QUANTITY, :COMMODITY_UNIT, :COST, :DISCOUNT, :BUY_DATE) '
    +'ON DUPLICATE KEY UPDATE '
    +'QUANTITY=QUANTITY+:QUANTITY ';
    ParamByName('B_UUID').AsString:=aBUYDOC.B_UUID;
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('SKU_NO').AsString:=dbUuid.FieldByName('UUID').AsString;
    ParamByName('ENA').AsString:=trim(EnaEdit.Text);
    ParamByName('QUANTITY').AsFloat:= Amount.Value;
    ParamByName('COMMODITY_UNIT').AsString:=Unidades.Text;
    ParamByName('COST').AsFloat:= Precio.Value;
    ParamByName('DISCOUNT').AsFloat:= Descuento.Value;
    ParamByName('BUY_DATE').AsDateTime:=aBUYDOC.BUY_DATE;
    ExecSQL;
    end;


end
else
begin
    Save2.Click;
   // Bookmark := Buydetalles.GetBookmark;

    with dbTrabajo do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=False;
    SQL.Clear;
    SQL.Text:='INSERT INTO GOODS_OFPROVEEDOR (GOODS_ID, ENA, SUCODIGO, COST, DISCOUNT, ID_PROVEEDOR ) '
    +'values (:GOODS_ID, :ENA, :SUCODIGO, :COST, :DISCOUNT, :ID_PROVEEDOR ) '
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, DISCOUNT=:DISCOUNT ';
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('ENA').AsString:=Trim(EnaEdit.Text);
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
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('COST').AsFloat:= Precio.Value;
    ParamByName('pvp1c').AsFloat:= PVP1C.Value;
    ExecSQL;
    Active:=False;
    SQL.Clear;
    SQL.Text:='UPDATE GOODS_SKU SET COST=:COST, SELLING_P1C=:SELLING_P1C, STOCK=STOCK+:STOCK '
    +'WHERE 1=1 AND ISCHILD=0 AND SKU_NO=:SKU_NO ';
    ParamByName('SKU_NO').AsString:=dbUuid.FieldByName('UUID').AsString;
    ParamByName('COST').AsFloat:= Precio.Value;
    ParamByName('SELLING_P1C').AsFloat:= PVP1C.Value;
    ParamByName('STOCK').AsFloat:= Amount.Value;
    ExecSQL;


    /////////仓库中的货品库存//////////
    Active:=False;
    sql.Clear;
    sql.Text:='INSERT INTO STOCKGOODS (ID_STOCK, GOODS_ID, SKU_NO, AMOUNT, GOODS_STATUS) '
    +'VALUES (:ID_STOCK, :GOODS_ID, :SKU_NO, AMOUNT=:AMOUNT, :GOODS_STATUS) '
    +'ON DUPLICATE KEY UPDATE '
    +'AMOUNT=AMOUNT+:AMOUNT ';
    ParamByName('ID_STOCK').AsString:=aBUYDoc.ID_STOCK;
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('SKU_NO').AsString:=dbUuid.FieldByName('UUID').AsString;
    ParamByName('AMOUNT').AsFloat:= Amount.Value;
    ParamByName('GOODS_STATUS').AsInteger:= 0;
    ExecSQL;

    Active:=False;
    SQL.Clear;
    SQL.Text:='INSERT INTO BUY_ITEMS (B_UUID, GOODS_ID, SKU_NO, ENA, QUANTITY, COMMODITY_UNIT, COST, DISCOUNT, BUY_DATE ) '
    +'VALUES (:B_UUID, :GOODS_ID, :SKU_NO, :ENA, :QUANTITY, :COMMODITY_UNIT, :COST, :DISCOUNT, :BUY_DATE) '
    +'ON DUPLICATE KEY UPDATE '
    +'QUANTITY=QUANTITY+:QUANTITY ';
    ParamByName('B_UUID').AsString:=aBUYDOC.B_UUID;
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('SKU_NO').AsString:=dbUuid.FieldByName('UUID').AsString;
    ParamByName('ENA').AsString:=trim(EnaEdit.Text);
    ParamByName('QUANTITY').AsFloat:= Amount.Value;
    ParamByName('COMMODITY_UNIT').AsString:=Unidades.Text;
    ParamByName('COST').AsFloat:= Precio.Value;
    ParamByName('DISCOUNT').AsFloat:= Descuento.Value;
    ParamByName('BUY_DATE').AsDateTime:=aBUYDOC.BUY_DATE;
    ExecSQL;
    end;

end;


   {新货品尾}
  end
  else
  begin
   {已保存货品头}
     if TypeBox.ItemIndex=2 then
begin
    CButton.Click;


    with dbTrabajo do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=False;
    SQL.Clear;
    SQL.Text:='INSERT INTO GOODS_OFPROVEEDOR (GOODS_ID, ENA, SUCODIGO, COST, DISCOUNT, ID_PROVEEDOR ) '
    +'values (:GOODS_ID, :ENA, :SUCODIGO, :COST, :DISCOUNT, :ID_PROVEEDOR ) '
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, DISCOUNT=:DISCOUNT ';
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('ENA').AsString:=Trim(ENAEdit.Text);
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
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('COST').AsFloat:= Precio.Value;
    ParamByName('pvp1c').AsFloat:= PVP1C.Value;
    ExecSQL;
    Active:=False;
    SQL.Clear;
    SQL.Text:='UPDATE GOODS_SKU SET COST=:COST, SELLING_P1C=:SELLING_P1C, STOCK=STOCK+:STOCK '
    +'WHERE 1=1 AND ISCHILD=0 AND SKU_NO=:SKU_NO ';
    ParamByName('SKU_NO').AsString:=Articulo.FieldByName('SKU_NO').AsString;
    ParamByName('COST').AsFloat:= Precio.Value;
    ParamByName('SELLING_P1C').AsFloat:= PVP1C.Value;
    ParamByName('STOCK').AsFloat:= Amount.Value;
    ExecSQL;

    /////////仓库中的货品库存//////////
    Active:=False;
    sql.Clear;
    sql.Text:='INSERT INTO STOCKGOODS (ID_STOCK, GOODS_ID, SKU_NO, AMOUNT, GOODS_STATUS) '
    +'VALUES (:ID_STOCK, :GOODS_ID, :SKU_NO, AMOUNT=AMOUNT+:AMOUNT, :GOODS_STATUS) '
    +'ON DUPLICATE KEY UPDATE '
    +'AMOUNT=AMOUNT+:AMOUNT ';
    ParamByName('ID_STOCK').AsString:=aBUYDoc.ID_STOCK;
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('SKU_NO').AsString:=Articulo.FieldByName('SKU_NO').AsString;
    ParamByName('AMOUNT').AsFloat:= Amount.Value;
    ParamByName('GOODS_STATUS').AsInteger:= 0;
    ExecSQL;

    Active:=False;

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


    Active:=False;
    SQL.Clear;
    SQL.Text:='INSERT INTO BUY_ITEMS (B_UUID, GOODS_ID, SKU_NO, ENA, QUANTITY, COMMODITY_UNIT, COST, DISCOUNT, BUY_DATE ) '
    +'VALUES (:B_UUID, :GOODS_ID, :SKU_NO, :ENA, :QUANTITY, :COMMODITY_UNIT, :COST, :DISCOUNT, :BUY_DATE) '
    +'ON DUPLICATE KEY UPDATE '
    +'QUANTITY=QUANTITY+:QUANTITY ';
    ParamByName('B_UUID').AsString:=aBUYDOC.B_UUID;
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('SKU_NO').AsString:=Articulo.FieldByName('SKU_NO').AsString;
    ParamByName('ENA').AsString:=trim(EnaEdit.Text);
    ParamByName('QUANTITY').AsFloat:= Amount.Value;
    ParamByName('COMMODITY_UNIT').AsString:=Unidades.Text;
    ParamByName('COST').AsFloat:= Precio.Value;
    ParamByName('DISCOUNT').AsFloat:= Descuento.Value;
    ParamByName('BUY_DATE').AsDateTime:=aBUYDOC.BUY_DATE;
    ExecSQL;
    end;


end
else
begin
    Save2.Click;
   // Bookmark := Buydetalles.GetBookmark;

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
    +'WHERE 1=1 AND ISCHILD=0 AND SKU_NO=:SKU_NO ';
    ParamByName('SKU_NO').AsString:=Articulo.FieldByName('SKU_NO').AsString;
    ParamByName('COST').AsFloat:= Precio.Value;
    ParamByName('SELLING_P1C').AsFloat:= PVP1C.Value;
    ParamByName('STOCK').AsFloat:= Amount.Value;
    ExecSQL;


    /////////仓库中的货品库存//////////
    Active:=False;
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
    { IF Articulo.FieldByName('TYPE').AsInteger = 1 THEN
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
    }


    Active:=False;
    SQL.Clear;
    SQL.Text:='INSERT INTO BUY_ITEMS (B_UUID, GOODS_ID, SKU_NO, ENA, QUANTITY, COMMODITY_UNIT, COST, DISCOUNT, BUY_DATE ) '
    +'VALUES (:B_UUID, :GOODS_ID, :SKU_NO, :ENA, :QUANTITY, :COMMODITY_UNIT, :COST, :DISCOUNT, :BUY_DATE) '
    +'ON DUPLICATE KEY UPDATE '
    +'QUANTITY=QUANTITY+:QUANTITY ';
    ParamByName('B_UUID').AsString:=aBUYDOC.B_UUID;
    ParamByName('GOODS_ID').AsString:=Articulo.FieldByName('GOODS_ID').AsString;
    ParamByName('SKU_NO').AsString:=Articulo.FieldByName('SKU_NO').AsString;
    ParamByName('ENA').AsString:=trim(EnaEdit.Text);
    ParamByName('QUANTITY').AsFloat:= Amount.Value;
    ParamByName('COMMODITY_UNIT').AsString:=Articulo.FieldByName('UNIT').AsString;
    ParamByName('COST').AsFloat:= Precio.Value;
    ParamByName('DISCOUNT').AsFloat:= Descuento.Value;
    ParamByName('BUY_DATE').AsDateTime:=aBUYDOC.BUY_DATE;
    ExecSQL;
    end;

end;

  {已保存货品尾}
  end;


  Buydetalles.Refresh;
  BuyDetalles.Last;
  //Buydetalles.GotoBookmark(Bookmark);


  GetTotal;

  //Articulo.FieldByName('PRECIO_COMPRAS_CON').AsCurrency
  EnaEdit.Text:='';
  ClearInputEdit();
  ItemsClear();
  EnaEDIT.SetFocus;

end;

procedure TFormBuyIn02.BitBtn5Click(Sender: TObject);
  var
  Result: TStringArray;
  str:string;
begin
str:=Enaedit.Text;
str:=StringReplace(str, '%', '', [rfReplaceAll]);
  Result:=FormGoodsList.IniciaBusquedas(str);
  Enaedit.Text:=Result[0];
  if ((Enaedit.Text='-') or (Enaedit.Text='-1')) then
  begin
  Enaedit.Text:='';
  end;
  Enaedit.SetFocus;
end;

procedure TFormBuyIn02.AvisoLimitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.BitBtn19Click(Sender: TObject);
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

procedure TFormBuyIn02.BitBtn20Click(Sender: TObject);
begin
  FormMarca.IniciaMExcute('GOODS_BRANDS', ['CODE','BRAND_NAME'], ['CODE','BRAND_NAME']);
  BrandQuery.Refresh;
end;

procedure TFormBuyIn02.BitBtn21Click(Sender: TObject);
begin
  if FormCategorys.IniciaCategory() then
  CategoryQuery.Refresh;
end;

procedure TFormBuyIn02.BitBtn22Click(Sender: TObject);
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

procedure TFormBuyIn02.BitBtn2Click(Sender: TObject);
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

procedure TFormBuyIn02.BitBtn5KeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TFormBuyIn02.BrandDBBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuyIn02.Button14Click(Sender: TObject);

  var
  i,j,k :integer;
begin
if BuyDetalles.RecordCount <=0 then exit;

BufDatasetLabels.Close;
BufDatasetLabels.CreateDataset;
BufDatasetLabels.Open;
BufDatasetLabels.DisableControls;
BuyDetalles.First;
for i:= 0 to BuyDetalles.RecordCount -1 do
begin
k:= ceil( BuyDetalles.FieldByName('QUANTITY').AsFloat);
for J := 0 to k-1 do
begin
with BufDatasetLabels do
       begin
append;
BufDatasetLabelsSKU_NO.AsString:= BuyDetalles.FieldByName('SKU_NO').AsString;
BufDatasetLabelsGOODS_ID.AsString := BuyDetalles.FieldByName('GOODS_ID').AsString;
BufDatasetLabelsENA.AsString:= BuyDetalles.FieldByName('ENA').AsString;
BufDatasetLabelsGOODS_NAME.AsString := BuyDetalles.FieldByName('GOODS_NAME').AsString;
BufDatasetLabelsBRAND_NAME.AsString := BuyDetalles.FieldByName('BRAND_NAME').AsString;
BufDatasetLabelsSCALAR.AsString:= BuyDetalles.FieldByName('SCALAR').AsString;
BufDatasetLabelsUNIT.AsString := BuyDetalles.FieldByName('COMMODITY_UNIT').AsString;
BufDatasetLabelsFECHA_FABRICA.AsString := '';
BufDatasetLabelsPVP.AsFloat := BuyDetalles.FieldByName('SELLING_P1C').AsFloat;
       end;
BuyDetalles.Next;
end;

end;
BufDatasetLabels.EnableControls;

frxReport1.Clear;
frxReport1.LoadFromFile(ReportPath+'EtiquetaSabateria40x25.fr3');

//frxReport1.DesignReport();
  frxReport1.PrepareReport();
 // frxReport1.ShowPreparedReport;
  if PCCONFIG.LABELPRINTNAME <> '' then
    begin
  frxReport1.PrintOptions.Printer := PCCONFIG.LABELPRINTNAME; //选择打印机名称
  end
  else frxReport1.PrintOptions.ShowDialog := True; //显示打印机选择框

  frxReport1.Print;

   //BufDatasetLabels.Clear;
   BufDatasetLabels.Close;

end;

end.

