unit create;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids, DBCtrls, Buttons, rxcurredit, connect, ZDataset, ZSqlUpdate, DB,
  BufDataset, LCLType, ComCtrls, Global, Variants;

type

  { TFAddGoods }

  TFAddGoods = class(TForm)
    AllSpecDS: TDataSource;
    AllSpecQuery: TZQuery;
    Button6: TButton;
    DBGoodsSkuQuery: TZQuery;
    Label26: TLabel;
    SS: TDataSource;
    SpuSpecsMemTable: TBufDataset;
    SpuSpecQuery: TZQuery;
    AvisoLimit: TComboBox;
    BitBtn2: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    BitBtn3: TBitBtn;
    BrandDBBox: TDBLookupComboBox;
    BrandDS: TDataSource;
    BrandQuery: TZQuery;
    btnClonar: TBitBtn;
    BufSun: TBufDataset;
    BufSunALLOT: TLongintField;
    BufSunAVISO: TLongintField;
    BufSunAVISONUM: TFloatField;
    BufSunCODE: TStringField;
    BufSunCOST: TCurrencyField;
    BufSunENA: TStringField;
    BufSunMUINT: TStringField;
    BufSunNAME: TStringField;
    BufSunNAME2: TStringField;
    BufSunPARENTID: TLongintField;
    BufSunPVP: TCurrencyField;
    BufSunSKU_NO: TStringField;
    BufSunUUID: TStringField;
    BufSunVOLUMN: TStringField;
    BufSunWHOLEPRICE: TCurrencyField;
    Button1: TButton;
    Button13: TButton;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Button7: TButton;
    Button8: TButton;
    CanDiscount: TComboBox;
    Cantidad: TCurrencyEdit;
    CategoryDS: TDataSource;
    CategoryQuery: TZQuery;
    CDBCost: TCurrencyEdit;
    CDBDISCOUNT: TCurrencyEdit;
    CDBLOWPRICE: TCurrencyEdit;
    CDBPvP1c: TCurrencyEdit;
    CDBPvP2c: TCurrencyEdit;
    CDBPvP3c: TCurrencyEdit;
    CDBWHOLESALE: TCurrencyEdit;
    ClasseDS: TDataSource;
    ClasseQuery: TZQuery;
    CombinaBD: TBufDataset;
    CombinaBDCOMMODITY_UNIT: TStringField;
    CombinaBDCOST: TFloatField;
    CombinaBDITEM_NAME: TStringField;
    CombinaBDMEMBER_SKU_NO: TStringField;
    CombinaBDQUANTITY: TFloatField;
    CombinaBDSELLING_P1C: TFloatField;
    CombinaDS: TDataSource;
    CombinationPanel: TPanel;
    ALLOTDS: TDataSource;
    Conserva: TCurrencyEdit;
    DataSource2: TDataSource;
    DaysAviso: TCurrencyEdit;
    dbCombina: TZQuery;
    DBGrid3: TDBGrid;
    dbInsert: TZQuery;
    dbParentAllot: TZQuery;
    dbFind: TZQuery;
    DBGoods2: TZQuery;
    dbUuid: TZQuery;
    DSSun: TDataSource;
    dbClonar: TZQuery;
    DBGoodsQuery: TZQuery;
    dbTrabajo: TZQuery;
    ItemName: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    LVSpecs: TListView;
    LowLimit: TCurrencyEdit;
    MemTable: TBufDataset;
    MemTableATTIBUTE_ID: TLongintField;
    MemTableATTIBUTE_VALUE: TStringField;
    MemTableATTIBUTE_VALUE_ID: TLongintField;
    MemTableGOODS_ID: TStringField;
    MemTableJSON: TStringField;
    BasicPanel: TPanel;
    Panel1: TPanel;
    SpecPanel: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    SaveBtn: TButton;
    Button3: TButton;
    CategoryDBBox: TDBLookupComboBox;
    CodingEdit: TEdit;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    MAvisoLimit: TComboBox;
    MCodingEdit: TEdit;
    MENAEdit: TEdit;
    MLowLimit: TCurrencyEdit;
    MNameEdit: TEdit;
    MNum: TCurrencyEdit;
    DBCost: TCurrencyEdit;
    DBPvP1c: TCurrencyEdit;
    DBWHOLESALE: TCurrencyEdit;
    ENAEdit: TEdit;
    IvaDBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MVolumeEdit: TEdit;
    NameEdit: TEdit;
    NameEdit2: TEdit;
    PanelHijo: TPanel;
    PanelM: TPanel;
    PanelB: TPanel;
    PanelMain: TPanel;
    PanelPrincipal: TPanel;
    SDBCost: TCurrencyEdit;
    SDBPvP1c: TCurrencyEdit;
    SDBWHOLESALE: TCurrencyEdit;
    SkuQuery: TZQuery;
    Sku_NoEdit: TEdit;
    SNum: TCurrencyEdit;
    SpecValuesQuery: TZQuery;
    SpuSpecsMemTableATTIBUTE_ID: TLongintField;
    SpuSpecsMemTableGOODS_ID: TStringField;
    SpuSpecsMemTableIS_DELETE: TSmallintField;
    TaxRateDS: TDataSource;
    TaxRateZQuery: TZQuery;
    TypeBox: TComboBox;
    Unidades: TEdit;
    MUnidades: TEdit;
    UUIDEdit: TEdit;
    VolumeEdit: TEdit;
    WeigthEdit: TEdit;
    ZUpdateSQL1: TZUpdateSQL;
    ALLOTUpdateSQL: TZUpdateSQL;
     procedure AllSpecDSDataChange(Sender: TObject; Field: TField);
     procedure AvisoLimitKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure BitBtn20Click(Sender: TObject);
     procedure BitBtn21Click(Sender: TObject);
     procedure BitBtn22Click(Sender: TObject);
     procedure BitBtn2Click(Sender: TObject);
     procedure BitBtn3Click(Sender: TObject);
     procedure BrandDBBoxKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure btnClonarClick(Sender: TObject);
     procedure Button13Click(Sender: TObject);
     procedure Button1Click(Sender: TObject);
     procedure Button2Click(Sender: TObject);
     procedure Button3Click(Sender: TObject);
     procedure Button4Click(Sender: TObject);
     procedure Button5Click(Sender: TObject);
     procedure Button6Click(Sender: TObject);
     procedure Button7Click(Sender: TObject);
     procedure Button8Click(Sender: TObject);
     procedure CanDiscountKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure CantidadKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure CategoryDBBoxKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure CDBCostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
       );
     procedure CDBLOWPRICEKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure CDBPvP1cKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure CDBPvP2cKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure CDBWHOLESALEKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure CodingEditKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure DBCostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
       );
     procedure DBPvP1cKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
       );
     procedure DBWHOLESALEKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
     procedure ENAEditEnter(Sender: TObject);
     procedure ENAEditExit(Sender: TObject);
     procedure ENAEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
       );
     procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
     procedure FormCreate(Sender: TObject);
     function ExistGoods(CDBarra: string):boolean;
     procedure FormShow(Sender: TObject);
     PROCEDURE GetCategorys();
    Procedure GetBrand();
    Procedure GetClasse();
    procedure GetAllSpec();
    procedure GetSpecsValues(Specs_id: integer);
    procedure GetGoodsSpuDetail(GoodsId:string);
    procedure ItemNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure ItemsClear();
    procedure DoGetTaxRates;
    procedure ClearHijo();
    procedure GetCombination(aSKU_NO:STRING);
    Function GetCombinacionCost():Double;
    Procedure GetSpuSpecs(aGoods_id:String);
    Function GetSelectedSpecCount():Integer;
    procedure IvaDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  //  procedure ListBox3Click(Sender: TObject);
    procedure LowLimitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure LVSpecsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure MAvisoLimitKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MCodingEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MENAEditExit(Sender: TObject);
    procedure MENAEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure MLowLimitKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MNameEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MNumKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MUnidadesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MVolumeEditChange(Sender: TObject);
    procedure MVolumeEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NameEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NameEditExit(Sender: TObject);
    procedure NameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure SaveBtnClick(Sender: TObject);
    procedure SDBCostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure SDBPvP1cChange(Sender: TObject);
    procedure SDBPvP1cKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure SDBWHOLESALEChange(Sender: TObject);
    procedure SDBWHOLESALEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sku_NoEditExit(Sender: TObject);
    procedure Sku_NoEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SNumKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TaxRateDSDataChange(Sender: TObject; Field: TField);
    procedure TypeBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure TypeBoxSelect(Sender: TObject);
    Function SimpleSave(): boolean;
    function ShelfLifeSave():boolean;
    Function SetSave():boolean;
    procedure CombinaSave();
    FuncTion SpecGoodsSave():boolean;
    Function GetTotalAllot():integer;
    Function GetId(goodsId:string):integer;
    Procedure GetParentAllot(ParentId:integer);
    procedure UnidadesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure UUIDEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
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

  procedure ShowFAddGoods(new:TGOODS);

var
  FAddGoods: TFAddGoods;
   NewGoods:TGOODS;
   Uid: TGuid;
  UResult: HResult;
  GOODS_ID, SKUUUID: string;
  IsNewGoods, HaveSkuItems, HaveNewSkuItem: Boolean;
  Hecho:boolean;
  aProveedor:TStringArray;
  Mgoods_id:string;
  Pid:integer;
  MSKUUUID:string;

implementation
uses
   Goods_Marca,Categorys_Spec, U_FindGoods_Spu, findout, select_onesku, specification, skuslist;

procedure ShowFAddGoods(new:TGOODS);
begin
  with TFAddGoods.Create(Application) do
    begin

      ENAEdit.Text:=new.ENA;
      ENAEditExit(FAddGoods);
      ENAEdit.Enabled:=False;
      NameEdit.Text:=new.ITEM_NAME;
      DBCost.Value:=new.COST;
      FFlag:=False;
      ShowModal;
      //ENAEditExit(FormGoodsSpu);
    end;
end;

{$R *.lfm}
{ TFormGoodsSpu }

function TFAddGoods.Created(new:TGOODS):boolean;
begin
  Hecho:=False;
  NewGoods:=new;
  ShowFAddGoods(NewGoods);
  Result:=Hecho;
end;

procedure TFAddGoods.DoGetTaxRates;
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

procedure TFAddGoods.IvaDBLookupComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

{
procedure TFAddGoods.ListBox3Click(Sender: TObject);
  var
  A_ID:integer;
begin
 A_ID:=Ptrint(ListBox3.Items.Objects[ListBox3.ItemIndex]);
 if A_ID = -1 then exit;
 GetSpecsValues(A_ID);
end;
}

procedure TFAddGoods.LowLimitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.LVSpecsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  A_Spec_Id: Integer;
begin
  SpuSpecsMemTable.DisableControls;
  if Item.Checked then
  begin
    A_Spec_Id:=strtoint(Item.SubItems[0]);
    if not  SpuSpecsMemTable.Locate('GOODS_ID;ATTIBUTE_ID', VarArrayOf([GOODS_ID,A_Spec_Id]),[]) then
            begin
            SpuSpecsMemTable.Append;
            SpuSpecsMemTable.FieldByName('GOODS_ID').AsString:= GOODS_ID;
            SpuSpecsMemTable.FieldByName('ATTIBUTE_ID').AsInteger:=A_Spec_Id;
            SpuSpecsMemTable.FieldByName('IS_DELETE').AsInteger:=0;
            SpuSpecsMemTable.Post;

            end
            else
             begin
               if SpuSpecsMemTable.Locate('GOODS_ID;ATTIBUTE_ID', VarArrayOf([GOODS_ID,A_Spec_Id]),[]) then
                begin
                SpuSpecsMemTable.Edit;
                SpuSpecsMemTable.FieldByName('IS_DELETE').AsInteger:=0;
                SpuSpecsMemTable.Post;

                end;
             end;
  end
  else
  begin

    A_Spec_Id:=strtoint(Item.SubItems[0]);
     if SpuSpecsMemTable.Locate('GOODS_ID;ATTIBUTE_ID', VarArrayOf([GOODS_ID,A_Spec_Id]),[]) then
                begin
                SpuSpecsMemTable.Edit;
                SpuSpecsMemTable.FieldByName('IS_DELETE').AsInteger:=1;
                SpuSpecsMemTable.Post;

                end;

  end;

  SpuSpecsMemTable.EnableControls;
end;

procedure TFAddGoods.MAvisoLimitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.MCodingEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.MENAEditExit(Sender: TObject);
begin
   with DBGoods2 do
     begin
      Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.Clear;
      SQL.Text:='SELECT T1.GOODS_ID, T1.GOODS_NAME, T1.GOODS_NAME2, T1.ENA, T1.CODE, T1.CATEGORY_ID, T1.BRAND_ID, T1.TYPE, T1.UNIT, T1.TAXRATE_ID, T1.WEIGTH, T1.VOLUME, T1.IS_ACTIVE, '
      +'T1.PARENT_ID, T1.CLASS_ID, T1.STOCKAVISO, T1.LOWLIMIT, T1.CAN_DISCount,T1.DAYS_CONSERVACION, T1.DAYS_AVISO,  T1.UPDATED_AT, '
      +'T2.COST, T2.SELLING_P1C, T2.SELLING_P2C, T2.SELLING_P3C, T2.LOWPRICE, T2.WHOLESALE, T2.DISCOUNT, T2.Points, T2.SKU_NO '
      +'FROM GOODS_SPU AS T1 LEFT JOIN GOODS_SKU AS T2 ON T2.GOODS_ID = T1.GOODS_ID '
      +'WHERE 1=1  '         //AND T2.ISCHILD = 0
      +'AND T1.ENA=:ENA Limit 1';
      ParamByName('ENA').AsString:=Trim(MENAEdit.Text);
      OPEN;
     end;
    if DBGoods2.RecordCount > 0 then
    begin
      if DBGoods2.FieldByName('Type').AsInteger <> 0 then
      begin
        showmessage('此编号不适合用于此处, 请更换!');
        MENAEdit.SetFocus;
        exit;
      end;

        MGOODS_ID:=DBGoods2.FieldByName('GOODS_ID').AsString;
        ///这里的sku编码是本身的编码, 不是属性商品.
        SKUUUID:=DBGoods2.FieldByName('SKU_NO').AsString;
        MCodingEdit.Text:=DBGoods2.FieldByName('CODE').AsString;
        MNameEdit.Text:= DBGoods2.FieldByName('GOODS_NAME').AsString;
        MUnidades.Text:=DBGoods2.FieldByName('UNIT').AsString;
        MVolumeEdit.Text:=DBGoods2.FieldByName('Volume').AsString;
        if DBGoods2.FieldByName('STOCKAVISO').AsInteger = 1 then
        MAvisoLimit.ItemIndex:=1 else MAvisoLimit.ItemIndex:=0;
        MLOWLIMIT.Value:=DBGoods2.FieldByName('LOWLIMIT').AsFloat;
        SDBCost.Value:=DBGoods2.FieldByName('COST').AsFloat;
        SDBPvP1c.Value:=DBGoods2.FieldByName('SELLING_P1C').AsFloat;
        SDBWHOLESALE.Value:=DBGoods2.FieldByName('WHOLESALE').AsFloat;
    end
    else
    begin
      Mgoods_id:=Get36UUID();
      MCodingEdit.Text:=RightStr(MENAEdit.Text, 6);
      MNameEdit.Text:=NameEdit.Text;
      SDBCost.Value:=DBCost.Value;
      //MSKUUUID:string;
    end;
    MNameEdit.SetFocus;
end;

procedure TFAddGoods.ClearHijo();
begin
      MENAEdit.Text:='';
      MCodingEdit.Text:='';
      MNameEdit.Text:= '';
      MUnidades.Text:='';
      MVolumeEdit.Text:='';
      MAvisoLimit.ItemIndex:=0;
      MLOWLIMIT.Value:=0;
      SDBCost.Value:=0;
      SDBPvP1c.Value:=0;
      SDBWHOLESALE.Value:=0;
end;

procedure TFAddGoods.MENAEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.MLowLimitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.MNameEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.MNumKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.MUnidadesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.MVolumeEditChange(Sender: TObject);
begin

end;

procedure TFAddGoods.MVolumeEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.NameEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.NameEditExit(Sender: TObject);
begin
   if TRIM(NameEdit2.Text)='' then
  NameEdit2.Text:=NameEdit.Text;
end;

procedure TFAddGoods.NameEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.SaveBtnClick(Sender: TObject);
var
  k: boolean;
  Allot:integer;
  theVar: Variant;
  theInt: integer;
  CAPACITY: integer;
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
  case TypeBox.ItemIndex of
  0:
    begin
     k:= SimpleSave();
    end;
  1:
    begin
     CAPACITY:=MNum.AsInteger;
     allot:=GetTotalAllot();
     if allot < 1 then
     begin
     showmessage('未分配, 不能实施保存');
     TypeBox.SetFocus;
     exit;
     end;
     if allot <> CAPACITY then
     begin
       showmessage('分配数量不对, 请先调整好!');
       button1.SetFocus;
       exit;
     end;
       k:=SetSave();

    end;
  2:
    begin
     // showmessage('组合商品');
      CombinaSave();
      k:=True;
      exit;
    end;
  3:
    begin
     k:= ShelfLifeSave();
    end;
  4:
    begin
     if Conserva.AsInteger < 1 then
     begin
     showmessage('天数不可以少.');
     Conserva.SetFocus;
     exit;
     end;
     k:= SpecGoodsSave();
    end;

  end;
  hecho:=k;
  SpuSpecsMemTable.Close;
  ENAEdit.SetFocus;
  if FFlag then
  close;
end;

procedure TFAddGoods.SDBCostKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.SDBPvP1cChange(Sender: TObject);
begin

end;

procedure TFAddGoods.SDBPvP1cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.SDBWHOLESALEChange(Sender: TObject);
begin

end;

procedure TFAddGoods.SDBWHOLESALEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.Sku_NoEditExit(Sender: TObject);

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

procedure TFAddGoods.Sku_NoEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.SNumKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.TaxRateDSDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TFAddGoods.TypeBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.TypeBoxSelect(Sender: TObject);
begin

   case  TypeBox.ItemIndex   of
   0:
     begin
       PanelHijo.Visible:=False;
       CombinationPanel.Visible:=False;
       PanelMain.Visible:=True;
       PanelMain.Parent:=PanelM;
       PanelMain.Align:=alClient;
       SpecPanel.Visible:=False;
       MNum.Value:=1;
       MNum.Enabled:=False;
       Label23.Caption:='普通商品';
       Conserva.Value:=0;
       Conserva.Enabled:=False;
       DaysAviso.Value:=0;
       DaysAviso.Enabled:=False;
     end;
   1:
     begin
      if IsNewGoods then
        BEGIN
           DBGrid1.DataSource:=DSSun;
        end
        else
        begin
           DBGrid1.DataSource:=ALLOTDS;
        end;
       PanelMain.Visible:=False;
       CombinationPanel.Visible:=False;
       PanelHijo.Visible:=True;
       PanelHijo.Parent:=PanelM;
       PanelHijo.Align:=alClient;
       MNum.Value:=0;
       MNum.Enabled:=True;
       Label23.Caption:='箱条码,非出售使用';
     end;
   2:
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
      PanelMain.Visible:=False;
      PanelHijo.Visible:=False;
      CombinationPanel.Visible:=True;
      CombinationPanel.Parent:=PanelM;
      CombinationPanel.Align:=alClient;
      MNum.Value:=1;
      MNum.Enabled:=False;
      Label23.Caption:='组合码, 如礼品等, 出售使用, 非购入使用';
     end;
   3:
     begin
       PanelHijo.Visible:=False;
       CombinationPanel.Visible:=False;
       PanelMain.Visible:=True;
       PanelMain.Parent:=PanelM;
       PanelMain.Align:=alClient;
       MNum.Value:=1;
       MNum.Enabled:=False;
       Label23.Caption:='拥有日期属性的商品(食品药物化妆品)';
       Conserva.Enabled:=True;
       DaysAviso.Enabled:=True;
     end;
   4:
     begin
       PanelHijo.Visible:=False;
       CombinationPanel.Visible:=False;
       PanelMain.Visible:=True;
       PanelMain.Parent:=PanelM;
       PanelMain.Align:=alClient;
       SpecPanel.Visible:=True;
       MNum.Value:=1;
       MNum.Enabled:=False;
       Label23.Caption:='属性商品(服装, 鞋子, 手机等)';
       Conserva.Value:=0;
       Conserva.Enabled:=False;
       DaysAviso.Value:=0;
       DaysAviso.Enabled:=False;
     end;
   end;
end;

procedure TFAddGoods.GetCombination(aSKU_NO:STRING);
begin

    with dbCombina do
     begin
        Connection:=DataModule2.ZCon1;
        Active:=false;
        SQL.Clear;
       SQL.TEXT:='SELECT CONCAT(T3.GOODS_NAME, T2.SKU_NAME) AS ITEM_NAME, T2.COST, T2.SELLING_P1C, T1.ID, T1.QUANTITY, T2.COMMODITY_UNIT, T1.MEMBER_SKU_NO '
       +'FROM GOODS_SKU_COMBINATION as T1 LEFT JOIN goods_sku AS T2 ON T1.MEMBER_SKU_NO = T2.SKU_NO '
       +'LEFT JOIN goods_spu AS T3 ON T3.GOODS_ID = T2.GOODS_ID '
       +'WHERE 1=1 AND T2.ISCHILD = 0 AND T1.SKU_NO=:SKU_NO ';
        ParamByName('SKU_NO').AsString:=aSKU_NO;
        OPEN;
     end;
end;
Function TFAddGoods.GetCombinacionCost():Double;
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

 PROCEDURE TFAddGoods.GetCategorys();
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

procedure TFAddGoods.FormCreate(Sender: TObject);
begin
   FFlag:=false;

   PanelHijo.Parent:=PanelM;
   PanelHijo.Align:=alClient;
   CombinationPanel.Parent:=PanelM;
   CombinationPanel.Align:=alClient;
   PanelMain.Parent:=PanelM;
   //SpecPanel.Parent:=PanelM;
   //SpecPanel.Align:=alClient;
   SpecPanel.Visible:=False;

   MemTable.Close;
 MemTable.CreateDataset;


GetAllSpec();

end;

procedure TFAddGoods.ENAEditExit(Sender: TObject);
begin
  // if not BitBtn2.Focused or not Button4.Focused then ENAEdit.SetFocus;
  if Trim(ENAEdit.Text)='' then
    begin

      exit;
    end;
  with dbUuid do
      begin
      Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.CLEAR;
      SQL.TEXT:='SELECT UUID() AS UUID';
      open;
      end;
  BufSun.Close;
BufSun.CreateDataset;

if ExistGoods(Trim(ENAEdit.Text)) then
begin
  GOODS_ID:=DBGoodsQuery.FieldByName('GOODS_ID').AsString;
  //获取sku编号
  GetGoodsSpuDetail(GOODS_ID);
  ///这里的sku编码是本身的编码, 不是属性商品.
  SKUUUID:=DBGoodsSkuQuery.FieldByName('SKU_NO').AsString;
  ///
  if DBGoodsQuery.FieldByName('TYPE').AsInteger = 4 then
  begin
   //多属性获取属性
     GetSpuSpecs(GOODS_ID );
  end;
  Pid:=DBGoodsQuery.FieldByName('ID').AsInteger;

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
  TypeBoxSelect(self);
  Unidades.Text:=DBGoodsQuery.FieldByName('UNIT').AsString;
  IvaDBLookupComboBox1.KeyValue:= DBGoodsQuery.FieldByName('TAXRATE_ID').Value;
  WeigthEdit.Text:=DBGoodsQuery.FieldByName('Weigth').AsString;
  VolumeEdit.Text:=DBGoodsQuery.FieldByName('Volume').AsString;
  AvisoLimit.ItemIndex:=DBGoodsQuery.FieldByName('STOCKAVISO').AsInteger;
  LOWLIMIT.Value:=DBGoodsQuery.FieldByName('LOWLIMIT').Value;
  CanDiscount.ItemIndex:=DBGoodsQuery.FieldByName('CAN_DISCount').AsInteger;
  //Edit4.Text:=formatfloat('#,##0.00',  DBGoodsQuery.FieldByName('Points').AsFloat);
  Conserva.Value:=DBGoodsQuery.FieldByName('DAYS_CONSERVACION').Value;
  DaysAviso.Value:=DBGoodsQuery.FieldByName('DAYS_AVISO').Value;
  DBCost.Value:=DBGoodsQuery.FieldByName('COST').Value;
  DBPvP1c.Value:=DBGoodsQuery.FieldByName('PVP1C').Value;
  MNum.Value:=DBGoodsQuery.FieldByName('CAPACITY').Value;
 // FieldByName('WHOLESALE').Value
 // DBDISCOUNT.Value:=DBGoodsQuery.FieldByName('DISCOUNT').Value;

 if DBGoodsQuery.FieldByName('TYPE').AsInteger = 1 then
 begin

  GetParentAllot(DBGoodsQuery.FieldByName('ID').AsInteger);
  DBGrid1.DataSource:=ALLOTDS;

  IsNewGoods:=False;
 end;
end
else
begin
  GOODS_ID:=Get36UUID();
  DBGrid1.DataSource:=DSSun;
  UUIDEdit.Text:=GOODS_ID;
  CodingEdit.Text:=RightStr(ENAEdit.Text, 6);
  IsNewGoods:=True;
  btnClonar.Enabled:=True;

end;

end;

procedure TFAddGoods.ENAEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  MemTable.Clear;
  MemTable.Close;
  CombinaBD.Clear;
  CombinaBD.Close;
  BufSun.Clear;
  BufSun.Close;
  SpuSpecsMemTable.Clear;
   SpuSpecsMemTable.Close;

end;

procedure TFAddGoods.Button1Click(Sender: TObject);
begin
  GroupBox1.Enabled:=True;
  MENAEdit.SetFocus;
end;

procedure TFAddGoods.BrandDBBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.btnClonarClick(Sender: TObject);
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
     // CombinaDS.DataSet:=DBCOMBINA;
      TypeBox.ItemIndex:=dbClonar.FieldByName('TYPE').Value;
      TypeBoxSelect(self);
      Unidades.Text:=dbClonar.FieldByName('UNIT').AsString;
      IvaDBLookupComboBox1.KeyValue:= dbClonar.FieldByName('TAXRATE_ID').Value;
      WeigthEdit.Text:=dbClonar.FieldByName('Weigth').AsString;
      VolumeEdit.Text:=dbClonar.FieldByName('Volume').AsString;
      DBCost.Value:=dbClonar.FieldByName('COST').Value;
      DBPvP1c.Value:=dbClonar.FieldByName('SELLING_P1C').Value;
      //DBPvP2c.Value:=dbClonar.FieldByName('SELLING_P2C').Value;
      //DBPvP3c.Value:=dbClonar.FieldByName('SELLING_P3C').Value;
      //DBLOWPRICE.Value:=dbClonar.FieldByName('LOWPRICE').Value;
      DBWHOLESALE.Value:=dbClonar.FieldByName('WHOLESALE').Value;
      //DBDISCOUNT.Value:=dbClonar.FieldByName('DISCOUNT').Value;
      //组合面板
     { CDBCost.Value:=dbClonar.FieldByName('COST').Value;
      CDBPvP1c.Value:=dbClonar.FieldByName('SELLING_P1C').Value;
      CDBPvP2c.Value:=dbClonar.FieldByName('SELLING_P3C').Value;
      CDBPvP3c.Value:=dbClonar.FieldByName('SELLING_P3C').Value;
      CDBLOWPRICE.Value:=dbClonar.FieldByName('LOWPRICE').Value;
      CDBWHOLESALE.Value:=dbClonar.FieldByName('WHOLESALE').Value;
      CDBDISCOUNT.Value:=dbClonar.FieldByName('DISCOUNT').Value; }
      end;

    end;
     NameEdit.SetFocus;
end;

procedure TFAddGoods.Button13Click(Sender: TObject);
begin
 if CombinaDS.DataSet = dbCombina then
 begin
  dbCombina.UpdateObject:=ZUpdateSQL1;
   ZUpdateSQL1.DeleteSQL.Text:='delete from GOODS_SKU_COMBINATION  where ID=:ID ';
  dbCombina.Delete;
 end;
 if CombinaDS.DataSet = CombinaBD then
 begin
  CombinaBD.Delete;
 end;
//CombinaDS.DataSet.Delete;
end;

procedure TFAddGoods.AvisoLimitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.AllSpecDSDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TFAddGoods.BitBtn20Click(Sender: TObject);
begin
   FormMarca.IniciaMExcute('GOODS_BRANDS', ['CODE','BRAND_NAME'], ['CODE','BRAND_NAME']);
  BrandQuery.Refresh;
  BrandDBBox.SetFocus;
end;

procedure TFAddGoods.BitBtn21Click(Sender: TObject);
begin
  if FormCategorys.IniciaCategory() then
  CategoryQuery.Refresh;
  CategoryDBBox.SetFocus;
end;

procedure TFAddGoods.BitBtn22Click(Sender: TObject);
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

procedure TFAddGoods.BitBtn2Click(Sender: TObject);
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

procedure TFAddGoods.BitBtn3Click(Sender: TObject);
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

procedure TFAddGoods.Button2Click(Sender: TObject);
 var
    AllotTotal: integer;
begin
if SNum.AsInteger < 1 then
begin
 SNum.SetFocus;
 exit;
 end;
    if IsNewGoods then
    begin
        try
        BufSun.DisableControls;
        BufSun.Open;
        with BufSun do
        begin
        Insert;
        BufSun.FieldByName('ENA').AsString:=Trim(MENAEdit.Text);
        BufSun.FieldByName('CODE').AsString:=Trim(MCodingEdit.Text);
        BufSun.FieldByName('UUID').Value:=Mgoods_id;
        BufSun.FieldByName('Name').Value:=Trim(MNameEdit.Text);
        if DBGoods2.RecordCount > 0 then
        BEGIN
        BufSun.FieldByName('Name2').Value:=DBGoods2.FieldByName('GOODS_NAME2').AsString;
        BufSun.FieldByName('SKU_NO').Value:=DBGoods2.FieldByName('SKU_NO').AsString;
        end
        else
        BEGIN
          BufSun.FieldByName('Name2').Value:=Trim(MNameEdit.Text);
        BufSun.FieldByName('SKU_NO').Value:='';
        end;
        BufSun.FieldByName('ALLOT').AsInteger:=SNum.AsInteger;
        BufSun.FieldByName('COST').AsCurrency:=SDBCost.Value;
        BufSun.FieldByName('PVP').AsCurrency:=SDBPvP1c.Value;
        BufSun.FieldByName('WholePrice').AsCurrency:=SDBWHOLESALE.Value;
        BufSun.FieldByName('VOLUMN').AsString:=MVolumeEdit.Text;
        BufSun.FieldByName('AVISO').AsInteger:=MAvisoLimit.ItemIndex;
        BufSun.FieldByName('AVISONUM').AsFloat:=MLowLimit.Value;
        BufSun.FieldByName('MUNIT').AsString:=MUnidades.Text;
        Post;
        end;
        finally
        BufSun.EnableControls;
        end;
    end
    else
    begin
    AllotTotal:=GetTotalAllot();

    if AllotTotal+SNum.AsInteger > MNum.AsInteger then
    begin
      showmessage('数量超过了, 不可添加');
      ClearHijo();
      MENAEdit.SetFocus ;
      Exit;
    end;
    ALLOTUpdateSQL.DeleteSQL.Text:='';
    dbParentAllot.UpdateObject:=ALLOTUpdateSQL;
    ALLOTUpdateSQL.InsertSQL.Text:='INSERT INTO ALLOT (ALLOT, GOODS_ID, ENA, PARENT_ID) '
    +'VALUES ( :ALLOT, :GOODS_ID, :ENA, :PARENT_ID) '
    +'ON DUPLICATE KEY UPDATE '
    +'ALLOT=ALLOT +:ALLOT ';
    dbParentAllot.Append;
    dbParentAllot.FieldByName('ALLOT').AsInteger:=SNum.AsInteger;
    dbParentAllot.FieldByName('GOODS_ID').AsString:=Mgoods_id;
    dbParentAllot.FieldByName('ENA').AsString:= Trim(MENAEdit.Text);
    dbParentAllot.FieldByName('PARENT_ID').AsInteger:=Pid;
    dbParentAllot.Post;
    end;

    ClearHijo();
    Button1.SetFocus;
    GroupBox1.Enabled:=False;


end;

procedure TFAddGoods.Button3Click(Sender: TObject);
begin
  if IsNewGoods then
  begin
  if BufSun.RecordCount <=0 then exit;
  BufSun.Delete;
  end
  else
  begin
  dbParentAllot.UpdateObject:=ALLOTUpdateSQL;
    ALLOTUpdateSQL.InsertSQL.Text:='';
    ALLOTUpdateSQL.DeleteSQL.Text:='DELETE FROM ALLOT WHERE ID=:ID';
    dbParentAllot.Delete;
  end;

end;

procedure TFAddGoods.Button4Click(Sender: TObject);
begin
  close;
end;

procedure TFAddGoods.Button5Click(Sender: TObject);
begin
  if Formspec.IniciaSpecs then
  AllSpecQuery.Refresh;
end;

procedure TFAddGoods.Button6Click(Sender: TObject);
begin
  FormGoodsSkuList.IniciarSkuList(DBGoodsQuery);
end;

procedure TFAddGoods.Button7Click(Sender: TObject);
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
    ParamByName('SKU_NO').AsString:=DBGoodsSkuQuery.FieldByName('SKU_NO').AsString;
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

procedure TFAddGoods.Button8Click(Sender: TObject);
begin
  ItemsClear();
   ENAEdit.Text:='';
   ENAEdit.SetFocus;

end;

procedure TFAddGoods.CanDiscountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.CantidadKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.CategoryDBBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.CDBCostKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.CDBLOWPRICEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.CDBPvP1cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.CDBPvP2cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.CDBWHOLESALEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.CodingEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.DBCostKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.DBPvP1cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.DBWHOLESALEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.ENAEditEnter(Sender: TObject);
begin
  SpuSpecsMemTable.Close;
 SpuSpecsMemTable.CreateDataset;
end;

  Procedure TFAddGoods.GetBrand();
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

  Procedure TFAddGoods.GetClasse();
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

procedure TFAddGoods.ItemNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;


  procedure TFAddGoods.ItemsClear();
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

  DBWHOLESALE.Value:=0;
 // SKUListQuery.Close;
  DBGoodsQuery.Close;
 // BufDtSun.Close;
  dbParentAllot.Close;
   BufSun.Close;
   CombinaBD.Close;
   dbCombina.Close;
  IsNewGoods:=True;

end;

  function TFAddGoods.ExistGoods(CDBarra: string):boolean;
 begin
     with DBGoodsQuery do
     begin
        Connection:=DataModule2.ZCon1;
        Active:=false;
        SQL.Clear;
       SQL.Text:='SELECT T1.ID, T1.GOODS_ID, T1.GOODS_NAME, T1.GOODS_NAME2, T1.ENA, T1.CODE, T1.CATEGORY_ID, T1.BRAND_ID, T1.TYPE, T1.UNIT, T1.TAXRATE_ID, T1.WEIGTH, T1.VOLUME, T1.IS_ACTIVE, '
       +'T1.PARENT_ID, T1.CLASS_ID, T1.STOCKAVISO, T1.LOWLIMIT, T1.CAN_DISCount, T1.CAPACITY, T1.DAYS_CONSERVACION, T1.DAYS_AVISO, T1.UPDATED_AT, T1.Points, '
         +'T2.COST, T2.PVP1C, T2.PVP2C, T2.PVP3C, T2.LOWPRICE, T2.WHOLESALE, T2.DISCOUNT '   //, T2.Points, T2.SKU_NO
         +'FROM GOODS_SPU AS T1 LEFT JOIN goods_spu_price AS T2 ON T2.GOODS_ID = T1.GOODS_ID '
         +'WHERE 1=1 ' //AND T2.ISCHILD = 0 '
         +'AND T1.ENA=:ENA ';
        ParamByName('ENA').AsString:=CDBarra;
        OPEN;
     end;
   if DBGoodsQuery.RecordCount <> 0 then
     RESULT := TRUE
     ELSE RESULT := FALSE;
 end;

  procedure TFAddGoods.GetGoodsSpuDetail(GoodsId:string);
  begin
     with DBGoodsSkuQuery do
     begin
        Connection:=DataModule2.ZCon1;
        Active:=false;
        SQL.Clear;
       SQL.Text:='SELECT * FROM GOODS_SKU WHERE GOODS_ID =:GOODS_ID ';
        ParamByName('GOODS_ID').AsString:=GOODS_ID;
        OPEN;
     end;
  end;

procedure TFAddGoods.FormShow(Sender: TObject);
begin
   DoGetTaxRates;
GetCategorys();
GetBrand();
GetClasse();
PanelMain.Visible:=True;
PanelMain.Parent:=PanelM;
PanelMain.Align:=alClient;
PanelHijo.Visible:=False;
PanelHijo.Parent:=nil;
CategoryDBBox.KeyValue:= CategoryDBBox.ListSource.DataSet.FieldByName(CategoryDBBox.KeyField).Value;
BrandDBBox.KeyValue:= BrandDBBox.ListSource.DataSet.FieldByName(BrandDBBox.KeyField).Value;
IvaDBLookupComboBox1.KeyValue:=IvaDBLookupComboBox1.ListSource.DataSet.FieldByName(IvaDBLookupComboBox1.KeyField).Value;

end;

Function TFAddGoods.SimpleSave():boolean;
var
  I: integer;
  NewSKU_NO:string;
  theVar: Variant;
  theInt: integer;
begin

  if length(ENAEdit.Text) >  13 then
  begin
    showmessage('这不是正确的条形码,  似乎是整箱条码, 请选择别的模式.');
    TypeBox.SetFocus;
  end;
 with dbTrabajo do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU '
       +'(GOODS_ID, GOODS_NAME, GOODS_NAME2,  ENA, CODE, CLASS_ID, CATEGORY_ID, BRAND_ID, TYPE, UNIT,  TAXRATE_ID, WEIGTH, VOLUME, IS_ACTIVE, PARENT_ID, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points, CAPACITY)'
       +'VALUES (:GOODS_ID, :GOODS_NAME, :GOODS_NAME2, :ENA, :CODE, :CLASS_ID, :CATEGORY_ID, :BRAND_ID, :TYPE, :UNIT, :TAXRATE_ID, :WEIGTH, :VOLUME, :IS_ACTIVE, :PARENT_ID, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points, CAPACITY ) '
       +'ON DUPLICATE KEY UPDATE '
       +'GOODS_NAME=:GOODS_NAME, GOODS_NAME2=:GOODS_NAME2, CODE=:CODE, CLASS_ID=:CLASS_ID, CATEGORY_ID=:CATEGORY_ID, '
       +'TYPE=:TYPE, UNIT=:UNIT, '
       +'BRAND_ID=:BRAND_ID, TAXRATE_ID=:TAXRATE_ID, WEIGTH=:WEIGTH, VOLUME=:VOLUME, IS_ACTIVE=:IS_ACTIVE, STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, '
       +'CAN_DISCount=:CAN_DISCount, Points=:Points, CAPACITY=:CAPACITY ';
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
    ParamByName('Points').AsFloat:=0;
    theVar:=MNum.Value;
    theInt:=theVar;
    ParamByName('CAPACITY').asinteger:=theInt;
    ExecSQL;

    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU_PRICE (GOODS_ID, COST, PVP1C, PVP2C, PVP3C, LOWPRICE, WHOLESALE, DISCOUNT) '
          +'VALUES (:GOODS_ID, :COST, :PVP1C, :PVP2C, :PVP3C, :LOWPRICE, :WHOLESALE, :DISCOUNT) '
          +'ON DUPLICATE KEY UPDATE '
          +'COST=:COST, PVP1C=:PVP1C, PVP2C=:PVP2C, PVP3C=:PVP3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT ';
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('COST').AsCurrency:=DBCost.Value;
          ParamByName('PVP1C').AsCurrency:=DBPvP1c.Value;
          ParamByName('PVP2C').AsCurrency:=0;
          ParamByName('PVP3C').AsCurrency:=0;
          ParamByName('LOWPRICE').AsCurrency:=0;
          ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
          ParamByName('DISCOUNT').AsCurrency:=0;
    ExecSQL;


    //单一商品没有规格属性分类.
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points ) '
    +'VALUES (UUID(), :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points)'
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD, '
    +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
     ParamByName('SKU_NAME').AsString:='';     //只允许spec的商品用有SKU_NAME.
     ParamByName('COST').AsCurrency:=DBCost.Value;
     ParamByName('SELLING_P1C').AsCurrency:=DBPvP1c.Value;
     ParamByName('SELLING_P2C').AsCurrency:=0;
     ParamByName('SELLING_P3C').AsCurrency:=0;
     ParamByName('LOWPRICE').AsCurrency:=0;
     ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
     ParamByName('DISCOUNT').AsFloat:=0;
     ParamByName('GOODS_ID').AsString:=GOODS_ID;
     ParamByName('SKU_CODING').AsString:=ENAEdit.Text;
     ParamByName('ISCHILD').AsInteger:=0;
     if AvisoLimit.ItemIndex=1 then ParamByName('STOCKAVISO').AsInteger:=1
       else ParamByName('STOCKAVISO').AsInteger:=0;
     ParamByName('LOWLIMIT').AsFloat:=LowLimit.Value;
     if CanDiscount.ItemIndex=1 then ParamByName('CAN_DISCount').AsInteger:=1
       else ParamByName('CAN_DISCount').AsInteger:=0;
     ParamByName('Points').AsFloat:=0;
     ExecSQL;

 end;
   ItemsClear();
   ENAEdit.Text:='';
  // btnClonar.Enabled:=False;
  // ENAEdit.SetFocus;

  // Hecho:=True;

  result:=True;

end;



Function TFAddGoods.ShelfLifeSave():boolean;
var
  I: integer;
  NewSKU_NO:string;
  theVar: Variant;
  theInt: integer;
begin

  if length(ENAEdit.Text) >  13 then
  begin
    showmessage('这不是正确的条形码,  似乎是整箱条码, 请选择别的模式.');
    TypeBox.SetFocus;
  end;
 with dbTrabajo do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU '
       +'(GOODS_ID, GOODS_NAME, GOODS_NAME2,  ENA, CODE, CLASS_ID, CATEGORY_ID, BRAND_ID, TYPE, UNIT,  TAXRATE_ID, WEIGTH, VOLUME, IS_ACTIVE, PARENT_ID, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points, CAPACITY, DAYS_CONSERVACION, DAYS_AVISO)'
       +'VALUES (:GOODS_ID, :GOODS_NAME, :GOODS_NAME2, :ENA, :CODE, :CLASS_ID, :CATEGORY_ID, :BRAND_ID, :TYPE, :UNIT, :TAXRATE_ID, :WEIGTH, :VOLUME, :IS_ACTIVE, :PARENT_ID, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points, :CAPACITY, :DAYS_CONSERVACION, :DAYS_AVISO ) '
       +'ON DUPLICATE KEY UPDATE '
       +'GOODS_NAME=:GOODS_NAME, GOODS_NAME2=:GOODS_NAME2, CODE=:CODE, CLASS_ID=:CLASS_ID, CATEGORY_ID=:CATEGORY_ID, '
       +'TYPE=:TYPE, UNIT=:UNIT, '
       +'BRAND_ID=:BRAND_ID, TAXRATE_ID=:TAXRATE_ID, WEIGTH=:WEIGTH, VOLUME=:VOLUME, IS_ACTIVE=:IS_ACTIVE, STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, '
       +'CAN_DISCount=:CAN_DISCount, Points=:Points, CAPACITY=:CAPACITY, DAYS_CONSERVACION=:DAYS_CONSERVACION, DAYS_AVISO=:DAYS_AVISO ';
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
    ParamByName('Points').AsFloat:=0;
    theVar:=MNum.Value;
    theInt:=theVar;
    ParamByName('CAPACITY').asinteger:=theInt;
    ParamByName('DAYS_CONSERVACION').asinteger:=Conserva.AsInteger;
    ParamByName('DAYS_AVISO').asinteger:=DaysAviso.AsInteger;
    ExecSQL;

    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU_PRICE (GOODS_ID, COST, PVP1C, PVP2C, PVP3C, LOWPRICE, WHOLESALE, DISCOUNT) '
          +'VALUES (:GOODS_ID, :COST, :PVP1C, :PVP2C, :PVP3C, :LOWPRICE, :WHOLESALE, :DISCOUNT) '
          +'ON DUPLICATE KEY UPDATE '
          +'COST=:COST, PVP1C=:PVP1C, PVP2C=:PVP2C, PVP3C=:PVP3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT ';
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('COST').AsCurrency:=DBCost.Value;
          ParamByName('PVP1C').AsCurrency:=DBPvP1c.Value;
          ParamByName('PVP2C').AsCurrency:=0;
          ParamByName('PVP3C').AsCurrency:=0;
          ParamByName('LOWPRICE').AsCurrency:=0;
          ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
          ParamByName('DISCOUNT').AsCurrency:=0;
    ExecSQL;


    //此商品没有规格属性分类.
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points ) '
    +'VALUES (UUID(), :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points)'
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD, '
    +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
     ParamByName('SKU_NAME').AsString:='';     //只允许spec的商品用有SKU_NAME.
     ParamByName('COST').AsCurrency:=DBCost.Value;
     ParamByName('SELLING_P1C').AsCurrency:=DBPvP1c.Value;
     ParamByName('SELLING_P2C').AsCurrency:=0;
     ParamByName('SELLING_P3C').AsCurrency:=0;
     ParamByName('LOWPRICE').AsCurrency:=0;
     ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
     ParamByName('DISCOUNT').AsFloat:=0;
     ParamByName('GOODS_ID').AsString:=GOODS_ID;
     ParamByName('SKU_CODING').AsString:=ENAEdit.Text;
     ParamByName('ISCHILD').AsInteger:=0;
     if AvisoLimit.ItemIndex=1 then ParamByName('STOCKAVISO').AsInteger:=1
       else ParamByName('STOCKAVISO').AsInteger:=0;
     ParamByName('LOWLIMIT').AsFloat:=LowLimit.Value;
     if CanDiscount.ItemIndex=1 then ParamByName('CAN_DISCount').AsInteger:=1
       else ParamByName('CAN_DISCount').AsInteger:=0;
     ParamByName('Points').AsFloat:=0;
     ExecSQL;

 end;
   ItemsClear();
   ENAEdit.Text:='';
  // btnClonar.Enabled:=False;
  // ENAEdit.SetFocus;

  // Hecho:=True;

  result:=True;

end;

Function TFAddGoods.GetSelectedSpecCount():Integer;
var
  i, count:Integer;
  Item: TListItem;
begin
   count:=0;
   for i:=0 to LVSpecs.Items.Count - 1 do
      begin
      Item:=LVSpecs.Items[i];
      if Item.Checked then
         begin
           inc(count);
         end;
      end;
   result:=count;
end;

Function TFAddGoods.SpecGoodsSave():boolean;
var
  i: integer;
  Item: TListItem;
begin
   if length(ENAEdit.Text) >  13 then
  begin
    showmessage('这不是正确的条形码,  似乎是整箱条码, 请选择别的模式.');
    TypeBox.SetFocus;
  end;
   if (SpuSpecsMemTable.RecordCount < 1) or (GetSelectedSpecCount() < 1) then
   begin
   showmessage('属性商品必须要选择必要的属性.');
   Button5.SetFocus;
   end;
 with dbTrabajo do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU '
       +'(GOODS_ID, GOODS_NAME, GOODS_NAME2,  ENA, CODE, CLASS_ID, CATEGORY_ID, BRAND_ID, TYPE, UNIT,  TAXRATE_ID, WEIGTH, VOLUME, IS_ACTIVE, PARENT_ID, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points, CAPACITY, DAYS_CONSERVACION, DAYS_AVISO)'
       +'VALUES (:GOODS_ID, :GOODS_NAME, :GOODS_NAME2, :ENA, :CODE, :CLASS_ID, :CATEGORY_ID, :BRAND_ID, :TYPE, :UNIT, :TAXRATE_ID, :WEIGTH, :VOLUME, :IS_ACTIVE, :PARENT_ID, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points, :CAPACITY, :DAYS_CONSERVACION, :DAYS_AVISO ) '
       +'ON DUPLICATE KEY UPDATE '
       +'GOODS_NAME=:GOODS_NAME, GOODS_NAME2=:GOODS_NAME2, CODE=:CODE, CLASS_ID=:CLASS_ID, CATEGORY_ID=:CATEGORY_ID, '
       +'TYPE=:TYPE, UNIT=:UNIT, '
       +'BRAND_ID=:BRAND_ID, TAXRATE_ID=:TAXRATE_ID, WEIGTH=:WEIGTH, VOLUME=:VOLUME, IS_ACTIVE=:IS_ACTIVE, STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, '
       +'CAN_DISCount=:CAN_DISCount, Points=:Points, CAPACITY=:CAPACITY, DAYS_CONSERVACION=:DAYS_CONSERVACION, DAYS_AVISO=:DAYS_AVISO ';
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
    ParamByName('Points').AsFloat:=0;
   // theVar:=MNum.Value;
   // theInt:=theVar;
    ParamByName('CAPACITY').asinteger:=MNum.AsInteger;
    ParamByName('DAYS_CONSERVACION').asinteger:=Conserva.AsInteger;
    ParamByName('DAYS_AVISO').asinteger:=DaysAviso.AsInteger;
    ExecSQL;

    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU_PRICE (GOODS_ID, COST, PVP1C, PVP2C, PVP3C, LOWPRICE, WHOLESALE, DISCOUNT) '
          +'VALUES (:GOODS_ID, :COST, :PVP1C, :PVP2C, :PVP3C, :LOWPRICE, :WHOLESALE, :DISCOUNT) '
          +'ON DUPLICATE KEY UPDATE '
          +'COST=:COST, PVP1C=:PVP1C, PVP2C=:PVP2C, PVP3C=:PVP3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT ';
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('COST').AsCurrency:=DBCost.Value;
          ParamByName('PVP1C').AsCurrency:=DBPvP1c.Value;
          ParamByName('PVP2C').AsCurrency:=0;
          ParamByName('PVP3C').AsCurrency:=0;
          ParamByName('LOWPRICE').AsCurrency:=0;
          ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
          ParamByName('DISCOUNT').AsCurrency:=0;
    ExecSQL;
    //属性值等在进货入库时输入。
    SQl.Clear;
    sql.Text:='INSERT INTO goods_spu_attribute(GOODS_ID, ATTIBUTE_ID) VALUES(:GOODS_ID, :ATTIBUTE_ID) '
    +'ON DUPLICATE KEY UPDATE IS_DELETE = :IS_DELETE,  UPDATE_TIME=now() ';
    {for i:=0 to LVSpecs.Items.Count - 1 do
      begin
      Item:=LVSpecs.Items[i];
      if (Item.Checked) and (Item.SubItems[0] <> '') then
         begin
         ParamByName('GOODS_ID').AsString:=GOODS_ID;
         ParamByName('ATTIBUTE_ID').AsString:=Item.SubItems[0];
         ExecSQL;
         end;
      end;
      }
      SpuSpecsMemTable.First;
      for i:=0 to SpuSpecsMemTable.RecordCount -1 do
        begin
        if SpuSpecsMemTable.FieldByName('IS_DELETE').AsInteger = 1 then
          if not SpuSpecQuery.Locate('GOODS_ID;ATTIBUTE_ID', VarArrayOf([SpuSpecsMemTable.FieldByName('GOODS_ID').AsString,SpuSpecsMemTable.FieldByName('ATTIBUTE_ID').AsInteger]),[]) then
          begin
          SpuSpecsMemTable.Next;
          Continue;
          end;
         ParamByName('GOODS_ID').AsString:=SpuSpecsMemTable.FieldByName('GOODS_ID').AsString;
         ParamByName('ATTIBUTE_ID').AsInteger:=SpuSpecsMemTable.FieldByName('ATTIBUTE_ID').AsInteger;
         ParamByName('IS_DELETE').AsInteger:=SpuSpecsMemTable.FieldByName('IS_DELETE').AsInteger;
         ExecSQL;
         SpuSpecsMemTable.Next;
        end;
 end;


   ItemsClear();
   ENAEdit.Text:='';


  result:=True;
end;
Function TFAddGoods.GetTotalAllot():integer;
var
  allot:integer;
  I: integer;
begin
  allot:=0;
  if IsNewGoods then
  begin
  DSSun.DataSet.First;
  for I := 0 to DSSun.DataSet.RecordCount-1 do
    begin
      allot:=allot+DSSun.DataSet.FieldByName('ALLOT').AsInteger;
      DSSun.DataSet.Next;
    end;
  end
  else
  begin
   ALLOTDS.DataSet.First;
   for I := 0 to ALLOTDS.DataSet.RecordCount-1 do
    begin
      allot:=allot+ALLOTDS.DataSet.FieldByName('ALLOT').AsInteger;
      ALLOTDS.DataSet.Next;
    end;
  end;

  result:=allot;
end;

function TFAddGoods.SetSave(): boolean;
var
  parentId, I:integer;
begin
//**
///  先保存箱货品

with dbTrabajo do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU '
       +'(GOODS_ID, GOODS_NAME, GOODS_NAME2,  ENA, CODE, CLASS_ID, CATEGORY_ID, BRAND_ID, TYPE, UNIT,  TAXRATE_ID, WEIGTH, VOLUME, IS_ACTIVE, PARENT_ID, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points, CAPACITY)'
       +'VALUES (:GOODS_ID, :GOODS_NAME, :GOODS_NAME2, :ENA, :CODE, :CLASS_ID, :CATEGORY_ID, :BRAND_ID, :TYPE, :UNIT, :TAXRATE_ID, :WEIGTH, :VOLUME, :IS_ACTIVE, :PARENT_ID, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points, :CAPACITY ) '
       +'ON DUPLICATE KEY UPDATE '
       +'GOODS_NAME=:GOODS_NAME, GOODS_NAME2=:GOODS_NAME2, CODE=:CODE, CLASS_ID=:CLASS_ID, CATEGORY_ID=:CATEGORY_ID, '
       +'TYPE=:TYPE, UNIT=:UNIT, '
       +'BRAND_ID=:BRAND_ID, TAXRATE_ID=:TAXRATE_ID, WEIGTH=:WEIGTH, VOLUME=:VOLUME, IS_ACTIVE=:IS_ACTIVE, STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, '
       +'CAN_DISCount=:CAN_DISCount, Points=:Points, CAPACITY=:CAPACITY ';
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
    ParamByName('STOCKAVISO').AsInteger:=0;
    ParamByName('LOWLIMIT').AsFloat:=0;
    ParamByName('CAN_DISCount').AsInteger:=1;
    ParamByName('Points').AsFloat:=0;
    ParamByName('CAPACITY').asinteger:=MNum.AsInteger;
    ExecSQL;

    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU_PRICE (GOODS_ID, COST, PVP1C, PVP2C, PVP3C, LOWPRICE, WHOLESALE, DISCOUNT) '
          +'VALUES (:GOODS_ID, :COST, :PVP1C, :PVP2C, :PVP3C, :LOWPRICE, :WHOLESALE, :DISCOUNT) '
          +'ON DUPLICATE KEY UPDATE '
          +'COST=:COST, PVP1C=:PVP1C, PVP2C=:PVP2C, PVP3C=:PVP3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT ';
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('COST').AsCurrency:=DBCost.Value;
          ParamByName('PVP1C').AsCurrency:=DBPvP1c.Value;
          ParamByName('PVP2C').AsCurrency:=0;
          ParamByName('PVP3C').AsCurrency:=0;
          ParamByName('LOWPRICE').AsCurrency:=0;
          ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
          ParamByName('DISCOUNT').AsCurrency:=0;
    ExecSQL;

    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points ) '
    +'VALUES (UUID(), :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points)'
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD, '
    +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
     ParamByName('SKU_NAME').AsString:='';     //只允许spec的商品用有SKU_NAME.
     ParamByName('COST').AsCurrency:=DBCost.Value;
     ParamByName('SELLING_P1C').AsCurrency:=DBPvP1c.Value;
     ParamByName('SELLING_P2C').AsCurrency:=0;
     ParamByName('SELLING_P3C').AsCurrency:=0;
     ParamByName('LOWPRICE').AsCurrency:=0;
     ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
     ParamByName('DISCOUNT').AsFloat:=0;
     ParamByName('GOODS_ID').AsString:=GOODS_ID;
     ParamByName('SKU_CODING').AsString:=ENAEdit.Text;
     ParamByName('ISCHILD').AsInteger:=0;
     ParamByName('STOCKAVISO').AsInteger:=0;
     ParamByName('LOWLIMIT').AsFloat:=LowLimit.Value;
     ParamByName('CAN_DISCount').AsInteger:=1;
     ParamByName('Points').AsFloat:=0;
     ExecSQL;
 end;
//保存子货品
   parentId:=GetId(GOODS_ID);
   if ParentId = 0 then
   begin
     showmessage('分箱(套)保存错误');
     exit;
   end;

    if IsNewGoods then
    begin
    DSSun.DataSet.First;
    for I := 0 to DSSun.DataSet.RecordCount-1 do
    begin
    with dbTrabajo do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU '
    +'(GOODS_ID, GOODS_NAME, GOODS_NAME2,  ENA, CODE, CLASS_ID, CATEGORY_ID, BRAND_ID, TYPE, UNIT,  TAXRATE_ID, WEIGTH, VOLUME, IS_ACTIVE, PARENT_ID, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points, Allot)'
    +'VALUES (:GOODS_ID, :GOODS_NAME, :GOODS_NAME2, :ENA, :CODE, :CLASS_ID, :CATEGORY_ID, :BRAND_ID, :TYPE, :UNIT, :TAXRATE_ID, :WEIGTH, :VOLUME, :IS_ACTIVE, :PARENT_ID, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points, :Allot ) '
    +'ON DUPLICATE KEY UPDATE '
    +'GOODS_NAME=:GOODS_NAME, GOODS_NAME2=:GOODS_NAME2, CODE=:CODE, CLASS_ID=:CLASS_ID, CATEGORY_ID=:CATEGORY_ID, '
    +'TYPE=:TYPE, UNIT=:UNIT, '
    +'BRAND_ID=:BRAND_ID, TAXRATE_ID=:TAXRATE_ID, WEIGTH=:WEIGTH, VOLUME=:VOLUME, IS_ACTIVE=:IS_ACTIVE, STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, '
    +'CAN_DISCount=:CAN_DISCount, Points=:Points, Allot=:Allot ';
    ParamByName('GOODS_ID').AsString:=DSSun.DataSet.FieldByName('UUID').AsString;
    ParamByName('GOODS_NAME').AsString:=DSSun.DataSet.FieldByName('Name').AsString;
    ParamByName('GOODS_NAME2').AsString:=DSSun.DataSet.FieldByName('Name2').AsString;
    ParamByName('ENA').AsString:=DSSun.DataSet.FieldByName('ENA').AsString;
    ParamByName('CODE').AsString:=DSSun.DataSet.FieldByName('CODE').AsString;
    ParamByName('CLASS_ID').AsInteger:=0;
    ParamByName('CATEGORY_ID').AsInteger:=CategoryDBBox.KeyValue;
    ParamByName('BRAND_ID').AsInteger:=BrandDBBox.KeyValue;
    ParamByName('TYPE').AsInteger:=0;
    ParamByName('UNIT').AsString:=DSSun.DataSet.FieldByName('MUNIT').AsString;
    ParamByName('TAXRATE_ID').AsInteger:=IvaDBLookupComboBox1.KeyValue;
    ParamByName('WEIGTH').AsString:= '';  //WEIGTHEdit.Text;
    ParamByName('VOLUME').AsString:=DSSun.DataSet.FieldByName('Volumn').AsString;
    ParamByName('IS_ACTIVE').AsInteger:=1;
    ParamByName('PARENT_ID').AsInteger:=parentId;
    ParamByName('STOCKAVISO').AsInteger:=DSSun.DataSet.FieldByName('Aviso').AsInteger;
    ParamByName('LOWLIMIT').AsFloat:=DSSun.DataSet.FieldByName('AVISONUM').AsFloat;
    ParamByName('CAN_DISCount').AsInteger:=1;
    ParamByName('Points').AsFloat:=0;
    ParamByName('Allot').asinteger:=0;          //DSSun.DataSet.FieldByName('Allot').AsInteger;
    ExecSQL;

    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU_PRICE (GOODS_ID, COST, PVP1C, PVP2C, PVP3C, LOWPRICE, WHOLESALE, DISCOUNT) '
    +'VALUES (:GOODS_ID, :COST, :PVP1C, :PVP2C, :PVP3C, :LOWPRICE, :WHOLESALE, :DISCOUNT) '
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, PVP1C=:PVP1C, PVP2C=:PVP2C, PVP3C=:PVP3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT ';
    ParamByName('GOODS_ID').AsString:=DSSun.DataSet.FieldByName('UUID').AsString;
    ParamByName('COST').AsCurrency:=DSSun.DataSet.FieldByName('Cost').AsFloat;
    ParamByName('PVP1C').AsCurrency:=DSSun.DataSet.FieldByName('PVP').AsFloat;
    ParamByName('PVP2C').AsCurrency:=0;
    ParamByName('PVP3C').AsCurrency:=0;
    ParamByName('LOWPRICE').AsCurrency:=0;
    ParamByName('WHOLESALE').AsCurrency:=DSSun.DataSet.FieldByName('WholePrice').AsFloat;
    ParamByName('DISCOUNT').AsCurrency:=0;
    ExecSQL;

    //插入数据到副表
    sql.Clear;
    Sql.Text:='INSERT INTO ALLOT (ALLOT, GOODS_ID, ENA, PARENT_ID) '
    +'VALUES(:ALLOT, :GOODS_ID, :ENA, :PARENT_ID) '
    +'ON DUPLICATE KEY UPDATE '
    +'ALLOT =:ALLOT ';
    ParamByName('Allot').asinteger:=DSSun.DataSet.FieldByName('Allot').AsInteger;
    ParamByName('GOODS_ID').AsString:=DSSun.DataSet.FieldByName('UUID').AsString;
    ParamByName('ENA').AsString:=DSSun.DataSet.FieldByName('ENA').AsString;
    ParamByName('PARENT_ID').AsInteger:=parentId;
    EXECSQL;

    SQL.Clear;
    if DSSun.DataSet.FieldByName('SKU_NO').AsString <> '' then
    begin
    sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points ) '
    +'VALUES (:SKU_NO, :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points)'
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD, '
    +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
    ParamByName('SKU_NO').AsString:=DSSun.DataSet.FieldByName('SKU_NO').AsString;
    end
    else
    sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points ) '
    +'VALUES (UUID(), :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points)'
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD, '
    +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ' ;

    ParamByName('SKU_NAME').AsString:='';     //只允许spec的商品用有SKU_NAME.
    ParamByName('COST').AsCurrency:=DSSun.DataSet.FieldByName('Cost').AsFloat;
    ParamByName('SELLING_P1C').AsCurrency:=DSSun.DataSet.FieldByName('PVP').AsFloat;
    ParamByName('SELLING_P2C').AsCurrency:=0;
    ParamByName('SELLING_P3C').AsCurrency:=0;
    ParamByName('LOWPRICE').AsCurrency:=0;
    ParamByName('WHOLESALE').AsCurrency:=DSSun.DataSet.FieldByName('WholePrice').AsFloat;
    ParamByName('DISCOUNT').AsFloat:=0;
    ParamByName('GOODS_ID').AsString:=DSSun.DataSet.FieldByName('UUID').AsString;
    ParamByName('SKU_CODING').AsString:=DSSun.DataSet.FieldByName('ENA').AsString;
    ParamByName('ISCHILD').AsInteger:=1;
    ParamByName('STOCKAVISO').AsInteger:=DSSun.DataSet.FieldByName('Aviso').AsInteger;
    ParamByName('LOWLIMIT').AsFloat:=DSSun.DataSet.FieldByName('AVISONUM').AsFloat;
    ParamByName('CAN_DISCount').AsInteger:=1;
    ParamByName('Points').AsFloat:=0;
    ExecSQL;
    end;
    DSSun.DataSet.Next;
    end;
  end;


end;

procedure TFAddGoods.CombinaSave();
var
  NewSKU_NO:string;
  i:integer;
begin

with dbTrabajo do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU '
       +'(GOODS_ID, GOODS_NAME, GOODS_NAME2,  ENA, CODE, CLASS_ID, CATEGORY_ID, BRAND_ID, TYPE, UNIT,  TAXRATE_ID, WEIGTH, VOLUME, IS_ACTIVE, PARENT_ID, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points, CAPACITY)'
       +'VALUES (:GOODS_ID, :GOODS_NAME, :GOODS_NAME2, :ENA, :CODE, :CLASS_ID, :CATEGORY_ID, :BRAND_ID, :TYPE, :UNIT, :TAXRATE_ID, :WEIGTH, :VOLUME, :IS_ACTIVE, :PARENT_ID, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points, CAPACITY ) '
       +'ON DUPLICATE KEY UPDATE '
       +'GOODS_NAME=:GOODS_NAME, GOODS_NAME2=:GOODS_NAME2, CODE=:CODE, CLASS_ID=:CLASS_ID, CATEGORY_ID=:CATEGORY_ID, '
       +'TYPE=:TYPE, UNIT=:UNIT, '
       +'BRAND_ID=:BRAND_ID, TAXRATE_ID=:TAXRATE_ID, WEIGTH=:WEIGTH, VOLUME=:VOLUME, IS_ACTIVE=:IS_ACTIVE, STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, '
       +'CAN_DISCount=:CAN_DISCount, Points=:Points, CAPACITY=:CAPACITY ';
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
    ParamByName('Points').AsFloat:=0;
    ParamByName('CAPACITY').asinteger:=0;
    ExecSQL;

    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SPU_PRICE (GOODS_ID, COST, PVP1C, PVP2C, PVP3C, LOWPRICE, WHOLESALE, DISCOUNT) '
          +'VALUES (:GOODS_ID, :COST, :PVP1C, :PVP2C, :PVP3C, :LOWPRICE, :WHOLESALE, :DISCOUNT) '
          +'ON DUPLICATE KEY UPDATE '
          +'COST=:COST, PVP1C=:PVP1C, PVP2C=:PVP2C, PVP3C=:PVP3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT ';
    ParamByName('GOODS_ID').AsString:=GOODS_ID;
    ParamByName('COST').AsCurrency:=DBCost.Value;
          ParamByName('PVP1C').AsCurrency:=DBPvP1c.Value;
          ParamByName('PVP2C').AsCurrency:=0;
          ParamByName('PVP3C').AsCurrency:=0;
          ParamByName('LOWPRICE').AsCurrency:=0;
          ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
          ParamByName('DISCOUNT').AsCurrency:=0;
    ExecSQL;


    //组合商品没有规格属性分类.
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO, LOWLIMIT, CAN_DISCount, Points ) '
    +'VALUES (UUID(), :SKU_NAME, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points)'
    +'ON DUPLICATE KEY UPDATE '
    +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD, '
    +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
     ParamByName('SKU_NAME').AsString:='';     //只允许spec的商品用有SKU_NAME.
     ParamByName('COST').AsCurrency:=DBCost.Value;
     ParamByName('SELLING_P1C').AsCurrency:=DBPvP1c.Value;
     ParamByName('SELLING_P2C').AsCurrency:=0;
     ParamByName('SELLING_P3C').AsCurrency:=0;
     ParamByName('LOWPRICE').AsCurrency:=0;
     ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
     ParamByName('DISCOUNT').AsFloat:=0;
     ParamByName('GOODS_ID').AsString:=GOODS_ID;
     ParamByName('SKU_CODING').AsString:=ENAEdit.Text;
     ParamByName('ISCHILD').AsInteger:=0;
     if AvisoLimit.ItemIndex=1 then ParamByName('STOCKAVISO').AsInteger:=1
       else ParamByName('STOCKAVISO').AsInteger:=0;
     ParamByName('LOWLIMIT').AsFloat:=LowLimit.Value;
     if CanDiscount.ItemIndex=1 then ParamByName('CAN_DISCount').AsInteger:=1
       else ParamByName('CAN_DISCount').AsInteger:=0;
     ParamByName('Points').AsFloat:=0;
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


 end;

end;

Function  TFAddGoods.GetId(goodsId:string):integer;
var
  Id: integer;
begin
Id:=0;
  with dbFind  do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='select ID from GOODS_SPU where 1=1 and GOODS_ID=:GOODS_ID ';
    ParamByName('GOODS_ID').AsString:=goodsId;
    open;
    id:=FieldByName('ID').AsInteger;
 end;
  result:=Id;
end;

Procedure TFAddGoods.GetParentAllot(ParentId:integer);
var
  i:integer;
begin
   with dbParentAllot do
     begin
        Connection:=DataModule2.ZCon1;
        Active:=false;
        SQL.Clear;
        Sql.Text:='SELECT T1.ID, T1.ALLOT, T1.GOODS_ID, T1.ENA, T1.PARENT_ID, T2.COST, T2.PVP1C AS PVP FROM ALLOT AS T1 LEFT JOIN GOODS_SPU_PRICE AS T2 ON T1.GOODS_ID = T2.GOODS_ID WHERE 1=1 and T1.PARENT_ID = :Parent_Id ';
        ParamByName('Parent_Id').AsInteger:= ParentId;
        open;
     end;
   {
   if dbParentAllot.RecordCount > 0 then
   begin
     dbParentAllot.First;
     BufSun.Open;
     for I := 0 to dbParentAllot.RecordCount-1 do
      begin
        with DBGoods2 do
        begin
        Connection:=DataModule2.ZCon1;
        Active:=false;
        SQL.Clear;
        SQL.Text:='SELECT T1.GOODS_ID, T1.GOODS_NAME, T1.GOODS_NAME2, T1.ENA, T1.CODE, T1.CATEGORY_ID, T1.BRAND_ID, T1.TYPE, T1.UNIT, T1.TAXRATE_ID, T1.WEIGTH, T1.VOLUME, T1.IS_ACTIVE, '
        +'T1.PARENT_ID, T1.CLASS_ID, T1.STOCKAVISO, T1.LOWLIMIT, T1.CAN_DISCount, T1.UPDATED_AT, '
        +'T2.COST, T2.SELLING_P1C, T2.SELLING_P2C, T2.SELLING_P3C, T2.LOWPRICE, T2.WHOLESALE, T2.DISCOUNT, T2.Points, T2.SKU_NO '
        +'FROM GOODS_SPU AS T1 LEFT JOIN GOODS_SKU AS T2 ON T2.GOODS_ID = T1.GOODS_ID '
        +'WHERE 1=1  '         //AND T2.ISCHILD = 0
        +'AND T1.ENA=:ENA Limit 1';
        ParamByName('ENA').AsString:=dbParentAllot.FieldByName('ENA').AsString;
        OPEN;
        end;

        with BufSun do
        begin
          Insert;
          BufSun.FieldByName('ENA').AsString:=DBGoods2.FieldByName('ENA').AsString;
          BufSun.FieldByName('CODE').AsString:=DBGoods2.FieldByName('CODE').AsString;
          BufSun.FieldByName('UUID').AsString:=DBGoods2.FieldByName('GOODS_ID').AsString;
          BufSun.FieldByName('Name').AsString:=DBGoods2.FieldByName('GOODS_NAME').AsString;
          BufSun.FieldByName('Name2').AsString:=DBGoods2.FieldByName('GOODS_Name2').AsString;
          BufSun.FieldByName('Cost').AsCurrency:=DBGoods2.FieldByName('COST').AsCurrency;
          BufSun.FieldByName('PVP').AsCurrency:=DBGoods2.FieldByName('SELLING_P1C').AsCurrency;
          BufSun.FieldByName('WHOLEPRICE').AsCurrency:=DBGoods2.FieldByName('WHOLESALE').AsCurrency;
          BufSun.FieldByName('ALLOT').AsInteger:=dbParentAllot.FieldByName('ALLOT').AsInteger;
          BufSun.FieldByName('SKU_NO').AsString:=DBGoods2.FieldByName('SKU_NO').AsString;

          Post;
        end;
        dbParentAllot.Next;
     end;
   end;
   DBGoods2.Close;
   dbParentAllot.Close;
   }
end;

procedure TFAddGoods.UnidadesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.UUIDEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.VolumeEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.WeigthEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFAddGoods.GetAllSpec();
var
  i:integer;
  str: string;
  Item: TListItem;
begin
  with AllSpecQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    Sql.Text:='select * from  goods_attribute_key';
    open;
  end;
 // ListBox3.Items.Clear;
 LVSpecs.Items.Clear;
  if AllSpecQuery.RecordCount <> 0 then
  begin
    AllSpecQuery.First;
    LVSpecs.Items.BeginUpdate;
     for I := 0 to AllSpecQuery.RecordCount -1 do
     begin
     str:=AllSpecQuery.FieldByName('name').AsString;
   //  SL.Values[ListUniQuery.FieldByName('attibute_id').AsString]:=str;
   //  ListBox3.AddItem(str, TObject( PtrInt(AllSpecQuery.FieldByName('attibute_id').AsInteger)));
     Item:= LVSpecs.Items.Add;
        Item.Caption:= AllSpecQuery.FieldByName('name').AsString;
        Item.SubItems.Add(AllSpecQuery.FieldByName('ATTIBUTE_ID').AsString);
       // Item.SubItems.Add(SpecValuesQuery.FieldByName('ID').AsString);
       // Item.SubItems.Add(SpecValuesQuery.FieldByName('JSON').AsString);
     AllSpecQuery.Next;
     end;
     LVSpecs.Items.EndUpdate;
  end;
end;

Procedure TFAddGoods.GetSpuSpecs(aGoods_id:String );
var
i, spec_id, n, V:integer;
str: string;
Item: TListItem;
begin
   with SpuSpecQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    Sql.Text:='select * from  goods_spu_attribute '
    +'where 1=1 '
    +'AND IS_DELETE = 0 '
    +'AND GOODS_ID = :GOODS_ID ';
    ParamByName('GOODS_ID').AsString:=aGoods_id;
    open;
  end;
   if SpuSpecQuery.RecordCount > 0 then
   begin

    SpuSpecQuery.First;
    SpuSpecsMemTable.DisableControls;
    SpuSpecsMemTable.Open;
     for I := 0 to SpuSpecQuery.RecordCount -1 do
     begin
     SpuSpecsMemTable.Append;
            SpuSpecsMemTable.FieldByName('GOODS_ID').AsString:= SpuSpecQuery.FieldByName('GOODS_ID').AsString;
            SpuSpecsMemTable.FieldByName('ATTIBUTE_ID').AsInteger:=SpuSpecQuery.FieldByName('ATTIBUTE_ID').AsInteger;
            SpuSpecsMemTable.FieldByName('IS_DELETE').AsInteger:=SpuSpecQuery.FieldByName('IS_DELETE').AsInteger;
            SpuSpecsMemTable.Post;

     SpuSpecQuery.Next;
     end;
     SpuSpecsMemTable.EnableControls;

    if SpuSpecsMemTable.RecordCount > 0 then
      begin
        SpuSpecsMemTable.First;
         for I := 0 to SpuSpecsMemTable.RecordCount -1 do
         begin
         spec_id:=SpuSpecsMemTable.FieldByName('ATTIBUTE_ID').AsInteger;
         for n := 0 to LVSpecs.Items.Count-1 do
            begin
            V:=strtoint(LVSpecs.Items.Item[n].SubItems[0]);   //1?? or 0??
              if (V = spec_id )  then
              LVSpecs.Items[n].Checked:=True;
            end;
         SpuSpecsMemTable.Next;
         end;
      end;

   end;
end;

procedure TFAddGoods.GetSpecsValues(Specs_id: integer);
var
  I, n: Integer;
  Item: TListItem;
  spec_id, V:integer;
begin
    LVSpecs.Items.Clear;
    with SpecValuesQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    Sql.Text:='SELECT T1.ID, T1.ATTIBUTE_ID, T1.ATTIBUTE_VALUE,  T2.NAME, '
              +'concat(''"'', T2.Name, ''":"'', T1.ATTIBUTE_VALUE, ''"'') as Json FROM GOODS_ATTRIBUTE_VALUE as T1 '
              +'left join GOODS_ATTRIBUTE_key as T2 '
              +'on T1.ATTIBUTE_ID = T2.ATTIBUTE_ID WHERE T1.ATTIBUTE_ID=:ATTIBUTE_ID ORDER BY ID ';
    ParamByName('ATTIBUTE_ID').AsInteger:= Specs_id;
    open;
  end;
   if SpecValuesQuery.RecordCount <> 0 then
  begin
    SpecValuesQuery.First;
    LVSpecs.Items.BeginUpdate;
  try
    for I := 0 to SpecValuesQuery.RecordCount-1 do
      begin
        Item:= LVSpecs.Items.Add;
        Item.Caption:= SpecValuesQuery.FieldByName('ATTIBUTE_VALUE').AsString;
        Item.SubItems.Add(SpecValuesQuery.FieldByName('ATTIBUTE_ID').AsString);
        Item.SubItems.Add(SpecValuesQuery.FieldByName('ID').AsString);
        Item.SubItems.Add(SpecValuesQuery.FieldByName('JSON').AsString);
        SpecValuesQuery.Next;
      end;
  finally
    LVSpecs.Items.EndUpdate;
  end;
  end;
  if MemTable.RecordCount > 0 then
  begin
      MemTable.First;
     for I := 0 to MemTable.RecordCount -1 do
     begin
     spec_id:=MemTable.FieldByName('ATTIBUTE_VALUE_ID').AsInteger;
      for n := 0 to LVSpecs.Items.Count-1 do
        begin
        V:=strtoint(LVSpecs.Items.Item[n].SubItems[1]);   //1?? or 0??
          if (V = spec_id )  then
          LVSpecs.Items[n].Checked:=True;
        end;
     MemTable.Next;
     end;
  end;
end;

end.

