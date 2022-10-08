unit his_pays;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids, LCLType,
  StdCtrls, ZDataset, Global, connect, rxcurredit, Grids;

type

  { TFormPayInfo }

  TFormPayInfo = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    PayQuery: TZQuery;
    Total: TCurrencyEdit;
    Payed: TCurrencyEdit;
    TotalQuery: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GetPayList();
    procedure GetRealpago();
  private

  public
     Procedure GetPayInformacion(Id_Buy:string; Serie:string);
  end;
  procedure ShowFormPayInfo;

var
  FormPayInfo: TFormPayInfo;
  PayId_Buy,PaySerie:string;

implementation

{$R *.lfm}
procedure ShowFormPayInfo;
begin
  with TFormPayInfo.Create(Application) do
    begin
      ShowModal;
    end;
end;

Procedure TFormPayInfo.GetPayInformacion(Id_Buy:string; Serie:string);
begin
  PayId_Buy:=Id_Buy;
  PaySerie:=Serie;
  ShowFormPayInfo;
end;

procedure TFormPayInfo.GetPayList();
begin
  with PayQuery do
  begin
    Connection:=DataModule2.ZCon1;;
     Active:=false;
     SQL.Clear;
     SQL.TEXT:='SELECT D_UUID, STAFF, EFECTIVO, TARJETA, BONUS, PUNTO, WECHAT, ALIPAY, CD_QR, TRANSFERENCIA, OTHER, SPENDING_DATE FROM SPENDING_ACCION '
     +'WHERE 1=1 '
     +'AND D_UUID=:ID_BUY ';
     ParamByName('ID_BUY').AsString:=PayId_Buy;
     open;
  end;
end;
procedure TFormPayInfo.GetRealpago();
begin
  with PayQuery do
  begin
    Connection:=DataModule2.ZCon1;;
     Active:=false;
     SQL.Clear;
     SQL.TEXT:='select T1.B_UUID, T1.REALPAGO, SUM(T2.EFECTIVO)+SUM(T2.TARJETA)+ SUM(T2.BONUS)+SUM(T2.PUNTO)+SUM(T2.WECHAT)+SUM(T2.ALIPAY)+SUM(T2.CD_QR)+SUM(T2.TRANSFERENCIA)+SUM(T2.OTHER) AS PAYTOTAL  '
     +'from BUY_HISTORY as T1 LEFT JOIN spending_accion AS T2 ON T1.B_UUID = T2.D_UUID  '
     +'WHERE 1=1 '
     +'AND T1.B_UUID=:ID_BUY  ';
     ParamByName('ID_BUY').AsString:=PayId_Buy;
     open;
  end;
  total.Value:=PayQuery.FieldByName('REALPAGO').AsFloat;
  Payed.Value:=PayQuery.FieldByName('PAYTOTAL').AsFloat;
end;

procedure TFormPayInfo.FormShow(Sender: TObject);
begin
   GetRealpago;
   GetPayList();
end;

procedure TFormPayInfo.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormPayInfo.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
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

procedure TFormPayInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If key=VK_ESCAPE then close;
end;

end.

