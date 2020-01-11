unit Moduleadd;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,Variants,LCLType, connect,
  DefaultTranslator, LResources,
  StdCtrls, DbCtrls, DBGrids, ZDataset, Global;

type

  { TFormM }

  TFormM = class(TForm)
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
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public
    function IniciaMExcute(dbTable: string;  SetColumns: Array of string; const TituloColumns: Array of string): integer;

  end;

var
  FormM: TFormM;
  Resultado: variant;
  SqlCMD: string;
  SqlTable: string;
  ColumnSelect: Array of string;
  RefColumns: array of string;
  TxtCoLumns: array of string;

implementation

{$R *.lfm}


procedure ShowFormM;
begin
  with TFormM.Create(Application) do
    begin
      ShowModal;
    end;
end;

{ TFormM }

procedure TFormM.FormCreate(Sender: TObject);
var
   ncontador, columnasvisibles, ncolumnas: integer;
begin

  if ( SqlTable=EmID+'MARCA') then Label2.Caption:='Marca/Fabricante';
  if (SqlTable=EmID+'QUANTIFIER') then Label2.Caption:='Concepcion de Unidad';
  if (SqlTable=EmID+'FILACODE') then Label2.Caption:='Seccion de Ubicaion';

  if ColumnSelect[1] = '' then
  begin
  button2.Enabled:=False;
  button3.Enabled:=False;
  end;

  dbExcute.SQL.Text:=SqlCMD;
  Datasource1.DataSet:=dbExcute;
  dbExcute.Active:= True;

 // columnasvisibles:= GridBusquedas.Columns.VisibleCount;

 // setlength(RefColumns, columnasvisibles);


  for ncontador:=0 to length(TxtCoLumns)-1 do
     begin
       if (ncontador=0) then  GridBusquedas.Columns.Items[ncontador].Width:=100
       else GridBusquedas.Columns.Items[ncontador].Width:=280;
      GridBusquedas.Columns.Items[ncontador].Title.Caption:= TxtCoLumns[ncontador];
     end;
end;

procedure TFormM.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
 // if (key=VK_RETURN) then begin key:=0; button3Click(Self); end;
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

procedure TFormM.Button2Click(Sender: TObject);
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

  except
   application.MessageBox('Error, 纪录重复(Ya existe)！','提示',0+64) ;
   dbExcute.Refresh;
  end;
  edit1.Text:='';
end;

procedure TFormM.Button1Click(Sender: TObject);
begin
  Close();
end;

procedure TFormM.Button3Click(Sender: TObject);
begin
try
if dbExcute.State in [dsEdit, dsInsert] then
    begin

    dbExcute.post;

    end;
Resultado:=1;
except
   application.MessageBox('Error, 纪录重复(Ya existe)！','提示',0+64) ;
   dbExcute.Refresh;
  end;
end;

procedure TFormM.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if (key=VK_RETURN) then begin key:=0; button2.SetFocus; Exit; end;
end;

function TFormM.IniciaMExcute(dbTable: string;  SetColumns: Array of string; const TituloColumns: Array of string): integer;
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


end.

