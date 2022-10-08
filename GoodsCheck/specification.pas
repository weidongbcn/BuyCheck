unit specification;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Dialogs, LCLType, Controls, Graphics,  ExtCtrls, StdCtrls,
  DBGrids, ZDataset, connect,Global, Grids;

type

  MemoDifier = class
  public
    procedure DBGridOnGetText(Sender: TField; var aText: string;
      DisplayText: boolean);
  end;

  { TFormspec }

  TFormspec = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    SpecQuery: TZQuery;
    SpecValuesQuery: TZQuery;
    TrabajoQuery: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBGrid2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GetAllSpec;
    procedure GetSpecsValues(Specs_id: integer);
    procedure SpecQueryAfterScroll(DataSet: TDataSet);
  private

  public
   function IniciaSpecs():boolean;
  end;
  procedure ShowFormspec;

var
  Formspec: TFormspec;
  NEW:BOOLEAN;
  blSelect: Boolean;
BookMark: TBookMark;
CurrNo, OldNo: integer;
Hecho:boolean;

implementation

{$R *.lfm}


procedure MemoDifier.DBGridOnGetText(Sender: TField; var aText: string;
  DisplayText: boolean);
begin
  if (DisplayText) then
    aText := Sender.AsString;
end;



procedure ShowFormspec;
begin
  with TFormspec.Create(Application) do
    begin
      ShowModal;
    end;
end;

procedure TFormspec.GetSpecsValues(Specs_id: integer);
begin
    with SpecValuesQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    Sql.Text:='SELECT * FROM GOODS_ATTRIBUTE_VALUE WHERE ATTIBUTE_ID=:ATTIBUTE_ID ';
    ParamByName('ATTIBUTE_ID').AsInteger:= Specs_id;
    open;
  end;
end;

procedure TFormspec.SpecQueryAfterScroll(DataSet: TDataSet);
var
id:integer;
begin

  id:= SpecQuery.FieldByName('ATTIBUTE_ID').AsInteger;
  GetSpecsValues(id);

end;

procedure TFormspec.Button1Click(Sender: TObject);
VAR
I, ID:INTEGER;
STR:STRING;

begin
if TRIM(Edit1.Text) = '' then
BEGIN
  Edit1.SetFocus;
  EXIT;
END;
with TrabajoQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_ATTRIBUTE_KEY (name, definition) VALUE (:NAME, :definition) '
          +'ON DUPLICATE KEY UPDATE definition=:definition';
     ParamByName('NAME').AsString:=TRIM(Edit1.Text);
     ParamByName('definition').AsString:=Memo2.Text;
    ExecSQL;

  end;
  SpecQuery.Refresh;
  if SpecQuery.Locate('name', TRIM(Edit1.Text), []) then
  begin
    ID:=SpecQuery.FieldByName('ATTIBUTE_ID').AsInteger;
  end;
  Edit1.Text:='';
  if ID < 1 then
  begin
    showmessage('不能插入规格属性值.');
    exit;
  end;
  if TRIM(MEMO1.Text) = '' then
  BEGIN
   EXIT;
   END;
    with TrabajoQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_ATTRIBUTE_VALUE (ATTIBUTE_ID, ATTIBUTE_VALUE) VALUES(:ATTIBUTE_ID, :ATTIBUTE_VALUE) ON DUPLICATE KEY UPDATE UPDATE_TIME=now() ';

    for i := 0 to Memo1.Lines.Count - 1 do begin
    STR:=Memo1.Lines.Strings[i];
    if Str = '' then Continue;
    ParamByName('ATTIBUTE_ID').AsInteger:= ID;
    ParamByName('ATTIBUTE_VALUE').AsString:=STR;            //STL.Strings[I];
    ExecSQL;
    end;
  end;
    showmessage('创建(更新)成功.');
    SpecQuery.Refresh;
    memo1.Clear;
    memo2.Clear;
    Hecho:=True;
   Edit1.SetFocus;
end;

procedure TFormspec.GetAllSpec;
begin
    with SpecQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT T1.ATTIBUTE_ID, T1.NAME, T1.DEFINITION, group_concat(T2.ATTIBUTE_VALUE separator '','') AS SPEC_VALUE '
    +' FROM GOODS_ATTRIBUTE_KEY as T1 '
    +'LEFT JOIN GOODS_ATTRIBUTE_VALUE AS T2 ON T1.ATTIBUTE_ID = T2.ATTIBUTE_ID GROUP BY T1.ATTIBUTE_ID';
    open;
  end;
end;


procedure TFormspec.Button2Click(Sender: TObject);
begin
close;
end;

procedure TFormspec.Button3Click(Sender: TObject);
begin
Panel5.Visible:=True;
Panel4.Visible:=False;
Dbgrid1.Enabled:=False;
Edit2.Focused;
end;

procedure TFormspec.Button4Click(Sender: TObject);
var
tempBookMark:TbookMark;
aBookMark:TbookMark;
i:integer;
begin
if dbgrid2.SelectedRows.Count <= 0 Then
begin
Application.MessageBox('提示','请选择您要删除的记录',MB_OK);
Exit;
end;
//If Application.MessageBox(Handle,,,mb_iconinformation+mb_YesNo)=IdYes Then
if MessageDlg('提示', '删除后数据将不可恢复，您确定要删除吗？', mtConfirmation,
   [mbYes, mbNo],0) = mrYes Then
Begin
i:=0;
DBGrid2.Datasource.Dataset.DisableControls;
While i<=dbgrid2.SelectedRows.Count - 1 Do
Begin
DBGrid2.Datasource.Dataset.Bookmark:=dbgrid2.SelectedRows.Items[i];//重要的在这里,取得BOOKMARK
TempBookmark:=DBGrid2.Datasource.Dataset.GetBookmark;
DBGrid2.Datasource.Dataset.GotoBookmark(TempBookmark);
with TrabajoQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='DELETE FROM GOODS_ATTRIBUTE_VALUE WHERE ID=:ID ';
    ParamByName('ID').Value:=Dbgrid2.DataSource.DataSet.fieldbyname('id').AsInteger;
ExecSql;
end;
DBGrid2.Datasource.Dataset.FreeBookmark(TempBookmark); //释放BOOKMARK
inc(i); //下一个选择记录
End;
DBGrid2.Datasource.Dataset.EnableControls;
end;
 SpecValuesQuery.Refresh;
 aBookMark:= SpecQuery.GetBookmark;
 SpecQuery.Refresh;
 SpecQuery.GotoBookmark(aBookMark);
end;

procedure TFormspec.Button5Click(Sender: TObject);
begin

Dbgrid1.Enabled:=True;
Panel5.Visible:=False;
end;

procedure TFormspec.Button6Click(Sender: TObject);
var
aBookMark:TbookMark;
begin
if Trim(Edit2.Text)= '' then Exit;
 with TrabajoQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_ATTRIBUTE_VALUE (ATTIBUTE_ID, ATTIBUTE_VALUE) VALUES(:ATTIBUTE_ID, :ATTIBUTE_VALUE) ON DUPLICATE KEY UPDATE UPDATE_TIME=now() ';
    ParamByName('ATTIBUTE_ID').AsInteger:=SpecQuery.fieldbyname('ATTIBUTE_ID').AsInteger;
    ParamByName('ATTIBUTE_VALUE').AsString:=Trim(Edit2.Text);
    ExecSql;
  end;
  SpecValuesQuery.Refresh;
 aBookMark:= SpecQuery.GetBookmark;
 SpecQuery.Refresh;
 SpecQuery.GotoBookmark(aBookMark);
 Edit2.Text:='';
 Edit2.SetFocus;
// Panel5.Visible:=False;
end;

procedure TFormspec.Button7Click(Sender: TObject);
begin
Panel4.Visible:=True;
Panel5.Visible:=False;
Dbgrid1.Enabled:=False;
Edit1.SetFocus;
end;

procedure TFormspec.Button8Click(Sender: TObject);
begin
Panel4.Visible:=False;
Dbgrid1.Enabled:=True;

end;

procedure TFormspec.Button9Click(Sender: TObject);
begin
if SpecQuery.RecordCount <= 0 Then
begin
Exit;
end;

if SpecQuery.FieldByName('NAME').AsString='' then
begin
// MessageBox(Handle,'请选择您要删除的记录','提示',MB_OK);
 Application.MessageBox('提示','请选择您要删除的记录',MB_OK);
Exit;
end;

//If MessageBox(Handle,'删除后数据将不可恢复，您确定要删除选中的规格以及其所有规格值吗？','提示',mb_iconinformation+mb_YesNo)=IdYes Then
if MessageDlg('提示', '删除后数据将不可恢复，您确定要删除选中的规格以及其所有规格值吗？', mtConfirmation,
   [mbYes, mbNo],0) = mrYes Then
Begin
with TrabajoQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='DELETE FROM GOODS_ATTRIBUTE_VALUE WHERE ATTIBUTE_ID=:ATTIBUTE_ID ';
    ParamByName('ATTIBUTE_ID').AsInteger:= SpecQuery.fieldbyname('ATTIBUTE_ID').AsInteger;
    ExecSql;
   sql.Clear;
   sql.Text:='DELETE FROM GOODS_ATTRIBUTE_KEY WHERE ATTIBUTE_ID=:ATTIBUTE_ID ';
   ParamByName('ATTIBUTE_ID').AsInteger:= SpecQuery.fieldbyname('ATTIBUTE_ID').AsInteger;
   ExecSql;
  end;
  SpecQuery.Refresh;
  Hecho:=True;
End;
end;

procedure TFormspec.DBGrid1DblClick(Sender: TObject);
begin
// EDIT1.Text:=SpecQuery.FieldByName('NAME').AsString;
// Edit1.SetFocus;
end;

procedure TFormspec.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
var
  MemoFieldReveal: MemoDifier;
begin
   if (DataCol = 1) then
   begin
     try
       DBGrid1.Columns.Items[3].Field.OnGetText := @MemoFieldReveal.DBGridOnGetText;
     except
       On E: Exception do
       begin
         ShowMessage('Exception caught : ' + E.Message);
       end;
     end;
   end;

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
  end;  {

   if ([gdSelected, gdFocused] * AState <> []) and (DBGrid1.SelectedColumn = Column) then
  begin
    DBGrid1.Canvas.Brush.Color := clRed;
    DBGrid1.Canvas.Font.Color := clWhite;
  end;
  }
end;

end;

procedure TFormspec.DBGrid2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Button = mbLeft then
begin
if not blSelect then
begin
BookMark := SpecValuesQuery.GetBookMark;
OldNo := SpecValuesQuery.RecNo;
blSelect := True;
Exit;
end
else
begin
if ssShift in Shift then
begin
CurrNo := SpecValuesQuery.RecNo;
SpecValuesQuery.DisableControls;
SpecValuesQuery.GotoBookmark(BookMark);
DBGrid2.SelectedRows.CurrentRowSelected := True;
if CurrNo > OldNo then
begin
while CurrNo > SpecValuesQuery.RecNo do
begin
DBGrid2.SelectedRows.CurrentRowSelected := True;
SpecValuesQuery.Next;
end;
end
else
begin
while CurrNo < SpecValuesQuery.RecNo do
begin
DBGrid2.SelectedRows.CurrentRowSelected := True;
SpecValuesQuery.Prior;
end;
end;
SpecValuesQuery.EnableControls;
SpecValuesQuery.FreeBookmark(BookMark);
blSelect := False;
CurrNo := 0;
OldNo := 0;
end
else
begin
BookMark := SpecValuesQuery.GetBookMark;
OldNo := SpecValuesQuery.RecNo;
blSelect := True;
Exit;
end;
end;
end;

end;

procedure TFormspec.Edit1Exit(Sender: TObject);
var
    ss : TStringList;
    str,dec, s : string;
begin
    ss:=TStringList.Create;
    dec:=',';
    if SpecQuery.Locate('name', TRIM(Edit1.Text), []) then
 BEGIN
   str := SpecQuery.FieldByName('SPEC_VALUE').AsString;
   //ss := str.Split(dec); //split(str,dec);
   for s in Str.Split(dec) do begin
    ss.Add(s);
  end;
   memo1.Lines.AddStrings(ss);
   memo2.Lines.Text:= SpecQuery.FieldByName('DEFINITION').AsString;
 END;
 ss.Free;

end;

procedure TFormspec.FormCreate(Sender: TObject);
begin
Hecho:=False;
GetAllSpec;
end;

function TFormspec.IniciaSpecs():boolean;
begin
  Hecho:=False;
   ShowFormspec;
   result:=Hecho;
end;


end.

