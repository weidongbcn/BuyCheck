unit StockActual;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  DBGrids, StdCtrls, Global, connect, ZDataset, Grids, rxcurredit;

type

  { TFormStock }

  TFormStock = class(TForm)
    AllGoodsDS: TDataSource;
    Button1: TButton;
    Button3: TButton;
    CategDataSource: TDataSource;
    CategQuery: TZQuery;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    Edit1: TEdit;
    FmDBLookupComboBox1: TDBLookupComboBox;
    Importe: TCurrencyEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Panel2: TPanel;
    CapitanQuery: TZQuery;
    StockNameDS: TDataSource;
    StockNameQuery: TZQuery;
    Panel1: TPanel;
    StockAllGoodsQuery: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBLookupComboBox1Select(Sender: TObject);
    procedure FmDBLookupComboBox1Select(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GetStockList;
    procedure GetStockAllGoods;
    procedure DoGetCATEGORIAS;
    procedure StockAllGoodsQueryAfterOpen(DataSet: TDataSet);
  private

  public

  end;

var
  FormStock: TFormStock;

implementation

{$R *.lfm}

{ TFormStock }
procedure TFormStock.GetStockList;
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
procedure TFormStock.GetStockAllGoods;
begin
 with StockAllGoodsQuery do
  begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     sql.Text:='select T1.ID_STOCK, T1.GOODS_ID, T1.SKU_NO, T2.ENA, T2.CODE, T2.GOODS_NAME, concat(T2.GOODS_NAME, T5.SKU_NAME ) AS CONCEPT, T1.AMOUNT, T5.COST, T4.BRAND_NAME,  T3.CATEGORY, T1.GOODS_STATUS from stockgoods as T1 '
     +'left join goods_spu as t2 on T1.GOODS_ID = t2.GOODS_ID  '
     +'left join categorys as t3 on t2.category_id = t3.ID '
     +'left join goods_brands as t4 on t4.BRAND_ID = t2.brand_id '
     +'left join goods_sku as t5 on T1.SKU_NO = t5.SKU_NO '
     +'WHERE 1=1 '
     +'AND ID_STOCK like ''%'+DBLookupComboBox1.Text+'%'' ';
    { SQL.Text:='select T1.ID_STOCK, T1.GOODS_ID, T1.SKU_NO, T3.ENA, T3.CODE, concat(T3.GOODS_NAME, T2.SKU_NAME ) AS CONCEPT, T1.AMOUNT, T2.COST, T5.BRAND_NAME,  T4.CATEGORY, T1.GOODS_STATUS from STOCKGOODS AS T1  '
     +'LEFT JOIN goods_sku AS T2 ON T2.SKU_NO = T2.SKU_NO '
     +'LEFT JOIN goods_spu AS T3 ON T3.GOODS_ID = T2.GOODS_ID '
     +'LEFT JOIN categorys AS T4 ON T3.category_id = T4.ID '
     +'LEFT JOIN goods_brands AS T5 ON T3.brand_id = T5.BRAND_ID '
     +'WHERE 1=1 '
     +'AND ID_STOCK like ''%'+DBLookupComboBox1.Text+'%'' ';
    // memo1.Lines.Add(SQL.Text);    }
     Open;
  end;

 with CapitanQuery do
  begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     sql.Text:='SELECT SUM(CASE WHEN T1.AMOUNT >0  THEN T1.AMOUNT * T5.COST ELSE 0 END) AS CAPITAN FROM STOCKGOODS AS T1 '
	 +'LEFT JOIN GOODS_SKU AS T5 ON T1.SKU_NO = T5.SKU_NO '
     +'WHERE 1=1 and T1.GOODS_STATUS = 1 '
     +'AND ID_STOCK like ''%'+DBLookupComboBox1.Text+'%'' ';
     open;
  end;

  Importe.Value:=CapitanQuery.FieldByName('CAPITAN').AsCurrency;
  Label4.Caption:='共有: '+inttostr(StockAllGoodsQuery.RecordCount)+' 条记录';


end;

procedure  TFormStock.DoGetCATEGORIAS;
var
i:integer;
  begin
  with CategQuery do
  begin
  Connection:=DataModule2.ZCon1;
  Active:=false;
  SQL.Clear;
    sql.Text:=' SELECT id, CATEGORY, parent_id FROM categorys; ' ;
   // +'Union all  Select NULL, ''none selected'', Null, '' ''';
     Open;
     first;
     ComboBox1.Clear;
     ComboBox1.Items.Add(nOpera2);
     for I := 0 to  RecordCount-1 do
     begin
     ComboBox1.Items.Add(FieldByName('category').AsString);
     next;
     end;
     ComboBox1.ItemIndex:=0;
     first;
  end;
  end;

procedure TFormStock.StockAllGoodsQueryAfterOpen(DataSet: TDataSet);
begin
  //TFloatfield(StockAllGoodsQuery.FieldByName('AMOUNT')).Displayformat := '####0';
// if Field.Name = 'PVP' then
  //   TFloatField(StockAllGoodsQuery.FieldByName('AMOUNT')).DisplayFormat := '0.00';
end;

procedure TFormStock.FormCreate(Sender: TObject);
begin
  DoGetCATEGORIAS;
  GetStockList;

end;

procedure TFormStock.FormShow(Sender: TObject);
begin
  GetStockAllGoods;
end;

procedure TFormStock.FmDBLookupComboBox1Select(Sender: TObject);
var
  ConditionSQL: string;
  key:string;
begin
 key:= FmDBLookupComboBox1.KeyValue;

  {ConditionSQL:='SELECT T1.ID_STOCK, T2.PRO_REFERENCIA, T1.PRO_CDBARRA,  T2.PRO_LANG1, T1.CANTIDAD, T2.PRECIO_COMPRAS_CON, T3.NAME AS CATEGORY  '
     +'FROM '+USEDBC.EMID+'STOCKGOODS AS T1 LEFT JOIN '+USEDBC.EMID+'PRODUCTLIST AS T2 '
     +'ON T1.PRO_CDBARRA=T2.PRO_CDBARRA LEFT JOIN '+USEDBC.EMID+'CATEGORYS AS T3 ON T2.ID_CATEGORY= T3.ID  '
     +'INNER JOIN (SELECT * FROM '+USEDBC.EMID+'CATEGORYS WHERE PARENT_ID='+key+'  '
     +'UNION SELECT * FROM '+USEDBC.EMID+'CATEGORYS WHERE PARENT_ID IN (SELECT ID FROM '+USEDBC.EMID+'CATEGORYS WHERE PARENT_ID = '+key+') '
     +'UNION SELECT * FROM '+USEDBC.EMID+'CATEGORYS WHERE ID ='+key+') AS T4 ON T2.ID_CATEGORY = T4.ID '
     +'and 1=1 AND ID_STOCK like ''%'+DBLookupComboBox1.Text+'%'' ';
    }
  with StockAllGoodsQuery do
  begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='select T1.ID_STOCK, T1.GOODS_ID, T1.SKU_NO, T2.ENA, T2.CODE, T2.GOODS_NAME, concat(T2.GOODS_NAME, T5.SKU_NAME ) AS CONCEPT, T1.AMOUNT, T5.COST, T4.BRAND_NAME,  T3.CATEGORY, T1.GOODS_STATUS from stockgoods as T1 '
     +'left join goods_spu as t2 on T1.GOODS_ID = t2.GOODS_ID  '
     +'left join categorys as t3 on t2.category_id = t3.ID '
     +'left join goods_brands as t4 on t4.BRAND_ID = t2.brand_id '
     +'left join goods_sku as t5 on T1.SKU_NO = t5.SKU_NO '
    // +'INNER JOIN (SELECT * FROM CATEGORYS WHERE PARENT_ID='+key+'  '
    // +'UNION SELECT * FROM CATEGORYS WHERE PARENT_ID IN (SELECT ID FROM CATEGORYS WHERE PARENT_ID = '+key+') '
    // +'UNION SELECT * FROM CATEGORYS WHERE ID ='+key+') AS T6 ON T2.category_id = T6.ID '
     +'WHERE 1=1 '
     +'AND ID_STOCK like ''%'+DBLookupComboBox1.Text+'%'' '
     +'and t2.category_id in (SELECT c.id FROM categorys AS c INNER JOIN CATEGORYSTREE t on c.Id = t.descendant WHERE t.ancestor = :key )';
     ParamByName('key').AsString:=key;
     Open;

     //and T2.ID_CATEGORY IN (1,2)
  end;
  Label4.Caption:='共有: '+inttostr(StockAllGoodsQuery.RecordCount)+' 条记录';
end;

procedure TFormStock.ComboBox1Select(Sender: TObject);
begin
  if ComboBox1.ItemIndex=0 then
  begin
    with StockAllGoodsQuery do
  begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='select T1.ID_STOCK, T1.GOODS_ID, T1.SKU_NO, T2.ENA, T2.CODE, T2.GOODS_NAME, concat(T2.GOODS_NAME, T5.SKU_NAME ) AS CONCEPT, T1.AMOUNT, T5.COST, T4.BRAND_NAME,  T3.CATEGORY, T1.GOODS_STATUS from stockgoods as T1 '
     +'left join goods_spu as t2 on T1.GOODS_ID = t2.GOODS_ID  '
     +'left join categorys as t3 on t2.category_id = t3.ID '
     +'left join goods_brands as t4 on t4.BRAND_ID = t2.brand_id '
     +'left join goods_sku as t5 on T1.SKU_NO = t5.SKU_NO '
     +'WHERE 1=1 '
     +'AND ID_STOCK like ''%'+DBLookupComboBox1.Text+'%'' ';

     Open;
  end;
  Label4.Caption:='共有: '+inttostr(StockAllGoodsQuery.RecordCount)+' 条记录';
  end
  else
  begin
  FmDBLookupComboBox1.ListSource.DataSet.RecNo:=ComboBox1.ItemIndex;
  FmDBLookupComboBox1.KeyValue:= FmDBLookupComboBox1.ListSource.DataSet.FieldByName(FmDBLookupComboBox1.KeyField).Value;
  FmDBLookupComboBox1.OnSelect(self);

  end;
end;

procedure TFormStock.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
    sText : String;
    aValue: double;
begin
 if (UpperCase(Column.Field.FieldName) = 'GOODS_STATUS') then
 //if ((Column.Field.FieldName) = 'GOODS_STATUS') then
  begin
  if Column.Field.Value = 1 then
        sText := '好'
      Else
        If Column.Field.Value = 0 Then
          sText := '损坏'
        Else
          sText := '';
  (Sender as TDBGrid).Canvas.FillRect(Rect);
  (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+2, sText);
  end;




end;

procedure TFormStock.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
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
  end;

  end;
end;

procedure TFormStock.Button3Click(Sender: TObject);
var
aFindStr:string;
Sqlstr: string;
key:string;
begin
  aFindStr:=Edit1.Text;
  IF aFindstr='' then exit;
 if ComboBox1.ItemIndex=0 then
    begin
    Sqlstr:='select T1.ID_STOCK, T1.GOODS_ID, T1.SKU_NO, T2.ENA, T2.CODE, T2.GOODS_NAME, concat(T2.GOODS_NAME, T5.SKU_NAME ) AS CONCEPT, T1.AMOUNT, T5.COST, T4.BRAND_NAME,  T3.CATEGORY, T1.GOODS_STATUS from stockgoods as T1 '
     +'left join goods_spu as t2 on T1.GOODS_ID = t2.GOODS_ID  '
     +'left join categorys as t3 on t2.category_id = t3.ID '
     +'left join goods_brands as t4 on t4.BRAND_ID = t2.brand_id '
     +'left join goods_sku as t5 on T1.SKU_NO = t5.SKU_NO '
     +'WHERE 1=1 '
     +'AND ID_STOCK like ''%'+DBLookupComboBox1.Text+'%'' '
     +' and (UPPER(T2.GOODS_NAME) LIKE ''%'+UPPERCASE(aFindStr)+'%'' '
     +' or UPPER(T2.GOODS_NAME2) LIKE ''%'+UPPERCASE(aFindStr)+'%'' '
     +' or UPPER(T5.SKU_NAME) LIKE ''%'+UPPERCASE(aFindStr)+'%'' '
       +'OR UPPER(T2.ENA) LIKE ''%'+UPPERCASE(aFindStr)+'%'' '
       +'OR UPPER(T2.CODE) LIKE ''%'+UPPERCASE(aFindStr)+'%'' '+' ) ';

   { select T1.ID_STOCK, T1.GOODS_ID, T1.SKU_NO, T3.ENA, T3.CODE, concat(T3.GOODS_NAME, T2.SKU_NAME ) AS CONCEPT, T1.AMOUNT, T2.COST, T5.BRAND_NAME,
T4.CATEGORY, T1.GOODS_STATUS from STOCKGOODS AS T1
LEFT JOIN goods_sku AS T2 ON T2.SKU_NO = T2.SKU_NO
LEFT JOIN goods_spu AS T3 ON T3.GOODS_ID = T2.GOODS_ID
LEFT JOIN categorys AS T4 ON T3.category_id = T4.ID
LEFT JOIN goods_brands AS T5 ON T3.brand_id = T5.BRAND_ID
WHERE 1=1 AND ID_STOCK like '%0001%'  and ( UPPER(T3.GOODS_NAME) LIKE '%CAJA%'
 or UPPER(T3.GOODS_NAME2) LIKE '%CAJA%'
 or UPPER(T2.SKU_NAME) LIKE '%CAJA%'
 OR UPPER(T3.ENA) LIKE '%CAJA%'
 OR UPPER(T3.CODE) LIKE '%CAJA%' );  }

    end
    else
    begin
     key:= FmDBLookupComboBox1.KeyValue;
     Sqlstr:='select T1.ID_STOCK, T1.GOODS_ID, T1.SKU_NO, T2.ENA, T2.CODE, T2.GOODS_NAME, concat(T2.GOODS_NAME, T5.SKU_NAME ) AS CONCEPT, T1.AMOUNT, T5.COST, T4.BRAND_NAME,  T3.CATEGORY, T1.GOODS_STATUS from stockgoods as T1 '
     +'left join goods_spu as t2 on T1.GOODS_ID = t2.GOODS_ID  '
     +'left join categorys as t3 on t2.category_id = t3.ID '
     +'left join goods_brands as t4 on t4.BRAND_ID = t2.brand_id '
     +'left join goods_sku as t5 on T1.SKU_NO = t5.SKU_NO '
     +'INNER JOIN (SELECT * FROM CATEGORYS WHERE PARENT_ID='+key+'  '
     +'UNION SELECT * FROM CATEGORYS WHERE PARENT_ID IN (SELECT ID FROM CATEGORYS WHERE PARENT_ID = '+key+') '
     +'UNION SELECT * FROM CATEGORYS WHERE ID ='+key+') AS T6 ON T3.category_id = T6.ID '
     +'WHERE 1=1 '
     +'AND ID_STOCK like ''%'+DBLookupComboBox1.Text+'%'' '
     +' and (UPPER(T2.GOODS_NAME) LIKE ''%'+UPPERCASE(aFindStr)+'%'' '
     +' or UPPER(T2.GOODS_NAME2) LIKE ''%'+UPPERCASE(aFindStr)+'%'' '
     +' or UPPER(T5.SKU_NAME) LIKE ''%'+UPPERCASE(aFindStr)+'%'' '
       +'OR UPPER(T2.ENA) LIKE ''%'+UPPERCASE(aFindStr)+'%'' '
       +'OR UPPER(T2.CODE) LIKE ''%'+UPPERCASE(aFindStr)+'%'' '+' ) ';
    end;

    with StockAllGoodsQuery do
  begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.TEXT:=Sqlstr;

     Open;
  end;
  Label4.Caption:='共有: '+inttostr(StockAllGoodsQuery.RecordCount)+' 条记录';
end;

procedure TFormStock.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFormStock.DBLookupComboBox1Select(Sender: TObject);
begin
  DBLookupComboBox2.KeyValue:=DBLookupComboBox1.KeyValue;
end;

end.

