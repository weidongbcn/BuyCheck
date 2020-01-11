unit select_onesku;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, ExtCtrls, DB,
  StdCtrls, ZDataset,LCLType, connect, Global;

type

  { TFormSelectOneSKU }

  TFormSelectOneSKU = class(TForm)
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
   // procedure GetSkuList(CDBarra: string);
  private

  public
     function IniciaSelection(data: TDataSet) : String;
  end;

  procedure ShowFormSelectSKU;

var
  FormSelectOneSKU: TFormSelectOneSKU;
  ENA: string;
  SKU_NO:string;
  Trabajo:TDataset;

implementation


procedure ShowFormSelectSKU;
begin
  with TFormSelectOneSKU.Create(Application) do
    begin
      ShowModal;
    end;
end;

{$R *.lfm}
{
procedure TFormSelectOneSKU.GetSkuList(CDBarra: string);
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
}

procedure TFormSelectOneSKU.FormCreate(Sender: TObject);
begin
  // GetSkuList(ENA);
   DataSource1.DataSet:=Trabajo;
end;

procedure TFormSelectOneSKU.Button2Click(Sender: TObject);
begin
  if Trabajo.RecordCount = 0 then
  SKU_NO:=''
  else
  SKU_NO:=Trabajo.FieldByName('SKU_NO').AsString;
  close;
end;

procedure TFormSelectOneSKU.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFormSelectOneSKU.DBGrid1DblClick(Sender: TObject);
begin
  Button2Click(self);
end;

procedure TFormSelectOneSKU.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then Button2Click(self);
end;


function TFormSelectOneSKU.IniciaSelection(data: TDataSet):String;
begin
  //ENA:=CDBarra;
  Trabajo:=data;
  SKU_NO:='';
  ShowFormSelectSKU;
  Result:=SKU_NO;
end;


end.

