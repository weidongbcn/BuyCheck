unit his_buys;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBCtrls, DBGrids, ZDataset, DateTimePicker, Global, connect, db;

type

  { TForm_His_BuyFromProveedor }

  TForm_His_BuyFromProveedor = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ProvQuery: TZQuery;
    BuyListQuery: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure DoGetProveedor;
    procedure FormCreate(Sender: TObject);
    procedure GetBuyList;
  private

  public

  end;

var
  Form_His_BuyFromProveedor: TForm_His_BuyFromProveedor;
  ID_PROVEEDOR:string;

implementation
uses
  his_pays, His_buy_detalles;

{$R *.lfm}

{ TForm_His_BuyFromProveedor }
procedure TForm_His_BuyFromProveedor.DoGetProveedor;
var
 i:integer;
begin
ProvQuery.Connection:=DataModule2.ZCon1;;
ProvQuery.Close;
ProvQuery.SQL.Text := 'select * from '+UseDBC.EMID+'PROVEEDORLIST';
ProvQuery.Open;
ProvQuery.First;
ComboBox1.Clear;
ComboBox1.Items.Add(nOpera3);
for I := 0 to (ProvQuery.RecordCount-1) do
begin
  ComboBox1.Items.Add(ProvQuery.FieldByName('NAME_COMERCIO').AsString);
  ProvQuery.Next;
end;
 ComboBox1.ItemIndex:=0;

end;

procedure TForm_His_BuyFromProveedor.FormCreate(Sender: TObject);
begin
  ID_PROVEEDOR:='';
  DateTimePicker1.DateTime:= IncMonth(Now(), -1);;
DateTimePicker2.DateTime:= Now();
DoGetProveedor;
GetBuyList;
end;

procedure TForm_His_BuyFromProveedor.GetBuyList;
var
  SQLSTR1, SQLSTR2, SQLSTR3: string;
begin
 with BuyListQuery do
  begin
    Connection:=DataModule2.ZCon1;;
     Active:=false;
     SQL.Clear;
     SQL.TEXT:='SELECT B_UUID, ID_PROVEEDOR, NAME_PROVEEDOR, DOCUMENT, N_DOCUMENT, STAFF, OPERATOR,  BUYDATE,  STATUS_FAC, N_FACTURA,  REALPAGO, ID_STOCK FROM BUY_HISTORY '
    +' WHERE 1=1 '
    //+'AND ID_TIENDA='''+UseDBC.EmID+''' '
    +'AND DATE(BUYDATE)>=:FECHA1 '
    +'AND DATE(BUYDATE)<=:FECHA2 ';
    ParamByName('FECHA1').AsDate:=DateTimePicker1.Date;
    ParamByName('FECHA2').AsDate:=DateTimePicker2.Date;
   open;

  end;
end;

procedure TForm_His_BuyFromProveedor.Button2Click(Sender: TObject);
begin
   GetBuyList;
end;

procedure TForm_His_BuyFromProveedor.Button3Click(Sender: TObject);
var
  Id_Buy:string;
  Serie:string;
begin
 if BuyListQuery.RecordCount < 1 then exit;
 Id_Buy:=BuyListQuery.FieldByName('B_UUID').AsString;
 FormPayInfo.GetPayInformacion(Id_Buy, '' );
end;

procedure TForm_His_BuyFromProveedor.Button4Click(Sender: TObject);
var
  Id_Buy:string;
  Serie:string;
begin
 if BuyListQuery.RecordCount < 1 then exit;
  Id_Buy:=BuyListQuery.FieldByName('B_UUID').AsString;
  FormBuyDetalles.GetBuyDetalles(Id_Buy, '');
end;

procedure TForm_His_BuyFromProveedor.Button1Click(Sender: TObject);
begin
   GetBuyList;
end;

procedure TForm_His_BuyFromProveedor.ComboBox1Select(Sender: TObject);
begin
  if combobox1.ItemIndex=0 then
begin
BuyListQuery.Filter:='';
BuyListQuery.Filtered:=True;
end
else
begin
DBLookupComboBox1.ListSource.DataSet.RecNo:=ComboBox1.ItemIndex;
DBLookupComboBox1.KeyValue:= DBLookupComboBox1.ListSource.DataSet.FieldByName(DBLookupComboBox1.KeyField).Value;
BuyListQuery.Filtered:=False;
BuyListQuery.Filter:=' ID_PROVEEDOR='+DBLookupComboBox1.KeyValue+' ';
BuyListQuery.Filtered:=True;
end;
end;

end.

