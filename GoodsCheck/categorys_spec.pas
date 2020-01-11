unit Categorys_Spec;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBGrids, ExtCtrls,
  StdCtrls, ZDataset,  connect, LCLType,
   Global;

type

  { TFormCategorys }

  TFormCategorys = class(TForm)
    btnDelete: TButton;
    btnEdit: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CategoryDS: TDataSource;
    CategoryQuery: TZQuery;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    SpecQuery: TZQuery;
    TrabajoQuery: TZQuery;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CategoryQueryAfterScroll(DataSet: TDataSet);
    procedure CrearLevel0(Category, Conception: string);
    procedure CrearChild(Category, Conception: string; P:integer);
    procedure FormCreate(Sender: TObject);
    procedure Modificar(Category, Conception: string; ID: INTEGER);
    procedure GetParentSpecs(Category_id: integer);
    procedure DoDelete(Category_id: INTEGER);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure GetAllCategorys;
  private

  public
     function IniciaCategory(): Boolean;
  end;

var
  FormCategorys: TFormCategorys;
  Hecho:Boolean;

implementation
uses
  categorys_spec_values, category_frmDlgCaption;

procedure ShowFormCategorys;
begin
  with TFormCategorys.Create(Application) do
    begin
      ShowModal;
    end;
end;

{$R *.lfm}

{ TFormCategorys }

function TFormCategorys.IniciaCategory(): Boolean;
begin
  Hecho:=False;
  ShowFormCategorys;
  result:=Hecho;
end;

procedure TFormCategorys.Button3Click(Sender: TObject);
var
Category_id:integer;
Category:string;
begin
  Category_id:= CategoryQuery.FieldByName('ID').AsInteger;
  Category:=CategoryQuery.FieldByName('CATEGORY').AsString;
 if FormCategorySpec.iniciarspec(Category_id, Category) then
   CategoryQuery.Refresh;
end;

procedure TFormCategorys.CrearLevel0(Category, Conception: string);
var
Category_id:integer;
begin
  with TrabajoQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO CATEGORYS(CATEGORY, DESCRIPCION, parent_id) '
              +'VALUE (:CATEGORY, :DESCRIPCION, 0)';
    ParamByName('CATEGORY').AsString:= Category;
    ParamByName('DESCRIPCION').AsString:= Conception;
    ExecSQL;
    SQL.Clear;
    SQL.Text:='select LAST_INSERT_ID() as lastid';
    open;
    Category_id:=FieldByName('lastid').AsInteger;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO CATEGORYSTREE(DESCENDANT, ANCESTOR,  DISTANCE) '   //本类ID, 父级ID, 距离
          +'VALUE(:DESCENDANT, :ANCESTOR, 0) ';
    ParamByName('DESCENDANT').AsInteger:= Category_id;
    ParamByName('ANCESTOR').AsInteger:= Category_id;
    ExecSQL;
  end;
end;

procedure TFormCategorys.Button1Click(Sender: TObject);
VAR
  STR1, STR2: STRING;
begin
 //frmDlgCaption.Iniciar('建新主分类', str1, str2);
   if frmDlgCapt.Iniciar('建新主分类', str1, str2) then
   BEGIN
     CrearLevel0(str1, str2);
     CategoryQuery.Refresh;
     Hecho:=True;
   END;
end;

procedure TFormCategorys.Button4Click(Sender: TObject);
begin
  close;
end;

procedure TFormCategorys.CategoryQueryAfterScroll(DataSet: TDataSet);
begin
  GetParentSpecs(CategoryQuery.FieldByName('ID').AsInteger);
end;

procedure TFormCategorys.btnEditClick(Sender: TObject);
VAR
  STR1, STR2: STRING;
  Category_id:integer;
begin
  Category_id:= CategoryQuery.FieldByName('ID').AsInteger;
  str1:= CategoryQuery.FieldByName('CATEGORY').AsString;
  str2:= CategoryQuery.FieldByName('DESCRIPCION').AsString;
   if frmDlgCapt.Iniciar('Edit', str1, str2) then
   BEGIN
     Modificar(str1, str2, Category_id);
     CategoryQuery.Refresh;
     Hecho:=True;
   END;
end;

procedure TFormCategorys.btnDeleteClick(Sender: TObject);
VAR
  STR1, STR2: STRING;
  Category_id:integer;
begin
  Category_id:= CategoryQuery.FieldByName('ID').AsInteger;
  str1:= CategoryQuery.FieldByName('CATEGORY').AsString;
  str2:= CategoryQuery.FieldByName('DESCRIPCION').AsString;
  DoDelete(Category_id);
  CategoryQuery.Refresh;
  SHOWMESSAGE(STR1+':'+STR2+': 删除成功.');
  hecho:=True;
end;

procedure TFormCategorys.Button2Click(Sender: TObject);
VAR
  STR1, STR2: STRING;
  parent_id:integer;
begin
  str1:= CategoryQuery.FieldByName('CATEGORY').AsString;
  if frmDlgCapt.Iniciar('Hijo', str1, str2) then
   BEGIN
    parent_id:= CategoryQuery.FieldByName('ID').AsInteger;

     CrearChild(str1, str2, parent_id);
     CategoryQuery.Refresh;
     hecho:=true;
   END;
end;


procedure TFormCategorys.CrearChild(Category, Conception: string; P:integer);
var
Category_id:integer;
begin
   //insert into CategorysTree(descendant, ancestor,  distance) VALUE(12, 12, 0);
//#SELECT 12 AS DESCENDANT,  ancestor,  distance+1 FROM CategorysTree WHERE DESCENDANT=9;
  with TrabajoQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO CATEGORYS(CATEGORY, DESCRIPCION, parent_id) '
              +'VALUE (:CATEGORY, :DESCRIPCION, :Parent_ID)';
    ParamByName('CATEGORY').AsString:= Category;
    ParamByName('DESCRIPCION').AsString:= Conception;
    ParamByName('Parent_ID').AsInteger:=P ;
    ExecSQL;
    SQL.Clear;
    SQL.Text:='select LAST_INSERT_ID() as lastid';
    open;
    Category_id:=FieldByName('lastid').AsInteger;
    Active:=false;
    SQL.Clear;
    sql.Text:='INSERT INTO CATEGORYSTREE(DESCENDANT, ANCESTOR,  DISTANCE) '   //本类ID, 父级ID, 距离
          +'VALUE(:DESCENDANT, :ANCESTOR, :DISTANCE) ';
    ParamByName('DESCENDANT').AsInteger:= Category_id;
    ParamByName('ANCESTOR').AsInteger:= Category_id;
    ParamByName('DISTANCE').AsInteger:= 0;
    ExecSQL;
    SQL.Clear;
    sql.Text:='INSERT INTO CATEGORYSTREE(DESCENDANT, ANCESTOR,  DISTANCE) '
            +'SELECT :CATEGORY_ID AS DESCENDANT,  ANCESTOR,  DISTANCE+1 FROM CATEGORYSTREE WHERE DESCENDANT=:PARENT_ID ';
     ParamByName('CATEGORY_ID').AsInteger:= Category_id;
     ParamByName('PARENT_ID').AsInteger:= P;
      ExecSQL;
      ////
      ///  INSERT INTO CATEGORYSTREE ( descendant, ancestor, distance)
      ///  SELECT '插入ID', t.ancestor,  t.distance+1
      //// FROM CATEGORYSTREE AS t
      ///// WHERE t.descendant = '父级ID'
    ////UNION ALL
    /////SELECT '插入ID', '插入ID', 0;
////////////////////////////
  end;
end;

procedure TFormCategorys.FormCreate(Sender: TObject);
begin
  GetAllCategorys;
end;

procedure TFormCategorys.GetParentSpecs(Category_id: integer);
begin
    with SpecQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT GROUP_CONCAT(T3.NAME) as SPEC FROM CATEGORYSTREE AS T1 '
            +'LEFT JOIN CATEGORYS_ATTRIBUTE AS T2 ON T2.CATEGORY_ID = T1.ANCESTOR '
            +'LEFT JOIN GOODS_ATTRIBUTE_KEY AS T3 ON T2.ATTIBUTE_ID = T3.ATTIBUTE_ID '
//#LEFT JOIN  GOODS_ATTRIBUTE_VALUE AS T4 ON T3.ATTIBUTE_ID = T4.ATTIBUTE_ID
            +'WHERE DESCENDANT=:CATEGORY_ID ';
     ParamByName('CATEGORY_ID').AsInteger:= Category_id;
     Open;
  end;
end;

procedure TFormCategorys.Modificar(Category, Conception: string; ID: INTEGER);
var
Category_id:integer;
begin
  with TrabajoQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='UPDATE CATEGORYS SET CATEGORY=:CATEGORY, DESCRIPCION=:DESCRIPCION '
            +'WHERE 1=1 AND ID=:ID ';
    ParamByName('CATEGORY').AsString:= Category;
    ParamByName('DESCRIPCION').AsString:= Conception;
    ParamByName('ID').AsInteger:= ID;
    ExecSQL;

  end;
end;

procedure TFormCategorys.DoDelete(Category_id: INTEGER);

begin
  with TrabajoQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='DELETE FROM CATEGORYS WHERE id = :CATEGORY_ID OR id IN (SELECT DESCENDANT FROM CATEGORYSTREE WHERE ANCESTOR = :CATEGORY_ID); ';
    ParamByName('CATEGORY_ID').AsInteger:= CATEGORY_ID;
    ExecSQL;
    SQL.Clear;
    //SQL.Text:='DELETE FROM CATEGORYSTREE WHERE DESCENDANT = :CATEGORY_ID OR ANCESTOR = :CATEGORY_ID ;';
    //SQL.Text:='DELETE FROM CATEGORYSTREE WHERE descendant IN (SELECT descendant FROM CATEGORYSTREE WHERE ancestor = :CATEGORY_ID)';  //删除所有子节
      //这句不通
    SQL.Text:='DELETE FROM CATEGORYSTREE WHERE descendant IN ( '
            +'SELECT cid FROM ( SELECT t1.descendant AS cid FROM CATEGORYSTREE as t1 WHERE t1.ancestor = :CATEGORY_ID ) AS c );';
    ParamByName('CATEGORY_ID').AsInteger:= CATEGORY_ID;
    ExecSQL;
  end;
end;


procedure TFormCategorys.GetAllCategorys;
begin
with CategoryQuery do
  begin
   Connection:=DataModule2.ZCon1;
    Active:=false;
    SQL.Clear;
    sql.Text:='SELECT T1.ID, T1.parent_id, T1.CATEGORY, T1.DESCRIPCION, group_concat(T3.name) AS SPEC FROM categorys  as T1 '
          +'LEFT JOIN categorys_attribute as T2 on T1.id = T2.CATEGORY_ID '
          +'left join goods_attribute_key as T3 on T3.attibute_id= T2.attibute_id group by T1.ID;';
    Open;
  end;

end;

end.

