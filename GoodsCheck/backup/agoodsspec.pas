unit aGoodsSpec;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ZDataset,
  ComCtrls, StdCtrls, Math, Global, connect;

type

  { TSpecMatrixForm }

  TSpecMatrixForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ScrollBox1: TScrollBox;
    SpecValuesQuery: TZQuery;
    SpuSpecQuery: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
  private

    procedure ListViewChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    Procedure GetSpuSpecs(aGoods_id:String );
    procedure  CreatingListView(Spec_name:string; Spec_id:integer);

  public
    function GetMatrixValues(aGoods_id:String; out Json_Name, value_ids: string): Boolean;
  end;


  procedure ShowSpecMatrixForm;

var
  SpecMatrixForm: TSpecMatrixForm;
  GOODS_ID:STRING;
  StockAviso, Hecho:boolean;
  i,j,m,n,p, x, k, y, o:Integer;
  GoodsDS: TZQuery;
  SKU_JSON_NAME, SKU_ATTIBUTE_VALUE_IDS: string;

implementation

procedure ShowSpecMatrixForm;
begin
  with TSpecMatrixForm.Create(Application) do
    begin
      ShowModal;
    end;
end;

{$R *.lfm}

{ TSpecMatrixForm }

function TSpecMatrixForm.GetMatrixValues( aGoods_id:String; out Json_Name, value_ids: string): boolean;
begin
 //Resultado:='';
  GOODS_ID:=aGoods_id;
  ShowSpecMatrixForm;
  //SetLength(result, 2);
  Json_Name := SKU_JSON_NAME;
  value_ids := SKU_ATTIBUTE_VALUE_IDS;
  result:= Hecho;
end;
procedure TSpecMatrixForm.FormShow(Sender: TObject);
begin
  m := 0;
  n := 0;
  p := 0;
  Hecho:=False;
  GetSpuSpecs(GOODS_ID);
 // GetGoodsSpuDetail(GOODS_ID);
end;

procedure TSpecMatrixForm.Button1Click(Sender: TObject);
var
 i, j, x, y: Integer;
 ListView: TListView;
 Item: TListItem;
 selectedTitle, selectedIds:string;
 gb: TGroupBox;
 jsonStr:string;
begin
  selectedTitle:='';
  selectedIds:='';
  jsonStr:='';
  y:=0;
 for i:= 0 to ScrollBox1.ControlCount -1 do
 begin
   if ScrollBox1.Controls[i] is TGroupBox  then
   begin
      gb:=TGroupBox(ScrollBox1.Controls[i]);
       selectedTitle:='';
       for j:=0 to gb.ControlCount -1 do
       begin
        if gb.Controls[j] is TListView then
        begin
         ListView:= TListView(gb.Controls[j]);
         for x:=0 to ListView.Items.Count -1 do
         begin
          Item:=ListView.Items[x];
          if Item.Checked then
          begin
           selectedTitle:='"'+gb.Caption+'":"'+Item.Caption+'"';
            if y=0 then
            begin
            selectedIds:=Item.SubItems[0];
            jsonStr:=selectedTitle;
            end
            else
            begin
            selectedIds:=selectedIds+'_'+Item.SubItems[0];
            jsonStr:=jsonStr+','+selectedTitle;
            end;
            inc(y);
          end;
          end;
        end;
       end;
   end;
 end;
  SKU_JSON_NAME:=jsonStr;
  SKU_ATTIBUTE_VALUE_IDS:=selectedIds;
  Hecho:=True;
  Close;
end;

procedure TSpecMatrixForm.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TSpecMatrixForm.FormCloseQuery(Sender: TObject; var CanClose: boolean
  );
var
 i,j,m, x:Integer;
 Gb :TGroupBox;

begin
  CanClose:=False;
  //关闭之前清理内存
 j:=0;

  SpuSpecQuery.Close;
  SpecValuesQuery.Close;
  //SetLength(Gbs,rec);
  for i:= ScrollBox1.ControlCount -1 downto 0 do
 begin
   if ScrollBox1.Controls[i] is TGroupBox  then
   begin
    Gb := TGroupBox(ScrollBox1.Controls[i]);
    for x:=Gb.ControlCount -1 downto 0 do
    begin
      if Gb.Controls[x] is TListView then
      begin
        TListView(Gb.Controls[x]).Free;
      end;
    end;
    Gb.Free;
   end;
 end;
 // ShowMessage('释放动态创建组件！');

  CanClose:=True;

end;


Procedure TSpecMatrixForm.GetSpuSpecs(aGoods_id:String );
var
i, spec_id, n, V:integer;
str: string;
Item: TListItem;
begin
   with SpuSpecQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    Sql.Text:='SELECT T1.* FROM tpv.goods_attribute_key AS T1  '
          +'left join tpv.goods_spu_attribute as T2 '
          +'on T1.ATTIBUTE_ID = T2.ATTIBUTE_ID  '
          +'where 1 = 1 '
          +'and T2.IS_DELETE = 0 '
          +'and GOODS_ID = :GOODS_ID ';
    ParamByName('GOODS_ID').AsString:=aGoods_id;
    open;
  end;
   if SpuSpecQuery.RecordCount > 0 then
   begin
    SpuSpecQuery.First;
     for I := 0 to SpuSpecQuery.RecordCount -1 do
     begin
      CreatingListView(SpuSpecQuery.FieldByName('name').AsString, SpuSpecQuery.FieldByName('attibute_id').AsInteger);
     SpuSpecQuery.Next;
     end;


   end;
end;

procedure  TSpecMatrixForm.CreatingListView(Spec_name:string; Spec_id:integer);
var
  GroupBox: TGroupBox;
  ListView: TListView;
  Item: TListItem;
  Linea:Integer;
begin

 GroupBox:=TGroupBox.Create(ScrollBox1);
 GroupBox.Caption:=spec_Name;
 GroupBox.Parent:=ScrollBox1;
 GroupBox.Left:= 2;
 GroupBox.Top := p  + 3;
 GroupBox.Width := ScrollBox1.Width-10;

 ListView := TListView.Create(GroupBox);
 ListView.Parent:=GroupBox;
 ListView.Left:=0;
  ListView.Top:=2;
  ListView.Width:=GroupBox.Width-20;
 //ListView.Align:=alClient;
 ListView.Checkboxes:=True;
 ListView.ViewStyle:=vsSmallIcon;
 ListView.OnChange:=@ListViewChange;
 //ListView.Height := ListView1.Height;
 with SpecValuesQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    Sql.Text:='SELECT T1.ID, T1.ATTIBUTE_ID, T1.ATTIBUTE_VALUE,  T2.NAME, '
              +'concat(''"'', T2.Name, ''":"'', T1.ATTIBUTE_VALUE, ''"'') as Json FROM GOODS_ATTRIBUTE_VALUE as T1 '
              +'left join GOODS_ATTRIBUTE_key as T2 '
              +'on T1.ATTIBUTE_ID = T2.ATTIBUTE_ID WHERE T1.ATTIBUTE_ID=:ATTIBUTE_ID ORDER BY ID ';
    ParamByName('ATTIBUTE_ID').AsInteger:= Spec_id;
    open;
  end;
   if SpecValuesQuery.RecordCount <> 0 then
  begin
  Linea:= ceil(SpecValuesQuery.RecordCount/trunc((GroupBox.Width)/100));

  if Linea = 1 then
  begin
  GroupBox.Height := Linea * 30 + 30;
  ListView.Height:=Linea * 30;
  end
  else
  begin
  GroupBox.Height := Linea * 30 +30;

  ListView.Height:=Linea * 30;
  end;
    SpecValuesQuery.First;
    ListView.Items.BeginUpdate;
  try
    for I := 0 to SpecValuesQuery.RecordCount-1 do
      begin
        Item:= ListView.Items.Add;
        Item.Caption:= SpecValuesQuery.FieldByName('ATTIBUTE_VALUE').AsString;
        Item.SubItems.Add(SpecValuesQuery.FieldByName('ID').AsString);  //ATTRIBUTE_VALUE_ID 属性值编号
        Item.SubItems.Add(SpecValuesQuery.FieldByName('ATTIBUTE_ID').AsString);
        Item.SubItems.Add(SpecValuesQuery.FieldByName('JSON').AsString);

        SpecValuesQuery.Next;
      end;
  finally
    ListView.Items.EndUpdate;
  end;
  end
   else
   begin
    GroupBox.Height := 20;

   end;
   p:= p  + 3 + GroupBox.Height;

end;



procedure TSpecMatrixForm.ListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var i: integer;
  ListView:TListView;
begin
     ListView:=   TListView(Sender);
  if Item.Checked then
  begin
    for i:=0 to ListView.Items.Count-1 do
    begin
      if ListView.Items[i].Index <> Item.Index then
      begin
        ListView.Items[i].Checked:=False;
      end;
    end;
 end;

end;

end.

