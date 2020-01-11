unit Select_SKU;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, ExtCtrls,
  StdCtrls, ZDataset,LCLType, connect, db, Global;

type

  { TFormSelectSKU }

  TFormSelectSKU = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    dbTrabajo: TZQuery;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormCreate(Sender: TObject);
    procedure GetSkuList(CDBarra: string);
  private

  public
     function IniciaSelection(CDBarra: string) : String;
  end;

  procedure ShowFormSelectSKU;

var
  FormSelectSKU: TFormSelectSKU;
  ENA: string;
  SKU_NO:string;

implementation


procedure ShowFormSelectSKU;
begin
  with TFormSelectSKU.Create(Application) do
    begin
      ShowModal;
    end;
end;

{$R *.lfm}

procedure TFormSelectSKU.GetSkuList(CDBarra: string);
begin
  with dbTrabajo do
      begin
      Connection:=DataModule2.ZCon1;
      Active:=false;
      SQL.Clear;
      Sql.Text:='select T1.SKU_NO, concat(T2.GOODS_NAME, T1.SKU_NAME) as Item_NAME, t2.ENA , T2.CODE, '
      +'T1.COST, T1.SELLING_P1C, T1.SELLING_P2C, T1.SELLING_P3C, T1.LOWPRICE, T1.WHOLESALE, T1.STOCK, T1.GOODS_ID, T1.SKU_CODING, T1.ISCHILD, '
      +'t2.category_id, T2.brand_id, T2.taxrate_id, T2.PARENT_ID, T2.CLASS_ID, T3.IVA, T3.REQ '
      +'from goods_sku as t1 left join goods_spu as t2 on T1.GOODS_ID = T2.GOODS_ID '
      +'LEFT JOIN GOODS_TAXRATE AS T3 ON T2.TAXRATE_ID = T3.ID '
      +'where 1=1 '
      +'and t2.ENA =:ENA ';
      ParamByName('ENA').AsString:=CDBarra;
      end
END;

procedure TFormSelectSKU.FormCreate(Sender: TObject);
begin
   GetSkuList(ENA);

end;

procedure TFormSelectSKU.Button2Click(Sender: TObject);
begin
  if dbTrabajo.RecordCount = 0 then
  SKU_NO:=''
  else
  SKU_NO:=dbTrabajo.FieldByName('SKU_NO').AsString;
  close;
end;

procedure TFormSelectSKU.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFormSelectSKU.DBGrid1DblClick(Sender: TObject);
begin
  Button2Click(self);
end;

procedure TFormSelectSKU.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then Button2Click(self);
end;


function TFormSelectSKU.IniciaSelection(CDBarra: string):String;
begin
  ENA:=CDBarra;
  SKU_NO:='';
  ShowFormSelectSKU;
  Result:=SKU_NO;
end;


end.

