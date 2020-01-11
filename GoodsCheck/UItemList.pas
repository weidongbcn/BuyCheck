unit UItemList;

{$MODE Delphi}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, connect,
  LCLType,Variants, Global,
  DBGrids, Grids, Udata, uFs, UItem,
  Buttons;

type

  { TFormItemlist }

  TFormItemlist = class(TForm)
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    btnAdd: TSpeedButton;
    btnEdit: TSpeedButton;
    btnDel: TSpeedButton;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
  private
    { Private declarations }
    tvStore: TConects;
    tvData: TCollection;
    tvChanged: Boolean;
    procedure UpdateGrid;
  public
    { Public declarations }
    function IniciaData() : Boolean;
  end;

  procedure ShowFormData;

var
  FormItemlist: TFormItemlist;
  Hecho: boolean;

implementation

procedure ShowFormData;
begin
  with TFormItemlist.Create(Application) do
    begin
      ShowModal;
    end;
end;

{$R *.lfm}
{
procedure TForm1.SizeColsToHeaders(Grid: TStringGrid);
var
  Col: integer;
begin
  for Col := 0 to (Grid.ColCount - 1) do
    Grid.ColWidths[Col] :=
      Grid.Canvas.TextWidth(Grid.Cells[Col, 0]) + 5;
end;
}

function TFormItemlist.IniciaData() : Boolean;
begin
  ShowFormData;
  Result:=Hecho;

end;

procedure TFormItemlist.btnAddClick(Sender: TObject);
begin
if TfrmItem.Execute(Self.tvData, -1) then
    begin
      Self.tvChanged := True;
      Self.tvChanged := True;
      Self.tvStore.SaveItems;
      UpdateGrid;
      hecho:=True;
      Self.StringGrid1.Row := Self.StringGrid1.RowCount - 1;
    end;
end;

procedure TFormItemlist.btnDelClick(Sender: TObject);
var
  i: LongInt;
begin
  i := Self.StringGrid1.Row;
  if (i >= 1) and (i <= Self.tvData.Count) then
    if MessageDlg( '确实要删除当前行？',
      mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
      begin
        Self.tvData.Delete(i-1);
        Self.tvStore.SaveItems;
        Self.tvChanged := True;
         UpdateGrid;
         hecho:=True;
      end;
end;

procedure TFormItemlist.btnEditClick(Sender: TObject);

var
  i: LongInt;
begin
  i := Self.StringGrid1.Row;// - Self.StringGrid1.FixedRows;

  if (i >= 1) and (i <= Self.tvData.Count) then
    if TfrmItem.Execute(Self.tvData, i-1) then
      begin
        Self.tvChanged := True;
        Self.tvStore.SaveItems;
        UpdateGrid;
        hecho:=True;
      end;

end;

procedure TFormItemlist.FormCreate(Sender: TObject);
begin
Self.tvStore := TConects.Create;
   StringGrid1.ColWidths[0]:= 32;      //id
   StringGrid1.ColWidths[1]:= 80;      //host
   StringGrid1.ColWidths[2]:= 90;      //user
   StringGrid1.ColWidths[3]:= 70;      //pass
   StringGrid1.ColWidths[4]:= 80;      //database
   StringGrid1.ColWidths[5]:= 40;      //port
   StringGrid1.ColWidths[6]:= 80;       //protocolo
   StringGrid1.ColWidths[7]:= 60;       //emid
   StringGrid1.ColWidths[8]:= 80;       //s-host
   StringGrid1.ColWidths[9]:= 32;
   StringGrid1.Cells[0,0]:='编号';
    StringGrid1.Cells[1,0]:='数据库地址';
    StringGrid1.Cells[2,0]:='账号';
    StringGrid1.Cells[3,0]:='密码';
    StringGrid1.Cells[4,0]:='数据库名';
    StringGrid1.Cells[5,0]:='端口';
    StringGrid1.Cells[6,0]:='连接方式';
    StringGrid1.Cells[7,0]:='企业编号';
    StringGrid1.Cells[8,0]:='服务器地址';
   // StringGrid1.Cells[9,0]:='';
   Self.tvStore.LoadItems;
   Self.tvData := Self.tvStore.Items;
   Hecho:=False;
end;

procedure TFormItemlist.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin

end;

procedure TFormItemlist.FormDestroy(Sender: TObject);
begin
Self.tvStore.Free;
end;

procedure TFormItemlist.FormShow(Sender: TObject);
begin
UpdateGrid;
end;

procedure TFormItemlist.UpdateGrid;
var
i:integer;
conectiones: TConectItem;
begin
  StringGrid1.RowCount:=1;

 for I := 1 to (Self.tvData.Count) do
 begin
 StringGrid1.RowCount:=StringGrid1.RowCount+1;
 conectiones := TConectItem(Self.tvData.Items[i-1]);
 StringGrid1.Cells[0,i]:=inttostr(i);
 StringGrid1.Cells[1,i]:=conectiones.dbHost;
 StringGrid1.Cells[2,i]:=conectiones.dbUser;
 StringGrid1.Cells[3,i]:='*********';//conectiones.dbPasswd;// '密码';
 StringGrid1.Cells[4,i]:=conectiones.dbDataBase; // '数据库名';
 StringGrid1.Cells[5,i]:=inttostr(conectiones.Port);// '端口';
 StringGrid1.Cells[6,i]:=conectiones.dbProtocolo; // '连接方式';
 StringGrid1.Cells[7,i]:=conectiones.EMID; // '企业编号';
 StringGrid1.Cells[8,i]:=conectiones.S_Server; // '服务器地址';
 end;



end;

end.
