unit GoodsFromProv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBCtrls, DBGrids, Global, connect, db, ZDataset, Grids;

type

  { TFormProGoods }

  TFormProGoods = class(TForm)
    Button1: TButton;
    Button5: TButton;
    DataSource1: TDataSource;
    ListQuery: TZQuery;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    Label11: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBLookupComboBox1Select(Sender: TObject);
    Procedure GetList(ID_PROVEEDOR: string);
  private

  public

  end;

var
  FormProGoods: TFormProGoods;

implementation
uses
  Proveedor;

{$R *.lfm}

{ TFormProGoods }
procedure TFormProGoods.GetList(ID_PROVEEDOR: string);
begin
  with ListQuery do
  begin
  Connection:=DataModule2.ZCon1; ;
  Active:=false;
  SQL.Clear;
     SQL.TEXT:='SELECT T1.GOODS_ID, T1.ENA, T2.GOODS_NAME, T3.IVA , T1.COST, T1.DISCOUNT, T4.CATEGORY, T1.ID_PROVEEDOR, T1.LAST_TIME FROM GOODS_OFPROVEEDOR AS T1 '
     +'LEFT JOIN GOODS_SPU AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
     +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID '
     +'LEFT JOIN CATEGORYS AS T4 ON T2.CATEGORY_ID = T4.ID '
     +' WHERE 1=1 AND ID_PROVEEDOR=:ID_PROVEEDOR ';
     ParamByName('ID_PROVEEDOR').AsString:=ID_PROVEEDOR;
     Open;
  end;
end;

procedure TFormProGoods.Button5Click(Sender: TObject);
  var
  result: integer;
  Sqltable:string;
begin

 Sqltable:= EMID+'PROVEEDORLIST';
  Result:=FormProveedor.IniciaMExcute(Sqltable);
  if (Result >0 ) then DataModule2.ProvQuery.Refresh;
end;

procedure TFormProGoods.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
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

procedure TFormProGoods.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFormProGoods.DBLookupComboBox1Select(Sender: TObject);
var
 ID:STRING;
begin
ID:='';
ID:=DBLookupComboBox1.KeyValue;
  GetList(ID);
end;

end.

