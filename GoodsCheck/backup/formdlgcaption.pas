unit formdlgcaption; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons;

type

  { TfrmDlgCaption }

  TfrmDlgCaption = class(TForm)
    bitbtnOK: TBitBtn;
    bitbtnCancel: TBitBtn;
    Description: TEdit;
    edtCaption: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    pnlButtons: TPanel;
    procedure bitbtnCancelClick(Sender: TObject);
    procedure bitbtnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }

  end; 

var
  frmDlgCaption: TfrmDlgCaption;

implementation

{$R *.lfm}

{ TfrmDlgCaption }

procedure TfrmDlgCaption.FormShow(Sender: TObject);
begin
   edtCaption.SetFocus;
end;

procedure TfrmDlgCaption.bitbtnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDlgCaption.bitbtnCancelClick(Sender: TObject);
begin

end;

end.

