unit FindoutGoodsInPro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, LCLType,
  DBGrids, ZDataset, Global, connect, Grids;

type

  { TGoodsFromProveedor }

  TGoodsFromProveedor = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ListQuery: TZQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure findoutGoods(FindStr: string);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public

  end;

var
  GoodsFromProveedor: TGoodsFromProveedor;

implementation

{$R *.lfm}

{ TGoodsFromProveedor }
procedure TGoodsFromProveedor.findoutGoods(FindStr: string);
begin
  with ListQuery do
  begin
  Connection:=DataModule2.ZCon1; ;
  Active:=false;

  SQL.Clear;
  SQL.TEXT:='SELECT T1.GOODS_ID, T1.ENA, T2.GOODS_NAME, T3.IVA , T1.COST, T1.DISCOUNT, T4.CATEGORY, T1.ID_PROVEEDOR, T5.NAME_COMERCIO, T1.LAST_TIME FROM GOODS_OFPROVEEDOR AS T1 '
     +'LEFT JOIN GOODS_SPU AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
     +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID '
     +'LEFT JOIN CATEGORYS AS T4 ON T2.CATEGORY_ID = T4.ID '
     +'left join '+UseDBC.EmID+'PROVEEDORLIST AS T5 on T1.ID_PROVEEDOR=T5.ID_PROVEEDOR '
     +'WHERE 1=1 '
     +'and ( T1.ENA LIKE ''%' + FindStr+'%'' '
                        +'OR T2.GOODS_NAME like ''%' + FindStr+'%'' ' +'OR T2.GOODS_NAME2 like ''%' + FindStr+'%'') ' ;
     Open;
  end;
  if ListQuery.RecordCount=0 then
    begin
    Label2.Caption:='找不到进货记录';
    end
    else
    Label2.Caption:='找到 '+inttostr(ListQuery.RecordCount)+' 记录';
end;

procedure TGoodsFromProveedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then Close;
end;

procedure TGoodsFromProveedor.Button2Click(Sender: TObject);
begin
  if Trim(Edit1.Text)='' then
begin
  ShowMessage(nMSN54);
  Edit1.SetFocus;
  exit;
end;
  findoutGoods(TRIM(EDIT1.Text));
end;

procedure TGoodsFromProveedor.DBGrid1PrepareCanvas(sender: TObject;
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
    DBGrid1.Canvas.Brush.color := clBlack; //当前行以黑色显示
    DBGrid1.Canvas.pen.mode := pmmask;
  end;

  end;
end;

procedure TGoodsFromProveedor.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TGoodsFromProveedor.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

end.

