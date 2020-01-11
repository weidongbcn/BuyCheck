unit Checkdb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  LCLtype, StdCtrls, Buttons, DbCtrls, DBGrids, ComCtrls, ZDataset, ZSqlUpdate,
  rxcurredit, variants, DB, memds, Types, Global, Grids, findout;

type

  { TFormCheck }

  TFormCheck = class(TForm)
    BitBtn5: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Memo2: TMemo;
    Reempezar: TButton;
    Button2: TButton;
    ComboBox2: TComboBox;
    DataSource1: TDataSource;
    dbArti: TZQuery;
    dbCheck: TZQuery;
    dbTrabajo: TZQuery;
    DetallesDataSource: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Label29: TLabel;
    ListView1: TListView;
    MemDataset1: TMemDataset;
    Panel2: TPanel;
    Panel3: TPanel;
    PVPRecomedable: TCurrencyEdit;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    CantidadPasado: TCurrencyEdit;
    Benificio: TCurrencyEdit;
    ChequeEdit: TCurrencyEdit;
    CantidadCompra: TCurrencyEdit;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    FamiliaBox1: TDBLookupComboBox;
    IvaDBLookupComboBox1: TDBLookupComboBox;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label38: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Lang2: TEdit;
    Marca: TEdit;
    Medida: TEdit;
    Panel4: TPanel;
    Panel1: TPanel;
    Panel5: TPanel;
    PrecioCompra: TCurrencyEdit;
    PVPEdit: TCurrencyEdit;
    PrecioAnterio: TCurrencyEdit;
    Reader: TEdit;
    ReqDBLookupComboBox1: TDBLookupComboBox;
    SubCateDataSource: TDataSource;
    SubCateQuery: TZQuery;
    Unidades: TEdit;
    GetDetallesQuery: TZQuery;
    SumTotalQuery: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;
    procedure BenificioChange(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ChequeEditExit(Sender: TObject);
    procedure ChequeEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox2CloseUp(Sender: TObject);
    procedure ComboBox2Enter(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FamiliaBox1CloseUp(Sender: TObject);
    procedure FamiliaBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FamiliaBox1Select(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IvaDBLookupComboBox1Change(Sender: TObject);
    procedure IvaDBLookupComboBox1ChangeBounds(Sender: TObject);
    procedure IvaDBLookupComboBox1Click(Sender: TObject);
    procedure IvaDBLookupComboBox1CloseUp(Sender: TObject);
    procedure IvaDBLookupComboBox1Select(Sender: TObject);
    procedure ReaderEnter(Sender: TObject);
    procedure ReempezarClick(Sender: TObject);
    procedure SubfamiliaBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure IvaDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Lang2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MarcaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MedidaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PVPEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure ReaderExit(Sender: TObject);
    procedure ReaderKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ReqDBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ShowTables;
    procedure GetSumTotal();
    procedure DoClear;
    procedure UnidadesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
  private


  public
     function IniciaDB(Forma_Read:string; dbItems: Array of string): boolean;

  end;

  procedure ShowFormCheckDb;

var
  FormCheck: TFormCheck;
  Items: string;
  IsNewProduct, continuar, buscaotravaz, Dochange:Boolean;
  FForma_Read:string;

implementation
uses
  connect, dblookup;

{$R *.lfm}

procedure ShowFormCheckDb;
begin
  with TFormCheck.Create(Application) do
    begin
      ShowModal;
    end;
end;

procedure TFormCheck.ShowTables;
begin
  ;
  with GetDetallesQuery do
  begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.Text:='SELECT T1.*, T2.NAME AS NAME FROM '+UseDBC.EmID+'REPASOLISTDETALLES AS T1 left join '+UseDBC.EmID+'CATEGORYS AS T2 on t1.id_category=t2.id '
         +'WHERE 1=1 '
         +'AND ID_TMPLIST IN ('+Items+') ';

    // ParamByName('ID_TMPLIST').AsString:=Items;
  //   ParamByName('ID_PROVEEDOR').AsString:=ACheckDoc.ID_PROVEEDOR;
  //   ParamByName('DOCUMENT').AsString:=ACheckDoc.DOCUMENT;
  //   ParamByName('N_DOCUMENT').AsString:=ACheckDoc.N_DOCUMENT;
  Open;
  end;
  TFloatField(GetDetallesQuery.FieldByName('PRECIO_sin')).DisplayFormat := '0.000';
  TFloatField(GetDetallesQuery.FieldByName('PRECIO_con')).DisplayFormat := '0.000';

  MemDataset1.CopyFromDataset(GetDetallesQuery);
end;

procedure TFormCheck.GetSumTotal();
var
  i: integer;
  vNewItem: TListItem;
begin
    //Icon.l
    with SumTotalQuery do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=False;
    SQL.Text:='SELECT ID_TMPLIST as ID_TMPLIST,  SUM(UNIDAD*PRECIO_CON*(1-DESCUENTO/100)) as uLineatotal, '
    +' SUM(CONTADO*PRECIO_CON*(1-DESCUENTO/100))AS CLINEATOTAL FROM '+USEDBC.EMID+'REPASOLISTDETALLES '
    +'WHERE 1=1 '
    +'AND ID_TMPLIST IN ('+Items+') '
    +'GROUP BY ID_TMPLIST';
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

procedure TFormCheck.DoClear;
begin

 Edit1.Clear;
 Edit2.Clear;
 Edit3.Clear;
 Lang2.Clear;
 PrecioAnterio.Value:=0;
 PrecioCompra.Value:=0;
 CantidadCompra.Value:=0;
 CantidadPasado.Value:=0;

 PVPEdit.Value:=0;

 ChequeEdit.Value:=0;


 //ivaDBLookupComboBox1.OnClick(Self);
 //DBLookupComboBox3.KeyValue:=null;
 //
// FamiliaBox1.KeyValue:= FamiliaBox1.ListSource.DataSet.FieldByName(FamiliaBox1.KeyField).Value;
// FamiliaBox1.OnClick(self);

end;

procedure TFormCheck.UnidadesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.FormCreate(Sender: TObject);
begin
 Memo2.Lines.Clear;
 Memo2.Lines.Add(nFun2);
 Memo2.Lines.Add(nFun8);
 Memo2.Lines.Add(nFun7);
Memo2.Lines.Add(nFun6);

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

procedure TFormCheck.IvaDBLookupComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.Lang2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.MarcaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.MedidaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.PVPEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.ReaderExit(Sender: TObject);
var
  index:integer;
begin
  if Reader.Text='' then exit;
   index:=ComboBox1.ItemIndex;

   case index of
   0: begin
        if not GetDetallesQuery.Locate('CDBARRA', trim(Reader.Text), []) then
        begin
        Showmessage('ESE REGISTRO NO EXISTE!');
        Reader.SetFocus;
        exit;
        end;
       { Edit1.Text:=MemDataset1.FieldByName('CDBARRA').AsString;
        Edit2.Text:=RightStr(Edit1.Text, 6);
        Edit3.Text:=MemDataset1.FieldByName('DESCRIPCION').AsString;  }
        //Edit4.Text:=MemDataset1.FieldByName('CDBARRA').AsString;


        CantidadCompra.Value:=GetDetallesQuery.Fieldbyname('UNIDAD').AsFloat;
        CantidadPasado.Value:=GetDetallesQuery.Fieldbyname('CONTADO').AsFloat;
        PrecioCompra.Value:=GetDetallesQuery.Fieldbyname('PRECIO_CON').AsFloat;

        PVPRecomedable.Value:=GetDetallesQuery.Fieldbyname('PRECIO_CON').AsFloat / (1-Benificio.Value/100);

       if length(Trim(Reader.Text)) = 13 then
       begin
         Edit1.Text:=GetDetallesQuery.fieldbyname('CDBARRA').asstring;

         Edit1Exit(self);
     {
     with dbArti do
        begin
        Connection:=DataModule2.ZCon1;
        Active:=false;
        SQL.Clear;
        SQL.Text:='SELECT * FROM '+UseDBC.EmID+'PRODUCTLIST WHERE 1=1 '   //'+UseDBC.EmID+'IMPUESTO.ID='+UseDBC.EmID+'PRODUCTO.IMPUESTO_ID '
        +'AND PRO_CDBARRA=''' + GetDetallesQuery.fieldbyname('CDBARRA').asstring+''' limit 1';
        open;
        end;

        if dbArti.RecordCount>0 then
        begin
        IsNewProduct:=False;
        Edit1.Text:=dbArti.fieldbyname('PRO_CDBARRA').asstring;
        Edit2.Text:=dbArti.fieldbyname('PRO_REFERENCIA').asstring;
        Edit3.Text:=dbArti.fieldbyname('PRO_LANG1').asstring;
        Lang2.Text:=dbArti.fieldbyname('PRO_LANG2').asstring;

        if not (dbArti.FieldByName('ID_CATE').AsString='') then
        begin
        FamiliaBox1.KeyValue:=dbArti.FieldByName('ID_CATE').AsString;
        FamiliaBox1.OnCloseUp(Self);
        end;
        if not (dbArti.FieldByName('ID_SUBCATE').AsString='') then
        begin
        SubfamiliaBox1.KeyValue:=dbArti.FieldByName('ID_SUBCATE').AsString;
        end;
        if not (dbArti.FieldByName('ID_IMPUESTO').AsString='') then
        begin
        IvaDBLookupComboBox1.KeyValue:=dbArti.FieldByName('ID_IMPUESTO').AsString;
        end;
        if not (dbArti.FieldByName('ID_IMPUESTO').AsString='') then
        begin
        ReqDBLookupComboBox1.KeyValue:=dbArti.FieldByName('ID_IMPUESTO').AsString;
        end;

        Medida.Text:=dbArti.FieldByName('MEDIDA').AsString;
        Unidades.Text:=dbArti.FieldByName('UNIDAD').AsString;
        PrecioAnterio.Value:= dbArti.fieldbyname('PRECIO_COMPRAS_CON').AsCurrency;
        PVPEdit.Value:=dbArti.fieldbyname('PVP1C').AsCurrency;
        Edit1.Color:=clDefault;
        end
        else
        begin
        IsNewProduct:=True;
        edit1.Text:=GetDetallesQuery.Fieldbyname('CDBARRA').asstring;
        edit2.Text:=RightStr(Trim(Edit1.Text), 6);
        edit3.Text:=GetDetallesQuery.Fieldbyname('DESCRIPCION').asstring;
        Edit1.Color:=clYellow;
        end;
        }
       end
       else
       begin
            edit3.Text:=GetDetallesQuery.Fieldbyname('DESCRIPCION').asstring;
         lang2.Text:=GetDetallesQuery.Fieldbyname('DESCRIPCION').asstring;
        Edit1.Color:=clYellow;
        Edit1.Text:='';
        Edit1.SetFocus;
       end;




       end;
   //  end;
   1: begin
        if not GetDetallesQuery.Locate('SUCODIGO',trim(Reader.Text),[loCaseInsensitive]) then
        begin
        Showmessage('ESE REGISTRO NO EXISTE!');
        Reader.SetFocus;
        exit;
        end;

        CantidadCompra.Value:=GetDetallesQuery.Fieldbyname('UNIDAD').AsFloat;
        CantidadPasado.Value:=GetDetallesQuery.Fieldbyname('CONTADO').AsFloat;
        PrecioCompra.Value:=GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat;
        PVPRecomedable.Value:=GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat / (1-Benificio.Value/100);

        if GetDetallesQuery.fieldbyname('CDBARRA').asstring <> '' then
        begin
           Edit1.Text:=GetDetallesQuery.fieldbyname('CDBARRA').asstring;
           Edit1Exit(self);
           { with dbArti do
            begin
            Connection:=DataModule2.ZCon1;
            Active:=false;
            SQL.Clear;
            SQL.Text:='SELECT * FROM '+UseDBC.EmID+'PRODUCTLIST WHERE 1=1 '   //'+UseDBC.EmID+'IMPUESTO.ID='+UseDBC.EmID+'PRODUCTO.IMPUESTO_ID '
            +'AND PRO_CDBARRA=''' + GetDetallesQuery.fieldbyname('CDBARRA').asstring +''' limit 1';
            open;
            end;

            if dbArti.RecordCount>0 then
            begin
            IsNewProduct:=False;
            Edit1.Text:=dbArti.fieldbyname('PRO_CDBARRA').asstring;
            Edit2.Text:=dbArti.fieldbyname('PRO_REFERENCIA').asstring;
            Edit3.Text:=dbArti.fieldbyname('PRO_LANG1').asstring;
            Lang2.Text:=dbArti.fieldbyname('PRO_LANG2').asstring;

            if not (dbArti.FieldByName('ID_CATE').AsString='') then
            begin
            FamiliaBox1.KeyValue:=dbArti.FieldByName('ID_CATE').AsString;
            FamiliaBox1.OnCloseUp(Self);
            end;
            if not (dbArti.FieldByName('ID_SUBCATE').AsString='') then
            begin
            SubfamiliaBox1.KeyValue:=dbArti.FieldByName('ID_SUBCATE').AsString;
            end;
            if not (dbArti.FieldByName('ID_IMPUESTO').AsString='') then
            begin
            IvaDBLookupComboBox1.KeyValue:=dbArti.FieldByName('ID_IMPUESTO').AsString;
            end;
            if not (dbArti.FieldByName('ID_IMPUESTO').AsString='') then
            begin
            ReqDBLookupComboBox1.KeyValue:=dbArti.FieldByName('ID_IMPUESTO').AsString;
            end;

            Medida.Text:=dbArti.FieldByName('MEDIDA').AsString;
            Unidades.Text:=dbArti.FieldByName('UNIDAD').AsString;
            PrecioAnterio.Value:= dbArti.fieldbyname('PRECIO_COMPRAS_CON').AsCurrency;
            PVPEdit.Value:=dbArti.fieldbyname('PVP1C').AsCurrency;
            Edit1.Color:=clDefault;
            end
            else
            begin
            IsNewProduct:=True;
            edit1.Text:=GetDetallesQuery.Fieldbyname('CDBARRA').asstring;
            edit2.Text:=RightStr(Trim(Edit1.Text), 6);
            edit3.Text:=GetDetallesQuery.Fieldbyname('DESCRIPCION').asstring;
            Edit1.Color:=clYellow;
            end; }
        end
        else begin
            with dbCheck do
            begin
            Connection:=DataModule2.ZCon1;
            Active:=false;
            SQL.Clear;
            SQL.Text:='SELECT PRO_CDBARRA FROM '+UseDBC.EmID+'GOODSOFPROVEEDOR '
                            +'where 1=1  and  SUCODIGO=''' + GetDetallesQuery.fieldbyname('SUCODIGO').asstring +''' '
                            +'and ID_PROVEEDOR =''' + GetDetallesQuery.fieldbyname('ID_PROVEEDOR').asstring +''' limit 1';
            open;
            end;

              if dbCheck.RecordCount < 1 then
              begin
              IsNewProduct:=True;
              edit3.Text:=GetDetallesQuery.Fieldbyname('DESCRIPCION').asstring;
              Edit1.Color:=clYellow;
              exit;
              end;

              Edit1.Text:=dbCheck.fieldbyname('PRO_CDBARRA').asstring;
              Edit1Exit(self);

            {
            with dbArti do
            begin
            Connection:=DataModule2.ZCon1;
            Active:=false;
            SQL.Clear;
            SQL.Text:='SELECT * FROM '+UseDBC.EmID+'PRODUCTLIST WHERE 1=1 '   //'+UseDBC.EmID+'IMPUESTO.ID='+UseDBC.EmID+'PRODUCTO.IMPUESTO_ID '
            +'AND PRO_CDBARRA=''' + dbCheck.fieldbyname('PRO_CDBARRA').asstring +''' limit 1';
            open;
            end;

            if dbArti.RecordCount>0 then
            begin
            IsNewProduct:=False;
            Edit1.Text:=dbArti.fieldbyname('PRO_CDBARRA').asstring;
            Edit2.Text:=dbArti.fieldbyname('PRO_REFERENCIA').asstring;
            Edit3.Text:=dbArti.fieldbyname('PRO_LANG1').asstring;
            Lang2.Text:=dbArti.fieldbyname('PRO_LANG2').asstring;

            if not (dbArti.FieldByName('ID_CATE').AsString='') then
            begin
            FamiliaBox1.KeyValue:=dbArti.FieldByName('ID_CATE').AsString;
            FamiliaBox1.OnCloseUp(Self);
            end;
            if not (dbArti.FieldByName('ID_SUBCATE').AsString='') then
            begin
            SubfamiliaBox1.KeyValue:=dbArti.FieldByName('ID_SUBCATE').AsString;
            end;
            if not (dbArti.FieldByName('ID_IMPUESTO').AsString='') then
            begin
            IvaDBLookupComboBox1.KeyValue:=dbArti.FieldByName('ID_IMPUESTO').AsString;
            end;
            if not (dbArti.FieldByName('ID_IMPUESTO').AsString='') then
            begin
            ReqDBLookupComboBox1.KeyValue:=dbArti.FieldByName('ID_IMPUESTO').AsString;
            end;

            Medida.Text:=dbArti.FieldByName('MEDIDA').AsString;
            Unidades.Text:=dbArti.FieldByName('UNIDAD').AsString;
            PrecioAnterio.Value:= dbArti.fieldbyname('PRECIO_COMPRAS_CON').AsCurrency;
            PVPEdit.Value:=dbArti.fieldbyname('PVP1C').AsCurrency;
            Edit1.Color:=clDefault;
            end
            else
            begin
            IsNewProduct:=True;
            edit3.Text:=GetDetallesQuery.Fieldbyname('DESCRIPCION').asstring;
            Edit1.Color:=clYellow;
            end;
            }
        end;

       // if IsNewProDuct then Edit1.SetFocus else ChequeEdit.SetFocus;
   end;

   end;

end;

procedure TFormCheck.ReaderKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.ReqDBLookupComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.BitBtn5Click(Sender: TObject);
var
 busqueda: string;
 Result: TStringArray;
  table:string;
begin
  busqueda := InputBox(nMSG5,nMSG6,'');
    if not (busqueda = '') then begin
      table:=USEDBC.EMID+'REPASOLISTDETALLES';
      Result:=FLookup.IniciaBusquedas(busqueda, ['SUCODIGO','CDBARRA', 'DESCRIPCION'], table, Items, ['SUCODIGO','CDBARRA', 'DESCRIPCION', 'PRECIO_con', 'UNIDAD', 'CONTADO', 'PVPC'], ['SUREFERENCIA', 'CDBARRA', 'DESCRIPCION', 'PRECIO_COMPRA', 'UNIDAD', 'CONTADO', 'PVPC'] );
  if ((Result[0]='-1')) or (Result[1]='-1') then
  begin
    reader.SetFocus;
  exit;
  end;

  if ((Result[0] <> '-1')) and (Result[1]='-1') then
    begin
    ComboBox1.ItemIndex:=1;
    Reader.Text:=Result[0];
    end
  else begin
    ComboBox1.ItemIndex:=0;
    Reader.Text:=Result[1];
  end;
  reader.SetFocus;
  exit;
  end;
end;

procedure TFormCheck.Button2Click(Sender: TObject);
var
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
    if Trim(Edit2.Text)='' then
    begin
    Edit2.SetFocus;
    Exit;
    end;
    if Trim(Edit3.Text)='' then
    begin
    Edit3.SetFocus;
    Exit;
    end;
    if FamiliaBox1.KeyValue=null then
  begin
    FamiliaBox1.SetFocus;
  Exit;
  end;

  if IvaDBLookupComboBox1.KeyValue=null then
  begin
    IvaDBLookupComboBox1.SetFocus;
  Exit;
  end;

//if IsNewProduct then
begin
  with dbTrabajo do
 begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.Text:='insert into '+EmID+'PRODUCTLIST '
     +'(PRO_REFERENCIA, PRO_LANG1, PRO_LANG2, PRO_CDBARRA, ID_CATEGORY, '
     +'MEDIDA, UNIDAD, ID_IMPUESTO, IVA, REQ, PRECIO_COMPRAS_SIN, PRECIO_COMPRAS_CON, PVP1S, PVP1C, '
     +'PVP2S, PVP2C, PVP3S, PVP3C, '
     +'STOCK_ACTUAL, STOCK_MAX_LIMIT, STOCK_MINI_LIMIT, CDBARRA_CAJA, UNITS_CAJA, '
     +'FECHA_ADD,  MARCA_NOMBRE, '
     +'CAN_DISCount, DISC_Limit, DISC_SELL, CAL_CANON, RATE_CANON, CAN_FACTURA, CAL_STOCK, ISOFERTA, ISPESO, STOP_USE, OBSERVACION) '
     +'VALUES (:PRO_REFERENCIA, :PRO_LANG1, :PRO_LANG2, :PRO_CDBARRA, :ID_CATEGORY, '
     +':MEDIDA, :UNIDAD, :ID_IMPUESTO, :IVA, :REQ, :PRECIO_COMPRAS_SIN, :PRECIO_COMPRAS_CON, :PVP1S, :PVP1C, '
     +':PVP2S, :PVP2C, :PVP3S, :PVP3C, '
     +':STOCK_ACTUAL, :STOCK_MAX_LIMIT, :STOCK_MINI_LIMIT, :CDBARRA_CAJA, :UNITS_CAJA, '
     +':FECHA_ADD,  :MARCA_NOMBRE, '
     +':CAN_DISCount, :DISC_Limit, :DISC_SELL, :CAL_CANON, :RATE_CANON, :CAN_FACTURA, :CAL_STOCK, :ISOFERTA, :ISPESO, :STOP_USE, :OBSERVACION) '
     +'ON DUPLICATE KEY UPDATE '
     +'PRO_REFERENCIA=:PRO_REFERENCIA, PRO_LANG1=:PRO_LANG1, PRO_LANG2=:PRO_LANG2, PRO_CDBARRA=:PRO_CDBARRA, '
      +'ID_CATEGORY=:ID_CATEGORY, '
     +'UNIDAD=:UNIDAD, ID_IMPUESTO=:ID_IMPUESTO, IVA=:IVA, REQ=:REQ, PRECIO_COMPRAS_SIN=:PRECIO_COMPRAS_SIN, '
     +'PRECIO_COMPRAS_CON=:PRECIO_COMPRAS_CON, PVP1S=:PVP1S, PVP1C=:PVP1C, '
     +'PVP2S=:PVP2S, PVP2C=:PVP2C, PVP3S=:PVP3S, PVP3C=:PVP3C, '
     +'STOCK_ACTUAL=STOCK_ACTUAL+:STOCK_ACTUAL, '
     +'CDBARRA_CAJA=:CDBARRA_CAJA, UNITS_CAJA=:UNITS_CAJA, '
     +'FECHA_FABRICA=:FECHA_FABRICA, FECHA_CADUCA=:FECHA_CADUCA,  MARCA_NOMBRE=:MARCA_NOMBRE, '
     +'CAN_DISCount=:CAN_DISCount, DISC_Limit=:DISC_Limit, DISC_SELL=:DISC_SELL, CAL_CANON=:CAL_CANON, '
     +'RATE_CANON=:RATE_CANON, CAN_FACTURA=:CAN_FACTURA, CAL_STOCK=:CAL_STOCK, ISOFERTA=:ISOFERTA, ISPESO=:ISPESO, STOP_USE=:STOP_USE, OBSERVACION=:OBSERVACION ';


     ParamByName('PRO_REFERENCIA').AsString:=Trim(Edit2.Text);
         ParamByName('PRO_CDBARRA').AsString:=Trim(Edit1.Text);
         ParamByName('PRO_LANG1').AsString:=Trim(Edit3.Text);
         ParamByName('PRO_LANG2').AsString:=Trim(Lang2.Text);
         ParamByName('ID_CATEGORY').AsString:=FamiliaBox1.KeyValue;
        { if FamiliaBox1.KeyValue=null then
         ParamByName('ID_CATE').AsString:='' else
         ParamByName('ID_CATE').AsString:=FamiliaBox1.listsource.dataset.FieldValues[FamiliaBox1.keyfield];
         ParamByName('CATEGORIA').AsString:=FamiliaBox1.Text;
         if SubfamiliaBox1.KeyValue=null then
         ParamByName('ID_SUBCATE').AsString:='' else
         ParamByName('ID_SUBCATE').AsString:=SubfamiliaBox1.KeyValue;
         ParamByName('SUBCATEGORIA').AsString:=SubfamiliaBox1.Text;
         }
         ParamByName('MEDIDA').AsString:=Trim(Medida.Text);
         ParamByName('UNIDAD').AsString:=Unidades.Text;

         ParamByName('ID_IMPUESTO').AsString:=IvaDBLookupComboBox1.KeyValue;
         ParamByName('IVA').AsFloat:= DataModule2.ivaQuery.FieldByName('iva').AsFloat;
         ParamByName('REQ').AsFloat:=DataModule2.ivaQuery.FieldByName('REQ').AsFloat;

         ParamByName('PRECIO_COMPRAS_SIN').AsFloat:=GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat/(1+DataModule2.ivaQuery.FieldByName('iva').AsFloat/100);
         ParamByName('PRECIO_COMPRAS_CON').AsFloat:=GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat;

         ParamByName('PVP1S').AsFloat:=PVPEdit.Value/(1+DataModule2.ivaQuery.FieldByName('iva').AsFloat/100);
         ParamByName('PVP1C').AsFloat:=PVPEdit.Value;
         ParamByName('PVP2S').AsFloat:=PVPEdit.Value/(1+DataModule2.ivaQuery.FieldByName('iva').AsFloat/100);;
         ParamByName('PVP2c').AsFloat:=PVPEdit.Value;
         ParamByName('PVP3S').AsFloat:=0;
         ParamByName('PVP3c').AsFloat:=0;
         ParamByName('STOCK_ACTUAL').AsFloat:=ChequeEdit.Value;
         ParamByName('STOCK_MAX_LIMIT').AsFloat:=0;
         ParamByName('STOCK_MINI_LIMIT').AsFloat:=0;
        // ParamByName('FECHA_FABRICA').AsDate:=DateEdit1.Date;
        // ParamByName('FECHA_CADUCA').AsDate:=DateEdit2.Date;
       //  ParamByName('DIAS_AVISA').AsInteger:=DiasAviso.AsInteger;
         ParamByName('FECHA_ADD').AsDate:=now();


     //    if AvisoCad.ItemIndex=1 then ParamByName('CAD_AVISO').AsString:='Y'
     //    else ParamByName('CAD_AVISO').AsString:='N';

       //  ParamByName('IMAGES_DATA').LoadFromStream(BlobStream, ftBlob);
      //   if PermiteDesc.ItemIndex=1 then ParamByName('CAN_DISCount').AsString:='Y'
        ParamByName('CAN_DISCount').AsString:='Y';

         ParamByName('DISC_Limit').AsFloat:=0;

        // if EnRebaja.ItemIndex=1 then ParamByName('ISOFERTA').AsString:='Y'
       //  else ParamByName('ISOFERTA').AsString:='N';
         ParamByName('ISOFERTA').AsString:='N';

         ParamByName('DISC_SELL').AsFloat:=0;

         ParamByName('CAL_CANON').AsString:='N';
         ParamByName('RATE_CANON').AsFloat:=0;
         //if PermiteFac.ItemIndex=1 then ParamByName('CAN_FACTURA').AsString:='Y'
         //else ParamByName('CAN_FACTURA').AsString:='N';

         ParamByName('CAN_FACTURA').AsString:='Y';
         ParamByName('CAL_STOCK').AsString:='Y' ;
         //else ParamByName('CAL_STOCK').AsString:='N';

        // if CalPeso.ItemIndex=1 then ParamByName('ISPESO').AsString:='Y'
        // else ParamByName('ISPESO').AsString:='N';
         ParamByName('ISPESO').AsString:='N';

       //  if Activa.ItemIndex=1 then ParamByName('STOP_USE').AsString:='N'
       //  else ParamByName('STOP_USE').AsString:='Y';
         ParamByName('STOP_USE').AsString:='N';

         //if EnRebaja.ItemIndex=1  then         ParamByName('ISOFERTA').AsString:='Y'
         //else ParamByName('ISOFERTA').AsString:='N';

         ParamByName('CDBARRA_CAJA').AsString:='';
         ParamByName('UNITS_CAJA').AsFloat:=0;

         ParamByName('MARCA_NOMBRE').AsString:=Marca.Text;                  //MarcaLookupComboBox.Text;
         ParamByName('OBSERVACION').AsString:='';

         //memo1.Lines.Text:=sql.Text;
         ExecSQL;

     //   SHOWMESSAGE('更新货品资料');
      // if IsNewProduct then
       begin
       SQL.CLEAR;
       SQL.TEXT:='INSERT INTO '+EMID+'STOCKGOODS '
       +'(ID_STOCK, PRO_REFERENCIA, PRO_LANG1, PRO_LANG2, PRO_CDBARRA, ID_CATEGORY, ' // ID_CATE,  ID_SUBCATE,'
       + 'CANTIDAD, ESTADO) VALUES (:ID_STOCK, :PRO_REFERENCIA, :PRO_LANG1, :PRO_LANG2, :PRO_CDBARRA, '
       +':ID_CATEGORY, '
      // +':ID_CATE,  :ID_SUBCATE,'
       + 'CANTIDAD =CANTIDAD+:CANTIDAD, :ESTADO)'
       +'ON DUPLICATE KEY UPDATE '
        +'ID_CATEGORY=:ID_CATEGORY, '
       //+'ID_CATE=:ID_CATE,  ID_SUBCATE=:ID_SUBCATE, '
       +'CANTIDAD =CANTIDAD+:CANTIDAD, ESTADO=:ESTADO';
       PARAMBYNAME('ID_STOCK').ASSTRING:= UseConf.ID_STOCKDEFAULT;
       ParamByName('PRO_REFERENCIA').AsString:=Trim(Edit2.Text);
       ParamByName('PRO_CDBARRA').AsString:=Trim(Edit1.Text);
       ParamByName('PRO_LANG1').AsString:=Trim(Edit3.Text);
       ParamByName('PRO_LANG2').AsString:=Trim(lang2.Text);
       ParamByName('ID_CATEGORY').AsString:=FamiliaBox1.KeyValue;
       {if FamiliaBox1.KeyValue=null then
       ParamByName('ID_CATE').AsString:='' else
       ParamByName('ID_CATE').AsString:=FamiliaBox1.listsource.dataset.FieldValues[FamiliaBox1.keyfield]; //FamiliaBox1.KeyValue;

       if SubfamiliaBox1.KeyValue=null then
       ParamByName('ID_SUBCATE').AsString:='' else
       ParamByName('ID_SUBCATE').AsString:=SubfamiliaBox1.KeyValue;
       }
       PARAMBYNAME('CANTIDAD').ASFLOAT:= ChequeEdit.Value;
       PARAMBYNAME('ESTADO').ASSTRING:='GOOD';
       EXECSQL;
      //  SHOWMESSAGE('更新数据库资料');
        end;
    //   if not (IdProv.Text='') then
       begin
      SQL.Clear;
      SQL.Text:='insert into '+EmID+'GOODSOFPROVEEDOR '
      +'(SUCODIGO, PRO_REFERENCIA, PRO_LANG1, PRO_LANG2, PRO_CDBARRA, ID_CATEGORY, ' // ID_CATE, CATEGORIA, ID_SUBCATE, SUBCATEGORIA, '
      +'ID_IMPUESTO, IVA, REQ, PRECIO_sin, PRECIO_CON, '
      +'ID_PROVEEDOR, '
      +'FECHA) '
      +'VALUES (:SUCODIGO, :PRO_REFERENCIA, :PRO_LANG1, :PRO_LANG2, :PRO_CDBARRA, :ID_CATEGORY, ' //:ID_CATE, :CATEGORIA, :ID_SUBCATE, :SUBCATEGORIA, '
      +':ID_IMPUESTO, :IVA, :REQ, :PRECIO_sin, :PRECIO_CON, '
      +':ID_PROVEEDOR, '
      +':FECHA) '
      +'ON DUPLICATE KEY UPDATE '
      +'SUCODIGO=:SUCODIGO, PRO_REFERENCIA=:PRO_REFERENCIA, PRO_LANG1=:PRO_LANG1, PRO_LANG2=:PRO_LANG2, PRO_CDBARRA=:PRO_CDBARRA, '
       +'ID_CATEGORY=:ID_CATEGORY, '
      //+'ID_CATE=:ID_CATE, CATEGORIA=:CATEGORIA, ID_SUBCATE=:ID_SUBCATE, SUBCATEGORIA=:SUBCATEGORIA, '
      +'ID_IMPUESTO=:ID_IMPUESTO, IVA=:IVA, REQ=:REQ, PRECIO_SIN=:PRECIO_SIN, '
      +'PRECIO_CON=:PRECIO_CON, '
      +'ID_PROVEEDOR=:ID_PROVEEDOR, '
      +'FECHA=:FECHA ';
       ParamByName('SUCODIGO').AsString:=GetDetallesQuery.Fieldbyname('SUCODIGO').AsString;
       ParamByName('PRO_REFERENCIA').AsString:=Trim(Edit2.Text);
       ParamByName('PRO_CDBARRA').AsString:=Trim(Edit1.Text);
       ParamByName('PRO_LANG1').AsString:=Trim(Edit3.Text);
       ParamByName('PRO_LANG2').AsString:=Trim(Lang2.Text);
       ParamByName('ID_CATEGORY').AsString:=FamiliaBox1.KeyValue;
      { if FamiliaBox1.KeyValue=null then
       ParamByName('ID_CATE').AsString:='' else
       ParamByName('ID_CATE').AsString:=FamiliaBox1.listsource.dataset.FieldValues[FamiliaBox1.keyfield];
       ParamByName('CATEGORIA').AsString:=FamiliaBox1.Text;
       if SubfamiliaBox1.KeyValue=null then
       ParamByName('ID_SUBCATE').AsString:='' else
       ParamByName('ID_SUBCATE').AsString:=SubfamiliaBox1.KeyValue;
       ParamByName('SUBCATEGORIA').AsString:=SubfamiliaBox1.Text;
       }
       ParamByName('ID_IMPUESTO').AsString:=IvaDBLookupComboBox1.KeyValue;
       ParamByName('IVA').AsFloat:= DataModule2.ivaQuery.FieldByName('iva').AsFloat;
       ParamByName('REQ').AsFloat:=DataModule2.ivaQuery.FieldByName('REQ').AsFloat;

       ParamByName('PRECIO_SIN').AsFloat:=GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat/(1+DataModule2.ivaQuery.FieldByName('iva').AsFloat/100);
       ParamByName('PRECIO_CON').AsFloat:=GetDetallesQuery.Fieldbyname('PRECIO_con').AsFloat;

       ParamByName('ID_PROVEEDOR').AsString:=GetDetallesQuery.fieldbyname('ID_PROVEEDOR').asstring;
       ParamByName('FECHA').AsDate:=date;

       ExecSQL;
      // SHOWMESSAGE('更新供应库资料');
       end;
   end;
end;

SQLModifyFoyerRecord :=  'UPDATE '+UseDBC.EmID+'REPASOLISTDETALLES SET ' +
                          ' MICODIGO = :MICODIGO, CDBARRA= :CDBARRA, CONTADO = :CONTADO, ID_IMPUESTO = :ID_IMPUESTO, IVA = :IVA, ' +
                          'REQ =:REQ, PRECIO_SIN =:PRECIO_SIN,  PRECIO_CON = :PRECIO_CON, PVPS =:PVPS, PVPC =:PVPC, '+
                          'ID_CATEGORY =:ID_CATEGORY, ISPASSED =:ISPASSED, ' +
                          'UPDATED =NOW() '+        ///用于更新 , 否则   0 records 错误.
                          'WHERE ID = :ID';
GetDetallesQuery.UpdateObject:=ZUpdateSQL1;
ZUpdateSQL1.ModifySQL.Text:=SQLModifyFoyerRecord;

GetDetallesQuery.Edit;

  if ComboBox2.ItemIndex <> 0 then
    begin
    GetDetallesQuery.Fieldbyname('CDBARRA').AsString:=Trim(Edit1.Text);
    end;
    GetDetallesQuery.Fieldbyname('MICODIGO').AsString:=Trim(Edit2.Text);
    GetDetallesQuery.Fieldbyname('CONTADO').AsFloat:=GetDetallesQuery.Fieldbyname('CONTADO').AsFloat+ChequeEdit.Value;
    GetDetallesQuery.Fieldbyname('ID_IMPUESTO').AsString:=ivaDBLookupComboBox1.KeyValue;
    GetDetallesQuery.Fieldbyname('IVA').AsFloat:=DataModule2.IVAQuery.FieldByName('iva').AsFloat;
    GetDetallesQuery.Fieldbyname('REQ').AsFloat:=DataModule2.ivaQuery.FieldByName('REQ').AsFloat;
    if GetDetallesQuery.Fieldbyname('PRECIO_SIN').AsFloat=0 then
        GetDetallesQuery.Fieldbyname('PRECIO_SIN').AsFloat:=GetDetallesQuery.Fieldbyname('PRECIO_CON').AsFloat/(1+DataModule2.ivaQuery.FieldByName('IVA').AsFloat/100);
    if GetDetallesQuery.Fieldbyname('PRECIO_CON').AsFloat=0 then
        GetDetallesQuery.Fieldbyname('PRECIO_CON').AsFloat:=GetDetallesQuery.Fieldbyname('PRECIO_SIN').AsFloat*(1+DataModule2.ivaQuery.FieldByName('IVA').AsFloat/100);


    GetDetallesQuery.Fieldbyname('PVPS').AsFloat:=PVPEdit.Value/(1+DataModule2.ivaQuery.FieldByName('iva').AsFloat/100);
    GetDetallesQuery.Fieldbyname('PVPC').AsFloat:=PVPEdit.Value;
    GetDetallesQuery.Fieldbyname('ID_CATEGORY').AsString:=FamiliaBox1.KeyValue;
    GetDetallesQuery.Fieldbyname('NAME').AsString:= FamiliaBox1.listsource.dataset.FieldByName('NAME').AsString;  //FamiliaBox1.ListSource.DataSet.FieldByName('NAME').AsString;

     GetDetallesQuery.Fieldbyname('ISPASSED').AsBoolean:=True;

   { if VarToStr(FamiliaBox1.KeyValue)='' then
    GetDetallesQuery.Fieldbyname('ID_CATE').AsString:=''
     else
    GetDetallesQuery.Fieldbyname('ID_CATE').AsString:=FamiliaBox1.KeyValue;
    GetDetallesQuery.Fieldbyname('CATEGORIA').AsString:=FamiliaBox1.Text;
    if VarToStr(SubFamiliaBox1.KeyValue)='' then
    GetDetallesQuery.Fieldbyname('ID_SUBCATE').AsString:=''
     else
    GetDetallesQuery.Fieldbyname('ID_SUBCATE').AsString:=SubFamiliaBox1.KeyValue;
    GetDetallesQuery.Fieldbyname('SUBCATEGORIA').AsString:=SubFamiliaBox1.Text;
     }
  //  GetDetallesQuery.Fieldbyname('ISPASSED').AsString:='Y';


    GetDetallesQuery.Post;
 //    SHOWMESSAGE('更新购买资料');
    // Bookmark := GetDetallesQuery.GetBookmark;
   // GetDetallesQuery.Refresh;
    // GetDetallesQuery.GotoBookmark(Bookmark);

     IsNewProduct:=FALSE;
      Reader.Clear;
     DoClear;
  GetSumTotal;
 // Salido:=False;
   Reader.SetFocus;
end;

procedure TFormCheck.ChequeEditExit(Sender: TObject);
begin

  if ChequeEdit.Text = '' then ChequeEdit.SetFocus ;
end;

procedure TFormCheck.BenificioChange(Sender: TObject);
begin
  PVPRecomedable.Value:=PrecioCompra.Value / (1-Benificio.Value/100);
end;

procedure TFormCheck.BitBtn20Click(Sender: TObject);
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

procedure TFormCheck.BitBtn21Click(Sender: TObject);
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



procedure TFormCheck.ChequeEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.ComboBox2CloseUp(Sender: TObject);
var
  index:integer;
begin
  GetDetallesQuery.FilterOptions:=[foCaseInsensitive];
  GetDetallesQuery.Filtered:=False;

  index:=ComboBox2.ItemIndex;
  case index of
  0: GetDetallesQuery.Filter:='';

  1: GetDetallesQuery.Filter:='(ISPASSED=''Y'' '
    +'AND CONTADO >= UNIDAD )';
  2: GetDetallesQuery.Filter:=' CONTADO < UNIDAD '
    ;
  3: GetDetallesQuery.Filter:='(UNIDAD < 0)'
    ;
  4: GetDetallesQuery.Filter:=' CONTADO <> UNIDAD '
  ;

  end;
  {
  if ComboBox2.Text=nMSN50 then
  begin
   GetDetallesQuery.Filter:='(ISPASSED=''Y'' '
    +'AND CONTADO >= UNIDAD )';

 end
 else
 begin
 if ComboBox2.Text=nMSN51 then
    begin

     GetDetallesQuery.Filter:=' CONTADO < UNIDAD ';
    end
    else
  begin
   if ComboBox2.Text=nMSN52 then
    begin
    GetDetallesQuery.Filter:='(UNIDAD < 0)';

    end
    else
   begin
    GetDetallesQuery.Filter:='';
   end;
  end;
 end;   }
 GetDetallesQuery.Filtered:=true;
end;

procedure TFormCheck.ComboBox2Enter(Sender: TObject);
begin
  GetDetallesQuery.Filter:='';
end;

procedure TFormCheck.DBGrid1DblClick(Sender: TObject);
begin
  if ComboBox1.ItemIndex=1 then
    begin
    reader.Text:=GetDetallesQuery.FieldByName('SUCODIGO').AsString;
    end
  else begin
  reader.Text:=GetDetallesQuery.FieldByName('CDBARRA').AsString;
  end;
  reader.SetFocus;
  exit;
end;

procedure TFormCheck.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

end;

procedure TFormCheck.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
begin

 if GetDetallesQuery.FieldByName('UNIDAD').AsFloat = GetDetallesQuery.FieldByName('CONTADO').AsFloat then
  DBGrid1.Canvas.Brush.Color:=clGreen
  else if GetDetallesQuery.FieldByName('UNIDAD').AsFloat < GetDetallesQuery.FieldByName('CONTADO').AsFloat then
   DBGrid1.Canvas.Brush.Color:=clRed;


end;

procedure TFormCheck.Edit1Exit(Sender: TObject);
begin
  if trim(reader.Text)='' then exit;
  if trim(Edit1.Text)='' then exit;
  if length(trim(Edit1.Text)) > 13 then
   begin
   showmessage(nMSG7);
   Edit1.SetFocus;
   exit;
   end;

  with dbArti do
        begin
        Connection:=DataModule2.ZCon1;
        Active:=false;
        SQL.Clear;
        SQL.Text:='SELECT * FROM '+UseDBC.EmID+'PRODUCTLIST WHERE 1=1 '   //'+UseDBC.EmID+'IMPUESTO.ID='+UseDBC.EmID+'PRODUCTO.IMPUESTO_ID '
        +'AND PRO_CDBARRA=''' + Trim(Edit1.Text)+''' limit 1';
        open;
        end;

        if dbArti.RecordCount>0 then
        begin
        IsNewProduct:=False;
        Edit1.Text:=dbArti.fieldbyname('PRO_CDBARRA').asstring;
        Edit2.Text:=dbArti.fieldbyname('PRO_REFERENCIA').asstring;
        Edit3.Text:=dbArti.fieldbyname('PRO_LANG1').asstring;
        Lang2.Text:=dbArti.fieldbyname('PRO_LANG2').asstring;
        FamiliaBox1.KeyValue:=dbArti.FieldByName('ID_CATEGORY').AsString;
        {
        if not (dbArti.FieldByName('ID_CATE').AsString='') then
        begin
        FamiliaBox1.KeyValue:=dbArti.FieldByName('ID_CATE').AsString;
        FamiliaBox1.OnCloseUp(Self);
        end;
        if not (dbArti.FieldByName('ID_SUBCATE').AsString='') then
        begin
        SubfamiliaBox1.KeyValue:=dbArti.FieldByName('ID_SUBCATE').AsString;
        end; }

        if not (dbArti.FieldByName('ID_IMPUESTO').AsString='') then
        begin
        IvaDBLookupComboBox1.KeyValue:=dbArti.FieldByName('ID_IMPUESTO').AsString;
        end;
        if not (dbArti.FieldByName('ID_IMPUESTO').AsString='') then
        begin
        ReqDBLookupComboBox1.KeyValue:=dbArti.FieldByName('ID_IMPUESTO').AsString;
        end;

        Medida.Text:=dbArti.FieldByName('MEDIDA').AsString;
        Unidades.Text:=dbArti.FieldByName('UNIDAD').AsString;
        PrecioAnterio.Value:= dbArti.fieldbyname('PRECIO_COMPRAS_CON').AsCurrency;
        PVPEdit.Value:=dbArti.fieldbyname('PVP1C').AsCurrency;
        Edit1.Color:=clDefault;
        end
        else
        begin
        IsNewProduct:=True;
       // edit1.Text:=GetDetallesQuery.Fieldbyname('CDBARRA').asstring;
        edit2.Text:=RightStr(Trim(Edit1.Text), 6);
        edit3.Text:=GetDetallesQuery.Fieldbyname('DESCRIPCION').asstring;
        //lang2.Text:=GetDetallesQuery.Fieldbyname('DESCRIPCION').asstring;
        Edit1.Color:=clYellow;
        end;

        if IsNewProDuct then Edit2.SetFocus else ChequeEdit.SetFocus;
end;

procedure TFormCheck.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.Edit3Exit(Sender: TObject);
begin
  if trim(lang2.Text) ='' then lang2.Text:= Edit3.Text;
end;

procedure TFormCheck.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.FamiliaBox1CloseUp(Sender: TObject);
var
Subcontronl:string;
begin
{
Subcontronl:='SUB'+vartostr(FamiliaBox1.KeyValue);
 with SubCateQuery do
 begin
      Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT * FROM '+EmID+'CATEGORIASLIST WHERE 1=1 AND CONTRONL='''+Subcontronl+'''';
     Open;
 end;
}

end;

procedure TFormCheck.FamiliaBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormCheck.FamiliaBox1Select(Sender: TObject);
var
   DataSet : TDataSet;
   CurrentValue,OldValue : Variant;
  OldListValue : String;
begin

  DataSet := FamiliaBox1.Listsource.DataSet;
  CurrentValue := FamiliaBox1.KeyValue;
  DataSet.DisableControls;
   DataSet.Locate(FamiliaBox1.KeyField,CurrentValue,[]);
end;

procedure TFormCheck.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_F5)  then begin key:=0; BitBtn5Click(self); Exit; End;    //buscar
   if (key=VK_F8)  then begin key:=0; ReempezarClick(self); Exit; End;
   if (key=VK_F4)  then begin key:=0; BitBtn20Click(self); Exit; End;
   if (key=VK_F7)  then begin key:=0; BitBtn21Click(self); Exit; End;
end;

procedure TFormCheck.IvaDBLookupComboBox1Change(Sender: TObject);
begin
  ReqDBLookupComboBox1.KeyValue:=IvaDBLookupComboBox1.KeyValue;
end;

procedure TFormCheck.IvaDBLookupComboBox1ChangeBounds(Sender: TObject);
begin

end;

procedure TFormCheck.IvaDBLookupComboBox1Click(Sender: TObject);
begin


end;

procedure TFormCheck.IvaDBLookupComboBox1CloseUp(Sender: TObject);
begin
  ReqDBLookupComboBox1.KeyValue:=IvaDBLookupComboBox1.KeyValue;
end;

procedure TFormCheck.IvaDBLookupComboBox1Select(Sender: TObject);
begin
   ReqDBLookupComboBox1.KeyValue:=IvaDBLookupComboBox1.KeyValue;
end;

procedure TFormCheck.ReaderEnter(Sender: TObject);
begin
  doclear;
end;

procedure TFormCheck.ReempezarClick(Sender: TObject);
begin
  Reader.Clear;
  doClear;
  Reader.SetFocus;
end;

procedure TFormCheck.SubfamiliaBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;



function TFormCheck.IniciaDB(Forma_Read:string; dbItems: Array of string): boolean;
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

   ShowFormCheckDb;
   result:=True;
end;

end.

