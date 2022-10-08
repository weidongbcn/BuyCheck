unit U_QUANTIFIER;

{$mode objfpc}{$H+}

interface

uses
 Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids, ZDataset, connect, LCLType, DBCtrls,
   Global;

type

  { TFormQUANTIFIER }

  TFormQUANTIFIER = class(TForm)
    dbExcute: TZQuery;
    Edit2: TEdit;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Button1: TButton;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Panel4: TPanel;
    Edit1: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Button3: TButton;
    DataSource1: TDataSource;
    UnidadQuery: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure DoGetQUANTIFIER;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  function IniciaQExcute(dbTable: string;  SetColumns: Array of string; const TituloColumns: Array of string): integer;
  end;
   procedure ShowFormQ;

var
  FormQUANTIFIER: TFormQUANTIFIER;
   Resultado: variant;
  SqlCMD: string;
  SqlTable: string;
  ColumnSelect: Array of string;
  RefColumns: array of string;
  TxtCoLumns: array of string;

implementation
//Uses
//U_NewGoods;

procedure ShowFormQ;
begin
  with TFormQUANTIFIER.Create(Application) do
    begin
      ShowModal;
    end;
end;


{$R *.lfm}


function TFormQUANTIFIER.IniciaQExcute(dbTable: string;  SetColumns: Array of string; const TituloColumns: Array of string): integer;
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


   ShowFormQ;

  result:= Resultado;

end;

 procedure TFormQUANTIFIER.Button2Click(Sender: TObject);
begin
if edit1.Text='' then  exit;
if edit2.Text='' then begin showmessage('没有添加的内容'); exit;  end;
  try
  with UnidadQuery do
  begin
    Append;
    FieldByName('CODE').AsString:=Trim(Edit2.Text);
    FieldByName('UNIDAD').AsString:=Trim(Edit1.Text);
    Post;
  end;

  except
   application.MessageBox('Error, 纪录重复(Ya existe)！','提示',0+64) ;

  end;
  UnidadQuery.ApplyUpdates;
  UnidadQuery.close;
  UnidadQuery.Open;
  showmessage('添加成功');
  Resultado:=1;
  edit1.Text:='';
  edit2.Text:='';
 // UnidadQuery.Append;
end;

procedure TFormQUANTIFIER.Button3Click(Sender: TObject);
begin
try
if UnidadQuery.State in [dsEdit, dsInsert] then
    begin

    UnidadQuery.post;
    Resultado:=1;
    end;
except
   application.MessageBox('Error, 纪录重复(Ya existe)！','提示',0+64) ;
   UnidadQuery.Refresh;
  end;
end;

procedure TFormQUANTIFIER.DoGetQUANTIFIER;
  begin
  with UnidadQuery do
  begin
  Connection:=DataModule2.ZCon1;;
  Active:=false;
  SQL.Clear;
     SQL.Text:='SELECT * FROM '+UseDBC.EmID+'QUANTIFIER WHERE 1=1 order by ID asc ';
     Open;

  end;
  end;

procedure TFormQUANTIFIER.FormCreate(Sender: TObject);
begin
 DoGetQUANTIFIER;
dbExcute.Connection:=DataModule2.ZCon1;
  dbExcute.Active:=false;
  dbExcute.SQL.Clear;
  dbExcute.SQL.Text:=SqlCMD;
  //Datasource1.DataSet:=dbExcute;
  dbExcute.Active:= True;
end;

procedure TFormQUANTIFIER.Button1Click(Sender: TObject);
begin
close;
end;

end.
