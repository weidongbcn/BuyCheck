unit Proveedor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, DbCtrls, EditBtn, Buttons, DBGrids, VirtualTrees,
  Variants,LCLType,
  DefaultTranslator, LResources,
  virtualdbtreeex, ZDataset, ZConnection;

type

  { TFormProveedor }

  TFormProveedor = class(TForm)
    ActiveBox: TCheckBox;
    BitBtn14: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    Button7: TButton;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    DBCompraDS: TDataSource;
    DBGrid3: TDBGrid;
    EmTypeDataSource: TDataSource;
    DateAdd: TDateEdit;
    DateDesde: TDateEdit;
    DateHasta: TDateEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit2: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit45: TEdit;
    Edit46: TEdit;
    Edit47: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    EditCodigo: TEdit;
    EmTypeUniQuery: TZQuery;
    DBCompra: TZQuery;
    Label1: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label5: TLabel;
    Label57: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    ListBox5: TListBox;
    Memo1: TMemo;
    ModeView: TComboBox;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    ProveedorDB: TDataSource;
    ProveedorQuery: TZQuery;
    GuardarQuery: TZQuery;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    VirtualDBTreeEx1: TVirtualDBTreeEx;

    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure DateAddKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid3DblClick(Sender: TObject);
    procedure DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit10KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit11KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit12KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit13Change(Sender: TObject);
    procedure Edit14KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure Edit15KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit17KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit18KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit19KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit20KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit21KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit22KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit5KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit6KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit7KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit8KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit9KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditCodigoExit(Sender: TObject);
    procedure EditCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ModeViewChange(Sender: TObject);
    procedure VirtualDBTreeEx1Click(Sender: TObject);
    procedure GetEmType(Sender: TObject);
    procedure GetHistoricoDeCompra(IDProveedor:string; Date1,Date2:Tdatetime);
    procedure clear;
    procedure  GetProveedor();
  private

  public
    function IniciaMExcute(dbTable: string) : integer;

   end;
   procedure ShowFormProveedor;

var
      FormProveedor: TFormProveedor;
      Resultado: variant;
      NewItem:boolean;
      yearstring:string;
      myDate : TDateTime;

implementation

uses
   connect,  Global;

    {$R *.lfm}

{ TFormProveedor }

procedure ShowFormProveedor;
begin
  with TFormProveedor.Create(Application) do
    begin
      ShowModal;
    end;
end;

{ TFormProveedor }
procedure TFormProveedor.GetEmType(Sender: TObject);
begin
   with EmTypeUniQuery do
  begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT * FROM '+EmID+'TYPE_EMPRESA';
     Open;
     if RecordCount>0 then
      begin
        DBLookupComboBox1.KeyValue:=DBLookupComboBox1.ListSource.DataSet.FieldValues[DBLookupComboBox1.keyfield];

      end;
  end;
end;
procedure TFormProveedor.clear;
begin
 // EditCodigo.Text:='';
     // DBLookupComboBox1.KeyValue:=UpperCase(ProveedorQuery.FieldByName('TYPE_EM').AsString);
      Edit1.Text:='';
      Edit2.Text:='';
      Edit3.Text:='';
      Edit4.Text:='';
      Edit5.Text:='';
      Edit6.Text:='';
      Edit7.Text:='';
      Edit8.Text:='';
      Edit9.Text:='';
      Edit10.Text:='';
      Edit11.Text:='';
      Edit12.Text:='';
      Edit13.Text:='';
      Edit14.Text:='';
      Edit15.Text:='';
      Edit16.Text:='';
      ActiveBox.Checked:=true;
      DateAdd.Date:= now();
      Edit17.Text:='';
      Edit18.Text:='';
      Edit19.Text:='';
      Edit20.Text:='';
      Edit21.Text:='';
      Edit22.Text:='';
      MEMO1.Lines.Clear;
      PageControl1.Pages[0].Show;
     // EditCodigo.ReadOnly:=true;
end;


procedure TFormProveedor.FormCreate(Sender: TObject);
begin

end;

procedure TFormProveedor.FormShow(Sender: TObject);
begin
{   if not ProveedorQuery.IsEmpty  then
 begin
   VirtualDBTreeEx1.OnClick(self);
   end;
 }
    DateAdd.Date:=Now();
 Datedesde.Date:=MyDate;
 DateHasta.Date:=Now();
  Resultado:=0;
  ModeView.Clear;
  ModeView.Items.Add(nList1);
  ModeView.Items.Add(nList2);
  ModeView.Items.Add(nList3);
  ModeView.ItemIndex:=0;
{ ProveedorQuery.Connection:=DataModule2.ZCon1;
  ProveedorQuery.Active:=False;
  ProveedorQuery.SQL.Clear;
  proveedorQuery.SQL.Add('select * from '+EmID+'PROVEEDORLIST  WHERE 1=1 order by ID_PROVEEDOR ');
  ProveedorQuery.Active:=True;   }
  GetEmType(self);
  GetProveedor();

end;

procedure  TFormProveedor.GetProveedor();
begin
    with ProveedorQuery do
  begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='select * from '+EmID+'PROVEEDORLIST  WHERE 1=1 order by ID_PROVEEDOR ';
     Open;

  end;

    ModeViewChange(self);
   // VirtualDBTreeEx1.DataSource:=ProveedorDB;
end;

procedure TFormProveedor.ModeViewChange(Sender: TObject);
begin
  case ModeView.ItemIndex of
   0:
   begin
    VirtualDBTreeEx1.ViewFieldName:='NAME_COMERCIO';
    DBGrid3.Columns[2].Visible:=true;
    DBGrid3.Columns[0].Visible:=False;
    DBGrid3.Columns[1].Visible:=False;
   end;
   1:
   begin
    VirtualDBTreeEx1.ViewFieldName:='NAME_EMPRESA';
    DBGrid3.Columns[1].Visible:=true;
    DBGrid3.Columns[2].Visible:=False;
    DBGrid3.Columns[0].Visible:=False;
   end;
    2:
   begin
    VirtualDBTreeEx1.ViewFieldName:='ID_PROVEEDOR';
    DBGrid3.Columns[0].Visible:=true;
    DBGrid3.Columns[1].Visible:=False;
    DBGrid3.Columns[2].Visible:=False;
   end;
end;

end;

procedure TFormProveedor.VirtualDBTreeEx1Click(Sender: TObject);
begin
      EditCodigo.Text:=ProveedorQuery.FieldByName('ID_PROVEEDOR').Value;
      DBLookupComboBox1.KeyValue:=UpperCase(ProveedorQuery.FieldByName('TYPE_EM').AsString);
      Edit1.Text:=ProveedorQuery.FieldByName('NAME_COMERCIO').AsString;
      Edit2.Text:=ProveedorQuery.FieldByName('NAME_EMPRESA').AsString;
      Edit3.Text:=ProveedorQuery.FieldByName('CIF').AsString;
      Edit4.Text:=ProveedorQuery.FieldByName('IDENTIFICATIONNIF').AsString;
      Edit5.Text:=ProveedorQuery.FieldByName('DIRECCION').AsString;
      Edit6.Text:=ProveedorQuery.FieldByName('POSTAL').AsString;
      Edit7.Text:=ProveedorQuery.FieldByName('CIUDAD').AsString;
      Edit8.Text:=ProveedorQuery.FieldByName('PROVINCIA').AsString;
      Edit9.Text:=ProveedorQuery.FieldByName('PAIS').AsString;
      Edit10.Text:=ProveedorQuery.FieldByName('TEL1').AsString;
      Edit11.Text:=ProveedorQuery.FieldByName('TEL2').AsString;
      Edit12.Text:=ProveedorQuery.FieldByName('MOVIL').AsString;
      Edit13.Text:=ProveedorQuery.FieldByName('FAX').AsString;
      Edit14.Text:=ProveedorQuery.FieldByName('EMAIL').AsString;
      Edit15.Text:=ProveedorQuery.FieldByName('WEB').AsString;
      Edit16.Text:=ProveedorQuery.FieldByName('CONTACTO').AsString;
      ActiveBox.Checked:=ProveedorQuery.FieldByName('ACTIVA').AsBoolean;
      DateAdd.Date:= ProveedorQuery.FieldByName('ADD_FECHA').AsDateTime;
      Edit17.Text:=ProveedorQuery.FieldByName('WECHAT').AsString;
      Edit18.Text:=ProveedorQuery.FieldByName('MY_ID').AsString;
      Edit19.Text:=ProveedorQuery.FieldByName('MY_NUMTARJETA').AsString;
      Edit20.Text:=ProveedorQuery.FieldByName('NAME_BANCO').AsString;
      Edit21.Text:=ProveedorQuery.FieldByName('CUENTA').AsString;
      Edit22.Text:=ProveedorQuery.FieldByName('TITULAR').AsString;
      MEMO1.Text:=ProveedorQuery.FieldByName('NOTA').AsString;
      PageControl1.Pages[0].Show;
      NewItem:=False;
    //  EditCodigo.ReadOnly:=True;
      GetHistoricoDeCompra(editCodigo.Text, myDate, now());
end;

procedure TFormProveedor.GetHistoricoDeCompra(IDProveedor:string; Date1,Date2:Tdatetime);
begin

    WITH DBCompra DO                             //GetBayIDDatos
  BEGIN
   Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='SELECT * FROM BUY_HISTORY '
    +' WHERE 1=1 '
    +'AND ID_TIENDA='''+EmID+''' '
    //+'AND YEAR(BUYDATE)=YEAR(NOW()) '
    +'AND DATE(BUYDATE)>=:FECHA1 '
    +'AND DATE(BUYDATE)<=:FECHA2 '
    +'AND ID_PROVEEDOR=:ID_PROVEEDOR ';

    ParamByName('FECHA1').AsDate:=date1;
    ParamByName('FECHA2').AsDate:=date2;
    ParamByName('ID_PROVEEDOR').AsString:=IDProveedor;
    Active:=true;
  END;
end;

procedure TFormProveedor.Button1Click(Sender: TObject);
begin

  close;
end;

procedure TFormProveedor.Button3Click(Sender: TObject);
begin
  if not PageControl1.Pages[0].Showing then Exit;


if Trim(EditCodigo.Text)='' then
begin
ShowMessage('没有什么可以删除的. No hay nada para eliminar!');
EditCodigo.Focused;
Exit;
end;

if DBLookupComboBox1.KeyValue=null then
begin
  DBLookupComboBox1.SetFocus;
  Exit;
end;


if Trim(Edit1.Text)='' then
begin
Edit1.SetFocus;
Exit;
end;

with GuardarQuery do
 begin
     Close;
     Connection:=DataModule2.ZCon1;
     SQL.Clear;
     //if newClienteItem then
     SQL.Text:='INSERT into '+EmID+'proveedorlist '
     +'(ID_PROVEEDOR, NAME_COMERCIO, NAME_EMPRESA, CIF, IDENTIFICATIONNIF, '
     +'DIRECCION, POSTAL, CIUDAD, PROVINCIA, PAIS, TEL1, TEL2, MOVIL, FAX, EMAIL, '
     +'TYPE_EM, WEB, CONTACTO, MY_ID, MY_NUMTARJETA, NAME_BANCO, CUENTA, NOTA, '
     +' ADD_FECHA, ACTIVA, TITULAR, WECHAT ) '
     +'values (:ID_PROVEEDOR, :NAME_COMERCIO, :NAME_EMPRESA, :CIF, :IDENTIFICATIONNIF, '
     +':DIRECCION, :POSTAL, :CIUDAD, :PROVINCIA, :PAIS, :TEL1, :TEL2, :MOVIL, :FAX, :EMAIL, '
     +':TYPE_EM, :WEB, :CONTACTO, :MY_ID, :MY_NUMTARJETA, :NAME_BANCO, :CUENTA, :NOTA, '
     +' :ADD_FECHA, :ACTIVA, :TITULAR, :WECHAT ) '
      +'ON DUPLICATE KEY UPDATE '
      +'NAME_COMERCIO=:NAME_COMERCIO, NAME_EMPRESA=:NAME_EMPRESA, CIF=:CIF, IDENTIFICATIONNIF=:IDENTIFICATIONNIF, '
     +'DIRECCION=:DIRECCION, POSTAL=:POSTAL, CIUDAD=:CIUDAD, PROVINCIA=:PROVINCIA, PAIS=:PAIS, TEL1=:TEL1, TEL2=:TEL2, MOVIL=:MOVIL, FAX=:FAX, EMAIL=:EMAIL, '
     +'TYPE_EM=:TYPE_EM, WEB=:WEB, CONTACTO=:CONTACTO, MY_ID=:MY_ID, MY_NUMTARJETA=:MY_NUMTARJETA, NAME_BANCO=:NAME_BANCO, CUENTA=:CUENTA, NOTA=:NOTA, '
     +' ADD_FECHA=:ADD_FECHA, ACTIVA=:ACTIVA, TITULAR=:TITULAR, WECHAT=:WECHAT ' ;
     ParamByName('ID_PROVEEDOR').AsString:=EditCodigo.Text;
     ParamByName('TYPE_EM').AsString:=DBLookupComboBox1.KeyValue;
     ParamByName('NAME_COMERCIO').AsString:=Edit1.Text;
     ParamByName('NAME_EMPRESA').AsString:=Edit2.Text;
     ParamByName('CIF').AsString:=Edit3.Text;
     ParamByName('IDENTIFICATIONNIF').AsString:=Edit4.Text;
     ParamByName('DIRECCION').AsString:=Edit5.Text;
     ParamByName('POSTAL').AsString:=Edit6.Text;
     ParamByName('CIUDAD').AsString:=Edit7.Text;
     ParamByName('PROVINCIA').AsString:=Edit8.Text;
     ParamByName('PAIS').AsString:=Edit9.Text;
     ParamByName('TEL1').AsString:=Edit10.Text;
     ParamByName('TEL2').AsString:=Edit11.Text;
     ParamByName('MOVIL').AsString:=Edit12.Text;
     ParamByName('FAX').AsString:=Edit13.Text;
     ParamByName('EMAIL').AsString:=Edit14.Text;
     ParamByName('WEB').AsString:=Edit15.Text;
     ParamByName('CONTACTO').AsString:=Edit16.Text;
     ParamByName('WECHAT').AsString:=Edit17.Text;
     ParamByName('MY_ID').AsString:=Edit18.Text;
     ParamByName('MY_NUMTARJETA').AsString:=Edit19.Text;
     ParamByName('NAME_BANCO').AsString:=Edit20.Text;
     ParamByName('CUENTA').AsString:=Edit21.Text;
     ParamByName('TITULAR').AsString:=Edit22.Text;
     ParamByName('NOTA').AsString:=memo1.Lines.Text;
     if ActiveBox.Checked then
     ParamByName('ACTIVA').AsString:='1' else
     ParamByName('ACTIVA').AsString:='0';
     ParamByName('ADD_FECHA').AsDate:=DateAdd.Date;
     ExecSQL;
 end;

 ProveedorQuery.Refresh;
 NewItem:=False;
 //EditCodigo.ReadOnly:=True;

  Resultado:=1;
end;

procedure TFormProveedor.Button6Click(Sender: TObject);
begin
EditCodigo.Text:='';
  clear;
NewItem:=True;
//EditCodigo.ReadOnly:=False;
EditCodigo.SetFocus;
end;

procedure TFormProveedor.DateAddKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.DBGrid3DblClick(Sender: TObject);
begin
   EditCodigo.Text:=ProveedorQuery.FieldByName('ID_PROVEEDOR').Value;
      DBLookupComboBox1.KeyValue:=UpperCase(ProveedorQuery.FieldByName('TYPE_EM').AsString);
      Edit1.Text:=ProveedorQuery.FieldByName('NAME_COMERCIO').AsString;
      Edit2.Text:=ProveedorQuery.FieldByName('NAME_EMPRESA').AsString;
      Edit3.Text:=ProveedorQuery.FieldByName('CIF').AsString;
      Edit4.Text:=ProveedorQuery.FieldByName('IDENTIFICATIONNIF').AsString;
      Edit5.Text:=ProveedorQuery.FieldByName('DIRECCION').AsString;
      Edit6.Text:=ProveedorQuery.FieldByName('POSTAL').AsString;
      Edit7.Text:=ProveedorQuery.FieldByName('CIUDAD').AsString;
      Edit8.Text:=ProveedorQuery.FieldByName('PROVINCIA').AsString;
      Edit9.Text:=ProveedorQuery.FieldByName('PAIS').AsString;
      Edit10.Text:=ProveedorQuery.FieldByName('TEL1').AsString;
      Edit11.Text:=ProveedorQuery.FieldByName('TEL2').AsString;
      Edit12.Text:=ProveedorQuery.FieldByName('MOVIL').AsString;
      Edit13.Text:=ProveedorQuery.FieldByName('FAX').AsString;
      Edit14.Text:=ProveedorQuery.FieldByName('EMAIL').AsString;
      Edit15.Text:=ProveedorQuery.FieldByName('WEB').AsString;
      Edit16.Text:=ProveedorQuery.FieldByName('CONTACTO').AsString;
      ActiveBox.Checked:=ProveedorQuery.FieldByName('ACTIVA').AsBoolean;
      DateAdd.Date:= ProveedorQuery.FieldByName('ADD_FECHA').AsDateTime;
      Edit17.Text:=ProveedorQuery.FieldByName('WECHAT').AsString;
      Edit18.Text:=ProveedorQuery.FieldByName('MY_ID').AsString;
      Edit19.Text:=ProveedorQuery.FieldByName('MY_NUMTARJETA').AsString;
      Edit20.Text:=ProveedorQuery.FieldByName('NAME_BANCO').AsString;
      Edit21.Text:=ProveedorQuery.FieldByName('CUENTA').AsString;
      Edit22.Text:=ProveedorQuery.FieldByName('TITULAR').AsString;
      MEMO1.Text:=ProveedorQuery.FieldByName('NOTA').AsString;
      PageControl1.Pages[0].Show;
      NewItem:=False;
    //  EditCodigo.ReadOnly:=True;
      GetHistoricoDeCompra(editCodigo.Text, myDate, now());
end;

procedure TFormProveedor.DBLookupComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit10KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit11KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit12KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit13Change(Sender: TObject);
begin

end;

procedure TFormProveedor.Edit14KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;



procedure TFormProveedor.Edit17KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit18KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit19KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;



procedure TFormProveedor.Edit21KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit22KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.Edit9KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;



procedure TFormProveedor.Edit20KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;


procedure TFormProveedor.Edit15KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;



procedure TFormProveedor.EditCodigoExit(Sender: TObject);
begin
  if Trim(EditCodigo.Text)='' then exit;
//if NewItem then
  begin
  if ProveedorQuery.Locate('ID_PROVEEDOR', EditCodigo.Text, [] ) then
    begin
      //showmessage(nMSN82);
      VirtualDBTreeEx1.OnClick(self);
      NewItem:=False;
     EditCodigo.SetFocus;
    end
    else
    begin
     clear;;
     NewItem:=True;
     DBLookupComboBox1.SetFocus;
    end;
  end;
end;

procedure TFormProveedor.EditCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TFormProveedor.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
   ProveedorQuery.Close;
end;

function TFormProveedor.IniciaMExcute(dbTable: string): integer;
begin
   ShowFormProveedor;

  result:= Resultado;
end;

end.

