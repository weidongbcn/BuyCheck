unit goodslist;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, connect,
  LCLType,Variants, Global,
  DefaultTranslator, LResources,
  StdCtrls, Buttons, DbCtrls, DBGrids, ZDataset, Grids;

type

  { TFormGoodsList }

  TFormGoodsList = class(TForm)
    BtAplicar: TBitBtn;
    BtCancelar: TBitBtn;
    BtCerrar: TBitBtn;
    CBCampos: TComboBox;
    Datasource1: TDataSource;
    dbBusquedas: TZQuery;
    DBGrid1: TDBGrid;
    DBImage1: TDBImage;
    EdTexto: TEdit;
    GBCampo: TGroupBox;
    GBTexto: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel27: TPanel;
    Panel3: TPanel;
    procedure BtAplicarClick(Sender: TObject);
    procedure BtCancelarClick(Sender: TObject);
    procedure BtCerrarClick(Sender: TObject);
    procedure CBCamposChange(Sender: TObject);
    procedure dbBusquedasAfterOpen(DataSet: TDataSet);
    procedure dbBusquedasAfterScroll(DataSet: TDataSet);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure EdTextoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public
    function IniciaBusquedas(TxtBusqueda: string): TStringArray;


  end;

  procedure ShowFormGoodsList;

var
  FormGoodsList: TFormGoodsList;
  Resultado: variant;
  SETFIELD: ARRAY OF STRING;
  SqlCMD: string; Orden: String;
  aFindStr: string;
  ref:string;



implementation

{$R *.lfm}

procedure ShowFormGoodsList;
begin
  with TFormGoodsList.Create(Application) do
    begin
      ShowModal;
    end;
end;

{ TFormGoodsList }

function TFormGoodsList.IniciaBusquedas(TxtBusqueda: string): TStringArray;
begin
  Resultado:='';
  SetLength(result, 2);
  result[0] := '';
  result[1] := '';
  aFindStr:=TxtBusqueda;
  if aFindStr<>'' then
  REF:=' AND (T1.ENA LIKE ''%' + aFindStr+'%'' '
         +'OR T1.CODE LIKE ''%' + aFindStr+'%'' '
         +'OR T1.GOODS_NAME LIKE ''%' + aFindStr+'%'' '
         +'OR T1.GOODS_NAME2 LIKE ''%' + aFindStr+'%'' '
         +'OR T3.BRAND_NAME LIKE ''%' + aFindStr+'%'') ' else ref:='';

 { SqlCMD:='select A.PRO_REFERENCIA, A.PRO_LANG1, A.PRO_CDBARRA, A.ID_CATE, A.CATEGORIA, A.ID_SUBCATE, A.SUBCATEGORIA, A.MARCA_NOMBRE, A.PRECIO_COMPRAS_CON, A.PVP1C, A.STOCK_ACTUAL, A.IMAGES_DATA, '
              +'B.ID_PROVEEDOR,  C.NAME_COMERCIO '
              +'from '
              +'(select A.PRO_REFERENCIA, A.PRO_LANG1, A.PRO_CDBARRA, A.ID_CATE, A.CATEGORIA, A.ID_SUBCATE, A.SUBCATEGORIA, A.MARCA_NOMBRE, A.PRECIO_COMPRAS_CON, A.PVP1C, A.STOCK_ACTUAL, A.IMAGES_DATA '
              +'from '+EmID+'productlist as a where 1=1 '+ref   //+marca+categoria
              +' ) as A  '
              +'left join  (select * from (select PRO_CDBARRA,ID_PROVEEDOR, PRECIO_CON, fecha  from '+EmID+'goodsofproveedor where 1=1 '
              //+  proveedor
              +' order by PRO_CDBARRA, ABS(FECHA - now()) ASC)  '
              +'as t1  group by PRO_CDBARRA) as B on A.pro_cdbarra= B.pro_cdbarra  left join '+EmID+'PROVEEDORLIST as C on B.ID_PROVEEDOR= C.ID_PROVEEDOR  '
              +' order by LENGTH(A.PRO_CDBARRA) ';   }

  //SqlCMD := 'SELECT T1.*, T2.NAME as NAME FROM '+EmID+'PRODUCTLIST AS T1 left join '+EmID+'CATEGORYS AS T2 on t1.id_category=t2.id where 1=1 ' +ref;
  SQLcmd := 'select T1.GOODS_ID, T1.ENA, T1.CODE, T1.GOODS_NAME, T1.GOODS_NAME2, T1.UNIT,  T2.CATEGORY, T3.BRAND_NAME, T4.IVA, T5.COST, T5.pvp1c, t1.weigth, t1.volume  from GOODS_SPU as T1 '
         +'LEFT JOIN categorys AS T2 ON T2.ID = T1.CATEGORY_ID '
         +'LEFT JOIN goods_brands AS T3 ON T3.BRAND_ID = T1.BRAND_ID  '
         +'LEFT JOIN goods_taxrate AS T4 ON T4.ID = T1.taxrate_id '
         +'LEFT JOIN goods_spu_price AS T5 ON T1.GOODS_ID = T5.GOODS_ID '
         +'WHERE 1=1 ' +ref;

   ShowFormGoodsList;
  // SetLength(result, 2);
  result[0] := Resultado[0];
  result[1] := Resultado[1];
  //result:= Resultado[0];
end;

procedure TFormGoodsList.FormCreate(Sender: TObject);
begin
   Resultado := VarArrayCreate([0, 1], varVariant);
   SetLength(SETFIELD, 4);

   CBCampos.Clear;
   CBCampos.Items.Add('条形码');
   CBCampos.Items.Add('名称');
   CBCampos.Items.Add('品牌');
   CBCampos.Items.Add('类别');
   CBCampos.ItemIndex:=0;
   SETFIELD[0]:='ENA';
   SETFIELD[1]:='GOODS_NAME';
   SETFIELD[2]:='BRAND_NAME';
   SETFIELD[3]:='CATEGORY';

   ORDEN:= ' ORDER BY LENGTH(ENA) ';
   EdTexto.Text:=aFindStr;
   if aFindStr<>'' then
   begin
    dbBusquedas.SQL.Text:=SqlCMD+ORDEN;
    Datasource1.DataSet:=dbBusquedas;
    dbBusquedas.Active:= True;
   Label1.Caption:='共查询到: '+inttostr(dbBusquedas.RecordCount)+' 条记录';
 //2019-02-01 修改, 启动不运行为好
   end;

  //dbBusquedas.Locate('PRO_REFERENCIA; PRO_LANG1; PRO_LANG2; PRO_CDBARRA; MARCA_NOMBRE ',
  //    VarArrayOf([aFindstr, aFindstr, aFindstr, aFindstr, aFindstr]), [loPartialkey, loCaseInsensitive]  );

end;

procedure TFormGoodsList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_F8) then begin key:=0; btAplicarClick(self); Exit; End;
 if (key=VK_RETURN) then begin key:=0; btCerrarClick(Self); end;
 if (key=VK_ESCAPE) then begin key:=0; btCancelarClick(Self); end;
 if (key=VK_F11) and (DBGrid1.Focused) then begin key:=0; EdTexto.SetFocus; Exit; End;
 if (key=VK_F11) and (EdTexto.Focused) then begin key:=0; DBGrid1.SetFocus; Exit; End;
 if (key=VK_F10)  then begin key:=0; CBCampos.SetFocus; Exit; End;
 //if (key=VK_F11)  then begin key:=0; GridBusquedas.SetFocus; Exit; End;
end;

procedure TFormGoodsList.BtCerrarClick(Sender: TObject);
begin
  if (EdTexto.Focused) then
  begin
     if (EdTexto.Text='' ) then DBGrid1.SetFocus ELSE btAplicarClick(self); Exit;
  end;
  if (btAplicar.Focused) then
  begin
     if (EdTexto.Text='' ) then EdTexto.SetFocus ELSE btAplicarClick(self); Exit;
  end;
  if (CBCampos.Focused) then
  begin
      Exit;
  end;

  Resultado[0]:= dbBusquedas.FieldByName('ENA').AsString;
  Resultado[1]:='1';

  if (Resultado[0] = null) then begin Resultado[0]:='-1'; Resultado[1]:='-1'; end;
  Close();
end;

procedure TFormGoodsList.CBCamposChange(Sender: TObject);
begin
  ORDEN:=' ORDER BY '+SETFIELD[CBCampos.ItemIndex];
end;

procedure TFormGoodsList.dbBusquedasAfterOpen(DataSet: TDataSet);
begin
//   TDatetimeField(dbBusquedas.fieldByName('FECHA')).DisplayFormat:='yyyy-mm-dd';
TFloatField(dbBusquedas.fieldByName('COST')).DisplayFormat := '0.000';
TFloatField(dbBusquedas.fieldByName('PVP1C')).DisplayFormat := '0.000';

end;

procedure TFormGoodsList.dbBusquedasAfterScroll(DataSet: TDataSet);
var
cPicStream: TMemoryStream; {to save to the blob}
cJpegImage: TJpegImage;
begin
//cPicStream := TMemoryStream.Create();
{DBImage1.Picture.Graphic :=nil;
if not dbBusquedas.FieldByName('IMAGES_DATA').IsNull then
      begin
        TblobField(dbBusquedas.FieldByName('IMAGES_DATA')).SaveToStream(cPicStream);
        cPicStream.Position:=0;
       if SizeOf(cPicStream)<> 0 then
       begin

       cJpegImage := TJpegImage.Create;
       cJpegImage.LoadFromStream(cPicStream);
       DBImage1.Picture.Graphic := cJPegImage;
       cJpegImage.Free;
        //TJPEGImage(DBImage1.Picture.Graphic).LoadFromStream(PicStream);
       end;
      end;
       cPicStream.Free;
        cPicStream:=nil;
   }

end;

procedure TFormGoodsList.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then begin key:=0; btCerrarClick(Self); end;
  IF (KEY=VK_UP) and (dbBusquedas.BOF) THEN
            EdTexto.SetFocus;
end;

procedure TFormGoodsList.DBGrid1PrepareCanvas(sender: TObject;
  DataCol: Integer; Column: TColumn; AState: TGridDrawState);
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
    DBGrid1.Canvas.Brush.color := clForm; //当前行以黑色显示
    DBGrid1.Canvas.pen.mode := pmmask;
  end;
   {

   if ([gdSelected, gdFocused] * AState <> []) and (DBGrid1.SelectedColumn = Column) then
  begin
    DBGrid1.Canvas.Brush.Color := clRed;
    DBGrid1.Canvas.Font.Color := clWhite;
  end;    }
end;
end;

procedure TFormGoodsList.EdTextoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF KEY = VK_DOWN THEN
  DBGrid1.SetFocus;
  IF KEY = VK_RETURN THEN
  btAplicarClick(Self);
end;

procedure TFormGoodsList.BtCancelarClick(Sender: TObject);
begin
  Resultado[0]:='-1';
  Resultado[1]:='-1';
   Close();
end;

procedure TFormGoodsList.BtAplicarClick(Sender: TObject);
begin
  aFindStr:=EdTexto.Text;
  if aFindStr<>'' then
   REF:=' AND (T1.ENA LIKE ''%' + aFindStr+'%'' '
         +'OR T1.CODE LIKE ''%' + aFindStr+'%'' '
         +'OR T1.GOODS_NAME LIKE ''%' + aFindStr+'%'' '
         +'OR T1.GOODS_NAME2 LIKE ''%' + aFindStr+'%'' '
         +'OR T3.BRAND_NAME LIKE ''%' + aFindStr+'%'') ' else ref:='';
  {SqlCMD:='select A.PRO_REFERENCIA, A.PRO_LANG1, A.PRO_CDBARRA, A.ID_CATE, A.CATEGORIA, A.ID_SUBCATE, A.SUBCATEGORIA, A.MARCA_NOMBRE, A.PRECIO_COMPRAS_CON, A.PVP1C, A.STOCK_ACTUAL, A.IMAGES_DATA, '
              +'B.ID_PROVEEDOR,  C.NAME_COMERCIO '
              +'from '
              +'(select A.PRO_REFERENCIA, A.PRO_LANG1, A.PRO_CDBARRA, A.ID_CATE, A.CATEGORIA, A.ID_SUBCATE, A.SUBCATEGORIA, A.MARCA_NOMBRE, A.PRECIO_COMPRAS_CON, A.PVP1C, A.STOCK_ACTUAL, A.IMAGES_DATA '
              +'from '+EmID+'productlist as a where 1=1 '+ref   //+marca+categoria
              +' ) as A  '
              +'left join  (select * from (select PRO_CDBARRA,ID_PROVEEDOR, PRECIO_CON, fecha  from '+EmID+'goodsofproveedor where 1=1 '
              //+  proveedor
              +' order by PRO_CDBARRA, ABS(FECHA - now()) ASC)  '
              +'as t1  group by PRO_CDBARRA) as B on A.pro_cdbarra= B.pro_cdbarra  left join '+EmID+'PROVEEDORLIST as C on B.ID_PROVEEDOR= C.ID_PROVEEDOR  '
              +' order by LENGTH(A.PRO_CDBARRA) ';    }

  //SqlCMD := 'SELECT * FROM '+EmID+'PRODUCTLIST WHERE 1=1 '+ref;
 // SqlCMD := 'SELECT T1.*, T2.NAME as NAME FROM '+EmID+'PRODUCTLIST AS T1 left join '+EmID+'CATEGORYS AS T2 on t1.id_category=t2.id where 1=1 ' +ref;
  SQLcmd := 'select T1.GOODS_ID, T1.ENA, T1.CODE, T1.GOODS_NAME, T1.GOODS_NAME2, T1.UNIT,  T2.CATEGORY, T3.BRAND_NAME, T4.IVA, T5.COST, T5.pvp1c, t1.weigth, t1.volume  from GOODS_SPU as T1 '
         +'LEFT JOIN categorys AS T2 ON T2.ID = T1.CATEGORY_ID '
         +'LEFT JOIN goods_brands AS T3 ON T3.BRAND_ID = T1.BRAND_ID  '
         +'LEFT JOIN goods_taxrate AS T4 ON T4.ID = T1.taxrate_id '
         +'LEFT JOIN goods_spu_price AS T5 ON T1.GOODS_ID = T5.GOODS_ID '
         +'WHERE 1=1 ' +ref;

  dbBusquedas.Active:= False;
  dbBusquedas.SQL.Text:=SqlCMD + ORDEN;
  dbBusquedas.Active:= True;
  Label1.Caption:='共查询到: '+inttostr(dbBusquedas.RecordCount)+' 条记录';

 // dbBusquedas.Locate('PRO_REFERENCIA; PRO_LANG1; PRO_LANG2; PRO_CDBARRA; MARCA_NOMBRE ',
 //           VarArrayOf([aFindstr, aFindstr, aFindstr, aFindstr, aFindstr]), [loPartialkey, loCaseInsensitive]  );
end;



end.

