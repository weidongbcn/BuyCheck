unit categorys_spec_values;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids, ZDataset, connect, LCLType, DBCtrls,
   Global;

type

  { TFormCategorySpec }

  TFormCategorySpec = class(TForm)
    Button1: TButton;
    Button3: TButton;
    ButtonNew: TButton;
    SpecDS: TDataSource;
    CategorySpecDS: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    MemListQuery: TZQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    CategorySpecQuery: TZQuery;
    SpecQuery: TZQuery;
    TrabajoQuery: TZQuery;
    procedure GetCategoryActualSpec;
    procedure GetAllSpec;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  function iniciarspec(Category_id:integer; Category:string):boolean;
  end;
  procedure ShowCategorySpec;

var
  FormCategorySpec: TFormCategorySpec;
  Cid:integer;
  Cname:string;

implementation
uses
  specification;

{$R *.lfm}

{ TFormCategorySpec }

procedure ShowCategorySpec;
begin
  with TFormCategorySpec.Create(Application) do
    begin
      caption:=Cname;
      Label2.Caption:='正在作业=> 分类编号:'+ inttostr(Cid)+', 名称:'+Cname;
      ShowModal;
    end;
end;

function TFormCategorySpec.iniciarspec(Category_id:integer; Category:string):boolean;
begin
  Cid:=Category_id;
   Cname:=Category;
  ShowCategorySpec;
end;

procedure TFormCategorySpec.GetCategoryActualSpec;
begin
  with CategorySpecQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT T3.attibute_id, T3.name FROM CategorysTree as T1 '
              +'INNER JOIN categorys_attribute AS T2 ON T2.CATEGORY_ID = T1.ancestor '
              +'left join goods_attribute_key as T3 on T2.attibute_id = T3.attibute_id '
              +'WHERE descendant=:descendant ';
    ParamByName('descendant').AsInteger:= Cid;
    Open;
  end;
end;

procedure TFormCategorySpec.GetAllSpec;
begin
    with SpecQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='select * from goods_attribute_key ';
    open;
  end;
end;

procedure TFormCategorySpec.Button1Click(Sender: TObject);
begin
  
if CategorySpecQuery.Locate('attibute_id',SpecQuery.fieldbyname('ATTIBUTE_ID').AsInteger,[]) then
begin
  showmessage('属性已经存在.');
  exit;
end;

 with TrabajoQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='insert into categorys_attribute (CATEGORY_ID, attibute_id) '
          +'value (:CATEGORY_ID, :attibute_id) '
          +'ON DUPLICATE KEY UPDATE attibute_id=:attibute_id';
    ParamByName('CATEGORY_ID').AsInteger:= Cid;
    ParamByName('attibute_id').AsInteger:= SpecQuery.fieldbyname('ATTIBUTE_ID').AsInteger;
    ExecSQL;
  end;
  showmessage('添加成功.');
  CategorySpecQuery.Refresh;
end;

procedure TFormCategorySpec.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TFormCategorySpec.ButtonNewClick(Sender: TObject);
begin
    if Formspec.IniciaSpecs then
  begin
    SpecQuery.Refresh;
  end;
end;

procedure TFormCategorySpec.FormCreate(Sender: TObject);
begin
  GetCategoryActualSpec;
GetAllSpec;
end;

end.

