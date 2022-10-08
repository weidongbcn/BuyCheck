unit cleardb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Global, connect, md5,
  ZDataset;

type

  { TClearDbForm }

  TClearDbForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    FinalQuery: TZQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  ClearDbForm: TClearDbForm;


implementation

{$R *.lfm}

{ TClearDbForm }

procedure TClearDbForm.Button1Click(Sender: TObject);
var
  key:string;
begin
   key := InputBox(nMSG12,nMSG13,'');
   if key = '' then exit;
   if MD5Print(MD5String(key)) <> passwordhash then
   begin
     showmessage(nMSG14);
     exit;
   end;
   with FinalQuery do
 begin
  Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     sql.Text:='UPDATE STOCKGOODS SET AMOUNT=0 WHERE 1=1 AND AMOUNT<=0 ';
     ExecSQL;
     SQL.Text:='UPDATE GOODS_SKU AS T1 SET T1.STOCK=T2.AMOUNT '
      +'WHERE 1=1 AND T1.AMOUNT <= 0 ';
     ExecSQL;
 end;
   Button1.Caption:='已经完成操作';
   Button1.Enabled:=false;
end;

procedure TClearDbForm.Button2Click(Sender: TObject);
var
  key:string;
begin
   key := InputBox(nMSG12,nMSG13,'');
   if key = '' then exit;
   if MD5Print(MD5String(key)) <> passwordhash then
   begin
     showmessage(nMSG14);
     exit;
   end;
   with FinalQuery do
 begin
  Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     sql.Text:='UPDATE STOCKGOODS SET AMOUNT=0 WHERE 1=1 ';
     ExecSQL;
     SQL.Text:='UPDATE GOODS_SKU AS T1 SET T1.STOCK = 0 '
      +'WHERE 1=1 ';
     ExecSQL;
 end;
   Button2.Caption:='已经完成操作';
   Button2.Enabled:=false;

end;

end.

