unit His_Goods_Buy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, ExtDlgs,
  EditBtn, StdCtrls, DBGrids, ZDataset, DateTimePicker, Global, connect;

type

  { TFormGoodsBuyHis }

  TFormGoodsBuyHis = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    ZQuery1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormGoodsBuyHis: TFormGoodsBuyHis;

implementation

{$R *.lfm}

{ TFormGoodsBuyHis }

procedure TFormGoodsBuyHis.FormCreate(Sender: TObject);
begin
 DateTimePicker1.DateTime:= IncMonth(Now(), -6);;
 DateTimePicker2.DateTime:= Now();
end;

procedure TFormGoodsBuyHis.Button1Click(Sender: TObject);
VAR
  aFindStr, ASQLStr:STRING;
begin
 AFINDSTR:=TRIM(EDIT1.Text);
  with ZQuery1 do
  begin
     Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.TEXT:='SELECT T1.B_UUID, T1.GOODS_ID, T1.SKU_NO, T2.ENA, T2.GOODS_NAME, T1.QUANTITY, T1.COMMODITY_UNIT, T1.COST, T1.DISCOUNT, T3.IVA, '
            +'T1.QUANTITY*T1.COST*(1-T1.DISCOUNT/100) AS LINEATOTAL, T4.SELLING_P1C, t5.BUYDATE, t5.ID_PROVEEDOR, t6.NAME_COMERCIO '
            +'FROM buy_items as T1 '
            +'LEFT JOIN goods_spu AS T2 ON T1.GOODS_ID = T2.GOODS_ID '
            +'LEFT JOIN goods_taxrate AS T3 ON T2.taxrate_id = T3.ID '
            +'LEFT JOIN goods_sku AS T4 ON T4.SKU_NO = T1.SKU_NO  '
            +'left join buy_history as t5 on T1.B_UUID = t5.B_UUID  '
            +'left join 0000proveedorlist as t6 on t6.ID_PROVEEDOR = t5.ID_PROVEEDOR  '
        +'WHERE 1=1 '
        +'AND ((T5.BUYDATE) BETWEEN :FECHA1 AND :FECHA2) '
       +'AND ( T2.ENA LIKE ''%' + AFINDSTR+'%'' '
                        +'OR T2.GOODS_NAME like ''%' + aFindStr+'%'') ' ;
     ParamByName('FECHA1').AsDate:=DateTimePicker1.Date;
     ParamByName('FECHA2').AsDate:=DateTimePicker2.Date;
      //  +'AND T2.PRO_LANG1 LIKE '%CAJA%' OR T2.PRO_CDBARRA LIKE '%CAJA%';';
     OPEN;
  end;
end;

procedure TFormGoodsBuyHis.Button2Click(Sender: TObject);
begin
  CLOSE;
end;

end.

