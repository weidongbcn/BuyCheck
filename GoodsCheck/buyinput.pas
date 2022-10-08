unit BuyInput;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBCtrls, LCLType,
   ZDataset, DateTimePicker, Global, connect, db;

type

  { TFormBuy }

  TFormBuy = class(TForm)
    Button1: TButton;
    Button5: TButton;
    BuyHelp: TZQuery;
    DataSource2: TDataSource;
    STAFFQuery: TZQuery;
    DataSource1: TDataSource;
    DateTimePicker1: TDateTimePicker;
    DBLookupComboBox1: TDBLookupComboBox;
    StaffDBLookupComboBox: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    GetBayIDZQuery: TZQuery;
    StockListQuery: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DateTimePicker1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLookupComboBox3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure GetBayIDDatos;
    procedure GetStockList;
    procedure GetSTAFFList;
    /////
    procedure CreateBuyUUID();
    procedure StaffDBLookupComboBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private

  public
    function IniciaNewBuy(): TBuyDocStruct;
  end;
   procedure ShowFormfindout;

var
  FormBuy: TFormBuy;
  ANewBUYDOC:TDocCompStruct;
  NewB_UUID:STRING;
  aBUYDoc:TBuyDocStruct;

implementation
uses
  Proveedor;

{$R *.lfm}

{ TFormBuy }
procedure ShowFormfindout;
begin
  with TFormBuy.Create(Application) do
    begin
      ShowModal;
    end;
end;

function TFormBuy.IniciaNewBuy(): TBuyDocStruct;
begin

   ShowFormfindout;
   //SetLength(result, 1);
  result:= aBUYDoc;
end;

procedure TformBuy.CreateBuyUUID();
begin
  NewB_UUID:=Get36UUID();
end;

procedure TFormBuy.StaffDBLookupComboBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuy.GetBayIDDatos;
begin
  with GetBayIDZQuery do
  begin
     Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT * FROM '+UseDBC.EmID+'SERIES WHERE TYPE_DOC=''Compra'' ';
     Active:=True;
     if RecordCount = 1 then
          begin
           //存在记录，写出。
           ANewBUYDOC.SERIE:=fieldbyname('SERIE').asstring;
           ANewBUYDOC.ID_BUY:=INTTOSTR(STRTOINT(fieldbyname('NumUsing').asstring)+1);
          // ANewBUYDOC.ISIVAINCLUIDO:=CheckBox1.Checked;
          // ANewBUYDOC.ISREQINCLUIDO:=CheckBox2.Checked;
          // PCPsText.Caption:=fieldbyname('SERIE').asstring;
          // PCPnText.Caption:=INTTOSTR(STRTOINT(fieldbyname('NumUsing').asstring)+1);
          end;
     CLOSE;
  end;

end;

procedure  TFormBuy.GetStockList;
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

procedure  TFormBuy.GetSTAFFList;
begin
  with STAFFQuery do
  begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.Clear;
  Sql.Text:='Select * from STAFF';
  open;
  end;
end;

procedure TFormBuy.Button1Click(Sender: TObject);
begin
  if DBLookupComboBox1.KeyValue= Null then begin DBLookupComboBox1.SetFocus; exit; end ;
  if DBLookupComboBox3.KeyValue= Null then begin DBLookupComboBox3.SetFocus; exit; end ;

  NewB_UUID:=Get36UUID();
  aBUYDoc.B_UUID:=NewB_UUID;
  aBUYDoc.DOCUMENT:=Edit2.Text;
  aBUYDoc.N_DOCUMENT:=Edit1.Text;
  aBUYDoc.Staff:=StaffDBLookupComboBox.Text;
  aBUYDoc.BUY_DATE:=DateTimePicker1.DateTime;
  aBUYDoc.ID_PROVEEDOR:=DBLookupComboBox1.KeyValue;
  aBUYDoc.NAME_PROVEEDOR:=DBLookupComboBox1.Text;;
  aBUYDoc.ID_STOCK:=DBLookupComboBox3.KeyValue;

  with BuyHelp do
    begin
    Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    SQL.Text:='INSERT INTO BUY_HISTORY (B_UUID, ID_PROVEEDOR, NAME_PROVEEDOR, DOCUMENT, N_DOCUMENT, ID_TIENDA, Staff, operator, TERMINAL, BUYDATE, STATUS_LOCK, STATUS_FAC, ID_STOCK) '
             +'VALUES (:B_UUID, :ID_PROVEEDOR, :NAME_PROVEEDOR, :DOCUMENT, :N_DOCUMENT, :ID_TIENDA, :Staff, :operator, :TERMINAL, :BUYDATE, :STATUS_LOCK, :STATUS_FAC, :ID_STOCK )';
    ParamByName('B_UUID').AsString:=aBUYDoc.B_UUID;
    ParamByName('ID_PROVEEDOR').AsString:=aBUYDoc.ID_PROVEEDOR;
    ParamByName('NAME_PROVEEDOR').AsString:=aBUYDoc.NAME_PROVEEDOR;
    ParamByName('DOCUMENT').AsString:=aBUYDoc.DOCUMENT;
    ParamByName('N_DOCUMENT').AsString:=aBUYDoc.N_DOCUMENT;
    ParamByName('ID_TIENDA').AsString:=UseDBC.EMID;
    ParamByName('Staff').AsString:=aBUYDoc.Staff;
    ParamByName('operator').AsString:=LOGIN;         
    ParamByName('TERMINAL').AsString:=UseDBC.PCID;
    ParamByName('BUYDATE').AsDate:=aBUYDoc.BUY_DATE;
    ParamByName('STATUS_LOCK').AsInteger:=0;
    ParamByName('STATUS_FAC').AsInteger:=0;
    ParamByName('ID_STOCK').AsString:=aBUYDoc.ID_STOCK;
    ExecSQL;
    end;
  close;
end;

procedure TFormBuy.Button5Click(Sender: TObject);
var
  result: integer;
  Sqltable:string;
begin

 Sqltable:= EMID+'PROVEEDORLIST';
  Result:=FormProveedor.IniciaMExcute(Sqltable);
  if (Result >0 ) then DataModule2.ProvQuery.Refresh;
end;

procedure TFormBuy.DateTimePicker1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuy.DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuy.DBLookupComboBox3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuy.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuy.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormBuy.FormCreate(Sender: TObject);
begin
  GetStockList;
  GetSTAFFList;
  DateTimePicker1.DateTime:=now();
  aBUYDoc.B_UUID:='';
  aBUYDoc.DOCUMENT:='';
  aBUYDoc.N_DOCUMENT:='';
  aBUYDoc.Staff:='';
  aBUYDoc.BUY_DATE:=now();
  aBUYDoc.ID_PROVEEDOR:='';
  aBUYDoc.NAME_PROVEEDOR:='';
  aBUYDoc.ID_STOCK:='';
  DBLookupComboBox1.KeyValue:= DBLookupComboBox1.ListSource.DataSet.FieldByName(DBLookupComboBox1.KeyField).Value;
  DBLookupComboBox3.KeyValue:= DBLookupComboBox3.ListSource.DataSet.FieldByName(DBLookupComboBox3.KeyField).Value;
end;

end.

