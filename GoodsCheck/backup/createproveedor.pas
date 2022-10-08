unit CreateProveedor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBCtrls, EditBtn, ZDataset, LCLType;

type

  { TNewProvForm }

  TNewProvForm = class(TForm)
    ActiveBox: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DateAdd: TDateEdit;
    DBCompra: TZQuery;
    DBCompraDS: TDataSource;
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
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    EditCodigo: TEdit;
    EmTypeDataSource: TDataSource;
    EmTypeUniQuery: TZQuery;
    GuardarQuery: TZQuery;
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
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ProveedorQuery: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DateAddKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit11KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit13KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit14KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit15KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit16KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit17KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit18KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit19KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit20KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit21KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit22KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit3Change(Sender: TObject);
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
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetMasIdofProveedor(): integer;
    procedure GetEmType(Sender: TObject);
  private

  public

  end;

var
  NewProvForm: TNewProvForm;
  NewId: integer;

implementation
uses
  connect,  Global, Proveedor;

{$R *.lfm}

{ TNewProvForm }

function TNewProvForm.GetMasIdofProveedor(): integer;
var
  maxId:integer;
begin
maxId:=0;
   with ProveedorQuery do
  begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='select MAX(ID) as ID FROM '+EmID+'PROVEEDORLIST ';
     Open;
  end;
   if ProveedorQuery.RecordCount > 0 then
   begin
   maxId:=ProveedorQuery.FieldByName('ID').AsInteger;
   end;
   result:=maxId;

end;

procedure TNewProvForm.GetEmType(Sender: TObject);
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

procedure TNewProvForm.Button3Click(Sender: TObject);
begin
  
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


FormProveedor.Resultado:=1;
FormProveedor.ProveedorQuery.Refresh;
showmessage('保存成功');

 //EditCodigo.ReadOnly:=True;


end;

procedure TNewProvForm.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TNewProvForm.Button2Click(Sender: TObject);
begin
  EditCodigo.Text:='';
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
  Edit17.Text:='';
  Edit18.Text:='';
  Edit19.Text:='';
  Edit20.Text:='';
end;

procedure TNewProvForm.DateAddKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit11KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit13KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit14KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit15KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit16KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit17KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit18KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit19KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit20KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit21KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit22KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit3Change(Sender: TObject);
begin

end;

procedure TNewProvForm.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.Edit9KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.EditCodigoExit(Sender: TObject);
begin
   if Trim(EditCodigo.Text)='' then exit;
   with ProveedorQuery do
  begin
    Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
     SQL.Text:='select * from '+EmID+'PROVEEDORLIST  WHERE 1=1 and ID_PROVEEDOR=:ID_PROVEEDOR order by ID_PROVEEDOR ';
     ParamByName('ID_PROVEEDOR').AsString:=EditCodigo.Text;
     Open;
  end;
   if ProveedorQuery.RecordCount > 0 then
   begin
   // EditCodigo.Text:=ProveedorQuery.FieldByName('ID_PROVEEDOR').Value;
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

   end;
   DBLookupComboBox1.SetFocus;
end;

procedure TNewProvForm.EditCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_Return then SelectNext(ActiveControl,True,True);
end;

procedure TNewProvForm.FormCreate(Sender: TObject);
begin
   NewId:=GetMasIdofProveedor();
   EditCodigo.Text:=IntToStr(NewID);
    GetEmType(self);
end;

procedure TNewProvForm.FormShow(Sender: TObject);
begin
  EditCodigo.SetFocus;
end;


end.

