unit PayofBuy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ZDataset, rxcurredit, Global, connect;

type

  { TFormBuyPay }

  TFormBuyPay = class(TForm)
    Button1: TButton;
    BuyTop: TZQuery;
    CurrencyEdit1: TCurrencyEdit;
    CurrencyEdit2: TCurrencyEdit;
    CurrencyEdit3: TCurrencyEdit;
    CurrencyEdit4: TCurrencyEdit;
    Label1: TLabel;
    Total: TCurrencyEdit;
    Realpago: TCurrencyEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PayQuery: TZQuery;
    UUIDEdit: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GetTotal;
  private

  public
    function FinalBuy(AFinalBUYDOC:TBuyDocStruct): Boolean;
  end;
   procedure ShowFormfindout(AFinalBUYDOC:TBuyDocStruct);

var
  FormBuyPay: TFormBuyPay;
  Fin: Boolean;
  AFinalDOC:TBuyDocStruct ;

implementation

{$R *.lfm}
procedure ShowFormfindout(AFinalBUYDOC:TBuyDocStruct);
begin
  with TFormBuyPay.Create(Application) do
    begin
     AFinalDOC:=AFinalBUYDOC;
     UUIDEdit.Text:=AFinalBUYDOC.B_UUID;
      Edit1.Text:=AFinalBUYDOC.DOCUMENT;
 Edit2.Text:=AFinalBUYDOC.N_DOCUMENT;
 Edit3.Text:=AFinalBUYDOC.NAME_PROVEEDOR;
 //Total.Value:=AfinalImporte.TOTALIMP;
 //Realpago.Value:=AfinalImporte.TOTALIMP;
      ShowModal;
    end;
end;

function TFormBuyPay.FinalBuy(AFinalBUYDOC:TBuyDocStruct): Boolean;
begin

   ShowFormfindout(AFinalBUYDOC);
  result:= Fin;
end;

{ TFormBuyPay }

procedure TFormBuyPay.Button1Click(Sender: TObject);
begin
  with PayQuery do
 begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.Clear;
  SQL.Text:='INSER INTO SPENDING_ITEMS (SPENDING_CONTENT_ID, D_UUID, ID_TIENDA, P0) VALUES (:SPENDING_CONTENT_ID, :D_UUID, :ID_TIENDA, :P0) '
  +'ON DUPLICATE KEY UPDATE '
  +'P0=:P0, UPDATE=NOW() ';
  ParamByName('SPENDING_CONTENT_ID').AsInteger:=0;   //0 购买支出
  ParamByName('D_UUID').AsString:=AFinalDOC.B_UUID;
  ParamByName('ID_TIENDA').AsString:=UseDBC.EMID;
  ParamByName('P0').AsFloat:= Realpago.Value;
  ExecSQL;
  Active:=False;
  SQL.Clear;
  SQL.Text:='INSERT INTO SPENDING_ACCION (D_UUID, STAFF, EFECTIVO, TARJETA,  TRANSFERENCIA, OTHER, SPENDING_DATE ) '
  +'VALUES (:D_UUID, :STAFF, :EFECTIVO, :TARJETA, :TRANSFERENCIA, :OTHER, :SPENDING_DATE )';
  ParamByName('D_UUID').AsString:=AFinalDOC.B_UUID;
  ParamByName('STAFF').AsString:=AFinalDOC.Staff;
  ParamByName('EFECTIVO').AsFloat:= CurrencyEdit1.Value;
  ParamByName('VISA').AsFloat:= CurrencyEdit2.Value;
  ParamByName('TRANSFERENCIA').AsFloat:= CurrencyEdit3.Value;
  ParamByName('OTHER').AsFloat:= CurrencyEdit4.Value;
  ParamByName('SPENDING_DATE').AsDate:=AFinalDOC.BUY_DATE;
   ExecSQL;
  Active:=False;
  SQL.Clear;
  SQL.Text:='UPDATE BUY_HISTORY SET REALPAGO=:REALPAGO, STATUS_LOCK=1, LOCKEDDATE=NOW() '
  +'WHERE 1=1 AND B_UUID=:B_UUID ';
  ParamByName('D_UUID').AsString:=AFinalDOC.B_UUID;
  ParamByName('REALPAGO').AsFloat:= Realpago.Value;
  ExecSQL;
  close;

 end;
  Tag:=1;
  Fin:=True;
  showmessage('处理完毕,将被关闭');
  close;
end;

procedure TFormBuyPay.FormCreate(Sender: TObject);
begin
  //GetTotal;
  Fin:=False;
end;

procedure TFormBuyPay.FormShow(Sender: TObject);
begin
  GetTotal;
end;

procedure TFormBuyPay.GetTotal;
begin
    with BuyTop do
 begin
  Connection:=DataModule2.ZCon1;
  Active:=False;
  SQL.TEXT:='SELECT sum(T1.QUANTITY*T1.COST*(1-T1.DISCOUNT/100)) AS TOTALIMP FROM BUY_ITEMS as T1 '
  +'WHERE 1=1 '
     +'AND T1.B_UUID=:B_UUID ';
     ParamByName('B_UUID').AsString:=AFinalDOC.B_UUID;
    open;
 end;
    Total.Value:=BuyTop.FieldByName('TOTALIMP').AsCurrency;
end;

end.

