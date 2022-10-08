unit His_buy_detalles;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids, LCLType,
  StdCtrls, ZDataset,Global, connect, Grids;

type

  { TFormBuyDetalles }

  TFormBuyDetalles = class(TForm)
    Button1: TButton;
    BuyDetalles: TZQuery;
    BuyDetallesDS: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GetList();
  private

  public
     Procedure GetBuyDetalles(Id_Buy:string; Serie:string);
  end;
  procedure ShowFormBuyDetalles;

var
  FormBuyDetalles: TFormBuyDetalles;
  PayId_Buy,PaySerie:string;

implementation

{$R *.lfm}
procedure ShowFormBuyDetalles;
begin
  with TFormBuyDetalles.Create(Application) do
    begin
      ShowModal;
    end;
end;

procedure TFormBuyDetalles.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFormBuyDetalles.DBGrid1PrepareCanvas(sender: TObject;
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

procedure TFormBuyDetalles.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If key=VK_ESCAPE then close;
end;

procedure TFormBuyDetalles.FormShow(Sender: TObject);
begin
  GetList();
end;

Procedure TFormBuyDetalles.GetBuyDetalles(Id_Buy:string; Serie:string);
begin
  PayId_Buy:=Id_Buy;
  PaySerie:=Serie;
  ShowFormBuyDetalles;
end;

procedure TFormBuyDetalles.GetList();
begin
  with BuyDetalles do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    SQL.TEXT:='SELECT T1.B_UUID, T1.GOODS_ID, T1.SKU_NO, T2.ENA, T2.GOODS_NAME, T1.QUANTITY, T1.COMMODITY_UNIT, T1.COST, T1.DISCOUNT, T3.IVA, '
            +'T1.QUANTITY*T1.COST*(1-T1.DISCOUNT/100) AS LINEATOTAL, T4.SELLING_P1C, T1.BUY_DATE  '
            +'FROM BUY_ITEMS as T1 '
            +'LEFT JOIN goods_spu AS T2 ON T1.GOODS_ID = T2.GOODS_ID  '
            +'LEFT JOIN goods_taxrate AS T3 ON T2.taxrate_id = T3.ID '
            +'LEFT JOIN goods_sku AS T4 ON T4.SKU_NO = T1.SKU_NO '
     +'WHERE 1=1 '
     +'AND T1.B_UUID=:B_UUID ';
     ParamByName('B_UUID').AsString:=PayId_Buy;
    open;

    end;
end;

end.

