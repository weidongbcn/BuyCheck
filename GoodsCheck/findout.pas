unit findout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBGrids, ExtCtrls, variants,
  Buttons, StdCtrls, ZDataset,connect, LCLType,
   Global;

type

  { TFormFindout }

  TFormFindout = class(TForm)
    AddButton: TButton;
    BtCancelar: TBitBtn;
    BtCerrar: TBitBtn;
    Datasource1: TDataSource;
    dbBusquedas: TZQuery;
    GridBusquedas: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure AddButtonClick(Sender: TObject);
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

  function IniciaBusquedas(dbTable: string; SetColumns: Array of string; const TituloColumns: Array of string): TStringArray;
  end;

  procedure ShowFormfindout;

var
  FormFindout: TFormFindout;
  ConsultaOriginal, Consulta, ConsultaAnterior:  string;
  CampoBuscar: Array of string;
  modificador: string;
  Comodin: string;
  Resultado: variant;
  TxtCampos: array of string;
  RefCampos: array of string;
  ColumnSelect: Array of string;
  Sqltable:string;

implementation
uses
  Proveedor,Goods_Marca, U_QUANTIFIER;

procedure ShowFormfindout;
begin
  with TFormFindout.Create(Application) do
    begin
      ShowModal;
    end;
end;

{$R *.lfm}

{ TFormFindout }

function TFormFindout.IniciaBusquedas(dbTable: string; SetColumns: Array of string; const TituloColumns: Array of string): TStringArray;
var
  contador: integer;
  Coles:string;
begin
   Resultado:='';
   Coles:='';
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

     Consulta:='SELECT '+Coles+ ' FROM '+ dbTable + ' WHERE 1=1 ';
     ConsultaOriginal:= Consulta;

   ShowFormfindout;
   SetLength(result, 2);
  result[0] := Resultado[0];
  result[1] := Resultado[1];
end;

procedure TFormFindout.GridBusquedasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then begin key:=0; btCerrarClick(Self); end;
end;

procedure TFormFindout.GridBusquedasDblClick(Sender: TObject);
begin
  btCerrarClick(Self);
end;

procedure TFormFindout.BtCerrarClick(Sender: TObject);
begin

  if ColumnSelect[0]='' then Resultado[0] := Consulta
                    else
                      begin
                      Resultado[0]:= dbBusquedas.FieldByName(ColumnSelect[0]).Value;
                      Resultado[1]:= dbBusquedas.FieldByName(ColumnSelect[1]).Value;

                      end;
  if (Resultado[0] = '') then begin Resultado[0]:=-1; Resultado[1]:=-1; end;
  Close();
end;

procedure TFormFindout.BtCancelarClick(Sender: TObject);
begin
  Resultado[0]:=-1;

  Resultado[1]:=-1;
   Close();
end;

procedure TFormFindout.AddButtonClick(Sender: TObject);
var
  result: integer;
begin
 // showmessage(Sqltable);
  if (Sqltable= EMID+'PROVEEDORLIST') then
  begin
  Result:=FormProveedor.IniciaMExcute(Sqltable);
  end;
  if (Sqltable= 'GOODS_BRANDS') then
  begin
  Result:=FormMarca.IniciaMExcute(Sqltable, ColumnSelect, TxtCampos );
  end;
  if (Sqltable= EMID+'QUANTIFIER') then
  begin
  Result:=FormQUANTIFIER.IniciaQExcute(Sqltable, ColumnSelect, TxtCampos );
  end;
  if (Result >0 ) then dbBusquedas.Refresh;
end;


procedure TFormFindout.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=CaFree;
end;

procedure TFormFindout.FormCreate(Sender: TObject);
var
   ncontador, columnasvisibles, ncolumnas: integer;
begin
 // Resultado := VarArrayCreate([0,1], varString);

  Resultado := VarArrayCreate([0, 1], varVariant);
  dbBusquedas.Connection:=DataModule2.ZCon1;
  dbBusquedas.Active:=false;
  dbBusquedas.SQL.Clear;
  dbBusquedas.SQL.Text:=ConsultaOriginal;
  Datasource1.DataSet:=dbBusquedas;
  dbBusquedas.Active:= True;

  columnasvisibles:= GridBusquedas.Columns.Count;

  setlength(RefCampos, columnasvisibles);
  for ncontador:=0 to length(txtCampos)-1 do
     begin
       if (ncontador=0) then  GridBusquedas.Columns.Items[ncontador].Width:=100
       else GridBusquedas.Columns.Items[ncontador].Width:=280;
      GridBusquedas.Columns.Items[ncontador].Title.Caption:= txtCampos[ncontador];
     end;
end;

procedure TFormFindout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 // if (key=VK_F8) then begin key:=0; btAplicarClick(self); Exit; End;
 if (key=VK_RETURN) then begin key:=0; btCerrarClick(Self); end;
 if (key=VK_ESCAPE) then begin key:=0; btCancelarClick(Self); end;
// if (key=VK_F12) and (GridBusquedas.Focused) then begin key:=0; EdTexto.SetFocus; Exit; End;
// if (key=VK_F12) and (EdTexto.Focused) then begin key:=0; GridBusquedas.SetFocus; Exit; End;
 if (key=VK_F10)  then begin key:=0; AddButton.SetFocus; Exit; End;
 if (key=VK_F11)  then begin key:=0; GridBusquedas.SetFocus; Exit; End;
end;

end.

