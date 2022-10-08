unit category_frmDlgCaption;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmDlgCapt = class(TForm)
    Label1: TLabel;
    edtCaption: TEdit;
    Label2: TLabel;
    Description: TEdit;
    Panel1: TPanel;
    bitbtnOK: TBitBtn;
    bitbtnCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure bitbtnOKClick(Sender: TObject);
    procedure bitbtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   function Iniciar(title:string; var Name, Descri: string):boolean;
  end;
  procedure ShowfrmDlgCaption(Cp, E1, E2:string);

var
  frmDlgCapt: TfrmDlgCapt;
  FTitle, str1, str2:string;
  Hecho:Boolean;

implementation
procedure ShowfrmDlgCaption(Cp, E1, E2:string);
begin
  with TfrmDlgCapt.Create(Application) do
    begin
      Caption:=Cp;
      if FTitle='修改' then
      begin
       // Caption:=Cp;
        edtCaption.Text:=E1;
        Description.Text:=E2;
      end;
      if FTitle='创建子分类' then
        begin
          Caption:=Cp+' | 主分类为:'+E1;
        end;
      ShowModal;
    end;
end;

{$R *.lfm}

procedure TfrmDlgCapt.bitbtnCancelClick(Sender: TObject);
begin
  Hecho:=False;
  self.close;
end;

procedure TfrmDlgCapt.bitbtnOKClick(Sender: TObject);
begin
  if Trim(edtCaption.Text)='' then Hecho:=False
  else
  begin
  str1:=Trim(edtCaption.Text);
  str2:=Description.Text;
  Hecho:=True;
  end;
  self.Close;
end;

procedure TfrmDlgCapt.FormCreate(Sender: TObject);
begin
  //frmDlgCapt.Caption:= FTitle;
  Hecho:=False;
end;

function TfrmDlgCapt.Iniciar(title:string;  var Name, Descri: string):boolean;
begin
   FTitle:=title;
   if (title='Edit') or (title='Hijo') then
   begin
   if (title='Edit') then
     FTitle:='修改' else FTitle:='创建子分类';
     str1:=Name;
     Str2:=Descri;
     ShowfrmDlgCaption(Ftitle, str1, str2);
   end
   else
   begin
    Name:='';
    Descri:='';
    ShowfrmDlgCaption(title, '', '');
   end;

   Name:=Str1;
   Descri:=Str2;
   result:=Hecho;
end;

end.
