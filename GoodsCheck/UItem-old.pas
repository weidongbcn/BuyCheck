unit UItem;

{$MODE Delphi}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, connect,
  LCLType,Variants, Global,
  Udata,  Buttons;

type

  { TfrmItem }

  TfrmItem = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure LabeledEdit1Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetItem(avItem: TConectItem);
    procedure GetItem(avItem: TConectItem);
  public
    { Public declarations }
    class function Execute(avData: TCollection; avIndex: LongInt): Boolean;
  end;

var
  frmItem: TfrmItem;

implementation

{$R *.lfm}

procedure TfrmItem.BitBtn1Click(Sender: TObject);
begin
if LabeledEdit1.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit2.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit3.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit4.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit5.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit6.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit7.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit8.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit9.Text='' then begin LabeledEdit8.SetFocus; exit; end;
if LabeledEdit10.Text='' then begin LabeledEdit8.SetFocus; exit; end;



end;

class function TfrmItem.Execute(avData: TCollection; avIndex: LongInt): Boolean;
begin
  with Self.Create(nil) do
    try
      if avIndex < 0 then
        Caption := '添加'
      else
        begin
          Caption := '编辑';
          SetItem(TConectItem(avData.Items[avIndex]));
        end;
      Result := (ShowModal = mrOk);
      if Result then
        if avIndex < 0 then
          GetItem(TConectItem(avData.Add))
        else
          GetItem(TConectItem(avData.Items[avIndex]));
    finally
      Destroy;
    end;
end;

procedure TfrmItem.SetItem(avItem: TConectItem);
begin
  Self.LabeledEdit1.Text := avItem.dbHost;
  Self.LabeledEdit2.Text := avItem.dbUser;
  Self.LabeledEdit3.Text := avItem.dbPasswd;
  Self.LabeledEdit4.Text := avItem.dbProtocolo;
  Self.LabeledEdit5.Text := avItem.dbDataBase;
  Self.LabeledEdit6.Text := inttostr(avItem.Port);
  Self.LabeledEdit7.Text := avItem.EMID;
  Self.LabeledEdit8.Text := avItem.PCID;
  Self.LabeledEdit9.Text := avItem.S_Server;
  Self.LabeledEdit10.Text := inttostr(avItem.S_Port);
end;

procedure TfrmItem.GetItem(avItem: TConectItem);
begin
  avItem.dbHost:=Self.LabeledEdit1.Text ;
  avItem.dbUser:= Self.LabeledEdit2.Text ;
  avItem.dbPasswd:= Self.LabeledEdit3.Text;
  avItem.dbProtocolo:= Self.LabeledEdit4.Text;
  avItem.dbDataBase:= Self.LabeledEdit5.Text;
  avItem.Port:= strtoint(Self.LabeledEdit6.Text);
  avItem.EMID:= Self.LabeledEdit7.Text;
  avItem.PCID:= Self.LabeledEdit8.Text;
  avItem.S_Server:= Self.LabeledEdit9.Text;
  avItem.S_Port:= strtoint(Self.LabeledEdit10.Text);
end;

procedure TfrmItem.LabeledEdit1Exit(Sender: TObject);
begin
LabeledEdit9.Text:=LabeledEdit1.Text;
end;

procedure TfrmItem.BitBtn2Click(Sender: TObject);
begin

end;

end.
