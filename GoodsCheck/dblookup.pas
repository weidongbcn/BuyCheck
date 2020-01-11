unit dblookup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids, variants, connect,
  ExtCtrls, Buttons, StdCtrls, ZDataset, ZConnection, LCLType;

type

  { TFLookup }

  TFLookup = class(TForm)
    BtCancelar: TBitBtn;
    BtCerrar: TBitBtn;
    Datasource1: TDataSource;
    dbBusquedas: TZQuery;
    dbConect: TZConnection;
    GridBusquedas: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BtCancelarClick(Sender: TObject);
    procedure BtCerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridBusquedasDblClick(Sender: TObject);
    procedure GridBusquedasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private

  public
    function IniciaBusquedas(TxtConsulta: string; CampoBusqueda: Array of string; dbTable: string; Items: string;SetColumns: Array of string; const TituloColumns: Array of string): TStringArray;

  end;

  procedure ShowFLookup;

var
  FLookup: TFLookup;
  AntColumna, Orden: String;
  ConsultaOriginal, Consulta, ConsultaAnterior:  string;
  CampoBuscar: Array of string;
  modificador: string;
  Comodin: string;
  Resultado: variant;
  TxtCampos: array of string;
  RefCampos: array of string;
  FindCampos: array of string;
  ColumnSelect: Array of string;
  Sqltable:string;

implementation

{$R *.lfm}
procedure ShowFLookup;
begin
  with TFLookup.Create(Application) do
    begin
      ShowModal;
    end;
end;

function TFLookup.IniciaBusquedas(TxtConsulta: string; CampoBusqueda: Array of string; dbTable: string; Items: string;
                                               SetColumns: Array of string; const TituloColumns: Array of string): TStringArray;
var
  contador: integer;
  Coles:string;
  Campos:string;
begin
   Resultado:='';
   Coles:='';
   Campos:='';
   modificador:=' LIKE '; Comodin:='%';
   Sqltable:=dbTable;
   SetLength(TxtCampos, length(TituloColumns));
    for contador:=high(TituloColumns) downto low(TituloColumns)  do
       TxtCampos[contador]:= TituloColumns[contador];

    SetLength(ColumnSelect, length(SetColumns));
    for contador:=low(SetColumns) to high(SetColumns)  do
       BEGIN
       ColumnSelect[contador]:= SetColumns[contador];
       if ( contador=0) then Coles:=SetColumns[contador] else
       Coles:=Coles+','+ SetColumns[contador] ;
       end;
    SetLength(FindCampos, length(CampoBusqueda));
    for contador:=low(FindCampos) to high(FindCampos)  do
       BEGIN
       FindCampos[contador]:= CampoBusqueda[contador];
       if ( contador=0) then Campos:=Campos+' AND '+CampoBusqueda[contador]+ modificador+'"'+Comodin+TxtConsulta+Comodin+'" ' else
       Campos:=Campos+' OR '+CampoBusqueda[contador]+ modificador+'"'+ Comodin+TxtConsulta+Comodin+'" ';
       end;

     Consulta:='SELECT '+Coles+ ' FROM '+ dbTable + ' WHERE 1=1 '+Campos +'AND ID_TMPLIST IN ('+Items+') ' ;

     ConsultaOriginal:= Consulta;
   //  showmessage(ConsultaOriginal);

   ShowFLookup;
   SetLength(result, 2);
  result[0] := Resultado[0];
  result[1] := Resultado[1];
end;

procedure TFLookup.GridBusquedasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then begin key:=0; btCerrarClick(Self); end;
end;

procedure TFLookup.GridBusquedasDblClick(Sender: TObject);
begin
  btCerrarClick(Self);
end;

procedure TFLookup.BtCerrarClick(Sender: TObject);
begin
  if ColumnSelect[0]='' then Resultado[0] := Consulta
                    else
                      begin

                      Resultado[0]:= dbBusquedas.FieldByName(ColumnSelect[0]).Value;
                      Resultado[1]:= dbBusquedas.FieldByName(ColumnSelect[1]).Value;

                      end;
  if (Resultado = null) then begin Resultado[0]:=-1; Resultado[1]:=-1; end;
  Close();
end;

procedure TFLookup.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Closeaction:=CaFree;
end;

procedure TFLookup.FormCreate(Sender: TObject);
var
   ncontador, columnasvisibles, ncolumnas: integer;
begin
  Conectate(dbConect);
 // Resultado := VarArrayCreate([0,1], varString);
  Resultado := VarArrayCreate([0, 1], varVariant);

  dbBusquedas.SQL.Text:=ConsultaOriginal;
  Datasource1.DataSet:=dbBusquedas;
  dbBusquedas.Active:= True;
  columnasvisibles:= GridBusquedas.Columns.VisibleCount;

  setlength(RefCampos, columnasvisibles);


  for ncontador:=0 to length(txtCampos)-1 do
     begin
       if (ncontador=2) then  GridBusquedas.Columns.Items[ncontador].Width:=220
       else GridBusquedas.Columns.Items[ncontador].Width:=100;
      GridBusquedas.Columns.Items[ncontador].Title.Caption:= txtCampos[ncontador];
     end;
  GridBusquedas.Columns.Items[3].DisplayFormat:='#0.000';
end;

procedure TFLookup.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then begin key:=0; btCerrarClick(Self); end;
 if (key=VK_ESCAPE) then begin key:=0; btCancelarClick(Self); end;
 if (key=VK_F11)  then begin key:=0; GridBusquedas.SetFocus; Exit; End;
end;

procedure TFLookup.BtCancelarClick(Sender: TObject);
begin
  Resultado[0]:=-1;

  Resultado[1]:=-1;
   Close();
end;

end.

