unit skuslist;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ComCtrls, Math,LCLType,
  DBGrids, DBCtrls, rxcurredit, ZDataset,  Global, connect;

type

  { TFormGoodsSkuList }

  TFormGoodsSkuList = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DataPanel: TPanel;
    DBCost: TCurrencyEdit;
    DBDISCOUNT: TCurrencyEdit;
    DBGrid2: TDBGrid;
    DBLOWPRICE: TCurrencyEdit;
    DBPvP1c: TCurrencyEdit;
    DBPvP2c: TCurrencyEdit;
    DBPvP3c: TCurrencyEdit;
    dbTrabajo: TZQuery;
    DBWHOLESALE: TCurrencyEdit;
    DSSkus: TDataSource;
    DBGoodsSkuQuery: TZQuery;
    CentrePanel: TPanel;
    Edit4: TEdit;
    ENAEdit: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label38: TLabel;
    Label43: TLabel;
    Label58: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LowLimit: TCurrencyEdit;
    NameEdit: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BasePanel: TPanel;
    Panel4: TPanel;
    Panel8: TPanel;
    ScrollBox1: TScrollBox;
    SpecValuesQuery: TZQuery;
    SpuSpecQuery: TZQuery;
    SwitchPanel: TPanel;
    TitilePanel: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Reset();
  private
    procedure ListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
    Procedure GetSpuSpecs(aGoods_id:String);
    procedure  CreatingListView(Spec_name:string; Spec_id:integer);
    procedure GetGoodsSpuDetail(GoodsId:string);
    Function FindValueExists(ids: string): Boolean;
  public
     function IniciarSkuList(GoodsDataset:TZQuery):boolean;
  end;

var
  FormGoodsSkuList: TFormGoodsSkuList;
  GOODS_ID:STRING;
  StockAviso:boolean;
  i,j,m,n,p, x, k, y, o:Integer;
  GoodsDS: TZQuery;
  rec: integer; //用于记录TGroupBox次数

  procedure ShowFormGoodsSkuList(GoodsDataset:TZQuery);


implementation

{$R *.lfm}

procedure ShowFormGoodsSkuList(GoodsDataset:TZQuery);
begin
  with TFormGoodsSkuList.Create(Application) do
    begin
      GOODS_ID:=GoodsDataset.FieldByName('GOODS_ID').AsString;
      GoodsDS:=GoodsDataset;
      ENAEdit.Text:= GoodsDataset.FieldByName('ENA').AsString;
      NameEdit.Text:= GoodsDataset.FieldByName('GOODS_NAME').AsString;
      Edit4.Text:=formatfloat('#,##0.00',  GoodsDataset.FieldByName('Points').AsFloat);
      DBCost.Value:=GoodsDataset.FieldByName('COST').Value;
      DBPvP1c.Value:=GoodsDataset.FieldByName('PVP1C').Value;
      DBPvP2c.Value:=GoodsDataset.FieldByName('PVP2C').Value;
      DBPvP3c.Value:=GoodsDataset.FieldByName('PVP3C').Value;
      DBLOWPRICE.Value:=GoodsDataset.FieldByName('LOWPRICE').Value;
      DBWHOLESALE.Value:=GoodsDataset.FieldByName('WHOLESALE').Value;
      DBDISCOUNT.Value:=GoodsDataset.FieldByName('DISCOUNT').Value;
      StockAviso:=GoodsDataset.FieldByName('STOCKAVISO').AsBoolean;
      ShowModal;
    end;
end;


{ TFormGoodsSkuList }

function TFormGoodsSkuList.IniciarSkuList(GoodsDataset:TZQuery):boolean;
begin
  ShowFormGoodsSkuList(GoodsDataset);
  result:= True;
end;

procedure TFormGoodsSkuList.Reset();
var
  i, j, x, y: Integer;
 ListView: TListView;
 Item: TListItem;
 gb: TGroupBox;
begin
  ENAEdit.Text:= GoodsDS.FieldByName('ENA').AsString;
  NameEdit.Text:= GoodsDS.FieldByName('GOODS_NAME').AsString;
  Edit4.Text:=formatfloat('#,##0.00',  GoodsDS.FieldByName('Points').AsFloat);
  DBCost.Value:=GoodsDS.FieldByName('COST').Value;
  DBPvP1c.Value:=GoodsDS.FieldByName('PVP1C').Value;
  DBPvP2c.Value:=GoodsDS.FieldByName('PVP2C').Value;
  DBPvP3c.Value:=GoodsDS.FieldByName('PVP3C').Value;
  DBLOWPRICE.Value:=GoodsDS.FieldByName('LOWPRICE').Value;
  DBWHOLESALE.Value:=GoodsDS.FieldByName('WHOLESALE').Value;
  DBDISCOUNT.Value:=GoodsDS.FieldByName('DISCOUNT').Value;
  StockAviso:=GoodsDS.FieldByName('STOCKAVISO').AsBoolean;
  for i:= 0 to ScrollBox1.ControlCount -1 do
  begin
   if ScrollBox1.Controls[i] is TGroupBox  then
   begin
      gb:=TGroupBox(ScrollBox1.Controls[i]);
       for j:=0 to gb.ControlCount -1 do
       begin
        if gb.Controls[j] is TListView then
        begin
         ListView:= TListView(gb.Controls[j]);
          for x:=0 to ListView.Items.Count -1 do
          begin
          Item:=ListView.Items[x];
          Item.Checked:=False;
          end;
        end;
       end;
   end;
 end;
end;

procedure TFormGoodsSkuList.Button1Click(Sender: TObject);
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

  if (jsonStr = '') or (selectedIds = '') then
  exit;
  if FindValueExists(selectedIds) then
  begin
   showmessage('属性商品已经存在');
   exit;
  end;
  jsonStr := '{'+jsonStr+'}';

  with dbTrabajo do
  begin
    Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO GOODS_SKU (SKU_NO, SKU_NAME, ATTIBUTE_VALUE_IDS, COST, SELLING_P1C, SELLING_P2C, SELLING_P3C, LOWPRICE, WHOLESALE, DISCOUNT, GOODS_ID, SKU_CODING, ISCHILD, STOCKAVISO,LOWLIMIT, CAN_DISCount, Points ) '
        +'VALUES (UUID(), :SKU_NAME, :ATTIBUTE_VALUE_IDS, :COST, :SELLING_P1C, :SELLING_P2C, :SELLING_P3C, :LOWPRICE, :WHOLESALE, :DISCOUNT, :GOODS_ID, :SKU_CODING, :ISCHILD, :STOCKAVISO, :LOWLIMIT, :CAN_DISCount, :Points )'
        +'ON DUPLICATE KEY UPDATE '
        +'COST=:COST, SELLING_P1C=:SELLING_P1C, SELLING_P2C=:SELLING_P2C, SELLING_P3C=:SELLING_P3C, LOWPRICE=:LOWPRICE, WHOLESALE=:WHOLESALE, DISCOUNT=:DISCOUNT, ISCHILD=:ISCHILD, '
        +'STOCKAVISO=:STOCKAVISO, LOWLIMIT=:LOWLIMIT, CAN_DISCount=:CAN_DISCount, Points=:Points ';
        ParamByName('SKU_NAME').AsString:=jsonStr;
        ParamByName('ATTIBUTE_VALUE_IDS').AsString:=selectedIds;
        ParamByName('COST').AsCurrency:=DBCost.Value;
        ParamByName('SELLING_P1C').AsCurrency:=DBPvP1c.Value;
        ParamByName('SELLING_P2C').AsCurrency:=DBPvP2c.Value;
        ParamByName('SELLING_P3C').AsCurrency:=DBPvP3c.Value;
        ParamByName('LOWPRICE').AsCurrency:=DBLOWPRICE.Value;
        ParamByName('WHOLESALE').AsCurrency:=DBWHOLESALE.Value;
        ParamByName('DISCOUNT').AsFloat:=DBDISCOUNT.Value;
        ParamByName('GOODS_ID').AsString:=GOODS_ID;
        ParamByName('SKU_CODING').AsString:='';
        ParamByName('ISCHILD').AsInteger:=1;
        ParamByName('STOCKAVISO').AsInteger:=0;
        ParamByName('LOWLIMIT').AsFloat:=LowLimit.Value;
        ParamByName('CAN_DISCount').AsInteger:=0;
        ParamByName('Points').AsFloat:=strtofloat(Trim(Edit4.Text));
        ExecSQL;
  end;
  DBGoodsSkuQuery.Refresh;
  Reset();

end;

procedure TFormGoodsSkuList.Button2Click(Sender: TObject);
begin
  if DBGoodsSkuQuery.FieldByName('STOCK').AsInteger <> 0 then
  showmessage('库存没有清零不能删除');
  if Application.MessageBox('删除数据责任巨大且不可恢复, 您确认删除选中的信息吗？', '提示', MB_ICONINFORMATION + MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then
  begin
       DBGoodsSkuQuery.Edit;
       DBGoodsSkuQuery.Delete;
  end;

end;

procedure TFormGoodsSkuList.Button3Click(Sender: TObject);
begin
  DBGoodsSkuQuery.Refresh;
end;

procedure TFormGoodsSkuList.Button4Click(Sender: TObject);
begin
  if DBGrid2.DataSource.DataSet.Modified then
  DBGrid2.DataSource.DataSet.Post;
end;

procedure TFormGoodsSkuList.Button5Click(Sender: TObject);
begin
  close;
end;

procedure TFormGoodsSkuList.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);

begin

end;

procedure TFormGoodsSkuList.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
var
 i,j,m, x:Integer;
 Gb :TGroupBox;
 Gbs: array of TGroupBox;
 LVs: array of TListView;
begin
  CanClose:=False;
  //关闭之前清理内存
 j:=0;
  DBGoodsSkuQuery.Close;
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

procedure TFormGoodsSkuList.FormCreate(Sender: TObject);
begin

end;

procedure TFormGoodsSkuList.FormShow(Sender: TObject);
begin
     m := 0;
 n := 0;
 p := 0;
  GetSpuSpecs(GOODS_ID);
  GetGoodsSpuDetail(GOODS_ID);

end;

Function  TFormGoodsSkuList.FindValueExists(ids: string): Boolean;
begin
   Result := DBGoodsSkuQuery.Locate('ATTIBUTE_VALUE_IDS', ids, []);
end;

Procedure TFormGoodsSkuList.GetSpuSpecs(aGoods_id:String );
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

procedure  TFormGoodsSkuList.CreatingListView(Spec_name:string; Spec_id:integer);
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
 inc(rec);
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



procedure TFormGoodsSkuList.ListViewChange(Sender: TObject; Item: TListItem;
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

procedure TFormGoodsSkuList.GetGoodsSpuDetail(GoodsId:string);
 begin
    with DBGoodsSkuQuery do
    begin
       Connection:=DataModule2.ZCon1;
       Active:=false;
       SQL.Clear;
      SQL.Text:='SELECT * FROM GOODS_SKU WHERE GOODS_ID =:GOODS_ID ';
       ParamByName('GOODS_ID').AsString:=GOODS_ID;
       OPEN;
    end;
 end;

end.

