unit Goods_Marca;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBCtrls, DBGrids, ZDataset, connect, LCLType,
   Global;

type

  { TFormMarca }

  TFormMarca = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Datasource1: TDataSource;
    dbExcute: TZQuery;
    DBNavigator1: TDBNavigator;
    Edit1: TEdit;
    GridBusquedas: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public

  function IniciaMExcute(dbTable: string;  SetColumns: Array of string; const TituloColumns: Array of string): integer;
  end;
   procedure ShowFormM;

var
  FormMarca: TFormMarca;
  Resultado: variant;
  SqlCMD: string;
  SqlTable: string;
  ColumnSelect: Array of string;
  RefColumns: array of string;
  TxtCoLumns: array of string;

implementation

{$R *.lfm}

{ TFormMarca }
procedure ShowFormM;
begin
  with TFormMarca.Create(Application) do
    begin
      ShowModal;
    end;
end;


function TFormMarca.IniciaMExcute(dbTable: string;  SetColumns: Array of string; const TituloColumns: Array of string): integer;
var
  contador: integer;
  cmd: STRING;
begin
   Resultado:=0;
   cmd:='';
   //Orden:= ' ASC';
   SqlTable:= dbTable;


   SetLength(TxtCoLumns, length(TituloColumns));
    for contador:=low(TituloColumns) to high(TituloColumns)  do
       TxtCoLumns[contador]:= TituloColumns[contador];

    SetLength(ColumnSelect, length(SetColumns));

    for contador:=low(SetColumns) to high(SetColumns)  do
       BEGIN
       ColumnSelect[contador]:= SetColumns[contador];
       if ( contador=0) then cmd:=SetColumns[contador] else
       cmd:=cmd+','+ SetColumns[contador]
       end;
    SqlCMD:='SELECT '+cmd+ ' FROM '+ SqlTable + ' WHERE 1=1 ';


   ShowFormM;

  result:= Resultado;

end;

procedure TFormMarca.Button1Click(Sender: TObject);
begin
close;
end;

procedure TFormMarca.Button2Click(Sender: TObject);
begin
if edit1.Text='' then  exit;
  if ColumnSelect[1] = '' then exit;
  try
  with dbExcute do
  begin
    Append;
    FieldByName(ColumnSelect[1]).AsString:=Edit1.Text;
    Post;
  end;
    Resultado:=1;
  except
   application.MessageBox('Error, 纪录重复(Ya existe)！','提示',0+64) ;

  end;
   dbExcute.Refresh;
  edit1.Text:='';

end;

procedure TFormMarca.Button3Click(Sender: TObject);
begin
try
if dbExcute.State in [dsEdit, dsInsert] then
    begin

    dbExcute.post;
     Resultado:=1;
    end;
except
   application.MessageBox('Error, 纪录重复(Ya existe)！','提示',0+64) ;
   dbExcute.Refresh;
  end;
end;

procedure TFormMarca.FormCreate(Sender: TObject);
begin

  dbExcute.Connection:=DataModule2.ZCon1;
  dbExcute.Active:=false;
  dbExcute.SQL.Clear;
  dbExcute.SQL.Text:=SqlCMD;
  Datasource1.DataSet:=dbExcute;
  dbExcute.Active:= True;
end;

procedure TFormMarca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=VK_ESCAPE) then begin key:=0; button1Click(Self); end;
// if (key=VK_F12) and (GridBusquedas.Focused) then begin key:=0; EdTexto.SetFocus; Exit; End;
// if (key=VK_F12) and (EdTexto.Focused) then begin key:=0; GridBusquedas.SetFocus; Exit; End;
 if (key=VK_F6)  then begin key:=0; Button4.SetFocus; Exit; End;
 if (key=VK_F7)  then begin key:=0; Edit1.SetFocus; Exit; End;
 if (key=VK_F8)  then begin key:=0; button2.SetFocus; Exit; End;
 if (key=VK_F9)  then begin key:=0; Button3.SetFocus; Exit; End;
 if (key=VK_F10)  then begin key:=0; Button1.SetFocus; Exit; End;
 if (key=VK_F11)  then begin key:=0; GridBusquedas.SetFocus; Exit; End;
end;


end.

