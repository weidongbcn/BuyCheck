unit WorkStation;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, LCLType,
  StdCtrls, DBGrids, ComCtrls, Buttons, Menus, ZDataset,StockActual, md5, Grids, create;

type

  { TFormWork }

  TFormWork = class(TForm)
    Button3: TButton;
    Button4: TButton;
    CategoryButton: TSpeedButton;
    CheckButton: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    ButtonNew: TButton;
    CheckButton1: TSpeedButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DocumentoButton: TSpeedButton;
    CaducaButton: TSpeedButton;
    DocumentoButton1: TSpeedButton;
    HisBuyButton1: TSpeedButton;
    f1: TMenuItem;
    HisBuyButton: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DelZQuery: TZQuery;
    LabelButton: TSpeedButton;
    MainPanel: TPanel;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N19: TMenuItem;
    NewGoodsButton: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Register: TSpeedButton;
    ScrollBox1: TScrollBox;
    StatusBar: TStatusBar;
    StoreButton: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    ListZQuery: TZQuery;
    GoodsButton: TSpeedButton;
    QuitButton: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    AlmacenButton: TSpeedButton;
    ProveedorButton: TSpeedButton;
    StoreButton1: TSpeedButton;
    StoreButton2: TSpeedButton;
    XPDemoButton: TSpeedButton;
    ExcelButton: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ButtonNewClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure LabelButtonClick(Sender: TObject);
    procedure DocumentoButtonClick(Sender: TObject);
    procedure ExcelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure NewGoodsButtonClick(Sender: TObject);
    procedure ProveedorButtonClick(Sender: TObject);
    procedure QuitButtonClick(Sender: TObject);
    procedure DemoButtonClick(Sender: TObject);
    procedure RegisterClick(Sender: TObject);
    procedure StoreButton1Click(Sender: TObject);
    procedure StoreButton2Click(Sender: TObject);
  private
    procedure GetListDB;
  public

  end;

var
  FormWork: TFormWork;
  Resultado: variant;
  Forma_Read:string;

implementation
uses
  connect,U_Conn_Indy, Global, Uloginmain, Checkdb, ReadDBfile,  addgoods, Proveedor, BuyIn01, buyin02, Inventory, BuyListCheck, Categorys_Spec,
  GoodsFromProv, FindoutGoodsInPro, His_Goods_Buy, his_buys, ABOUT, EtiquetasArticulos, cleardb, caduca;

{$R *.lfm}

{ TFormWork }

//----------------------------------------------------------------------------------------------------------------------

procedure TFormWork.DemoButtonClick(Sender: TObject);

// This method is a kind of scheduler. Here we switch between the demo forms.

var
  NewDemoClass: TFormClass;
  NewDemo: TForm;

begin
  case (Sender as TSpeedButton).Tag of
    0:
      NewDemoClass := nil; //仓库;
    1:
      NewDemoClass := TFormCategorys;
    2:
      NewDemoClass := TFormGoodsSpu;
    3:
      NewDemoClass := TFormProveedor;
    5:
      NewDemoClass := TForm_His_BuyFromProveedor;    //  购买历史
    6:
      NewDemoClass := TFormStock; //库存;
    7:
      NewDemoClass := TFormInventory; //盘点
    8:
      NewDemoClass := nil;
    9:
      NewDemoClass := TFormProGoods;
    10:
      NewDemoClass := TGoodsFromProveedor;
    11:
      NewDemoClass := TListCaducacionForm;
  else
    NewDemoClass := nil;
  end;
  if Assigned(NewDemoClass) then
  begin
  NewDemo := NewDemoClass.Create(Self);
      NewDemo.Showmodal;
      NewDemo.Free;

  end;

  //if (ContainerPanel.ControlCount = 0) or not (ContainerPanel.Controls[0] is NewDemoClass) then
 // begin
 //   if ContainerPanel.ControlCount > 0 then
 //     ContainerPanel.Controls[0].Free;

 //   if Assigned(NewDemoClass) then
 //   begin
 //     NewDemo := NewDemoClass.Create(Self);
     // NewDemo.Hide;
     // NewDemo.BorderStyle := bsNone;
     // NewDemo.Parent := ContainerPanel;
   //   NewDemo.Align := alClient;
    //  NewDemo.Show;
    //  NewDemo.Free;
  //  end;
 // end;
end;

procedure TFormWork.RegisterClick(Sender: TObject);
begin
  AboutBox:=TAboutBox.Create(self);
  AboutBox.ShowModal;
  AboutBox.Free;
end;

procedure TFormWork.StoreButton1Click(Sender: TObject);
var
  key:string;
begin
   key := PasswordBox(nMSG15,'');
   if key = '' then
   begin
     showmessage(nMSG12);
     exit;
   end;
   if MD5Print(MD5String(key)) <> passwordhash then
   begin
     showmessage(nMSG16);
     exit;
   end;
  ClearDbForm:=TClearDbForm.Create(self);
  ClearDbForm.ShowModal;
  ClearDbForm.Free;
end;

procedure TFormWork.StoreButton2Click(Sender: TObject);
begin
  FormGoodsBuyHis:= TFormGoodsBuyHis.Create(self);
  FormGoodsBuyHis.ShowModal;
  FormGoodsBuyHis.Free;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TFormWork.GetListDB;
var
i:integer;
s1,s2:string;
begin
//showmessage(UseDBC.EmID);
  with ListZQuery do
begin
  Connection:=DataModule2.ZCon1; //UniConnection1;
  Active:=False;
  {SELECT T1.ID_TMPLIST, T1.ID_PROVEEDOR, T1.NAME_PROVEEDOR, T1.DOCUMENT, T1.N_DOCUMENT, T1.STAFF, T1.READ_COL, T1.FECHA_C, T1.FECHA_I,
T1.EMPLEADO, T1.ISIVAINCLUIDO, T1.ISREQINCLUIDO, T1.ISCHECKED, T1.ID_STOCK, IF(T1.ISIVAINCLUIDO='Y', SUM(T2.UNIDAD*T2.PRECIO_CON*(1-T2.DISCOUNT/100)),
            SUM(T2.UNIDAD*T2.PRECIO_SIN*(1-T2.DISCOUNT/100))) AS UTOTAL FROM CHECKLIST_ORDERS AS T1
            LEFT JOIN checklist_items AS T2 ON T1.ID_TMPLIST = T2.ID_TMPLIST GROUP BY T1.ID_TMPLIST order by T1.ID_TMPLIST desc ;
            }
  s1:='SELECT A.ID_TMPLIST as ID_TMPLIST, A.ID_PROVEEDOR as ID_PROVEEDOR, A.NAME_PROVEEDOR as NAME_PROVEEDOR, '
           +'A.DOCUMENT as DOCUMENT, A.N_DOCUMENT as N_DOCUMENT, A.READ_COL, A.FECHA_C, '
            +'A.FECHA_I, A.EMPLEADO, A.ISIVAINCLUIDO, A.ISREQINCLUIDO, A.ISCHECKED, A.ID_STOCK, '
            +'IF(A.ISIVAINCLUIDO=''Y'', SUM(AMOUNT*PRECIO_CON*(1-DISCOUNT/100)), '
            +'SUM(AMOUNT*PRECIO_SIN*(1-DISCOUNT/100))) AS UTOTAL ' ;
         s2:='FROM CHECKLIST_ORDERS A,CHECKLIST_ITEMS B '
            +'WHERE B.ID_TMPLIST=A.ID_TMPLIST '
            +'GROUP BY A.ID_TMPLIST order by A.ID_TMPLIST desc ';
  SQL.Text:=s1+s2;

  Open;
end;
//TFloatField(ListZQuery.FieldByName('UTOTAL')).DisplayFormat := '0.000';

end;

procedure TFormWork.ButtonNewClick(Sender: TObject);
begin
  FormImportXLS:= TFormImportXLS.Create(self);
  FormImportXLS.ShowModal;
  FormImportXLS.Free;
  ListZQuery.Refresh;
end;

procedure TFormWork.DBGrid1DblClick(Sender: TObject);
begin
 Button1.Click;
end;

procedure TFormWork.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_RETURN then
  begin
   key:=0;
   Button1.Click;

  end;
end;

procedure TFormWork.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
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

  { if ([gdSelected, gdFocused] * AState <> []) and (DBGrid1.SelectedColumn = Column) then
  begin
    DBGrid1.Canvas.Brush.Color := clRed;
    DBGrid1.Canvas.Font.Color := clWhite;

  end;  }
    if ([gdSelected] * AState <> []) then
  begin
    DBGrid1.Canvas.Brush.color := clBlack; //当前行以黑色显示
    DBGrid1.Canvas.pen.mode := pmmask;
  end;

end;
end;

procedure TFormWork.LabelButtonClick(Sender: TObject);
begin
  FormEtiPEs:= TFormEtiPEs.Create(self);
  FormEtiPEs.ShowModal;
  FormEtiPEs.Free;
end;

procedure TFormWork.DocumentoButtonClick(Sender: TObject);
begin
   {FormBuyIn02:= TFormBuyIn02.Create(self);
  FormBuyIn02.ShowModal;
  FormBuyIn02.Free;
  ListZQuery.Refresh;   }
  FormBuyIn:= TFormBuyIn.Create(self);
  FormBuyIn.ShowModal;
  FormBuyIn.Free;
  ListZQuery.Refresh;
end;

procedure TFormWork.ExcelButtonClick(Sender: TObject);
begin
  ButtonNew.Click;
end;

procedure TFormWork.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  DMindy.IdTCPClient1.Disconnect;
  sleep(10);
  //DMindy.Mt.Terminate;
  //DMindy.Mt.FreeInstance;
end;

FUNCTION GetTmpLists(DB: TDBGrid):TStringArray;
var
 i, b: integer;
 Readtipo: string;
begin
  Forma_Read:='';
  if DB.SelectedRows.Count <= 0 then
  begin
    SetLength(result, 1);
    result[0]:='-1';
  end
  else
  begin
    b:=0;
    SetLength(result, DB.SelectedRows.Count+1);

  with DB.DataSource.DataSet do
    begin
      for i:=1 to DB.SelectedRows.Count do
       begin
         gotobookmark(Pointer(DB.SelectedRows.Items[i-1]));
         if i=1 then
         begin
         Forma_Read:=DB.DataSource.DataSet.FieldByName('READ_COL').AsString;
         result[i]:=DB.DataSource.DataSet.FieldByName('ID_TMPLIST').AsString;
         b:=b+1;
         end
         else if Forma_Read=DB.DataSource.DataSet.FieldByName('READ_COL').AsString then
         begin
         b:=b+1;
         result[b]:=DB.DataSource.DataSet.FieldByName('ID_TMPLIST').AsString;

         end;
       end;
    end;
  end;
  result[0]:=inttostr(b);

end;

procedure TFormWork.Button1Click(Sender: TObject);
var
  itemstr: string;
  i, x: integer;
  lists: TStringArray;
begin
 { with dbgrid1.DataSource.DataSet do
    begin
    first;
    while not eof do
    begin
    dbgrid1.SelectedRows.CurrentRowSelected:=true;
    next;
    end;
    end;   }
 {  itemstr:='';
   with DBGrid1.DataSource.DataSet do
    begin
  for i:=0 to DBGrid1.SelectedRows.Count-1 do
  begin
    gotobookmark(Pointer(DBGrid1.SelectedRows.Items[i]));
    itemstr:=itemstr+DBGrid1.DataSource.DataSet.FieldByName('ID_PROVEEDOR').AsString+' ';
  end;
  showmessage(itemstr);

    end;  }
  if dbgrid1.SelectedRows.Count <= 0 then
  begin
  showmessage(nMSG9);
   exit;
   end;
   lists:=GetTmpLists(dbgrid1);
   if not Form1.IniciaDB(Forma_Read, lists) then showmessage('Load data failed.');;
   ListZQuery.Refresh;

   {i:=strtoint(lists[0]);
   if i <= 0 then exit;
   for x:=1 to i do
    begin
    showmessage(lists[x]);
    end;  }

end;

procedure TFormWork.Button2Click(Sender: TObject);
begin
  {FormCategory:=TFormCategory.Create(self);
  FormCategory.ShowModal;
  FormCategory.Free; }

  {FormStock:= TFormStock.Create(self);
  FormStock.ShowModal;
  FormStock.Free; }

  FormProGoods:= TFormProGoods.Create(self);
  FormProGoods.ShowModal;
  FormProGoods.Free;
end;

procedure TFormWork.Button3Click(Sender: TObject);
begin
  FormBuyIn:= TFormBuyIn.Create(self);
  FormBuyIn.ShowModal;
  FormBuyIn.Free;
  ListZQuery.Refresh;
end;

procedure TFormWork.Button4Click(Sender: TObject);
begin
  FAddGoods:= TFAddGoods.Create(self);
  FAddGoods.ShowModal;
  FAddGoods.Free;
end;

procedure TFormWork.FormCreate(Sender: TObject);
begin
  GetListDB;
end;

procedure TFormWork.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_F6)  then
  begin
   key:=0;
   FormGoodsBuyHis:= TFormGoodsBuyHis.Create(self);
  FormGoodsBuyHis.ShowModal;
  FormGoodsBuyHis.Free;
  End;

  if key=VK_F3 then
  OpenCashEspon;

  if key=VK_F4 then
  AbirCajon();
end;

procedure TFormWork.FormShow(Sender: TObject);
begin
  DBGrid1.SetFocus;
   DBGrid1.SelectedRows.CurrentRowSelected := true;
end;

procedure TFormWork.N13Click(Sender: TObject);
var
  i, x: integer;
  lists: TStringArray;
begin
  if dbgrid1.SelectedRows.Count <= 0 then
  begin
  showmessage(nMSG9);
   exit;
   end;
  ID_TMPLIST:=ListZQuery.fieldbyname('ID_TMPLIST').asstring;
  with DelZQuery do
  begin
   Connection:=DataModule2.ZCon1;; //UniConnection1;
  Active:=False;
  SQL.Text:='DELETE FROM checklist_orders '
       +'WHERE 1=1 '
    +'AND ID_TMPLIST=:ID_TMPLIST ';
     ParamByName('ID_TMPLIST').AsString:=ID_TMPLIST;
    ExecSQL;
  Active:=false;
    sql.Clear;
    sql.Text:='DELETE FROM CHECKLIST_ITEMS '
    +'WHERE 1=1 '
    +'AND ID_TMPLIST=:ID_TMPLIST ';
     ParamByName('ID_TMPLIST').AsString:=ACheckDoc.ID_TMPLIST;
     ExecSQL;
     ShowMessage('删除成功.');
  end;

  ListZQuery.Refresh;
end;

procedure TFormWork.NewGoodsButtonClick(Sender: TObject);
begin
  FAddGoods:=TFAddGoods.Create(self);
  FAddGoods.ShowModal;
  FAddGoods.Free;
end;

procedure TFormWork.ProveedorButtonClick(Sender: TObject);
begin
  FormProveedor:=TFormProveedor.Create(self);
  FormProveedor.ShowModal;
  FormProveedor.Free;
end;

procedure TFormWork.QuitButtonClick(Sender: TObject);
begin
   Close;
end;

end.

