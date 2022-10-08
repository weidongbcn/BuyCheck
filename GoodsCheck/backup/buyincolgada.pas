unit BuyInColgada;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  StdCtrls, ZDataset, LCLType,
  connect, Global, Grids;

type

  { TFormColgada }

  TFormColgada = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    DBList: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure GetBuyList;
  private

  public
    function GetOldBuyList(): TBuyDocStruct;
  end;

  procedure ShowFormfindout;

var
  FormColgada: TFormColgada;
  AOldCompDOC:TBuyDocStruct;

implementation

{$R *.lfm}

{ TFormColgada }
procedure ShowFormfindout;
begin
  with TFormColgada.Create(Application) do
    begin
      ShowModal;
    end;
end;

function TFormColgada.GetOldBuyList(): TBuyDocStruct;
begin

   ShowFormfindout;
  result:= AOldCompDOC;
end;

procedure TFormColgada.GetBuyList;
  begin
   with DBList do
  begin
  Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT * FROM BUY_HISTORY '
     +'WHERE 1=1 '
     +'AND STATUS_LOCK=0 ';
    Open;
  end;
end;

procedure TFormColgada.Button1Click(Sender: TObject);
begin
  DBGrid1DblClick(self);
end;

procedure TFormColgada.Button2Click(Sender: TObject);
begin
  CLOSE;
end;

procedure TFormColgada.DBGrid1DblClick(Sender: TObject);
begin
  if DBList.fieldbyname('B_UUID').asstring = '' then
  begin
    button2.SetFocus;
    exit;
  end
  else
  begin
    AOldCompDOC.B_UUID:=DBList.fieldbyname('B_UUID').asstring;
    AOldCompDOC.ID_PROVEEDOR:=DBList.fieldbyname('ID_PROVEEDOR').asstring;
    //AOldCompDOC.id_tienda
    AOldCompDOC.NAME_PROVEEDOR:=DBList.fieldbyname('NAME_PROVEEDOR').asstring;
    AOldCompDOC.DOCUMENT:=DBList.fieldbyname('DOCUMENT').asstring;
    AOldCompDOC.N_DOCUMENT:=DBList.fieldbyname('N_DOCUMENT').asstring;
    AOldCompDOC.ID_STOCK:= DBList.fieldbyname('ID_STOCK').asstring;
    AOldCompDOC.STAFF:=DBList.fieldbyname('STAFF').asstring;
    AOldCompDOC.BUY_DATE:=DBList.fieldbyname('BUYDATE').AsDateTime;
    Tag:=1;
    Close;
  end;
end;

procedure TFormColgada.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 //if Key=VK_Return then SelectNext(ActiveControl,True,True);
  if key = VK_RETURN then
  DBGrid1DblClick(self);
end;

procedure TFormColgada.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
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
    DBGrid1.Canvas.Brush.color := clyellow; //当前行以黑色显示
    DBGrid1.Canvas.pen.mode := pmmask;
  end;

        {
   if ([gdSelected, gdFocused] * AState <> []) and (DBGrid1.SelectedColumn = Column) then
  begin
    DBGrid1.Canvas.Brush.Color := clBlack;
   // DBGrid1.Canvas.Font.Color := clWhite;
  end; }
end;
end;

procedure TFormColgada.FormCreate(Sender: TObject);
begin

  AOldCompDOC.BUY_DATE:=Now();
  AOldCompDOC.B_UUID:='';
  AOldCompDOC.ID_PROVEEDOR:='';
  AOldCompDOC.NAME_PROVEEDOR:='';
  AOldCompDOC.N_DOCUMENT:='';
  AOldCompDOC.STAFF:='';
  GetBuyList;
end;

end.

