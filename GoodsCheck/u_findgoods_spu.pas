unit U_FindGoods_Spu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBGrids, ExtCtrls,
  StdCtrls, Buttons, ZDataset, connect, LCLType,
   Global;

type

  { TFormFindGoods_Spu }

  TFormFindGoods_Spu = class(TForm)
    BitBtn14: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    EdTexto: TEdit;
    Label1: TLabel;
    ListUniQuery: TZQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure DoFindOut(aStr: string);
    procedure BitBtn14Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure EdTextoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormCreate(Sender: TObject);
  private

  public

   function IniciaBusquedas( out Articulo_id: string ):boolean;
  end;
   procedure ShowFormBusquedas;

var
  FormFindGoods_Spu: TFormFindGoods_Spu;
  Str, OutStr: string;
  Hecho:boolean;

implementation


{$R *.lfm}

{ TFormFindGoods_Spu }


procedure ShowFormBusquedas;
begin
  with TFormFindGoods_Spu.Create(Application) do
    begin
      ShowModal;
    end;
end;
function TFormFindGoods_Spu.IniciaBusquedas( out Articulo_id: string ):boolean;
begin
  // str:=Busqueda;
   ShowFormBusquedas;
   Articulo_id:=OutStr;
   result:=Hecho;
end;

procedure TFormFindGoods_Spu.BitBtn14Click(Sender: TObject);
begin
  DoFindOut(Trim(EdTexto.Text));
end;

procedure TFormFindGoods_Spu.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TFormFindGoods_Spu.Button2Click(Sender: TObject);
begin
  if ListUniQuery.RecordCount =0 then exit;
OutStr:=ListUniQuery.FieldByName('ENA').AsString;
Hecho:=True;
close;
end;

procedure TFormFindGoods_Spu.DBGrid1DblClick(Sender: TObject);
begin
if ListUniQuery.RecordCount =0 then exit;
OutStr:=ListUniQuery.FieldByName('ENA').AsString;
Hecho:=True;
close;
end;

procedure TFormFindGoods_Spu.DoFindOut(aStr: string);
begin
  with ListUniQuery do
 begin
 Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT T1.GOODS_ID, T1.GOODS_NAME, T1.ENA, T1.CODE, T3.CATEGORY, T4.BRAND_NAME,  T5.CLASS, T2.PVP1C FROM GOODS_SPU AS T1 '
            +'LEFT JOIN GOODS_SPU_PRICE T2 ON T2.GOODS_ID = T1.GOODS_ID '
            +'LEFT JOIN CATEGORYS AS T3 ON T3.ID= T1.CATEGORY_ID '
            +'LEFT JOIN GOODS_BRANDS AS T4 ON T4.BRAND_ID = T1.BRAND_ID '
            +'LEFT JOIN CLASSES AS T5 ON T5.ID = T1.CLASS_ID '
            +'WHERE 1=1  and (GOODS_NAME LIKE ''%' + aStr+'%'' or ENA LIKE ''%' + aStr+'%''or CATEGORY LIKE ''%' + aStr+'%'' or BRAND_NAME LIKE ''%' + aStr+'%'' )';
    open;
 end;
end;

procedure TFormFindGoods_Spu.EdTextoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then BitBtn14.OnClick(SELF);

end;

procedure TFormFindGoods_Spu.FormCreate(Sender: TObject);
begin
OutStr:='';
Hecho:=False;
end;


end.

