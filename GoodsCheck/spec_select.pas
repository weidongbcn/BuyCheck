unit Spec_Select;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, DBCtrls, ComCtrls, DBGrids, ZDataset, Variants, connect,
  memds, Global;

type

  { TFormSelectSpec }

  TFormSelectSpec = class(TForm)
    AllSpecDS: TDataSource;
    ListBox3: TListBox;
    MemTable: TBufDataset;
    MemTableATTIBUTE_ID: TLongintField;
    MemTableATTIBUTE_VALUE: TStringField;
    MemTableATTIBUTE_VALUE_ID: TLongintField;
    MemTableGOODS_ID: TStringField;
    MemTableJSON: TStringField;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListUniQuery: TZQuery;
    AllSpecQuery: TZQuery;
    ListView1: TListView;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    SpecValuesQuery: TZQuery;
    TrabajoQuery: TZQuery;
    MemListQuery: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Function GetListSql():string;
    procedure GetCategoryActualSpec(Category_id:integer);
    procedure GetAllSpec();
    procedure GetSpecsValues(Specs_id: integer);
    procedure GetTmpSpecList(SqlCondicion:string);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure ListView1CustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  private

  public
     function IniciarSelect(Category_id:integer;  Goods_Id:string):TStringArray;
  end;

  procedure ShowFormSelectSpec;

var
  FormSelectSpec: TFormSelectSpec;
  Cid, ATTIBUTE_ID, ATTIBUTE_VALUE_ID:integer;
  Gid:String;
  //json:string;
  Data:TStringArray;

implementation
uses
  specification;

{$R *.lfm}
function combination(a,b:string):string;
begin
  if (a <> '') and (b <> '') then result:=a+','+b
  else
  begin
    if a='' then
       begin
         if b='' then result:= ''
         else result:=b;
       end
       else
       begin
         if b='' then result:=a;

       end;
  end;
end;

function Cartesian(a, b: TStringArray): TStringArray;
var
  ret: array of string;
  i, j, n: integer;
  len_a, len_b, mem: integer;
begin
  len_a:=length(a);
  len_b:=length(b);
  if (len_a=0) then
       begin
          if (len_b=0) then result:=nil       //mem:=0   //
          else mem:=len_b;
       end
       else
       begin
         if (len_b=0) then mem:=len_a
         else mem:=len_a*len_b;
       end;
      setlength(result, mem);
      for I := 0 to len_a-1 do
      begin
      for J := 0 to len_b-1 do
        begin
          Result[i*len_b+j]:=combination(a[i], b[j]);
        end;
      end;
end;

function Multicartesian (Data: array of TStringArray):TStringArray;
var
  len: integer;
  memsize:integer;
  r:TStringArray;
  s, t:string;
  I: Integer;
begin
   len:=length(Data);
   if len=0 then Result:=nil   //Data[0]  //data=null
   else if len=1 then result:=Data[0]
   else
   begin
     r:=data[0];
     for I := 1 to len-1 do
      begin
        r:= Cartesian(r, data[i]);
      end;
   end;
   result:=r;
end;


procedure ShowFormSelectSpec;
begin
  with TFormSelectSpec.Create(Application) do
    begin
      ShowModal;
    end;
end;

procedure TFormSelectSpec.ListBox1Click(Sender: TObject);
var
 A_ID:integer;
begin
 // A_ID:= strtoint(ListBox1.Items.Objects[ListBox1.ItemIndex].ToString);
  A_ID:=PtrInt(Listbox1.Items.Objects[Listbox1.ItemIndex]);
  GetSpecsValues(A_ID);
end;

procedure TFormSelectSpec.ListBox2Click(Sender: TObject);
var
 A_ID:integer;
begin
  A_ID:=Ptrint(ListBox2.Items.Objects[ListBox2.ItemIndex]);
  GetSpecsValues(A_ID);

end;

procedure TFormSelectSpec.ListBox3Click(Sender: TObject);
var
  A_ID:integer;
begin
 A_ID:=Ptrint(ListBox3.Items.Objects[ListBox3.ItemIndex]);
 GetSpecsValues(A_ID);

end;

procedure TFormSelectSpec.ListView1CustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Item.Checked then begin
    Sender.Canvas.Brush.Color := clGreen;
    Sender.Canvas.Font.Color := clLime;
  end;
end;

function TFormSelectSpec.IniciarSelect(Category_id:integer; Goods_Id:string):TStringArray;
begin
//TS:= TClientDataSet.;
//json:='';
  //Data:=Null;
  Cid:=Category_id;
  Gid:=Goods_Id;
  ShowFormSelectSpec;

  result:=Data;
end;


Function TFormSelectSpec.GetListSql():string;
var
i, n:integer;
A_ID, A_VALUE_ID:string;
sql:string;
List: TStringList;
saltar:boolean;
begin
List:= TStringList.Create;
List.Sorted := True; //需要先指定排序
List.Duplicates := dupIgnore; //如
  MemTable.First;
  sql:='';
  for I := 0 to MemTable.RecordCount-1 do
   begin
          A_ID:= MemTable.FieldByName('ATTIBUTE_ID').AsString;
          List.Add(A_ID);
          MemTable.Next;
   end;
   sql:=List.CommaText;
   List.Free;
   // showmessage(Sql);
   result:=sql;
end;

procedure TFormSelectSpec.FormCreate(Sender: TObject);
begin
MemTable.Close;
 MemTable.CreateDataset;
GetCategoryActualSpec(Cid);
GetAllSpec();
end;

procedure TFormSelectSpec.Button3Click(Sender: TObject);
var
i:integer;
A_ID, A_VALUE_ID, A_VALUE, A_JSON:string;
Sql:string;
begin
 if ListView1.Items.Count=0 then exit;
    MemTable.DisableControls;
    MemTable.Open;
   for I := 0 to ListView1.Items.Count-1 do
   begin
          A_ID:= ListView1.Items.Item[i].SubItems[0];
          A_VALUE_ID:=ListView1.Items.Item[i].SubItems[1];
          A_VALUE:=ListView1.Items.Item[i].Caption;
          A_JSON:=ListView1.Items.Item[i].SubItems[2];;
      if ListView1.Items.Item[i].Checked then
         begin
           // showmessage(ATTIBUTE_ID);
            if not  MemTable.Locate('GOODS_ID; ATTIBUTE_ID; ATTIBUTE_VALUE_ID', VarArrayOf([GId,A_ID, A_VALUE_ID]),[]) then
            begin

            MemTable.Append;
            MemTable.FieldByName('GOODS_ID').AsString:= GId;
            MemTable.FieldByName('ATTIBUTE_ID').AsString:=A_ID;
            MemTable.FieldByName('ATTIBUTE_VALUE_ID').AsString:=A_VALUE_ID;
            MemTable.FieldByName('ATTIBUTE_VALUE').AsString:=A_VALUE;
            MemTable.FieldByName('JSON').AsString:=A_JSON;
            MemTable.Post;
            MemTable.EnableControls;
            end;
         end
         else
         begin
           if MemTable.Locate('GOODS_ID; ATTIBUTE_ID; ATTIBUTE_VALUE_ID', VarArrayOf([GId,A_ID, A_VALUE_ID]),[]) then
            begin
            MemTable.DisableControls;
            MemTable.Delete;
            //MemTable.ap;
            MemTable.EnableControls;
            end;
         end;
   end;
    Sql:=GetListSql();

    GetTmpSpecList(Sql);

end;

procedure TFormSelectSpec.Button2Click(Sender: TObject);
var
 ATTIBUTE_ID:integer;
begin
  ATTIBUTE_ID:= PtrInt(ListBox1.Items.Objects[ListBox1.ItemIndex]);
if Trim(Edit1.Text)= '' then Exit;
 with TrabajoQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_ATTRIBUTE_VALUE (ATTIBUTE_ID, ATTIBUTE_VALUE) VALUES(:ATTIBUTE_ID, :ATTIBUTE_VALUE) ON DUPLICATE KEY UPDATE UPDATE_TIME=now() ';
    ParamByName('ATTIBUTE_ID').AsInteger:=ATTIBUTE_ID;
    ParamByName('ATTIBUTE_VALUE').AsString:=Trim(Edit1.Text);
    ExecSql;
  end;
  SpecValuesQuery.Refresh;
 Edit1.Text:='';
 Edit1.SetFocus;
end;

procedure TFormSelectSpec.Button1Click(Sender: TObject);
begin
  if Formspec.IniciaSpecs then
  AllSpecQuery.Refresh;
end;

procedure TFormSelectSpec.Button4Click(Sender: TObject);
var
 //json:string;
  i, j, x, y: Integer;
  A_ID:String;
  s: string;
  DimValue: array of TStringArray;
  ItemValue: TStringArray;
  //t3: Tarray<string>;

  function FilterRecordCount(dataset : TDataset) : integer;
  begin
  try
    result := 0;
    dataset.disablecontrols;
    dataset.first;
    while not dataset.eof do
    begin
       result := result + 1;
       dataset.next
    end;
  finally
    dataset.enablecontrols;
  end;
  end;
begin
 setlength(DimValue, ListBox2.Count);
  for X := 0 to ListBox2.Count-1 do
  begin
   setlength(ItemValue, 0);
   MemTable.Filtered:=False;
    A_ID:=inttostr( PtrInt(ListBox2.Items.Objects[X]));
     MemTable.Filter:='ATTIBUTE_ID = '+A_ID;
     MemTable.Filtered:=True;
     j:=FilterRecordCount(MemTable);
     if J > 0 then
      begin
        setlength(ItemValue, J);
        MemTable.DisableControls;
        MemTable.First;
        { for I := 0 to MemTable.RecordCount -1 do
         begin
            ItemValue[I]:= MemTable.FieldByName('JSON').AsString;
         MemTable.Next;
         end;  }
         //while not MemTable.eof do
         for I := 0 to J -1 do
         begin
              ItemValue[I]:= MemTable.FieldByName('JSON').AsString;
              MemTable.next
         end;
      end;
     DimValue[X]:= ItemValue;
  end;
   Data:=Multicartesian(DimValue);
   close;
end;

procedure TFormSelectSpec.Button5Click(Sender: TObject);
begin
  close;
end;


procedure TFormSelectSpec.GetTmpSpecList(SqlCondicion:string);
var
I, ID:integer;
FName:string;
begin
   with MemListQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='select * from  goods_attribute_key where attibute_id in ('+SqlCondicion+') ';
    //ParamByName('condicion').AsString:= SqlCondicion;
    open;
  end;

  ListBox2.Items.Clear;
  if MemListQuery.RecordCount <> 0 then
  begin
      MemListQuery.First;
     for I := 0 to MemListQuery.RecordCount -1 do
     begin
     FName:=MemListQuery.FieldByName('name').AsString;
     ID:=MemListQuery.FieldByName('attibute_id').AsInteger;
     ListBox2.AddItem(FName, TObject(PtrInt(ID)));
     MemListQuery.Next;
     end;
  end;
end;


procedure TFormSelectSpec.GetCategoryActualSpec(Category_id:integer);
var
 i, n:integer;
 str:string;
 spec_name:string;
begin
 // SL.Clear;
  with ListUniQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT T3.attibute_id, T3.name FROM CategorysTree as T1 '
              +'INNER JOIN categorys_attribute AS T2 ON T2.CATEGORY_ID = T1.ancestor '
              +'left join goods_attribute_key as T3 on T2.attibute_id = T3.attibute_id '
              +'WHERE descendant=:descendant ';
    ParamByName('descendant').AsInteger:= Category_id;
    open;
  end;

  if ListUniQuery.RecordCount <> 0 then
  begin
    ListUniQuery.First;
     for I := 0 to ListUniQuery.RecordCount -1 do
     begin
     str:=ListUniQuery.FieldByName('name').AsString;
   //  SL.Values[ListUniQuery.FieldByName('attibute_id').AsString]:=str;
     ListBox1.AddItem(str, TObject( PtrInt(ListUniQuery.FieldByName('attibute_id').AsInteger)));
     ListUniQuery.Next;
     end;
  end;


end;

procedure TFormSelectSpec.GetSpecsValues(Specs_id: integer);
var
  I, n: Integer;
  Item: TListItem;
  spec_id, V:integer;
begin
    ListView1.Items.Clear;
    with SpecValuesQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    Sql.Text:='SELECT T1.ID, T1.ATTIBUTE_ID, T1.ATTIBUTE_VALUE,  T2.NAME, '
              +'concat(''"'', T2.Name, ''":"'', T1.ATTIBUTE_VALUE, ''"'') as Json FROM GOODS_ATTRIBUTE_VALUE as T1 '
              +'left join GOODS_ATTRIBUTE_key as T2 '
              +'on T1.ATTIBUTE_ID = T2.ATTIBUTE_ID WHERE T1.ATTIBUTE_ID=:ATTIBUTE_ID ORDER BY ID ';
    ParamByName('ATTIBUTE_ID').AsInteger:= Specs_id;
    open;
  end;
   if SpecValuesQuery.RecordCount <> 0 then
  begin
    SpecValuesQuery.First;
    ListView1.Items.BeginUpdate;
  try
    for I := 0 to SpecValuesQuery.RecordCount-1 do
      begin
        Item:= ListView1.Items.Add;
        Item.Caption:= SpecValuesQuery.FieldByName('ATTIBUTE_VALUE').AsString;
        Item.SubItems.Add(SpecValuesQuery.FieldByName('ATTIBUTE_ID').AsString);
        Item.SubItems.Add(SpecValuesQuery.FieldByName('ID').AsString);
        Item.SubItems.Add(SpecValuesQuery.FieldByName('JSON').AsString);
        SpecValuesQuery.Next;
      end;
  finally
    ListView1.Items.EndUpdate;
  end;
  end;
  if MemTable.RecordCount > 0 then
  begin
      MemTable.First;
     for I := 0 to MemTable.RecordCount -1 do
     begin
     spec_id:=MemTable.FieldByName('ATTIBUTE_VALUE_ID').AsInteger;
      for n := 0 to ListView1.Items.Count-1 do
        begin
        V:=strtoint(ListView1.Items.Item[n].SubItems[1]);
          if (V = spec_id )  then
          ListView1.Items[n].Checked:=True;
        end;
     MemTable.Next;
     end;
  end;
end;

procedure TFormSelectSpec.GetAllSpec();
var
  i:integer;
  str: string;
begin
  with AllSpecQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    Sql.Text:='select * from  goods_attribute_key';
    open;
  end;
  ListBox3.Items.Clear;
  if AllSpecQuery.RecordCount <> 0 then
  begin
    AllSpecQuery.First;
     for I := 0 to AllSpecQuery.RecordCount -1 do
     begin
     str:=AllSpecQuery.FieldByName('name').AsString;
   //  SL.Values[ListUniQuery.FieldByName('attibute_id').AsString]:=str;
     ListBox3.AddItem(str, TObject( PtrInt(AllSpecQuery.FieldByName('attibute_id').AsInteger)));
     AllSpecQuery.Next;
     end;
  end;
end;


end.

