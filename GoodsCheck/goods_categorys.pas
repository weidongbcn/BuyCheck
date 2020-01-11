unit Goods_Categorys;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  virtualdbtreeex, ZDataset, LCLType,  connect,
   Global;

type

  { TFormCategory }

  TFormCategory = class(TForm)
    btnApply: TButton;
    btnDelete: TButton;
    btnEdit: TButton;
    btnMove: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    categDataSource: TDataSource;
    dbCategory: TZQuery;
    Panel1: TPanel;
    ProveedorDB: TDataSource;
    VirtualDBTreeEx1: TVirtualDBTreeEx;
    procedure btnApplyClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnMoveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GetCATEGORIAS;
    procedure Button3Click(Sender: TObject);
  private

  public

   function IniciaCategory(): Boolean;
  end;
   procedure ShowFormCategory;

var
  FormCategory: TFormCategory;
  Hecho: Boolean;

implementation
uses
  formdlgcaption;


{$R *.lfm}

{ TFormCategory }

procedure ShowFormCategory;
begin
  with TFormCategory.Create(Application) do
    begin
      ShowModal;
    end;
end;

function TFormCategory.IniciaCategory(): Boolean;
begin
  ShowFormCategory;
  result:=Hecho;
end;

procedure TFormCategory.GetCATEGORIAS;
begin
  with dbCategory do
  begin
  Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
    sql.Text:='SELECT * FROM CATEGORYS';
     Open;
  end;
end;

procedure TFormCategory.FormCreate(Sender: TObject);
begin
  Hecho:=False;
  GetCATEGORIAS;
end;

procedure TFormCategory.Button1Click(Sender: TObject);
var
  nodeCaption, Description : String;
begin
  nodeCaption := '';

  frmDlgCaption.Caption := nCaption3;
  frmDlgCaption.edtCaption.Text := '';
  frmDlgCaption.Description.Text:= '';
  frmDlgCaption.ShowModal;

  if frmDlgCaption.ModalResult = mrOK then
     begin
       nodeCaption := frmDlgCaption.edtCaption.Text;
       Description := frmDlgCaption.Description.Text;
       if Assigned(VirtualDBTreeEx1) then
          begin
           // VirtualDBTreeEx1.Items.AddNewChild(VirtualDBTreeEx1.Selected,nodeCaption);

           dbCategory.Insert;
           dbCategory.FieldByName('CATEGORY').AsString:=nodeCaption;
           dbCategory.FieldByName('DESCRIPCION').AsString:=Description;
           dbCategory.FieldByName('Parent_ID').AsInteger:=dbCategory.FieldByName('ID').AsInteger;
           dbCategory.Post;
          end
      // else //VirtualDBTreeEx1.Items.AddNewChild(nil,nodeCaption);
        else ShowMessage(nMSG8);

     end;

     Hecho:=True;
end;

procedure TFormCategory.btnEditClick(Sender: TObject);

  var
  Description : String;
begin
  if Assigned(VirtualDBTreeEx1) then
     begin
       frmDlgCaption.Caption := nCaption5;
       Description:=VirtualDBTreeEx1.DataSource.DataSet.FieldByName('Descripcion').AsString;
       frmDlgCaption.edtCaption.Text := dbCategory.FieldByName('CATEGORY').AsString; //VirtualDBTreeEx1.Selected.Text;
       frmDlgCaption.Description.Text:= Description;
       frmDlgCaption.ShowModal;
       if frmDlgCaption.ModalResult = mrOK then
          begin
            VirtualDBTreeEx1.DataSource.DataSet.Edit;
            VirtualDBTreeEx1.DataSource.DataSet.FieldByName('CATEGORY').AsString :=
              frmDlgCaption.edtCaption.Text;
            VirtualDBTreeEx1.DataSource.DataSet.FieldByName('DESCRIPCION').AsString :=
              frmDlgCaption.Description.Text;

            VirtualDBTreeEx1.DataSource.DataSet.Post;
          end;
       Hecho:=True;
     end
  else ShowMessage('You should select a node first!');
end;

procedure TFormCategory.btnMoveClick(Sender: TObject);
  var
    ParentID, Code : Integer;
  begin
    //需要重写/
    if Assigned(VirtualDBTreeEx1) then
       begin
         frmDlgCaption.Caption := 'Enter Parent ID';
         frmDlgCaption.edtCaption.Text := '';
         //frmDlgCaption.Description.Text:= '';
         frmDlgCaption.ShowModal;
         if frmDlgCaption.ModalResult = mrOK then
            begin
              val(frmDlgCaption.edtCaption.Text, ParentID, Code);
              if Code = 0 then
                 begin
                   VirtualDBTreeEx1.DataSource.DataSet.Edit;
                   VirtualDBTreeEx1.DataSource.DataSet.FieldByName('Parent_ID').AsInteger := ParentID;
                 end
              else ShowMessage('Invalid number!');
            end;
       end;
end;

procedure TFormCategory.btnDeleteClick(Sender: TObject);
begin
   if Assigned(VirtualDBTreeEx1) then
     begin
       //VirtualDBTreeEx1.Selected.Delete;
       Hecho:=True;
     end;
end;

procedure TFormCategory.btnApplyClick(Sender: TObject);
begin
  dbCategory.ApplyUpdates;
  Hecho:=True;
end;

procedure TFormCategory.Button2Click(Sender: TObject);
var
  nodeCaption, Description : String;
begin
  nodeCaption := '';
  frmDlgCaption.Caption := nCaption4;
  frmDlgCaption.edtCaption.Text := '';
  frmDlgCaption.Description.Text:= '';
  frmDlgCaption.ShowModal;

  if frmDlgCaption.ModalResult = mrOK then
     begin
       nodeCaption := frmDlgCaption.edtCaption.Text;
       Description := frmDlgCaption.Description.Text;
       begin
         dbCategory.Insert;
           dbCategory.FieldByName('CATEGORY').AsString:=nodeCaption;
           dbCategory.FieldByName('Descripcion').AsString:=Description;
           dbCategory.FieldByName('Parent_ID').AsInteger:=0;
           dbCategory.Post;
           Hecho:=True;
       end;
     end;
end;

procedure TFormCategory.Button3Click(Sender: TObject);
begin
  Close;
end;

end.

