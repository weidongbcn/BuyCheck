unit CreateNewInventory;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  connect, ZDataset, Global;

type

  { TFormNewInventory }

  TFormNewInventory = class(TForm)
    Button2: TButton;
    Button3: TButton;
    DataSource1: TDataSource;
    DBLookupComboBox3: TDBLookupComboBox;
    Label1: TLabel;
    Label16: TLabel;
    Memo1: TMemo;
    StockListQuery: TZQuery;
    CreateQuery: TZQuery;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GetStockList;
  private

  public
     function IniciaNewInventory(): TBuyDocStruct;
  end;

  procedure ShowFormfindout;

var
  FormNewInventory: TFormNewInventory;
  aDoc:TBuyDocStruct;

implementation
procedure ShowFormfindout;
begin
  with TFormNewInventory.Create(Application) do
    begin
      ShowModal;
    end;
end;

function TFormNewInventory.IniciaNewInventory(): TBuyDocStruct;
begin

   ShowFormfindout;
   //SetLength(result, 1);
  result:= aDoc;
end;

{$R *.lfm}

{ TFormNewInventory }
procedure  TFormNewInventory.GetStockList;
begin
  with StockListQuery do
  begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.Clear;
  Sql.Text:='Select * from '+UseDBC.EMID+'STOCKLIST';
  open;

  end;
end;

procedure TFormNewInventory.Button2Click(Sender: TObject);
var
  CH_UUID:string;
begin
  if DBLookupComboBox3.KeyValue=null then
  begin DBLookupComboBox3.SetFocus; exit; end;

  CH_UUID:=Get36UUID();

  aDoc.ID_STOCK:= DBLookupComboBox3.KeyValue;
  with CreateQuery do
  begin
  Connection:=DataModule2.ZCon1;
  Active:=false;
  SQL.Clear;
  Sql.Text:='INSERT INTO STOCKCHECKTOPS '
   +'(CH_UUID, ID_STOCK, ID_TIENDA, TERMINAL, EMPLEADO, NOTA) '
   +'VALUES (:CH_UUID, :ID_STOCK, :ID_TIENDA, :TERMINAL, :EMPLEADO, :NOTA) ';
   ParamByName('CH_UUID').AsString:=CH_UUID;
   ParamByName('ID_STOCK').AsString:=DBLookupComboBox3.KeyValue;
   ParamByName('ID_TIENDA').AsString:=UseDBC.EMID;
   ParamByName('TERMINAL').AsString:=UseDBC.PCID;
   ParamByName('EMPLEADO').AsString:=LOGIN;
   ParamByName('NOTA').AsMemo:=Memo1.Text;
  ExecSQL;
  aDoc.B_UUID:=CH_UUID;
  aDoc.BUY_DATE:=now();

  end;
  close;
end;

procedure TFormNewInventory.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TFormNewInventory.FormCreate(Sender: TObject);
begin
  aDoc.B_UUID:='';
  aDoc.ID_STOCK:='';
end;

procedure TFormNewInventory.FormShow(Sender: TObject);
begin
  GetStockList;
end;

end.

