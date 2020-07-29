unit BuyListCheck;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBGrids, ZDataset, ZSqlUpdate, LCLType, ComCtrls, DBCtrls, connect,
  rxcurredit, db, memds, Global, Grids, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    Benificio: TCurrencyEdit;
    BitBtn5: TBitBtn;
    BrandDBBox: TDBLookupComboBox;
    BrandDS: TDataSource;
    BrandQuery: TZQuery;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button8: TButton;
    Button9: TButton;
    CantidadCompra: TCurrencyEdit;
    CantidadPasado: TCurrencyEdit;
    CategoryDS: TDataSource;
    CategoryQuery: TZQuery;
    Change: TCurrencyEdit;
    ChequeEdit: TCurrencyEdit;
    ClasseDS: TDataSource;
    ClasseQuery: TZQuery;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DataSource1: TDataSource;
    dbArti: TZQuery;
    dbTest: TZQuery;
    dbCheck: TZQuery;
    DBGrid1: TDBGrid;
    dbTrabajo: TZQuery;
    DetallesDataSource: TDataSource;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label17: TLabel;
    Label28: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Lang1: TEdit;
    CategoryDBBox: TDBLookupComboBox;
    GetDetallesQuery: TZQuery;
    GroupBox1: TGroupBox;
    Image1: TImage;
    IvaDBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label29: TLabel;
    Label38: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Lang2: TEdit;
    ListView1: TListView;
    MemDataset1: TMemDataset;
    Memo2: TMemo;
    C1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Original: TCurrencyEdit;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel8: TPanel;
    PopupMenu1: TPopupMenu;
    PrecioAnterio: TCurrencyEdit;
    PrecioCompra: TCurrencyEdit;
    PVPEdit: TCurrencyEdit;
    PVPRecomedable: TCurrencyEdit;
    Reader: TEdit;
    Reempezar: TButton;
    SumTotalQuery: TZQuery;
    TaxRateDS: TDataSource;
    TaxRateZQuery: TZQuery;
    UUIDEdit: TEdit;
    CombinaQuery: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;
    procedure BitBtn5Click(Sender: TObject);
    procedure BrandDBBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Enter(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure CantidadCompraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CantidadPasadoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CategoryDBBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChangeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ChequeEditExit(Sender: TObject);
    procedure ChequeEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1Select(Sender: TObject);
    procedure ComboBox2Enter(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Edit10Change(Sender: TObject);
    procedure Edit10KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure IvaDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Lang1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Lang2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure N2Click(Sender: TObject);
    procedure OriginalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure PrecioAnterioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PrecioCompraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PVPEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure PVPRecomedableKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ReaderExit(Sender: TObject);
    procedure ReaderKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ReempezarClick(Sender: TObject);
    procedure ShowTables;
    procedure GetSumTotal();
    Function ExistGoods(CDBarra: string):Boolean;
    Function SelectSKU(CDBarra:string; out Articulo:string):boolean;
    procedure DoClear;
    PROCEDURE GetCategorys();
    Procedure GetBrand();
    Procedure GetClasse();
    procedure DoGetTaxRates;
    procedure UUIDEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    Procedure GetGoods(CdBarra: string);
  private

  public
     function IniciaDB(Forma_Read:string; dbItems: Array of string): boolean;
  end;

   procedure ShowFormCheckDb(Son: boolean);

var
  Form1: TForm1;
  Items: string;
  IsNewGoods, continuar, buscaotravaz, Dochange, oneItem:Boolean;
  FForma_Read:string;
  aAlterProduct:TPRODUCTOST;

implementation
uses
  Select_SKU, AddGoods, dblookup;

procedure ShowFormCheckDb(Son:boolean);
begin
  with TForm1.Create(Application) do
    begin
    Button1.Enabled:=Son;
      ShowModal;
    end;
end;

{$R *.lfm}

{ TForm1 }

function TForm1.IniciaDB(Forma_Read:string; dbItems: Array of string): boolean;
var
  i, x: integer;

begin
   i:=strtoint(dbItems[0]);
   if i <= 0 then begin result:=false; exit; end;
   FForma_Read:=Forma_Read;
   Items:='';
   for x:=1 to i do
    begin
      if x=i then
    Items:=Items+dbItems[x]
    else Items:=Items+dbItems[x]+',';
    end;
    oneItem:=(x=1);
   ShowFormCheckDb(x=1);
   result:=True;
end;

Function TForm1.ExistGoods(CDBarra: string):Boolean;
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

Function TForm1.SelectSKU(CDBarra:string; out Articulo:string):boolean;
begin

end;

procedure TForm1.DoGetTaxRates;
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

 PROCEDURE TForm1.GetCategorys();
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

 Procedure TForm1.GetBrand();
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

  Procedure TForm1.GetClasse();
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

procedure TForm1.DoClear;
begin
  UUIDEdit.Clear;
 Edit1.Clear;
 Edit2.Clear;
 Lang1.Clear;
 Lang2.Clear;
 PrecioAnterio.Value:=0;
 PrecioCompra.Value:=0;
 CantidadCompra.Value:=0;
 CantidadPasado.Value:=0;
 PVPRecomedable.Value:=0;
 PVPEdit.Value:=0;
 ChequeEdit.Value:=0;
end;

procedure TForm1.UUIDEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.ShowTables;
begin
  ;
  with GetDetallesQuery do
  begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.Text:='SELECT T1.*, T3.CATEGORY, T4.ID_STOCK  FROM CHECKLIST_ITEMS AS T1 '
            +'LEFT JOIN GOODS_SPU AS T2 ON T2.GOODS_ID = T1.GOODS_ID '
            +'left join CATEGORYS AS T3 on T2.CATEGORY_ID = T3.id '
            +'LEFT JOIN checklist_orders AS T4 ON T4.ID_TMPLIST = T1.ID_TMPLIST '
         +' WHERE 1=1 '
         +'AND T1.ID_TMPLIST IN ('+Items+') ';

    // ParamByName('ID_TMPLIST').AsString:=Items;
  //   ParamByName('ID_PROVEEDOR').AsString:=ACheckDoc.ID_PROVEEDOR;
  //   ParamByName('DOCUMENT').AsString:=ACheckDoc.DOCUMENT;
  //   ParamByName('N_DOCUMENT').AsString:=ACheckDoc.N_DOCUMENT;
  Open;
  end;
 // TFloatField(GetDetallesQuery.FieldByName('PRECIO_sin')).DisplayFormat := '0.000';
  //TFloatField(GetDetallesQuery.FieldByName('PRECIO_con')).DisplayFormat := '0.000';

  //MemDataset1.CreateTable;

 // MemDataset1.CopyFromDataset(GetDetallesQuery);

end;

procedure TForm1.GetSumTotal();
var
  i: integer;
  vNewItem: TListItem;
begin
    //Icon.l
    with SumTotalQuery do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=False;
    {
    SELECT T1.ID_TMPLIST, T1.ID_PROVEEDOR, T1.NAME_PROVEEDOR, T1.DOCUMENT, T1.N_DOCUMENT, T1.STAFF, T1.READ_COL, T1.FECHA_C, T1.FECHA_I,
T1.EMPLEADO, T1.ISIVAINCLUIDO, T1.ISREQINCLUIDO, T1.ISCHECKED, T1.ID_STOCK, IF(T1.ISIVAINCLUIDO='Y', SUM(T2.UNIDAD*T2.PRECIO_CON*(1-T2.DISCOUNT/100)),
            SUM(T2.UNIDAD*T2.PRECIO_SIN*(1-T2.DISCOUNT/100))) AS UTOTAL FROM CHECKLIST_ORDERS AS T1
            LEFT JOIN checklist_items AS T2 ON T1.ID_TMPLIST = T2.ID_TMPLIST GROUP BY T1.ID_TMPLIST order by T1.ID_TMPLIST desc ;
    }

    SQL.Text:='select T1.ID_TMPLIST, T1.ID_PROVEEDOR,T1.NAME_PROVEEDOR, T1.DOCUMENT, T1.N_DOCUMENT, T1.STAFF, T1.FECHA_C, '
    +'IF(T1.ISIVAINCLUIDO=''Y'', SUM(T2.AMOUNT*T2.PRECIO_CON*(1-T2.DISCOUNT/100)), '
    +       ' SUM(T2.AMOUNT*T2.PRECIO_SIN*(1-T2.DISCOUNT/100))) AS uLINEATOTAL, T1.ID_STOCK  '
    +'FROM CHECKLIST_ORDERS AS T1 '
    +'LEFT JOIN CHECKLIST_ITEMS AS T2 ON T1.ID_TMPLIST = T2.ID_TMPLIST '
    +'WHERE 1=1 '
    +'AND T1.ID_TMPLIST IN ('+Items+') '
    +'GROUP BY T1.ID_TMPLIST';
    Open;
    end;
   // TFloatField(SumTotalQuery.FieldByName('uLineatotal')).DisplayFormat := '0.00';
    ListView1.Clear;
    ListView1.BeginUpdate;
    for i:=0 to SumTotalQuery.RecordCount-1 do
     begin
        with ListView1.Items.Add do
       begin
       vNewItem := ListView1.Items.Add;
       vNewItem.Caption := SumTotalQuery.FieldByName('ID_TMPLIST').AsString;
      { with vNewItem.SubItems do begin
         add('单据金额:'+SumTotalQuery.FieldByName('uLineatotal').AsString)
       end; }
       vNewItem.SubItems.Add(formatfloat('0.000',  SumTotalQuery.FieldByName('uLineatotal').AsFloat));

       end;
       SumTotalQuery.Next;
     end;
    ListView1.EndUpdate;


end;

procedure TForm1.ReaderExit(Sender: TObject);
var
  SKU_NO:string;
  Product:TGOODS;
  index:integer;
  aKEY: word;
begin
   if trim(Reader.Text)='' then
   begin
  // edit1.TabStop:=False;
   exit;
   end;
  // Edit1.TabStop:=True;
    index:=ComboBox1.ItemIndex;
    aKEY:=VK_RETURN;
    case index of
   0: begin
        if not GetDetallesQuery.Locate('CDBARRA', trim(Reader.Text), []) then
        begin
        Showmessage('ESE REGISTRO NO EXISTE!');
        Reader.SetFocus;
        exit;
        end;
        Edit1.Text:=GetDetallesQuery.fieldbyname('CDBARRA').asstring;
        CantidadCompra.Value:=GetDetallesQuery.Fieldbyname('AMOUNT').AsFloat;
        CantidadPasado.Value:=GetDetallesQuery.Fieldbyname('CONTADO').AsFloat;
        PrecioCompra.Value:=GetDetallesQuery.Fieldbyname('PRECIO_CON').AsFloat;
        PVPRecomedable.Value:=GetDetallesQuery.Fieldbyname('PRECIO_CON').AsFloat / (1-Benificio.Value/100);
        Panel5.Enabled:=True;
       end;
   //  end;
   1: begin
        if not GetDetallesQuery.Locate('SUCODIGO',trim(Reader.Text),[loCaseInsensitive]) then
        begin
        Showmessage('ESE REGISTRO NO EXISTE!');
        Reader.SetFocus;
        exit;
        end;
        CantidadCompra.Value:=GetDetallesQuery.Fieldbyname('AMOUNT').AsFloat;
        CantidadPasado.Value:=GetDetallesQuery.Fieldbyname('CONTADO').AsFloat;
        PrecioCompra.Value:=GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat;
        PVPRecomedable.Value:=GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat / (1-Benificio.Value/100);
        Panel5.Enabled:=True;
        if GetDetallesQuery.fieldbyname('CDBARRA').asstring <> '' then
        begin
           Edit1.Text:=GetDetallesQuery.fieldbyname('CDBARRA').asstring;
           //Edit1Exit(self);
        end
        else begin
            with dbCheck do
            begin
            Connection:=DataModule2.ZCon1;
            Active:=false;
            SQL.Clear;
            SQL.Text:='SELECT ENA FROM GOODS_OFPROVEEDOR '
                            +'where 1=1  and  SUCODIGO=''' + GetDetallesQuery.fieldbyname('SUCODIGO').asstring +''' '
                            +'and ID_PROVEEDOR =''' + SumTotalQuery.fieldbyname('ID_PROVEEDOR').asstring +''' limit 1';
            open;
            end;

              if dbCheck.RecordCount < 1 then
              begin
              Edit1.Color:=clYellow;
              Edit1.SetFocus;
              exit;
              end;
              Edit1.Text:=dbCheck.fieldbyname('ENA').asstring;
        end;
   end;
   end;

   Edit1Exit(self);
   //Edit1KeyDown(self, aKEY, []);
    //showmessage('s');
   {判断进货单存不存在货品, 判断是否是新货品, 判断有没有属性货品}
   {if not GetDetallesQuery.Locate('CDBARRA', trim(Reader.Text), []) then
        begin
        Showmessage('ESE REGISTRO NO EXISTE!');
        Reader.SetFocus;
        exit;
        end
   ELSE
   BEGIN

   end;   }
end;

procedure TForm1.ReaderKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.ReempezarClick(Sender: TObject);
begin
  Reader.Clear;
  doClear;
  Panel5.Enabled:=False;
  Reader.SetFocus;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo2.Lines.Clear;
 Memo2.Lines.Add(nFun2);
 Memo2.Lines.Add(nFun8);
 Memo2.Lines.Add(nFun4);
 Memo2.Lines.Add(nFun7);
 Memo2.Lines.Add(nFun9);
 Memo2.Lines.Add(nFun6);

DoGetTaxRates;
GetCategorys();
GetBrand();
GetClasse();

ListView1.Columns.Items[0].Caption:= nCaption1;
ListView1.Columns.Items[0].Width:=80;
ListView1.Columns.Items[1].Caption:= nCaption2;//ListView1.Columns.Items[2].Caption:= '列3';
ListView1.Columns.Items[1].Width:=100; //这里设定列的宽度
ComboBox2.Clear;
  ComboBox2.Items.Add(nMSN49);
  ComboBox2.Items.Add(nMSN50);
  ComboBox2.Items.Add(nMSN51);
  ComboBox2.Items.Add(nMSN52);
  ComboBox2.Items.Add(nMSN53);
  ComboBox2.ItemIndex:=0;
  if FForma_Read = 'CODING' then Combobox1.ItemIndex:=1 else ComboBox1.ItemIndex:=0;
  ShowTables;
  GetSumTotal;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
var
  Product:TGoods;
begin
  //if key=VK_F3 then
  //OpenCashEspon;

  if key=VK_F3 then
  AbirCajon();

  if Key=VK_F5 then
  begin
  if trim(Edit1.Text)='' then
  begin
  FormGoodsSpu:=TFormGoodsSpu.Create(self);
  FormGoodsSpu.ShowModal;
  FormGoodsSpu.Free;
  end
  else
  begin
  Product.ENA:=trim(Edit1.Text);
  Product.GOODS_ID:=dbArti.FieldByName('GOODS_ID').AsString;
  Product.SKU_NO:=dbArti.FieldByName('SKU_NO').AsString;
     Product.ITEM_NAME:=dbArti.Fieldbyname('GOODS_NAME').asstring;
     Product.COST:=dbArti.Fieldbyname('COST').AsFloat;
        IF FormGoodsSpu.Created(Product) THEN
        begin
        GetGoods(Trim(Edit1.Text));
        end ;
       // GetGoods(Trim(Edit1.Text));

    end;
  end;

  if Key=Vk_F8 then
  begin
    ReempezarClick(self);
  end;

  if key=VK_F9 then
  BitBtn5Click(self);

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Panel5.Enabled:=False;
  Reader.SetFocus;
    if oneItem then
  begin

  with DbTest do
  begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.Text:='SELECT ID_TMPLIST, ISCHECKED FROM CHECKLIST_ORDERS '
            +'WHERE 1=1 and ID_TMPLIST=:ID_TMPLIST ';
  ParamByName('ID_TMPLIST').AsString:=Items;
  open;
  end;
  if DbTest.RecordCount > 0 then
  begin

  //if (DbTest.FieldByName('ISCHECKED').AsBoolean = True) then button1.Enabled:=False else button1.Enabled:=True;

    button1.Enabled:=not DbTest.FieldByName('ISCHECKED').AsBoolean;
  end;

  end;
end;

procedure TForm1.IvaDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.Lang1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.Lang2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.N2Click(Sender: TObject);
begin
 Button4Click(self);
end;

procedure TForm1.OriginalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.PrecioAnterioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.PrecioCompraKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.PVPEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
  if Key=VK_Left then ChequeEdit.SetFocus;
  if Key=VK_up then ChequeEdit.SetFocus;
end;

procedure TForm1.PVPRecomedableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  if GetDetallesQuery.RecordCount = 0 then exit;
  if GetDetallesQuery.Fieldbyname('CDBARRA').asstring = '' then exit;
  doClear;
  Reader.Text:= GetDetallesQuery.Fieldbyname('CDBARRA').asstring;
  Reader.SetFocus;
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  grid : TDBGrid;
  row : integer;
  const
  RowHeight = 18;
begin

if (DBGrid1.DataSource.DataSet.FieldByName('AMOUNT').AsFloat=DBGrid1.DataSource.DataSet.FieldByName('CONTADO').AsFloat) then
  begin
  DBGrid1.Canvas.Font.Color:=clyellow;
  dbgrid1.Canvas.Brush.Color := clGreen;
  dbgrid1.Canvas.FillRect(Rect);
  end
  else
  if (DBGrid1.DataSource.DataSet.FieldByName('AMOUNT').AsFloat < DBGrid1.DataSource.DataSet.FieldByName('CONTADO').AsFloat) then
  begin
  dbgrid1.Canvas.Brush.Color := clRed;
  dbgrid1.Canvas.FillRect(Rect);
  end;
  DBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TForm1.Edit10Change(Sender: TObject);
var
 FINDSTR:string;
 index:integer;
begin
  FINDSTR:=Edit10.Text;
  index:=ComboBox2.ItemIndex;
 { case index of
  0: begin
  DetallesDataSource.DataSet.Filter:='CDBARRA=''' +  FINDSTR +'*''';
  DetallesDataSource.DataSet.Filtered:=true;
  end;

  1: GetDetallesQuery.Filter:=' (ISPASSED=1 '
    +'AND CONTADO >= AMOUNT ) and (SUCODIGO LIKE ''%'+FINDSTR+'%'' or  CDBARRA LIKE ''%'+FINDSTR+'%'' or DESCRIPCION LIKE ''%'+FINDSTR+'%'' )';


  2: GetDetallesQuery.Filter:=' CONTADO < AMOUNT and (SUCODIGO LIKE ''%'+FINDSTR+'%'' or  CDBARRA LIKE ''%'+FINDSTR+'%'' or DESCRIPCION LIKE ''%'+FINDSTR+'%'' )';
  3: GetDetallesQuery.Filter:=' (AMOUNT < 0) and (SUCODIGO LIKE ''%'+FINDSTR+'%'' or  CDBARRA LIKE ''%'+FINDSTR+'%'' or DESCRIPCION LIKE ''%'+FINDSTR+'%'' )' ;
  4: GetDetallesQuery.Filter:=' CONTADO <> AMOUNT and (SUCODIGO LIKE ''%'+FINDSTR+'%'' or  CDBARRA LIKE ''%'+FINDSTR+'%'' or DESCRIPCION LIKE ''%'+FINDSTR+'%'' )';
  end;  }
end;

procedure TForm1.Edit10KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 FINDSTR:string;
 index:integer;
begin
  FINDSTR:=Edit10.Text;
  if Key=VK_RETURN then
  begin
   GetDetallesQuery.Filtered:=False;
   GetDetallesQuery.Filter:=' CDBARRA LIKE ' +  QuotedStr('*'+ FINDSTR + '*') + ' or DESCRIPCION LIKE ' +  QuotedStr('*'+ FINDSTR + '*');
   GetDetallesQuery.Filtered:=True;
   {Ztable.Filtered:=false;
   Ztable.Filter:= ' AFiled like  ' +  QuotedStr( edit.Text + '*');
   Ztable.Filtered:=true; }
  end;

end;

Procedure TForm1.GetGoods(CdBarra: string);
var
  SKU_NO:string;
  Product:TGOODS;
begin
   IsNewGoods:=True;
   with dbArti do
      begin
      Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.CLEAR;
      SQL.TEXT:='SELECT T1.SKU_NO, T2.GOODS_NAME, T2.GOODS_NAME2, T2.ENA , T2.CODE, T2.TYPE, T1.COMMODITY_UNIT, '
      +'T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
      +'T2.CATEGORY_ID, T2.BRAND_ID, T2.TAXRATE_ID, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ '
      +'FROM GOODS_SKU AS T1 LEFT JOIN GOODS_SPU AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
      +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID '
      +'WHERE 1=1 AND T1.ISCHILD= 1 '
      +'AND T2.ENA =:ENA ';
      ParamByName('ENA').AsString:=CdBarra;
      open;
      end;
      if dbArti.RecordCount > 1 then
      begin
      SKU_NO:=FormSelectSKU.IniciaSelection(CdBarra);
      if SKU_NO = '' then
          begin
          DoClear;
          Reader.SetFocus;
          exit;
          end;
      if not (dbArti.Locate('SKU_NO', SKU_NO, [])) then
          begin
          DoClear;
            Reader.SetFocus;
            exit;
          end;
      end
      ELSE
      BEGIN
      with dbArti do
      begin
      Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.CLEAR;
      SQL.TEXT:='SELECT T1.SKU_NO, T2.GOODS_NAME, T2.GOODS_NAME2, T2.ENA , T2.CODE, T2.TYPE, T1.COMMODITY_UNIT, '
      +'T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
      +'T2.CATEGORY_ID, T2.BRAND_ID, T2.TAXRATE_ID, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ '
      +'FROM GOODS_SKU AS T1 LEFT JOIN GOODS_SPU AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
      +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID '
      +'WHERE 1=1 AND T1.ISCHILD= 0 '
      +'AND T2.ENA =:ENA ';
      ParamByName('ENA').AsString:=CdBarra;
      open;
      END;
      SKU_NO:=dbArti.FieldByName('SKU_NO').AsString;
      if SKU_NO = '' then
          begin
          DoClear;
          Reader.SetFocus;
          exit;
          end;
      end;
      UUIDEdit.Text:=dbArti.FieldByName('SKU_NO').AsString;
      Edit2.Text:=dbArti.FieldByName('CODE').AsString;
      Lang1.Text:=dbArti.FieldByName('GOODS_NAME').AsString;
      Lang2.Text:=dbArti.FieldByName('GOODS_NAME2').AsString;
      CategoryDBBox.KeyValue:= dbArti.FieldByName('CATEGORY_ID').Value;
      BrandDBBox.KeyValue:= dbArti.FieldByName('BRAND_ID').Value;
      IvaDBLookupComboBox1.KeyValue:= dbArti.FieldByName('TAXRATE_ID').Value;
      PrecioAnterio.Value:= dbArti.fieldbyname('COST').AsCurrency;
      PVPEdit.Value:=dbArti.fieldbyname('SELLING_P1C').AsCurrency;
      IsNewGoods:=False;
      Panel5.Enabled:=True;
      ChequeEdit.SetFocus;
end;

procedure TForm1.Edit1Exit(Sender: TObject);
var
  SKU_NO:string;
  Product:TGOODS;
begin
  if trim(edit1.Text) = '' then  exit;
   IF ExistGoods(trim(Edit1.Text)) THEN
    BEGIN
    panel5.Enabled:=True;
       GetGoods(Trim(Edit1.Text));
       ChequeEdit.SetFocus;
     END
     ELSE
     BEGIN
     Product.ENA:=trim(Edit1.Text);
     Product.ITEM_NAME:=GetDetallesQuery.Fieldbyname('DESCRIPCION').asstring;
     Product.COST:=GetDetallesQuery.Fieldbyname('PRECIO_CON').AsFloat;
     Product.SKU_NO:='';
        IF NOT FormGoodsSpu.Created(Product) THEN
        begin
        DoClear;
        Reader.SetFocus;
        EXIT;
        end ;
        GetGoods(Trim(Edit1.Text));
       { IsNewGoods:=True;
        edit1.Text:='';
        Reader.SetFocus;
                exit;}
     end;
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key=VK_Return then
  begin
  if IsNewGoods then Reader.SetFocus
  else
  SelectNext(ActiveControl,True,True);

  end;
  if Key=VK_Left then Reader.SetFocus;
  if Key=VK_up then Reader.SetFocus;
end;

procedure TForm1.Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
   if Key=VK_Left then Reader.SetFocus;
  if Key=VK_up then Reader.SetFocus;
end;

procedure TForm1.Edit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
var
 busqueda: string;
 Result: TStringArray;
  table:string;
begin
  Reader.Text:='';
  doClear;
  busqueda := InputBox(nMSG5,nMSG6,'');
    if not (busqueda = '') then begin
      table:='CHECKLIST_ITEMS';
      Result:=FLookup.IniciaBusquedas(busqueda, ['SUCODIGO','CDBARRA', 'DESCRIPCION'], table, Items, ['SUCODIGO','CDBARRA', 'DESCRIPCION', 'PRECIO_con', 'AMOUNT', 'CONTADO', 'PVPC'], ['SUREFERENCIA', 'CDBARRA', 'DESCRIPCION', 'PRECIO_COMPRA', 'AMOUNT', 'CONTADO', 'PVPC'] );
  if ((Result[0]='-1')) or (Result[1]='-1') then
  begin
    reader.SetFocus;
  exit;
  end;

  if ((Result[0] <> '-1')) and (Result[1]='-1') then
    begin
    ComboBox1.ItemIndex:=1;
    Reader.Text:=Result[0];
    GetDetallesQuery.Locate('SUCODIGO', Result[0], []);
    end
  else begin
    ComboBox1.ItemIndex:=0;
    Reader.Text:=Result[1];
    GetDetallesQuery.Locate('CDBARRA', Result[1], []);
  end;
  reader.SetFocus;
  exit;
  end;

end;

procedure TForm1.BrandDBBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i:integer;
  B_UUID:STRING;
begin
  SumTotalQuery.First;
  for i:=0 to SumTotalQuery.RecordCount-1 do
  BEGIN

  with dbTest do
  begin
   Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.Clear;
  sql.Text:='select ISCHECKED from CHECKLIST_ORDERS '
  +'where 1=1 '
  +'AND CHECKLIST_ORDERS.ID_TMPLIST=:ID_TMPLIST '
     +'AND CHECKLIST_ORDERS.ID_PROVEEDOR=:ID_PROVEEDOR ';
  ParamByName('ID_TMPLIST').AsString:=SumTotalQuery.Fieldbyname('ID_TMPLIST').AsString; ;
  ParamByName('ID_PROVEEDOR').AsString:=SumTotalQuery.Fieldbyname('ID_PROVEEDOR').AsString;
  open;
  end;

  if dbTest.FieldByName('ISCHECKED').AsString='Y' then Continue;

  B_UUID:=Get36UUID();
  with dbTrabajo do
  begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.Clear;
  SQL.Text:='UPDATE CHECKLIST_ORDERS set ISCHECKED=''Y'' '
  +'WHERE 1=1 '
     +'AND CHECKLIST_ORDERS.ID_TMPLIST=:ID_TMPLIST '
     +'AND CHECKLIST_ORDERS.ID_PROVEEDOR=:ID_PROVEEDOR ';
  ParamByName('ID_TMPLIST').AsString:=SumTotalQuery.Fieldbyname('ID_TMPLIST').AsString; ;
  ParamByName('ID_PROVEEDOR').AsString:=SumTotalQuery.Fieldbyname('ID_PROVEEDOR').AsString;
  ExecSQL;
  SQL.Clear;
  SQL.Text:='INSERT INTO BUY_HISTORY (B_UUID, ID_PROVEEDOR, NAME_PROVEEDOR, DOCUMENT, N_DOCUMENT, ID_TIENDA, Staff, operator, TERMINAL, BUYDATE, STATUS_LOCK, STATUS_FAC, LOCKEDDATE, REALPAGO, ID_STOCK) '
             +'VALUES (:B_UUID, :ID_PROVEEDOR, :NAME_PROVEEDOR, :DOCUMENT, :N_DOCUMENT, :ID_TIENDA, :Staff, :operator, :TERMINAL, :BUYDATE, :STATUS_LOCK, :STATUS_FAC, NOW(), :REALPAGO, :ID_STOCK )';

  ParamByName('B_UUID').AsString:=B_UUID;
    ParamByName('ID_PROVEEDOR').AsString:=SumTotalQuery.Fieldbyname('ID_PROVEEDOR').AsString;
    ParamByName('NAME_PROVEEDOR').AsString:=SumTotalQuery.Fieldbyname('NAME_PROVEEDOR').AsString;
    ParamByName('DOCUMENT').AsString:=SumTotalQuery.Fieldbyname('DOCUMENT').AsString;
    ParamByName('N_DOCUMENT').AsString:=SumTotalQuery.Fieldbyname('N_DOCUMENT').AsString;
    ParamByName('ID_TIENDA').AsString:=UseDBC.EMID;
    ParamByName('Staff').AsString:=SumTotalQuery.Fieldbyname('STAFF').AsString;
    ParamByName('operator').AsString:=LOGIN;
    ParamByName('TERMINAL').AsString:=UseDBC.PCID;
    ParamByName('BUYDATE').AsDate:=SumTotalQuery.Fieldbyname('FECHA_C').AsDateTime;
    ParamByName('STATUS_LOCK').AsInteger:=1;
    ParamByName('STATUS_FAC').AsInteger:=0;
    ParamByName('REALPAGO').AsFloat:= SumTotalQuery.FieldByName('uLineatotal').AsFloat;
    ParamByName('ID_STOCK').AsString:=SumTotalQuery.Fieldbyname('ID_STOCK').AsString;
    ExecSQL;

    ////要重写.另建一表.
    Active:=False;
  SQL.Clear;
  SQL.Text:='INSERT INTO BUY_ITEMS (B_UUID, GOODS_ID, SKU_NO, ENA, QUANTITY, COMMODITY_UNIT, COST, DISCOUNT, BUY_DATE ) '
  +'SELECT :B_UUID, GOODS_ID, SKU_NO, ENA, QUANTITY, COMMODITY_UNIT, COST, DISCOUNT, BUY_DATE FROM TMP_BUY_ITEMS '
  +'WHERE 1=1 AND ID_TMPLIST=:ID_TMPLIST ';
   ParamByName('B_UUID').AsString:=B_UUID;
   ParamByName('ID_TMPLIST').AsString:=SumTotalQuery.Fieldbyname('ID_TMPLIST').AsString;
   ExecSQL;


    SQL.Clear;
  SQL.Text:='INSERT INTO SPENDING_ITEMS (SPENDING_CONTENT_ID, D_UUID, ID_TIENDA, P0) VALUES (:SPENDING_CONTENT_ID, :D_UUID, :ID_TIENDA, :P0) '
  +'ON DUPLICATE KEY UPDATE '
  +'P0=:P0 ';
  ParamByName('SPENDING_CONTENT_ID').AsInteger:=0;   //0 购买支出
  ParamByName('D_UUID').AsString:=B_UUID;
  ParamByName('ID_TIENDA').AsString:=UseDBC.EMID;
  ParamByName('P0').AsFloat:= SumTotalQuery.FieldByName('uLineatotal').AsFloat;
  ExecSQL;
  Active:=False;
  SQL.Clear;
  SQL.Text:='INSERT INTO SPENDING_ACCION (D_UUID, STAFF, EFECTIVO, TARJETA,  TRANSFERENCIA, OTHER, SPENDING_DATE ) '
  +'VALUES (:D_UUID, :STAFF, :EFECTIVO, :TARJETA, :TRANSFERENCIA, :OTHER, :SPENDING_DATE )';
  ParamByName('D_UUID').AsString:=B_UUID;
  ParamByName('STAFF').AsString:=SumTotalQuery.Fieldbyname('STAFF').AsString;
  ParamByName('EFECTIVO').AsFloat:= SumTotalQuery.FieldByName('uLineatotal').AsFloat;
  ParamByName('TARJETA').AsFloat:= 0;
  ParamByName('TRANSFERENCIA').AsFloat:= 0;
  ParamByName('OTHER').AsFloat:= 0;
  ParamByName('SPENDING_DATE').AsDate:=SumTotalQuery.Fieldbyname('FECHA_C').AsDateTime;
  ExecSQL;
  END;
    SumTotalQuery.Next;
  end;
  SumTotalQuery.Close;
  GetDetallesQuery.Close;
  button1.Enabled:=false;
  showmessage('储存完毕');
end;

procedure TForm1.Button2Click(Sender: TObject);
VAR
  I :INTEGER;
  Bookmark: TBookmark;
  SQLModifyFoyerRecord: string;
begin

   if Trim(Reader.Text)='' then
    begin
    Reader.SetFocus;
    Exit;
    end;
    if Trim(Edit1.Text)='' then
    begin
    Edit1.SetFocus;
    Exit;
    end;

    if IsNewGoods then
    begin
    Reader.SetFocus;
    Exit;
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
  ParamByName('GOODS_ID').AsString:=dbArti.FieldByName('GOODS_ID').AsString;
  ParamByName('ENA').AsString:=dbArti.FieldByName('ENA').AsString;
  ParamByName('SUCODIGO').AsString:=GetDetallesQuery.Fieldbyname('SUCODIGO').AsString;
  ParamByName('COST').AsFloat:= GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat;
  ParamByName('DISCOUNT').AsFloat:= GetDetallesQuery.Fieldbyname('DISCOUNT').AsFloat;
  ParamByName('ID_PROVEEDOR').AsString:=SumTotalQuery.Fieldbyname('ID_PROVEEDOR').AsString;
  ExecSQL;
  Active:=False;
  SQL.Clear;
  SQL.Text:='INSERT INTO GOODS_SPU_PRICE (GOODS_ID, COST, pvp1c) values (:GOODS_ID, :COST, :pvp1c) '
  +'ON DUPLICATE KEY UPDATE '
  +'COST=:COST, PVP1C=:PVP1C ';
  ParamByName('GOODS_ID').AsString:=dbArti.FieldByName('GOODS_ID').AsString;
  ParamByName('COST').AsFloat:= GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat;
  ParamByName('pvp1c').AsFloat:= PVPEdit.Value;
  ExecSQL;


  IF dbArti.FieldByName('TYPE').AsInteger = 1 THEN
  BEGIN
    WITH CombinaQuery do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=False;
    SQL.Text:='SELECT * FROM GOODS_SKU_COMBINATION WHERE 1=1 AND SKU_NO=:SKU_NO ';
    ParamByName('SKU_NO').AsString:=dbArti.FieldByName('SKU_NO').AsString;
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
      ParamByName('STOCK').AsFloat:= CHEQUEEdit.Value*CombinaQuery.FieldByName('QUANTITY').AsFloat;
      ExecSQL;
      sql.Clear;
      sql.Text:='INSERT INTO STOCKGOODS (ID_STOCK, GOODS_ID, SKU_NO, AMOUNT, GOODS_STATUS) '
      +'VALUES (:ID_STOCK, :GOODS_ID, :SKU_NO, AMOUNT=AMOUNT+:AMOUNT, :GOODS_STATUS) '
      +'ON DUPLICATE KEY UPDATE '
      +'AMOUNT=AMOUNT+:AMOUNT ';
      ParamByName('ID_STOCK').AsString:=GetDetallesQuery.Fieldbyname('ID_STOCK').AsString;
      ParamByName('GOODS_ID').AsString:=CombinaQuery.FieldByName('GOODS_ID').AsString;
      ParamByName('SKU_NO').AsString:=CombinaQuery.FieldByName('MEMBER_SKU_NO').AsString;
      ParamByName('AMOUNT').AsFloat:= CHEQUEEdit.Value*CombinaQuery.FieldByName('QUANTITY').AsFloat;
      ParamByName('GOODS_STATUS').AsInteger:= 0;
      ExecSQL;
      //////////临时表，储存sku/////
      sql.Clear;
      sql.Text:='INSERT INTO TMP_BUY_ITEMS (GOODS_ID, SKU_NO, ENA, QUANTITY, COMMODITY_UNIT, COST, DISCOUNT, BUY_DATE, ID_TMPLIST) '
      +'VALUES (:GOODS_ID, :SKU_NO, :ENA, :QUANTITY, :COMMODITY_UNIT, :COST, :DISCOUNT, :BUY_DATE, :ID_TMPLIST) '
      +'ON DUPLICATE KEY UPDATE '
      +'QUANTITY=QUANTITY+:QUANTITY ';
      ParamByName('GOODS_ID').AsString:=CombinaQuery.FieldByName('GOODS_ID').AsString;
      ParamByName('SKU_NO').AsString:=CombinaQuery.FieldByName('MEMBER_SKU_NO').AsString;
      ParamByName('ENA').AsString:=dbArti.FieldByName('ENA').AsString;
      ParamByName('QUANTITY').AsFloat:= CHEQUEEdit.Value*CombinaQuery.FieldByName('QUANTITY').AsFloat;
      ParamByName('COMMODITY_UNIT').AsString:=dbArti.FieldByName('COMMODITY_UNIT').AsString;
      ParamByName('COST').AsFloat:= GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat;
      ParamByName('DISCOUNT').AsFloat:= GetDetallesQuery.Fieldbyname('DISCOUNT').AsFloat;
      ParamByName('BUY_DATE').AsDate:=SumTotalQuery.Fieldbyname('FECHA_C').AsDateTime;
      ParamByName('ID_TMPLIST').AsString:=GetDetallesQuery.Fieldbyname('ID_TMPLIST').AsString;
      ExecSQL;
      CombinaQuery.Next;
      end;
    end;
  end
  ELSE
  BEGIN
  Active:=False;
  SQL.Clear;
  SQL.Text:='UPDATE GOODS_SKU SET COST=:COST, SELLING_P1C=:SELLING_P1C, STOCK=STOCK+:STOCK '
        +'WHERE 1=1 AND ISCHILD=0 AND SKU_NO=:SKU_NO ';
  ParamByName('SKU_NO').AsString:=dbArti.FieldByName('SKU_NO').AsString;
  ParamByName('COST').AsFloat:= GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat;
  ParamByName('SELLING_P1C').AsFloat:= PVPEdit.Value;
  ParamByName('STOCK').AsFloat:= CHEQUEEdit.Value;
  ExecSQL;

  /////////仓库中的货品库存//////////
  sql.Clear;
  sql.Text:='INSERT INTO STOCKGOODS (ID_STOCK, GOODS_ID, SKU_NO, AMOUNT, GOODS_STATUS) '
  +'VALUES (:ID_STOCK, :GOODS_ID, :SKU_NO, AMOUNT=AMOUNT+:AMOUNT, :GOODS_STATUS) '
  +'ON DUPLICATE KEY UPDATE '
  +'AMOUNT=AMOUNT+:AMOUNT ';
  ParamByName('ID_STOCK').AsString:=GetDetallesQuery.Fieldbyname('ID_STOCK').AsString;
  ParamByName('GOODS_ID').AsString:=dbArti.FieldByName('GOODS_ID').AsString;
  ParamByName('SKU_NO').AsString:=dbArti.FieldByName('SKU_NO').AsString;
  ParamByName('AMOUNT').AsFloat:= CHEQUEEdit.Value;
  ParamByName('GOODS_STATUS').AsInteger:= 0;
  ExecSQL;

  //////////临时表，储存sku/////
  sql.Clear;
  sql.Text:='INSERT INTO TMP_BUY_ITEMS (GOODS_ID, SKU_NO, ENA, QUANTITY, COMMODITY_UNIT, COST, DISCOUNT, BUY_DATE, ID_TMPLIST) '
  +'VALUES (:GOODS_ID, :SKU_NO, :ENA, :QUANTITY, :COMMODITY_UNIT, :COST, :DISCOUNT, :BUY_DATE, :ID_TMPLIST) '
  +'ON DUPLICATE KEY UPDATE '
  +'QUANTITY=QUANTITY+:QUANTITY ';
  ParamByName('GOODS_ID').AsString:=dbArti.FieldByName('GOODS_ID').AsString;
  ParamByName('SKU_NO').AsString:=dbArti.FieldByName('SKU_NO').AsString;
  ParamByName('ENA').AsString:=dbArti.FieldByName('ENA').AsString;
  ParamByName('QUANTITY').AsFloat:= CHEQUEEdit.Value;
  ParamByName('COMMODITY_UNIT').AsString:=dbArti.FieldByName('COMMODITY_UNIT').AsString;
  ParamByName('COST').AsFloat:= GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat;
  ParamByName('DISCOUNT').AsFloat:= GetDetallesQuery.Fieldbyname('DISCOUNT').AsFloat;
  ParamByName('BUY_DATE').AsDate:=SumTotalQuery.Fieldbyname('FECHA_C').AsDateTime;
  ParamByName('ID_TMPLIST').AsString:=GetDetallesQuery.Fieldbyname('ID_TMPLIST').AsString;
  ExecSQL;
  END;

 end;


  ////对进货单据的操作///

SQLModifyFoyerRecord :=  'UPDATE CHECKLIST_ITEMS SET ' +
                         'GOODS_ID=:GOODS_ID, SKU_NO=:SKU_NO, '+
                        ' MICODIGO = :MICODIGO, CDBARRA= :CDBARRA, CONTADO = :CONTADO,  IVA = :IVA, ' +
                        ' PRECIO_SIN =:PRECIO_SIN,  PRECIO_CON = :PRECIO_CON, PVPS =:PVPS, PVPC =:PVPC, '+
                        'ISPASSED =:ISPASSED, ' +
                        'UPDATED =NOW() '+        ///用于更新 , 否则   0 records 错误.
                        'WHERE ID = :ID';
GetDetallesQuery.UpdateObject:=ZUpdateSQL1;
ZUpdateSQL1.ModifySQL.Text:=SQLModifyFoyerRecord;

GetDetallesQuery.Edit;
GetDetallesQuery.Fieldbyname('GOODS_ID').AsString:=dbArti.FieldByName('GOODS_ID').AsString;
GetDetallesQuery.Fieldbyname('SKU_NO').AsString:=dbArti.FieldByName('SKU_NO').AsString;
if ComboBox2.ItemIndex <> 0 then
begin
GetDetallesQuery.Fieldbyname('CDBARRA').AsString:=Trim(Edit1.Text);
end;
GetDetallesQuery.Fieldbyname('MICODIGO').AsString:=Trim(Edit2.Text);
GetDetallesQuery.Fieldbyname('CONTADO').AsFloat:=GetDetallesQuery.Fieldbyname('CONTADO').AsFloat+ChequeEdit.Value;
GetDetallesQuery.Fieldbyname('IVA').AsFloat:=DataModule2.IVAQuery.FieldByName('iva').AsFloat;
if GetDetallesQuery.Fieldbyname('PRECIO_SIN').AsFloat=0 then
  GetDetallesQuery.Fieldbyname('PRECIO_SIN').AsFloat:=GetDetallesQuery.Fieldbyname('PRECIO_CON').AsFloat/(1+DataModule2.ivaQuery.FieldByName('IVA').AsFloat/100);
if GetDetallesQuery.Fieldbyname('PRECIO_CON').AsFloat=0 then
  GetDetallesQuery.Fieldbyname('PRECIO_CON').AsFloat:=GetDetallesQuery.Fieldbyname('PRECIO_SIN').AsFloat*(1+DataModule2.ivaQuery.FieldByName('IVA').AsFloat/100);
GetDetallesQuery.Fieldbyname('PVPS').AsFloat:=PVPEdit.Value/(1+DataModule2.ivaQuery.FieldByName('iva').AsFloat/100);
GetDetallesQuery.Fieldbyname('PVPC').AsFloat:=PVPEdit.Value;
//GetDetallesQuery.Fieldbyname('CATEGORY').AsString:= CategoryDBBox.listsource.dataset.FieldByName('CATEGORY').AsString;
GetDetallesQuery.Fieldbyname('ISPASSED').AsBoolean:=True;
GetDetallesQuery.Post;

  Reader.Clear;
  DoClear;
  GetSumTotal;
  Panel5.Enabled:=False;
  Reader.SetFocus;
end;

procedure TForm1.Button2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Left then PVPEdit.SetFocus;
  if Key=VK_up then PVPEdit.SetFocus;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if GetDetallesQuery.RecordCount=0 then exit;
if FForma_Read = 'CODING' then exit;
if GetDetallesQuery.FieldByName('ISCHECKED').AsBoolean then exit;
if GetDetallesQuery.FieldByName('AMOUNT').AsFloat<=0 then
begin
 if Panel10.Visible=True then
  begin
    button9.OnClick(self);
  end;
exit;
end;
Panel10.Visible:=True;
Edit3.Text:=GetDetallesQuery.FieldByName('CDBARRA').AsString;
Original.Value:=GetDetallesQuery.Fieldbyname('AMOUNT').AsFloat;
EDIT4.SetFocus;
DBGrid1.Enabled:=False;

end;

procedure TForm1.Button5Enter(Sender: TObject);
begin
  Reader.SetFocus;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  Bookmark: TBookmark;
  index:integer;
  AMOUNT:Double;
begin
if (Change.Value > Original.Value) or (Change.Value <=0 ) then
begin
  showmessage('数量不对吧');
  Change.SetFocus;
  exit;
end;
if trim(Edit4.Text)='' then
begin
  Edit4.SetFocus;
  exit;
end;
 Bookmark := GetDetallesQuery.GetBookmark;
 AMOUNT:= GetDetallesQuery.Fieldbyname('AMOUNT').AsFloat-Change.Value;
 GetDetallesQuery.UpdateObject:=ZUpdateSQL1;
ZUpdateSQL1.ModifySQL.Text:='UPDATE CHECKLIST_ITEMS SET ' +
'AMOUNT =:AMOUNT, '+
'UPDATED =NOW() '+        ///用于更新 , 否则   0 records 错误.
'WHERE ID = :ID';
GetDetallesQuery.Edit;
 GetDetallesQuery.Fieldbyname('AMOUNT').AsFloat:= AMOUNT;
 GetDetallesQuery.Post;

 with dbTrabajo do
 begin
 Connection:=DataModule2.ZCon1;
  Active:=False;
 sql.Clear;
 sql.Text:='insert into  CHECKLIST_ITEMS  (GOODS_ID, SKU_NO, SUCODIGO, CDBARRA, MICODIGO, DESCRIPCION, AMOUNT, PRECIO_SIN, PRECIO_CON, DISCOUNT, IVA, PVPOPTION, ID_TMPLIST, CONTADO, PVPS, PVPC, IMPORTE) '
  +'select * from (select GOODS_ID, SKU_NO, SUCODIGO, :CD, MICODIGO, DESCRIPCION, :AMOUNT, PRECIO_SIN, PRECIO_CON, DISCOUNT, IVA, PVPOPTION, ID_TMPLIST, CONTADO, PVPS, PVPC, IMPORTE from CHECKLIST_ITEMS '
  +'where 1=1 and  cdbarra =:CDBARRA) as t2 '
  +'on duplicate key update CHECKLIST_ITEMS.AMOUNT=CHECKLIST_ITEMS.AMOUNT+:AMOUNT ';
 ParamByName('CD').AsString:=Trim(Edit4.Text);
 ParamByName('CDBARRA').AsString:=Trim(Edit3.Text);
 ParamByName('AMOUNT').AsFloat:=Change.Value;
 ExecSQL;

 end;
 GetDetallesQuery.Refresh;
 index:=ComboBox2.ItemIndex;
  case index of
  0: GetDetallesQuery.Filter:='';

  1: GetDetallesQuery.Filter:='(ISPASSED=1 '
    +'AND CONTADO >= AMOUNT )';
  2: GetDetallesQuery.Filter:=' CONTADO < AMOUNT '
    ;
  3: GetDetallesQuery.Filter:='(AMOUNT < 0)'
    ;
  4: GetDetallesQuery.Filter:=' CONTADO <> AMOUNT '
  ;
  end;
 //GetDetallesQuery.GotoBookmark(Bookmark);
  Edit3.Text:='';
  Edit4.Text:='';
  Original.Value:=0;
  Change.Value:=0;
  Button9Click(self);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  Edit3.Text:='';
  Edit4.Text:='';
  Panel1.Enabled:=True;
  DBGrid1.Enabled:=True;
  Panel10.Visible:=False;
end;

procedure TForm1.C1Click(Sender: TObject);
begin
  BitBtn5Click(self);
end;

procedure TForm1.CantidadCompraKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.CantidadPasadoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.CategoryDBBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.ChangeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TForm1.ChequeEditExit(Sender: TObject);
begin
  if ChequeEdit.Value > (CantidadCompra.Value*100) then
  begin
  ChequeEdit.SetFocus;
  exit;
  end;
 { if (IsNewGoods=True) and (ChequeEdit.Value=0) then
 // if MessageDlg('提示', '您确定数量为 0 ？', mtConfirmation,
 //  [mbYes, mbNo],1) = mrNo Then
   if Application.MessageBox ('您确定数量为 0 ?', 'Warning', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION)
= idNO then
   begin
    ChequeEdit.SetFocus;
    exit;
   end;  }
end;

procedure TForm1.ChequeEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
  if Key=VK_Left then Reader.SetFocus;
  if Key=VK_up then Reader.SetFocus;
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
  if  ComboBox1.ItemIndex = 1 then Edit1.TabStop:=True;
  if  ComboBox1.ItemIndex = 0 then Edit1.TabStop:=False;
end;

procedure TForm1.ComboBox2Enter(Sender: TObject);
begin
   GetDetallesQuery.Filter:='';
end;

procedure TForm1.ComboBox2Select(Sender: TObject);
var
  index:integer;
begin
  GetDetallesQuery.FilterOptions:=[foCaseInsensitive];
  GetDetallesQuery.Filtered:=False;

  index:=ComboBox2.ItemIndex;
  case index of
  0: GetDetallesQuery.Filter:='';

  1: GetDetallesQuery.Filter:='(ISPASSED=1 '
    +'AND CONTADO >= AMOUNT )';
  2: GetDetallesQuery.Filter:=' CONTADO < AMOUNT '
    ;
  3: GetDetallesQuery.Filter:='(AMOUNT < 0)'
    ;
  4: GetDetallesQuery.Filter:=' CONTADO <> AMOUNT '
  ;

  end;
  {
  if ComboBox2.Text=nMSN50 then
  begin
   GetDetallesQuery.Filter:='(ISPASSED=''Y'' '
    +'AND CONTADO >= AMOUNT )';

 end
 else
 begin
 if ComboBox2.Text=nMSN51 then
    begin

     GetDetallesQuery.Filter:=' CONTADO < AMOUNT ';
    end
    else
  begin
   if ComboBox2.Text=nMSN52 then
    begin
    GetDetallesQuery.Filter:='(AMOUNT < 0)';

    end
    else
   begin
    GetDetallesQuery.Filter:='';
   end;
  end;
 end;   }
 GetDetallesQuery.Filtered:=true;
end;

end.

