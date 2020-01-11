unit addgood;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, DbCtrls, DBGrids, EditBtn, Buttons, rxcurredit, lclintf,
  ZConnection, ZDataset, Busquedas, Global, Variants , findout, Moduleadd,
  LCLType, ExtDlgs, IniFiles,
  goodslist, Proveedor,
  LazUtils,  printers,
  Translations,DefaultTranslator, Menus,
  connect, PrintersDlgs, db;

type

  { TFormGoods }

  TFormGoods = class(TForm)
    Activa: TComboBox;
    Activa1: TComboBox;
    AvisoCad: TComboBox;
    AvisoMini: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    btnClonar: TBitBtn;
    Button1: TButton;
    Button16: TButton;
    Button17: TButton;
    Button2: TButton;
    Button3: TButton;
    CalPeso: TComboBox;
    CantidadCaja: TCurrencyEdit;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CurrencyEdit1: TCurrencyEdit;
    SLDS: TDataSource;
    GoodsProDS: TDataSource;
    DBCompraDS: TDataSource;
    DBGrid3: TDBGrid;
    EstanteriaDS: TDataSource;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    DateEdit4: TDateEdit;
    DateEdit5: TDateEdit;
    dbArti: TZQuery;
    dbClonar: TZQuery;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid4: TDBGrid;
    DBImage1: TDBImage;
    DBLookupProveedor: TDBLookupComboBox;
    DBPriceBc: TCurrencyEdit;
    DBPriceBs: TCurrencyEdit;
    DBPvP1c: TCurrencyEdit;
    DBPvP1s: TCurrencyEdit;
    DBPvP2c: TCurrencyEdit;
    DBPvP2s: TCurrencyEdit;
    DBPvP3c: TCurrencyEdit;
    DBPvP3s: TCurrencyEdit;
    dbTrabajo: TZQuery;
    DescRebaja: TCurrencyEdit;
    DiasAviso: TCurrencyEdit;
    Edit1: TEdit;
    IdProv: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label36: TLabel;
    LabelIVA: TLabel;
    MainPopupMenu: TPopupMenu;
    Marca: TEdit;
    Medida: TEdit;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    OpenDialog1: TOpenDialog;
    PrintDialog1: TPrintDialog;
    Ubica: TEdit;
    EnRebaja: TComboBox;
    GoodsOfProvQuery: TZQuery;
    GoodsofStockQuery: TZQuery;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Memo2: TMemo;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel3: TPanel;
    Panel4: TPanel;
    RefCaja: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    LimitLow: TCurrencyEdit;
    PVPv: TCurrencyEdit;
    TabSheet7: TTabSheet;
    Unidades: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    DateAdd: TEdit;
    UProveedor: TEdit;
    Edit49: TEdit;
    DateMod: TEdit;
    Edit50: TEdit;
    Lang2: TEdit;
    FmDBLookupComboBox1: TDBLookupComboBox;
    IvaDBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label3: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label4: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label9: TLabel;
    MaxDesc: TCurrencyEdit;
    Memo1: TMemo;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel17: TPanel;
    Panel2: TPanel;
    Panel23: TPanel;
    PermiteDesc: TComboBox;
    ReqDBLookupComboBox1: TDBLookupComboBox;
    Stock: TCurrencyEdit;
    StockListDB: TDBLookupComboBox;
    SubCateDataSource: TDataSource;
    SubCateQuery: TZQuery;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    GoodsDetallesQuery: TZQuery;
    EstanteriaQuery: TZQuery;
    DBCompra: TZQuery;
    StockListQuery: TZQuery;
    procedure Activa1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure ActivaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AvisoCadKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure AvisoMiniKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CalPesoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure Clearup;
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btnClonarClick(Sender: TObject);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBCompraAfterOpen(DataSet: TDataSet);
    procedure DBPriceBcKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBPriceBsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBPvP1cKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBPvP1sKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBPvP2cKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBPvP2sKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBPvP3cKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBPvP3sKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DescRebajaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DiasAvisoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit3Change(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EnRebajaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FmDBLookupComboBox1CloseUp(Sender: TObject);
    procedure FmDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FmDBLookupComboBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure GoodsOfProvQueryAfterOpen(DataSet: TDataSet);
    procedure IvaDBLookupComboBox1Change(Sender: TObject);
    procedure IvaDBLookupComboBox1Click(Sender: TObject);
    procedure IvaDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure IvaDBLookupComboBox1Select(Sender: TObject);
    procedure Lang2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LimitLowKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
   // procedure MainPopupMenuPopup(Sender: TObject);
    Procedure MainPopupClick(Sender: TObject);   //动态菜单OnClick事件响应
    procedure MarcaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MaxDescKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure MedidaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PermiteDescKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UbicaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UnidadesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure UProveedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AbirCajones();
  private
    procedure GetProductDetalles;
    procedure GetGoodsofStock;
    procedure GetGoodsOfProveedor;
    procedure GetGoodsOfEstatetia;
    procedure GetStockList;

  public
    procedure GetAllGoods;
    function Created(new:TGOODS):boolean;

  end;

var
  FormGoods: TFormGoods;
  IsNewGoods:boolean;
  formattedDateTime : string;


implementation

{$R *.lfm}

{ TFormGoods }

procedure TFormGoods.GetAllGoods;
begin
 with DbArti do
 begin
  Connection:=DataModule2.ZCon1;    //DataModule1.UniConn; //
  Active:=False;
  SQL.Clear;
  Sql.Text:='SELECT PRO_REFERENCIA, PRO_LANG1, PRO_CDBARRA FROM '+EmID+'PRODUCTLIST '
      +'WHERE 1=1 ' ;
   Open;
end;

end;

procedure  TFormGoods.GetProductDetalles;
var
cPicStream1: TMemoryStream; {to save to the blob}
cJpegImage1: TJpegImage;
begin
cPicStream1:= TMemoryStream.Create;
 with GoodsDetallesQuery do
 begin
  Connection:=DataModule2.ZCon1;    //DataModule1.UniConn; //
  Active:=False;
  SQL.Clear;
  //Sql.Text:='SELECT * FROM '+EmID+'PRODUCTLIST '
  sql.Text:='SELECT T1.*, T2.NAME as NAME FROM '+EmID+'PRODUCTLIST AS T1 left join '+UseDBC.EmID+'CATEGORYS AS T2 on t1.id_category=t2.id '
      +'WHERE 1=1 '
      +'and PRO_CDBARRA= :PRO_CDBARRA';
     ParamByName('PRO_CDBARRA').AsString:=Trim(Edit1.Text);
   Open;

   if not (RecordCount<1) then
   begin

    Edit2.Text:=FieldByName('PRO_REFERENCIA').AsString;
    Edit3.Text:=FieldByName('PRO_LANG1').AsString;
    Lang2.Text:=FieldByName('PRO_LANG2').AsString;
    Medida.Text:=FieldByName('MEDIDA').AsString;
    if not (FieldByName('ID_CATEGORY').AsString='') then
    begin
    FmDBLookupComboBox1.KeyValue:=FieldByName('ID_CATEGORY').AsString;
    FmDBLookupComboBox1.OnCloseUp(Self);
    end;
   { if not (FieldByName('ID_SUBCATE').AsString='') then
    begin
    FmDBLookupComboBox2.KeyValue:=FieldByName('ID_SUBCATE').AsString;
    end; }
    if not (FieldByName('ID_IMPUESTO').AsString='') then
    begin
    IvaDBLookupComboBox1.KeyValue:=FieldByName('ID_IMPUESTO').AsString;
    end;
    if not (FieldByName('ID_IMPUESTO').AsString='') then
    begin
    ReqDBLookupComboBox1.KeyValue:=FieldByName('ID_IMPUESTO').AsString;
    end;

    Medida.Text:=FieldByName('MEDIDA').AsString;
    Unidades.Text:=FieldByName('UNIDAD').AsString;

    DBPriceBs.Value:= FieldByName('PRECIO_COMPRAS_SIN').Value;
    DBPriceBc.Value:= FieldByName('PRECIO_COMPRAS_CON').Value;
    DBPvP1s.Value:= FieldByName('PVP1S').Value;
    DBPvP1c.Value:= FieldByName('PVP1C').Value;
    DBPvP2s.Value:= FieldByName('PVP2S').Value;
    DBPvP2c.Value:= FieldByName('PVP2C').Value;
    DBPvP3s.Value:= FieldByName('PVP3S').Value;
    DBPvP3c.Value:= FieldByName('PVP3C').Value;
    PVPv.Value:= (FieldByName('PVP1C').AsFloat);
    LimitLow.Value:=FieldByName('STOCK_MINI_LIMIT').Value;
    //LimitHigh.Value:=FieldByName('STOCK_MAX_LIMIT').Value;
    if not (FieldByName('FECHA_FABRICA').AsString='') then
    DateEdit1.Date:=FieldByName('FECHA_FABRICA').AsDateTime;
    if not (FieldByName('FECHA_CADUCA').AsString='') then
    DateEdit1.Date:=FieldByName('FECHA_CADUCA').AsDateTime;
    if not (FieldByName('DIAS_AVISA').IsNull) then
    begin
    DiasAviso.Value:= FieldByName('DIAS_AVISA').Value;
    end;
    DateAdd.Text:=FieldByName('FECHA_ADD').AsString;
    DateMod.Text:=FieldByName('FECHA_MODIFICA').AsString;
    Marca.Text:=FieldByName('MARCA_NOMBRE').AsString;
    Stock.Value:=FieldByName('STOCK_ACTUAL').Value;
    RefCaja.Text:=FieldByName('CDBARRA_CAJA').AsString;
    if not (FieldByName('UNITS_CAJA').IsNull) then
    begin
    CantidadCaja.Value:=FieldByName('UNITS_CAJA').Value;
    end;
    DBImage1.Picture.Graphic:=nil;
    if not FieldByName('IMAGES_DATA').IsNull then
      begin
        TblobField(FieldByName('IMAGES_DATA')).SaveToStream(cPicStream1);
        cPicStream1.Position:=0;
       if SizeOf(cPicStream1)<> 0 then
       begin
       cJpegImage1 := TJpegImage.Create;
       cJpegImage1.LoadFromStream(cPicStream1);
       DBImage1.Picture.Graphic := cJPegImage1;
       cJpegImage1.Free;
       end;
      end;
    if FieldByName('CAN_DISCount').AsBoolean =True then
    PermiteDesc.ItemIndex:=1 else PermiteDesc.ItemIndex:=0;
    MaxDesc.Value:=FieldByName('DISC_Limit').Value;
    if FieldByName('ISOFERTA').AsBoolean =True then
    EnRebaja.ItemIndex:=1 else EnRebaja.ItemIndex:=0;
    DescRebaja.Value:=FieldByName('DISC_SELL').Value;
    if FieldByName('ISPESO').AsBoolean =True then
    CalPeso.ItemIndex:=1 else CalPeso.ItemIndex:=0;

     if FieldByName('CAD_AVISO').AsBoolean =True then
    AvisoCad.ItemIndex:=1 else AvisoCad.ItemIndex:=0;


   // if FieldByName('CAN_FACTURA').AsBoolean =True then
   // PermiteFac.ItemIndex:=1 else PermiteFac.ItemIndex:=0;

  // Ubica.Text:=;

    if FieldByName('STOP_USE').AsBoolean =True then
    Activa.ItemIndex:=0 else Activa.ItemIndex:=1;
    memo1.lines.Text:=FieldByName('OBSERVACION').AsString;
    IsNewGoods:=False;


   end
   else
   begin
    IsNewGoods:=True;
    btnClonar.Enabled:=True;
    //PageControl1.ActivePage:=PGeneral;
    Edit2.Text:=RightStr(Edit1.Text, 6);
   end;


   if not ISNewGoods then GetGoodsofStock;


 end;

end;

procedure TFormGoods.GetGoodsofStock;
begin
 with GoodsofStockQuery do
  begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT A.ID_STOCK, A.NOMBRE, IFNULL(B.PRO_CDBARRA,'''') as PRO_CDBARRA, IFNULL(B.CANTIDAD,0) AS CANTIDAD '
     +'FROM '+EmID+'STOCKLIST AS A left join '+EmID+'STOCKGOODS as B on A.ID_STOCK =b.ID_STOCK and B.PRO_CDBARRA='''+TRIM(EDIT1.Text)+''' ';


     //SQL.Text:='SELECT * FROM '+UseDBC.EmID+'STOCKGOODS '
    // SQL.Text:='SELECT T1.ID_STOCK, T1.PRO_REFERENCIA, T1.PRO_LANG1, T1.PRO_LANG2, T1.PRO_CDBARRA, T2.ID_CATE, T2.CATEGORIA, T2.ID_SUBCATE, T2.SUBCATEGORIA, T1.CANTIDAD, T1.ESTADO FROM '+UseDBC.EmID+'STOCKGOODS AS T1, '+UseDBC.EmID+'PRODUCTLIST AS T2 '
    // +'WHERE 1=1 '
    // +'AND T1.PRO_CDBARRA=T2.PRO_CDBARRA '
    // +'AND ID_STOCK like ''%'+DBLookupComboBox1.Text+'%'' '
    // +'and (T1.PRO_REFERENCIA LIKE ''%' + TRIM(EDIT1.Text)+'%'' '
     //                   +'OR T1.PRO_CDBARRA LIKE ''%' + TRIM(EDIT1.Text)+'%'' '
     //                   +'OR T1.PRO_LANG1 like ''%' + TRIM(EDIT1.Text)+'%'') ' ;


     Open;

  end;
end;

procedure TFormGoods.GetGoodsOfEstatetia;
begin
  with EstanteriaQuery do
 begin
  Connection:=DataModule2.ZCon1; ;
  Active:=False;
  SQL.Clear;
  Sql.Text:='SELECT * FROM '+EmID+'estanteria WHERE 1=1 AND PRO_CDBARRA=:PRO_CDBARRA ; ';
      ParamByName('PRO_CDBARRA').AsString:=Trim(Edit1.Text);

  open;
 end;

end;


procedure TFormGoods.GetGoodsOfProveedor;
var
c:Integer;
begin
WITH GoodsOfProvQuery DO                             //GetBayIDDatos
  BEGIN
   Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
    { SQL.Text:='select *, max(FECHA) from '+UseDBC.EmID+'GOODSOFPROVEEDOR as a '
      +'left join '+UseDBC.EmID+'PROVEEDORLIST b on a.ID_PROVEEDOR=b.ID_PROVEEDOR '
     +'WHERE 1=1 '
     +'AND PRO_CDBARRA=:PRO_CDBARRA GROUP BY b.ID_PROVEEDOR order by A.FECHA desc';  }
     SQL.Text:='SELECT A.PRO_CDBARRA, A.PRO_LANG1, A.PRECIO_CON, A.ID_PROVEEDOR, A.FECHA, B.NAME_COMERCIO  '
     +'FROM '+EmID+'goodsofproveedor as A left join '+EmID+'PROVEEDORLIST b on a.ID_PROVEEDOR=b.ID_PROVEEDOR '
     +'where 1=1 AND PRO_CDBARRA=:PRO_CDBARRA group by b.ID_PROVEEDOR order by A.FECHA desc';
      ParamByName('PRO_CDBARRA').AsString:=Trim(Edit1.Text);

    Open;
  END;

  //DBLookupComboBox2.KeyValue:=GoodsOfProvQuery.FieldByName('ID_PROVEEDOR').AsVariant;
 { ComboBox1.Clear;
  GoodsOfProvQuery.First;
  for c := 0 to GoodsOfProvQuery.RecordCount-1 do
  begin
    ComboBox1.Items.Add(GoodsOfProvQuery.FieldByName('NAME_COMERCIO').AsString);
    GoodsOfProvQuery.Next;
  end;
  ComboBox1.ItemIndex:=0; }

  if GoodsOfProvQuery.RecordCount <=0 then BitBtn19.Visible:=true
  else begin
  GoodsOfProvQuery.First;
  UProveedor.Text:=GoodsOfProvQuery.FieldByName('NAME_COMERCIO').AsString;
  end;

end;

procedure TFormGoods.BitBtn19Click(Sender: TObject);
var
  Result: TStringArray;
  table:string;
begin
  table:=EMID+'PROVEEDORLIST';

  Result:=FormFindout.IniciaBusquedas(table, ['ID_PROVEEDOR','NAME_COMERCIO'], ['Código','Nombre Comercio'] );
  UProveedor.Text:=Result[1];
  IdProv.Text:=Result[0];
  if ((UProveedor.Text='-') or (UProveedor.Text='-1')) then
  begin
  UProveedor.Text:='';  // else Edit1Exit(Edit1);
  IdProv.Text:='';

  end;
  UProveedor.Focused;

end;

procedure TFormGoods.BitBtn20Click(Sender: TObject);
var
  Result: TStringArray;
  table:string;
begin
 table:=EMID+'QUANTIFIER';
  Result:=FormFindout.IniciaBusquedas( table, ['ID','UNIDAD'], ['ID', 'UNIDADES VENTA'] );
  Unidades.Text:=Result[1];
  if ((Unidades.Text='-') or (Unidades.Text='-1')) then
  begin
  Unidades.Text:='';
  end;
  Unidades.Focused;
end;

procedure TFormGoods.BitBtn21Click(Sender: TObject);
var
  Result: TStringArray;
  table:string;
begin
 table:=EMID+'MARCA';
  Result:=FormFindout.IniciaBusquedas( table, ['ID','MARCA_NOMBRE'], ['ID', 'MARCA/FABRICA'] );
  Marca.Text:=Result[1];
  if ((Marca.Text='-') or (Marca.Text='-1')) then
  begin
  Marca.Text:='';
  end;
  Marca.Focused;

end;

procedure TFormGoods.BitBtn3Click(Sender: TObject);
begin
  if Edit1.Text='' then exit;
  if not dbArti.Locate('PRO_CDBARRA', Edit1.Text, []) then
    begin
      Showmessage('ESE REGISTRO NO EXISTE, NO PUEDE BORRARLO!');
      exit;
    end;
   boxstyle :=  MB_ICONQUESTION + MB_YESNO;
   If Application.MessageBox('CONFIRME EL BORRADO DEL REGISTRO','TPV', boxstyle) = IDNO Then
      Exit;
   dbArti.Delete;//---- Borrar articulo
   Edit1.Text := ''; Clearup;
end;

procedure TFormGoods.BitBtn5Click(Sender: TObject);
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

procedure TFormGoods.btnClonarClick(Sender: TObject);

  var
  busqueda: string;
  formattedDateTime : string;
begin
  // Procedimiento para clonar registros de artículos
  busqueda := InputBox(nMSG3,nMSG4,'');

    if not (busqueda = '') then begin
     dbClonar.Connection:=DataModule2.ZCon1;
     if dbClonar.Active=True then dbClonar.Active:=False;
     dbClonar.SQL.Clear;
     dbClonar.SQL.Add('SELECT * FROM '+EmID+'PRODUCTLIST  WHERE 1=1 AND PRO_CDBARRA= '''+busqueda+'''');
     dbClonar.Open;
   if dbClonar.RecordCount>0 then begin
    //Edit2.Text:=dbClonar.FieldByName('PRO_REFERENCIA').AsString;
    Edit3.Text:=dbClonar.FieldByName('PRO_LANG1').AsString;
    Lang2.Text:=dbClonar.FieldByName('PRO_LANG2').AsString;
    Medida.Text:=dbClonar.FieldByName('MEDIDA').AsString;
    if not (dbClonar.FieldByName('ID_CATEGORY').AsString='') then
    begin
    FmDBLookupComboBox1.KeyValue:=dbClonar.FieldByName('ID_CATEGORY').AsString;
   // FmDBLookupComboBox1.OnCloseUp(Self);
    end;
    {if not (dbClonar.FieldByName('ID_SUBCATE').AsString='') then
    begin
    FmDBLookupComboBox2.KeyValue:=dbClonar.FieldByName('ID_SUBCATE').AsString;
    end;   }
    if not (dbClonar.FieldByName('ID_IMPUESTO').AsString='') then
    begin
    IvaDBLookupComboBox1.KeyValue:=dbClonar.FieldByName('ID_IMPUESTO').AsString;
    end;
    if not (dbClonar.FieldByName('ID_IMPUESTO').AsString='') then
    begin
    ReqDBLookupComboBox1.KeyValue:=dbClonar.FieldByName('ID_IMPUESTO').AsString;
    end;

    Medida.Text:=dbClonar.FieldByName('MEDIDA').AsString;
    Unidades.Text:=dbClonar.FieldByName('UNIDAD').AsString;

    DBPriceBs.Value:= dbClonar.FieldByName('PRECIO_COMPRAS_SIN').Value;
    DBPriceBc.Value:= dbClonar.FieldByName('PRECIO_COMPRAS_CON').Value;
    DBPvP1s.Value:= dbClonar.FieldByName('PVP1S').Value;
    DBPvP1c.Value:= dbClonar.FieldByName('PVP1C').Value;
    DBPvP2s.Value:= dbClonar.FieldByName('PVP2S').Value;
    DBPvP2c.Value:= dbClonar.FieldByName('PVP2C').Value;
    DBPvP3s.Value:= dbClonar.FieldByName('PVP3S').Value;
    DBPvP3c.Value:= dbClonar.FieldByName('PVP3C').Value;

    DateTimeToString(formattedDateTime, 'c', NOW());
    DateAdd.Text:=formattedDateTime;
    DateMod.Text:=formattedDateTime;
    Marca.Text:=dbClonar.FieldByName('MARCA_NOMBRE').AsString;
    end;
    dbClonar.Close;

    end;
end;

procedure TFormGoods.DateEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=VK_RETURN) then
  begin
   Dateedit2.SetFocus;
  end;
end;

procedure TFormGoods.DateEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=VK_RETURN) then
  begin
   AvisoCad.SetFocus;
  end;
end;

procedure TFormGoods.DBCompraAfterOpen(DataSet: TDataSet);
begin
  TDatetimeField(DBCompra.fieldByName('BUYDATE')).DisplayFormat:='yyyy-mm-dd';
TFloatField(DBCompra.fieldByName('PVPS_CP')).DisplayFormat := '0.000';
TFloatField(DBCompra.fieldByName('PVPC_CP')).DisplayFormat := '0.000';
end;

procedure TFormGoods.DBPriceBcKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=VK_RETURN) then
  begin
   DBPvP1c.SetFocus;
  end;
   if Key=VK_Up then
begin
  Unidades.SetFocus;
end;
end;

procedure TFormGoods.DBPriceBsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=VK_RETURN) then
  begin
   DBPvP1s.SetFocus;
  end;
end;

procedure TFormGoods.DBPvP1cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   DBPvP2c.SetFocus;
  end;
   if Key=VK_Up then
begin
  DBPriceBc.SetFocus;
end;
 if Key=VK_left then
begin
  DBPriceBc.SetFocus;
end;
end;

procedure TFormGoods.DBPvP1sKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=VK_RETURN) then
  begin
   DBPvP2s.SetFocus;
  end;
end;

procedure TFormGoods.DBPvP2cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   DBPvP3c.SetFocus;
  end;
    if Key=VK_Up then
begin
  DBPvP1c.SetFocus;
end;
if Key=VK_left then
begin
  DBPvP1c.SetFocus;
end;
end;

procedure TFormGoods.DBPvP2sKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=VK_RETURN) then
  begin
   DBPvP3s.SetFocus;
  end;
end;

procedure TFormGoods.DBPvP3cKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   UProveedor.SetFocus;
  end;
    if Key=VK_Up then
begin
  DBPvP2c.SetFocus;
end;
   if Key=VK_left then
begin
  DBPvP2c.SetFocus;
end;
end;

procedure TFormGoods.DBPvP3sKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   UProveedor.SetFocus;
  end;
end;

procedure TFormGoods.DescRebajaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   bitbtn2.SetFocus;
  end;
end;

procedure TFormGoods.DiasAvisoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=VK_RETURN) then
  begin
   Activa.SetFocus;
  end;
end;

procedure TFormGoods.Clearup;

begin
  //Edit1.Text:='';
  Edit2.Text:='';
  Edit3.Text:='';
  Lang2.Text:='';

  //LabelPrecio.Caption:='';
  PVPv.Value:=0;
  UProveedor.Text:='';

  CalPeso.ItemIndex:=0;
  DBPriceBs.Value:=0;
    DBPriceBc.Value:=0;
    DBPvP1s.Value:=0;
    DBPvP1c.Value:=0;
    DBPvP2s.Value:=0;
    DBPvP2c.Value:=0;
    DBPvP3s.Value:=0;
    DBPvP3c.Value:=0;
    Stock.Value:=0;
    LimitLow.Value:=0;
    AvisoMini.ItemIndex:=0;
    AvisoCad.ItemIndex:=0;
    Medida.Text:='';
    Marca.Text:='';
    DiasAviso.Value:=0;
    DateEdit1.Date:=Now;
    DateEdit2.Date:=Now;
    RefCaja.Text:='';
    CantidadCaja.Value:=0;

    DateTimeToString(formattedDateTime, 'c', NOW());
    DateAdd.Text:=formattedDateTime;
    DateMod.Text:=formattedDateTime;
    CantidadCaja.Value:=0;
  PermiteDesc.ItemIndex:=1;
  MaxDesc.Value:=0.00;
  EnRebaja.ItemIndex:=0;
  DescRebaja.Value:=0.00;
  //PermiteFac.ItemIndex:=1;
  Activa.ItemIndex:=1;
  Memo1.Lines.Clear;
  DBImage1.Picture:= nil;
   PageControl1.Pages[0].Show;
  //PageControl1.Pages[3].TabVisible := False;

end;

procedure TFormGoods.BitBtn2Click(Sender: TObject);
  var
  BlobStream: TMemoryStream; {to save to the blob}
begin
  if (Trim(Edit1.Text)='') or (Trim(Edit2.Text)='') then
  begin
  ShowMessage('No se puede guardar.');
  Edit1.SetFocus;
  Exit;
  end;

  if (Trim(Edit3.Text)='') then
  begin
    Edit3.SetFocus;
  Exit;
  end;

  if (Trim(Lang2.Text)='') then
  begin
    Lang2.SetFocus;
  Exit;
  end;

  if FmDBLookupComboBox1.KeyValue=null then
  begin
    FmDBLookupComboBox1.SetFocus;
  Exit;
  end;

  if IvaDBLookupComboBox1.KeyValue=null then
  begin
    IvaDBLookupComboBox1.SetFocus;
  Exit;
  end;

  BlobStream := TMemoryStream.Create();
  BlobStream.seek(0,0);
  if (DBImage1.Picture.Graphic <> nil) and
  not (DBImage1.Picture.Graphic.Empty) then
  begin

  begin
   DBImage1.Picture.Graphic.SaveToStream(BlobStream);
  BlobStream.seek(0,0);
  end;
  end;

  with dbTrabajo do
   begin
    Connection:=DataModule2.ZCon1; //UniConnection1;
    Active:=False;
    SQL.Clear;
    SQL.Text:='insert into '+EmID+'PRODUCTLIST '
     +'(PRO_REFERENCIA, PRO_LANG1, PRO_LANG2, PRO_CDBARRA, ID_CATEGORY,' //ID_CATE, CATEGORIA, ID_SUBCATE, SUBCATEGORIA, '
     +'MEDIDA, UNIDAD, ID_IMPUESTO, IVA, REQ, PRECIO_COMPRAS_SIN, PRECIO_COMPRAS_CON, PVP1S, PVP1C, '
     +'PVP2S, PVP2C, PVP3S, PVP3C, '
     +'STOCK_ACTUAL, STOCK_MAX_LIMIT, STOCK_MINI_LIMIT, CDBARRA_CAJA, UNITS_CAJA, '
     +'FECHA_FABRICA, FECHA_CADUCA, CAD_AVISO, FECHA_AVISA, FECHA_ADD, IMAGES_DATA, MARCA_NOMBRE, '
     +'CAN_DISCount, DISC_Limit, DISC_SELL, CAL_CANON, RATE_CANON, CAN_FACTURA, CAL_STOCK, ISOFERTA, ISPESO, STOP_USE, OBSERVACION) '
     +'VALUES (:PRO_REFERENCIA, :PRO_LANG1, :PRO_LANG2, :PRO_CDBARRA, :ID_CATEGORY, ' //:ID_CATE, :CATEGORIA, :ID_SUBCATE, :SUBCATEGORIA, '
     +':MEDIDA, :UNIDAD, :ID_IMPUESTO, :IVA, :REQ, :PRECIO_COMPRAS_SIN, :PRECIO_COMPRAS_CON, :PVP1S, :PVP1C, '
     +':PVP2S, :PVP2C, :PVP3S, :PVP3C, '
     +':STOCK_ACTUAL, :STOCK_MAX_LIMIT, :STOCK_MINI_LIMIT, :CDBARRA_CAJA, :UNITS_CAJA, '
     +':FECHA_FABRICA, :FECHA_CADUCA, :CAD_AVISO, :DIAS_AVISA, :FECHA_ADD, :IMAGES_DATA, :MARCA_NOMBRE, '
     +':CAN_DISCount, :DISC_Limit, :DISC_SELL, :CAL_CANON, :RATE_CANON, :CAN_FACTURA, :CAL_STOCK, :ISOFERTA, :ISPESO, :STOP_USE, :OBSERVACION) '
     +'ON DUPLICATE KEY UPDATE '
     +'PRO_REFERENCIA=:PRO_REFERENCIA, PRO_LANG1=:PRO_LANG1, PRO_LANG2=:PRO_LANG2, PRO_CDBARRA=:PRO_CDBARRA, '
     +'ID_CATEGORY=:ID_CATEGORY, '
     //+'ID_CATE=:ID_CATE, CATEGORIA=:CATEGORIA, ID_SUBCATE=:ID_SUBCATE, SUBCATEGORIA=:SUBCATEGORIA, '
     +'UNIDAD=:UNIDAD, ID_IMPUESTO=:ID_IMPUESTO, IVA=:IVA, REQ=:REQ, PRECIO_COMPRAS_SIN=:PRECIO_COMPRAS_SIN, '
     +'PRECIO_COMPRAS_CON=:PRECIO_COMPRAS_CON, PVP1S=:PVP1S, PVP1C=:PVP1C, '
     +'PVP2S=:PVP2S, PVP2C=:PVP2C, PVP3S=:PVP3S, PVP3C=:PVP3C, '
     +'STOCK_MAX_LIMIT=:STOCK_MAX_LIMIT, STOCK_MINI_LIMIT=:STOCK_MINI_LIMIT, '
     +'CDBARRA_CAJA=:CDBARRA_CAJA, UNITS_CAJA=:UNITS_CAJA, '
     +'FECHA_FABRICA=:FECHA_FABRICA, FECHA_CADUCA=:FECHA_CADUCA, CAD_AVISO=:CAD_AVISO, DIAS_AVISA=:DIAS_AVISA, IMAGES_DATA=:IMAGES_DATA, MARCA_NOMBRE=:MARCA_NOMBRE, '
     +'CAN_DISCount=:CAN_DISCount, DISC_Limit=:DISC_Limit, DISC_SELL=:DISC_SELL, CAL_CANON=:CAL_CANON, '
     +'RATE_CANON=:RATE_CANON, CAN_FACTURA=:CAN_FACTURA, CAL_STOCK=:CAL_STOCK, ISOFERTA=:ISOFERTA, ISPESO=:ISPESO, STOP_USE=:STOP_USE, OBSERVACION=:OBSERVACION ';
        ParamByName('PRO_REFERENCIA').AsString:=Trim(Edit2.Text);
         ParamByName('PRO_CDBARRA').AsString:=Trim(Edit1.Text);
         ParamByName('PRO_LANG1').AsString:=Trim(Edit3.Text);
         ParamByName('PRO_LANG2').AsString:=Trim(Lang2.Text); //ABuyPRODUCT.LANG2;
         if FmDBLookupComboBox1.KeyValue=null then
         ParamByName('ID_CATEGORY').AsString:='' else
         ParamByName('ID_CATEGORY').AsString:=FmDBLookupComboBox1.KeyValue;


        // ParamByName('CATEGORIA').AsString:=FmDBLookupComboBox1.Text;
        // if FmDBLookupComboBox2.KeyValue=null then
        // ParamByName('ID_SUBCATE').AsString:='' else
        // ParamByName('ID_SUBCATE').AsString:=FmDBLookupComboBox2.KeyValue;
        // ParamByName('SUBCATEGORIA').AsString:=FmDBLookupComboBox2.Text;
         ParamByName('MEDIDA').AsString:=Trim(Medida.Text);
         ParamByName('UNIDAD').AsString:=Unidades.Text;

         ParamByName('ID_IMPUESTO').AsString:=IvaDBLookupComboBox1.KeyValue;
         ParamByName('IVA').AsFloat:= DataModule2.ivaQuery.FieldByName('iva').AsFloat;
         ParamByName('REQ').AsFloat:=DataModule2.ivaQuery.FieldByName('REQ').AsFloat;

         ParamByName('PRECIO_COMPRAS_SIN').AsFloat:=DBPriceBs.Value;
         ParamByName('PRECIO_COMPRAS_CON').AsFloat:=DBPriceBc.Value;

         ParamByName('PVP1S').AsFloat:=DBPvP1s.Value;
         ParamByName('PVP1C').AsFloat:=DBPvP1c.Value;
         ParamByName('PVP2S').AsFloat:=DBPvP2s.Value;
         ParamByName('PVP2c').AsFloat:=DBPvP2c.Value;
         ParamByName('PVP3S').AsFloat:=DBPvP3s.Value;
         ParamByName('PVP3c').AsFloat:=DBPvP3c.Value;
         ParamByName('STOCK_ACTUAL').AsFloat:=Stock.Value;
         ParamByName('STOCK_MAX_LIMIT').AsFloat:=0;
         ParamByName('STOCK_MINI_LIMIT').AsFloat:=LimitLow.Value;
         ParamByName('FECHA_FABRICA').AsDate:=DateEdit1.Date;
         ParamByName('FECHA_CADUCA').AsDate:=DateEdit2.Date;
         ParamByName('DIAS_AVISA').AsInteger:=DiasAviso.AsInteger;
         ParamByName('FECHA_ADD').AsDate:=now();
         ParamByName('FECHA_ADD').AsDate:=now();

         if AvisoCad.ItemIndex=1 then ParamByName('CAD_AVISO').AsString:='Y'
         else ParamByName('CAD_AVISO').AsString:='N';

         ParamByName('IMAGES_DATA').LoadFromStream(BlobStream, ftBlob);
         if PermiteDesc.ItemIndex=1 then ParamByName('CAN_DISCount').AsString:='Y'
         else ParamByName('CAN_DISCount').AsString:='N';

         ParamByName('DISC_Limit').AsFloat:=MaxDesc.Value;

         if EnRebaja.ItemIndex=1 then ParamByName('ISOFERTA').AsString:='Y'
         else ParamByName('ISOFERTA').AsString:='N';

         ParamByName('DISC_SELL').AsFloat:=DescRebaja.Value;

         ParamByName('CAL_CANON').AsString:='N';
         ParamByName('RATE_CANON').AsFloat:=0;
         //if PermiteFac.ItemIndex=1 then ParamByName('CAN_FACTURA').AsString:='Y'
         //else ParamByName('CAN_FACTURA').AsString:='N';

         ParamByName('CAN_FACTURA').AsString:='Y';
         ParamByName('CAL_STOCK').AsString:='Y' ;
         //else ParamByName('CAL_STOCK').AsString:='N';

         if CalPeso.ItemIndex=1 then ParamByName('ISPESO').AsString:='Y'
         else ParamByName('ISPESO').AsString:='N';

         if Activa.ItemIndex=1 then ParamByName('STOP_USE').AsString:='N'
         else ParamByName('STOP_USE').AsString:='Y';

         //if EnRebaja.ItemIndex=1  then         ParamByName('ISOFERTA').AsString:='Y'
         //else ParamByName('ISOFERTA').AsString:='N';

         ParamByName('CDBARRA_CAJA').AsString:=Trim(RefCaja.Text);
         ParamByName('UNITS_CAJA').AsFloat:=CantidadCaja.Value;

         ParamByName('MARCA_NOMBRE').AsString:=Marca.Text;                  //MarcaLookupComboBox.Text;
         ParamByName('OBSERVACION').AsString:=memo1.lines.Text;

         //memo1.Lines.Text:=sql.Text;
         ExecSQL;

         //  //////////////////////////添加货品资料////////////////////
  	  ///////STOCKGOODS

          ///这里需要重新修改，未完成2019-02-16
        ///
        if NewGoods then
        begin
        SQL.CLEAR;
        SQL.TEXT:='INSERT INTO '+EMID+'STOCKGOODS '
        +'(ID_STOCK, PRO_REFERENCIA, PRO_LANG1, PRO_LANG2, PRO_CDBARRA, ID_CATEGORY, '
        + 'CANTIDAD, ESTADO) VALUES (:ID_STOCK, :PRO_REFERENCIA, :PRO_LANG1, :PRO_LANG2, :PRO_CDBARRA, '
        +':ID_CATEGORY, '
        + 'CANTIDAD =CANTIDAD+:CANTIDAD, :ESTADO)'
        +'ON DUPLICATE KEY UPDATE '
        +'ID_CATE=:ID_CATE,  ID_SUBCATE=:ID_SUBCATE, '
        +'CANTIDAD =CANTIDAD+:CANTIDAD, ESTADO=:ESTADO';
        PARAMBYNAME('ID_STOCK').ASSTRING:= UseConf.ID_STOCKDEFAULT;
        ParamByName('PRO_REFERENCIA').AsString:=Trim(Edit2.Text);
        ParamByName('PRO_CDBARRA').AsString:=Trim(Edit1.Text);
        ParamByName('PRO_LANG1').AsString:=Trim(Edit3.Text);
        ParamByName('PRO_LANG2').AsString:=Trim(lang2.Text);
        if FmDBLookupComboBox1.KeyValue=null then
        ParamByName('ID_CATEGORY').AsString:='' else
        ParamByName('ID_CATEGORY').AsString:=FmDBLookupComboBox1.KeyValue; //FmDBLookupComboBox1.KeyValue;

       // if FmDBLookupComboBox2.KeyValue=null then
       // ParamByName('ID_SUBCATE').AsString:='' else
       // ParamByName('ID_SUBCATE').AsString:=FmDBLookupComboBox2.KeyValue;

        PARAMBYNAME('CANTIDAD').ASFLOAT:= Stock.Value;
        PARAMBYNAME('ESTADO').ASSTRING:='GOOD';
        EXECSQL;

        if not (IdProv.Text='') then
        begin
       SQL.Clear;
       SQL.Text:='insert into '+EmID+'GOODSOFPROVEEDOR '
       +'(SUCODIGO, PRO_REFERENCIA, PRO_LANG1, PRO_LANG2, PRO_CDBARRA, ID_CATEGORY, ' //ID_CATE, CATEGORIA, ID_SUBCATE, SUBCATEGORIA, '
       +'ID_IMPUESTO, IVA, REQ, PRECIO_sin, PRECIO_CON, '
       +'ID_PROVEEDOR, '
       +'FECHA) '
       +'VALUES (:SUCODIGO, :PRO_REFERENCIA, :PRO_LANG1, :PRO_LANG2, :PRO_CDBARRA, :ID_CATEGORY, ' //:ID_CATE, :CATEGORIA, :ID_SUBCATE, :SUBCATEGORIA, '
       +':ID_IMPUESTO, :IVA, :REQ, :PRECIO_sin, :PRECIO_CON, '
       +':ID_PROVEEDOR, '
       +':FECHA) '
       +'ON DUPLICATE KEY UPDATE '
       +'SUCODIGO=:SUCODIGO, PRO_REFERENCIA=:PRO_REFERENCIA, PRO_LANG1=:PRO_LANG1, PRO_LANG2=:PRO_LANG2, PRO_CDBARRA=:PRO_CDBARRA, '
       +'ID_CATEGORY=:IDCATEGORY, '
       //+'ID_CATE=:ID_CATE, CATEGORIA=:CATEGORIA, ID_SUBCATE=:ID_SUBCATE, SUBCATEGORIA=:SUBCATEGORIA, '
       +'ID_IMPUESTO=:ID_IMPUESTO, IVA=:IVA, REQ=:REQ, PRECIO_SIN=:PRECIO_SIN, '
       +'PRECIO_CON=:PRECIO_CON, '
       +'ID_PROVEEDOR=:ID_PROVEEDOR, '
       +'FECHA=:FECHA ';
        ParamByName('SUCODIGO').AsString:='';
        ParamByName('PRO_REFERENCIA').AsString:=Trim(Edit2.Text);
        ParamByName('PRO_CDBARRA').AsString:=Trim(Edit1.Text);
        ParamByName('PRO_LANG1').AsString:=Trim(Edit3.Text);
        ParamByName('PRO_LANG2').AsString:=Trim(Lang2.Text);
        if FmDBLookupComboBox1.KeyValue=null then
        ParamByName('ID_CATEGORY').AsString:='' else
        ParamByName('ID_CATEGORY').AsString:=FmDBLookupComboBox1.KeyValue;
       // ParamByName('CATEGORIA').AsString:=FmDBLookupComboBox1.Text;
       // if FmDBLookupComboBox2.KeyValue=null then
       // ParamByName('ID_SUBCATE').AsString:='' else
       // ParamByName('ID_SUBCATE').AsString:=FmDBLookupComboBox2.KeyValue;
      //  ParamByName('SUBCATEGORIA').AsString:=FmDBLookupComboBox2.Text;
        ParamByName('ID_IMPUESTO').AsString:=IvaDBLookupComboBox1.KeyValue;
        ParamByName('IVA').AsFloat:= DataModule2.ivaQuery.FieldByName('iva').AsFloat;
        ParamByName('REQ').AsFloat:=DataModule2.ivaQuery.FieldByName('REQ').AsFloat;

        ParamByName('PRECIO_SIN').AsFloat:=DBPriceBs.Value;
        ParamByName('PRECIO_CON').AsFloat:=DBPriceBc.Value;
        ParamByName('ID_PROVEEDOR').AsString:=IdProv.Text;
        ParamByName('FECHA').AsDate:=date;

        ExecSQL;
        end;
        end;


   end;

  // ReadProductDatos;
  // ShowMessage(nMSN61);
   Clearup;
   Edit1.Text:='';
   Edit1.SetFocus;


end;

procedure TFormGoods.BitBtn6Click(Sender: TObject);
begin
  Edit1.Text:='';
  clearup;
  Edit1.SetFocus;
end;

procedure TFormGoods.Button17Click(Sender: TObject);
var
  Result: TStringArray;
  table:string;
  SIdProv,SUProveedor:string;
begin
  table:=EMID+'PROVEEDORLIST';

  Result:=FormFindout.IniciaBusquedas(table, ['ID_PROVEEDOR','NAME_COMERCIO'], ['Código','Nombre Comercio'] );
  SUProveedor:=Result[1];
  SIdProv:=Result[0];
  if ((SUProveedor='-') or (SUProveedor='-1')) then
  begin
  exit;

  end;


  with dbTrabajo do
   begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='insert into '+UseDBC.EmID+'GOODSOFPROVEEDOR '
     +'(SUCODIGO, PRO_REFERENCIA, PRO_LANG1, PRO_LANG2, PRO_CDBARRA, ID_CATEGOTY, '//ID_CATE, CATEGORIA, ID_SUBCATE, SUBCATEGORIA, '
     +'ID_IMPUESTO, IVA, REQ, PRECIO_sin, PRECIO_CON, '
     +'ID_PROVEEDOR, '
     +'FECHA) '
     +'VALUES (:SUCODIGO, :PRO_REFERENCIA, :PRO_LANG1, :PRO_LANG2, :PRO_CDBARRA, :ID_CATEGORY, '//:ID_CATE, :CATEGORIA, :ID_SUBCATE, :SUBCATEGORIA, '
     +':ID_IMPUESTO, :IVA, :REQ, :PRECIO_sin, :PRECIO_CON, '
     +':ID_PROVEEDOR, '
     +':FECHA) '
     +'ON DUPLICATE KEY UPDATE '
     +'SUCODIGO=:SUCODIGO, PRO_REFERENCIA=:PRO_REFERENCIA, PRO_LANG1=:PRO_LANG1, PRO_LANG2=:PRO_LANG2, PRO_CDBARRA=:PRO_CDBARRA, '
     +'ID_CATEGORY=:IDCATEGORY, '
     //+'ID_CATE=:ID_CATE, CATEGORIA=:CATEGORIA, ID_SUBCATE=:ID_SUBCATE, SUBCATEGORIA=:SUBCATEGORIA, '
     +'ID_IMPUESTO=:ID_IMPUESTO, IVA=:IVA, REQ=:REQ, PRECIO_SIN=:PRECIO_SIN, '
     +'PRECIO_CON=:PRECIO_CON, '
     +'ID_PROVEEDOR=:ID_PROVEEDOR, '
     +'FECHA=:FECHA ';
     ParamByName('SUCODIGO').AsString:='';
     ParamByName('PRO_REFERENCIA').AsString:=Trim(Edit2.Text);
          ParamByName('PRO_CDBARRA').AsString:=Trim(Edit1.Text);
          ParamByName('PRO_LANG1').AsString:=Trim(Edit3.Text);
          ParamByName('PRO_LANG2').AsString:=Trim(Lang2.Text);
           if FmDBLookupComboBox1.KeyValue=null then
       ParamByName('ID_CATEGORY').AsString:='' else
       ParamByName('ID_CATEGORY').AsString:=FmDBLookupComboBox1.KeyValue;
      { ParamByName('CATEGORIA').AsString:=FmDBLookupComboBox1.Text;
       if FmDBLookupComboBox2.KeyValue=null then
       ParamByName('ID_SUBCATE').AsString:='' else
       ParamByName('ID_SUBCATE').AsString:=FmDBLookupComboBox2.KeyValue;
       ParamByName('SUBCATEGORIA').AsString:=FmDBLookupComboBox2.Text;  }
       ParamByName('ID_IMPUESTO').AsString:=IvaDBLookupComboBox1.KeyValue;
       ParamByName('IVA').AsFloat:= DataModule2.ivaQuery.FieldByName('iva').AsFloat;
       ParamByName('REQ').AsFloat:=DataModule2.ivaQuery.FieldByName('REQ').AsFloat;
       ParamByName('PRECIO_SIN').AsFloat:=DBPriceBs.Value;
       ParamByName('PRECIO_CON').AsFloat:=DBPriceBc.Value;
       ParamByName('ID_PROVEEDOR').AsString:=SIdProv;
       ParamByName('FECHA').AsDate:=date;

       ExecSQL;
      end;

     GoodsOfProvQuery.Refresh;

  //if (Result >0 ) then dbBusquedas.Refresh;
end;

procedure TFormGoods.Button1Click(Sender: TObject);
  var
    P: TPoint;
  begin
    //

end;

procedure TFormGoods.Button2Click(Sender: TObject);
begin
  if Ubica.Text='' then bitbtn22click(self);
end;

procedure TFormGoods.Button3Click(Sender: TObject);
  var
    P: TPoint;
  begin
    GetCursorPos(P);
    MainPopupMenu.Popup(P.X, P.Y);

end;

procedure TFormGoods.CalPesoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=VK_RETURN) then
  begin
   LimitLow.SetFocus;
  end;
end;

procedure TFormGoods.BitBtn12Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
   begin
     if FileExists(OpenPictureDialog1.FileName) then
       DbImage1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
       edit2.Focused;
   end;
end;

procedure TFormGoods.BitBtn14Click(Sender: TObject);
begin

end;

procedure TFormGoods.AvisoMiniKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=VK_RETURN) then
  begin
   Dateedit1.SetFocus;
  end;
end;

procedure TFormGoods.AvisoCadKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=VK_RETURN) then
  begin
   DiasAviso.SetFocus;
  end;
end;

procedure TFormGoods.Activa1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Memo1.SetFocus;
end;

procedure TFormGoods.ActivaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=VK_RETURN) then
  begin
   Activa1.SetFocus;
  end;
end;

procedure TFormGoods.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TFormGoods.BitBtn22Click(Sender: TObject);
  var
    Result: TStringArray;
    table:string;
  begin
   table:=EMID+'FILACODE';
    Result:=FormFindout.IniciaBusquedas( table, ['ID','FILA'], ['ID', 'SECTOR'] );
    UBICA.Text:=Result[1];
    if ((Unidades.Text='-') or (Ubica.Text='-1')) then
    begin
    Ubica.Text:='';
    end;

end;

procedure TFormGoods.Edit1Exit(Sender: TObject);
begin
  if not DBinit then exit;
  if not BitBtn2.Focused then
   if not BitBtn3.Focused then
    if not BitBtn1.Focused then
   //  if not BitBtn5.Focused then
if not BitBtn5.Focused then begin
  if (Pos('%', Edit1.Text) > 0) then
  begin BitBtn5.SetFocus; exit; end;

  if not (Trim( Edit1.Text)='') then
  begin
  PageControl1.Pages[0].Show;
  GetProductDetalles;

  GetGoodsOfProveedor;

  WITH DBCompra DO
  BEGIN
   Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;


    SQL.Text:='SELECT A.ID_BUY, A.SERIES, A.PRO_REFERENCIA, A.PRO_LANG1, A.PRO_CDBARRA, A.PVPS_CP ,A.IVA, A.PVPC_CP, A.CANTIDAD_CP, A.DESCUENTO_CP, '
       +'B.ID_PROVEEDOR, B.NAME_PROVEEDOR, B.DOCUMENT, B.N_DOCUMENT ,B.BUYDATE '
       +'FROM '+EmID+'BUYLISTDETAILED A, '+EmID+'buylisttop B WHERE 1=1 AND A.ID_BUY=B.ID_BUY AND A.SERIES=B.SERIES '
       //+'and ((B.BUYDATE) BETWEEN :FECHA1 and :FECHA2) '
       +'AND PRO_CDBARRA=:PRO_CDBARRA '
       +'AND BUYDATE>=:FECHA1 AND BUYDATE<=:FECHA2'
      // +Codigo + Cantidades + Importe +
       +' ORDER BY BUYDATE DESC';
     ParamByName('FECHA1').AsDate:=DateEdit4.Date;
     ParamByName('FECHA2').AsDate:=DateEdit5.Date;
      ParamByName('PRO_CDBARRA').AsString:=Trim(Edit1.Text);

    Open;
  END;
   GetGoodsOfEstatetia;

  end;

end;

end;

procedure TFormGoods.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
  if (Trim(Edit1.Text)='') then
   begin
   key:=0;
   //BitBtn5Click(Self);
   exit;
   end else Edit2.SetFocus;
  end;
end;

procedure TFormGoods.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=VK_RETURN) then
  begin
   Edit3.SetFocus;
  end;
end;

procedure TFormGoods.Edit3Change(Sender: TObject);
  var
    OldStart: Integer;
begin
    with Edit3 do
      if Text <> '' then
      begin
        OnChange  := nil;
        OldStart  := SelStart;
        Selstart  := 0;
        Sellength := 1;
        Seltext   := AnsiUpperCase(Text[1]);
        SelStart  := OldStart;
        OnChange  := @Edit3Change;
      end;


end;

procedure TFormGoods.Edit3Exit(Sender: TObject);
begin
  if TRIM(Lang2.Text)='' then
Lang2.Text:=Edit3.Text;
end;

procedure TFormGoods.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   Lang2.SetFocus;
  end;
  if (key=VK_UP) then
  begin
   Edit2.SetFocus;
  end;
end;

procedure TFormGoods.EnRebajaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   DescRebaja.SetFocus;
  end;
end;

procedure TFormGoods.FmDBLookupComboBox1CloseUp(Sender: TObject);
var
Subcontronl:string;
begin
 // showmessage( FmDBLookupComboBox1.KeyValue);
 // showmessage( FmDBLookupComboBox1.listsource.dataset.FieldByName('id').AsString);
//if DBLookupComboBox3.KeyValue=null then  Exit;
{
Subcontronl:='SUB'+vartostr(FmDBLookupComboBox1.KeyValue);
 with SubCateQuery do
 begin
      Connection:=DataModule2.ZCon1;    //DataModule1.UniConn; //
     Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT * FROM '+EmID+'CATEGORIASLIST WHERE 1=1 AND CONTRONL='''+Subcontronl+'''';
     Open;
 end;
}
end;

procedure TFormGoods.FmDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
  // FmDBLookupComboBox2.SetFocus;
   SelectNext(Sender as TWinControl, True, True);
  end;
  if (key=VK_UP) then
  begin
   Lang2.SetFocus;
  end;
end;

procedure TFormGoods.FmDBLookupComboBox2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   Medida.SetFocus;
  end;
end;

procedure TFormGoods.FormCreate(Sender: TObject);
 var
    addSubItem:TMenuItem;
    i:Integer;
    j:integer;
    k:integer;
    TempPoList:TStringList;
    value,value2:String;
begin
//  dbArti.Sql.Text:='SELECT * FROM artitien'+Tienda+' ORDER BY A0';
//  dbArti.Active := True;
  if not DBinit then
self.Caption:=nMSG0+Lang;
self.Caption:=self.Caption+' ('+DBhost+':'+DBDataBase+')';
LabelIVA.Caption:=nMSG2;
  if UseConf.SELLWITHPVP then
begin
  DBPriceBs.Enabled:=False;
  DBPvP1s.Enabled:=False;
  DBPvP2s.Enabled:=False;
  DBPvP3s.Enabled:=False;

end
else
begin
  DBPriceBc.Enabled:=False;
  DBPvP1c.Enabled:=False;
  DBPvP2c.Enabled:=False;
  DBPvP3c.Enabled:=False;
end;


TempPoList:=TStringList.Create;
  GetFileList(TempPoList,RutaLang,'.po');

  for i:=0 to TempPoList.Count-1 do
  begin
   j:=pos('.',TempPoList[i]);          //在获取的PO文件名中寻找'.'出现的第一个位置
   k:=LastDelimiter('.', TempPoList[i]);
   if j = k then
     begin
      value :='Default';
      value2 :=nDefault;
     end
   else
     begin
         value := Copy(TempPoList[i],j+1, k-j-1);    //copy(文本, 第几个开始取, 取几个)
     end;
   if value = 'es' then value2 := es;
   if value = 'zh' then value2 := zh;
   if value = 'ch' then value2 := zh;
   if value = 'en' then value2 := en;
  //ShowMessage(value);
  addSubItem:= TMenuItem.Create(Self);
  addSubItem.Name := value;
  addSubItem.Caption := value2;
  addSubItem.OnClick:=@MainPopupClick;
  self.MainPopupMenu.Items.Add(addSubItem);

  end;

Memo2.Lines.Clear;
memo2.Lines.Add(nMsg1);
memo2.Lines.Add('');
Memo2.Lines.Add(nFun1);
Memo2.Lines.Add(nFun2);
Memo2.Lines.Add(nFun3);
Memo2.Lines.Add(nFun4);
Memo2.Lines.Add(nFun5);
Memo2.Lines.Add(nFun6);


end;

procedure TFormGoods.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_F3)  then begin key:=0;    AbirCajones();  Exit; End;
  if (key=VK_F4)  then begin key:=0; BitBtn20Click(self); Exit; End;
   if (key=VK_F5)  then begin key:=0; BitBtn5Click(self); Exit; End;    //buscar
   if (key=VK_F6)  then begin key:=0; BitBtn12Click(self); Exit; End;   //picture
   if (key=VK_F7)  then begin key:=0; BitBtn19Click(self); Exit; End;
   if (key=VK_F8)  then begin key:=0; BitBtn6Click(self); Exit; End;

   if (KEY= VK_ESCAPE) then self.Close;
end;

procedure TFormGoods.FormKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TFormGoods.FormShow(Sender: TObject);
begin
 Label1.Alignment:=(taRightJustify);
 Label2.Alignment:=(taRightJustify);
 Label3.Alignment:=(taRightJustify);
 Label4.Alignment:=(taRightJustify);

  DateTimeToString(formattedDateTime, 'c', NOW());
    DateAdd.Text:=formattedDateTime;
    DateMod.Text:=formattedDateTime;
    if DataModule2.Zcon1.Connected then
  begin
  GetAllGoods;
  GetStockList;

  end;
end;

procedure TFormGoods.GoodsOfProvQueryAfterOpen(DataSet: TDataSet);
begin
  TDatetimeField(GoodsOfProvQuery.fieldByName('FECHA')).DisplayFormat:='yyyy-mm-dd';
TFloatField(GoodsOfProvQuery.fieldByName('PRECIO_CON')).DisplayFormat := '0.000';
end;

procedure TFormGoods.IvaDBLookupComboBox1Change(Sender: TObject);
begin
   ReqDBLookupComboBox1.KeyValue:=IvaDBLookupComboBox1.KeyValue;
end;

procedure TFormGoods.IvaDBLookupComboBox1Click(Sender: TObject);
begin

end;

procedure TFormGoods.IvaDBLookupComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (key=VK_RETURN) then
  begin
  if UseConf.SELLWITHPVP then
   DBPriceBc.SetFocus else DBPriceBs.SetFocus
  end;
end;

procedure TFormGoods.IvaDBLookupComboBox1Select(Sender: TObject);
begin
  ReqDBLookupComboBox1.KeyValue:=IvaDBLookupComboBox1.KeyValue;
end;

procedure TFormGoods.Lang2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   FmDBLookupComboBox1.SetFocus;
  end;
  if (key=VK_UP) then
  begin
   Edit3.SetFocus;
  end;
end;

procedure TFormGoods.LimitLowKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=VK_RETURN) then
  begin
   AvisoMini.SetFocus;
  end;
end;

procedure TFormGoods.MainPopupClick(Sender: TObject);
begin
with (Sender as TMenuItem)do
   begin
      OpenDialog1.FileName:=fileconf;
      IniReader := TIniFile.Create(OpenDialog1.FileName);
      IniReader.WriteString('Environment','Lang',TMenuItem(Sender).Name);
      IniReader.WriteString('Environment','FallbackLang',TMenuItem(Sender).Name);
   end;
end;

procedure TFormGoods.MarcaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=VK_RETURN) then
  begin
   Unidades.SetFocus;
  end;
    if (key=VK_UP) then
  begin
   Medida.SetFocus;
  end;
end;

procedure TFormGoods.MaxDescKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   EnRebaja.SetFocus;
  end;
end;

procedure TFormGoods.MedidaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=VK_RETURN) then
  begin
   marca.SetFocus;
  end;
      if (key=VK_UP) then
  begin
   FmDBLookupComboBox1.SetFocus;
  end;
end;

procedure TFormGoods.PermiteDescKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   MaxDesc.SetFocus;
  end;
end;

procedure TFormGoods.UbicaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=VK_RETURN) then
  begin
   bitbtn22click(self);
  end;
end;

procedure TFormGoods.UnidadesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   PageControl1.Pages[0].Show;
   IvaDBLookupComboBox1.SetFocus;
  end;
  if (key=VK_UP) then
  begin
   Marca.Focused;
  end;

end;

procedure TFormGoods.UProveedorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
  begin
   permiteDesc.SetFocus;
  end;
end;

procedure TFormGoods.GetStockList;
var
 i:integer;
begin
  with StockListQuery do
  begin
    Connection:=DataModule2.Zcon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT * FROM '+UseDBC.EmID+'STOCKLIST ';
     Open;
     first;
  end;

end;

procedure TFormGoods.AbirCajones();
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

