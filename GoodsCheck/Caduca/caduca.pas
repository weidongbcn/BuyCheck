unit caduca;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids, DBGrids, ZDataset, rxcurredit, connect,Global;

type

  { TListCaducacionForm }

  TListCaducacionForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    DaysAviso: TCurrencyEdit;
    DBGrid1: TDBGrid;
    dbListado: TZQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure GetList(scene, days:integer);
  public

  end;

var
  ListCaducacionForm: TListCaducacionForm;

implementation

{$R *.lfm}

{ TListCaducacionForm }

procedure TListCaducacionForm.Button1Click(Sender: TObject);
begin
   case ComboBox1.ItemIndex of
   0:
     GetList(0,0);
   1:
     GetList(1,0);
   2:
     GetList(2, DaysAviso.AsInteger);
   end;
end;

procedure TListCaducacionForm.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TListCaducacionForm.GetList(scene, days:integer);
var
  sqlStr:string;
begin
   case scene of
   0:      //警告期商品
     begin
      sqlStr:= 'select t1.GOODS_ID, t1.GOODS_NAME, t1.GOODS_NAME2, t1.ENA, t1.CODE, t1.CLASS_ID, t1.CATEGORY_ID, t1.BRAND_ID, t1.type, t1.UNIT, t1.TAXRATE_ID, t1.weigth, t1.volume,t1.DAYS_CONSERVACION, t2.AMOUNT, t2.FECHA_CADUCA, t3.CATEGORY, t4.BRAND_NAME from goods_spu as t1 '
        +'right join goods_shelflife_stock as t2 on t1.GOODS_ID = t2.GOODS_ID '
        +'left join categorys as t3 on t1.CATEGORY_ID = t3.ID  '
        +'left join goods_brands as t4 on t1.BRAND_ID = t4.BRAND_ID '
        +'where 1=1  '
        +'and (t1.`type` = 3) and (t1.days_aviso > 0) '
        +'and (date_sub(t2.FECHA_CADUCA, interval days_aviso day) < curdate());' ;
      with dbListado do
     begin
      Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.Clear;
      SQL.Text:=sqlStr;
      open;
     end;
     end;
   1:      //过期未处理商品
     begin
        sqlStr:= 'select t1.GOODS_ID, t1.GOODS_NAME, t1.GOODS_NAME2, t1.ENA, t1.CODE, t1.CLASS_ID, t1.CATEGORY_ID, t1.BRAND_ID, t1.type, t1.UNIT, t1.TAXRATE_ID, t1.weigth, t1.volume,t1.DAYS_CONSERVACION, t2.AMOUNT, t2.FECHA_CADUCA, t3.CATEGORY, t4.BRAND_NAME from goods_spu as t1 '
        +'right join goods_shelflife_stock as t2 on t1.GOODS_ID = t2.GOODS_ID '
        +'left join categorys as t3 on t1.CATEGORY_ID = t3.ID  '
        +'left join goods_brands as t4 on t1.BRAND_ID = t4.BRAND_ID '
      +'where 1=1 '
      +'and (t1.`type` = 3) '
      +'and (t2.FECHA_CADUCA < curdate());';
      with dbListado do
     begin
      Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.Clear;
      SQL.Text:=sqlStr;
      open;
     end;
     end;
   2:   //查看几天内要过期的商品
     begin
        sqlStr:= 'select t1.GOODS_ID, t1.GOODS_NAME, t1.GOODS_NAME2, t1.ENA, t1.CODE, t1.CLASS_ID, t1.CATEGORY_ID, t1.BRAND_ID, t1.type, t1.UNIT, t1.TAXRATE_ID, t1.weigth, t1.volume,t1.DAYS_CONSERVACION, t2.AMOUNT, t2.FECHA_CADUCA, t3.CATEGORY, t4.BRAND_NAME from goods_spu as t1 '
        +'right join goods_shelflife_stock as t2 on t1.GOODS_ID = t2.GOODS_ID '
        +'left join categorys as t3 on t1.CATEGORY_ID = t3.ID  '
        +'left join goods_brands as t4 on t1.BRAND_ID = t4.BRAND_ID '
      +'where 1=1 '
      +'and (t1.`type` = 3) '
      +'and (date_sub(t2.FECHA_CADUCA, interval :DAYS day) < curdate());';
      with dbListado do
     begin
      Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.Clear;
      SQL.Text:=sqlStr;
      ParamByName('DAYS').AsInteger:=days;
      open;
     end;
     end;

   end;


end;

end.

