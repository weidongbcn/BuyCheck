unit category;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ZDataset, ZConnection, connect, ZedDBTreeView, VirtualDBGrid, Global,
  virtualghfdbtreeex, virtualdbtreeex;

type

  { TFormCategory }

  TFormCategory = class(TForm)
    btnApply: TButton;
    btnDelete: TButton;
    btnEdit: TButton;
    btnMove: TButton;
    Button1: TButton;
    Button2: TButton;
    categDataSource: TDataSource;
    dbCategory: TZQuery;
    ProveedorDB: TDataSource;
    ProveedorQuery: TZQuery;
    VirtualDBTreeEx1: TVirtualDBTreeEx;
    zdbCategorys: TZedDBTreeView;
    procedure btnApplyClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnMoveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Getcategorias;
    procedure zdbCategorysDblClick(Sender: TObject);

  private

  public

  end;

var
  FormCategory: TFormCategory;

implementation
uses
  formdlgcaption;

{$R *.lfm}

{ TFormCategory }
procedure TFormCategory.GetCATEGORIAS;
begin
 { with dbCategory do
  begin
  Connection:=DataModule2.ZCon1;
     Active:=false;
     SQL.Clear;
    // SQL.Text:='SELECT *, CONCAT(''SUB'',CA_CODIGO) AS SS FROM '+UseDBC.EmID+'CATEGORIASLIST WHERE 1=1 AND CONTRONL=''00'' ';
    // SQL.Text:='SELECT *, CONCAT(''SUB'',CA_CODIGO) AS SS FROM '+UseDBC.EmID+'CATEGORIASLIST ';  select * from 0000categorys
    sql.Text:='SELECT * FROM '+UseDBC.EmID+'CATEGORYS';
     Open;
  end;  }
end;

procedure TFormCategory.zdbCategorysDblClick(Sender: TObject);
begin
  //showmessage(zdbCategorys.Items.Item[1].Text)
end;

procedure TFormCategory.FormShow(Sender: TObject);
var
  sqltext, ss: string;
begin
  {
  +-----------+------------+---------------+--------+
| ProductID |  SaleDate  | PaymentMethod | Amount |
+-----------+------------+---------------+--------+
|         3 | 2012-02-10 | Cash          |     10 |
|         3 | 2012-02-10 | Cash          |     10 |
|         3 | 2012-02-10 | Check         |     15 |
|         3 | 2012-02-10 | Credit Card   |     25 |
|         4 | 2012-02-10 | Cash          |      5 |
|         4 | 2012-02-10 | Check         |      6 |
|         4 | 2012-02-10 | Credit Card   |      7 |
+-----------+------------+---------------+--------+
Desired Output -

  alter TABLE 0000productlist ADD column ID_CATEGORY INT;
  alter TABLE 0000STOCKGOODS ADD column ID_CATEGORY INT;
  alter TABLE 0000GOODSOFPROVEEDOR ADD column ID_CATEGORY INT;
  alter TABLE 0000REPASOLISTDETALLES ADD column ID_CATEGORY INT ;
  alter TABLE 0000REPASOLISTDETALLES ADD column `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

  alter TABLE 0000BUYLISTTOP ADD column ID_STOCK varchar(10);
  alter TABLE 0000BUYLISTDetailed ADD column `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
  alter  table 0000stockgoods change `PRO_REFERENCIA` `PRO_REFERENCIA` varchar(120) NOT NULL DEFAULT '' COMMENT '减缩码';

  DROP PROCEDURE IF EXISTS getpath;
DELIMITER $$
CREATE PROCEDURE getpath(IN cat_id INT, OUT path TEXT)
BEGIN
    DECLARE catname VARCHAR(200);
    DECLARE temppath TEXT;
    DECLARE tempparent INT;
    SET max_sp_recursion_depth = 255;
    SELECT name, parent FROM category WHERE category_id=cat_id INTO catname, tempparent;
    IF tempparent IS NULL
    THEN
        SET path = catname;
    ELSE
        CALL getpath(tempparent, temppath);
        SET path = CONCAT(temppath, '/', catname);
    END IF;
END$$
DELIMITER ;

DROP FUNCTION IF EXISTS getpath;
DELIMITER $$
CREATE FUNCTION getpath(cat_id INT) RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE res TEXT;
    CALL getpath(cat_id, res);
    RETURN res;
END$$
DELIMITER ;


根据传入id查询所有父节点的id
DROP function IF EXISTS getChildList;
DELIMITER $$
CREATE FUNCTION `getChildList`(rootId INT) RETURNS varchar(1000) CHARSET utf8
    COMMENT '这个函数用来计算所有子节点id'
BEGIN
    DECLARE sTemp VARCHAR(1000);
       DECLARE sTempChd VARCHAR(1000);

       SET sTemp = '';
       SET sTempChd =cast(rootId as CHAR);

       WHILE sTempChd is not null DO
       #判断是否是第一个，不加的话第一个会为空
       IF sTemp != '' THEN
			SET sTemp = concat(sTemp,',',sTempChd);
		ELSE
			SET sTemp = sTempChd;
		END IF;
        # SET sTemp = concat(sTemp,',',sTempChd);
         SELECT group_concat(id) INTO sTempChd FROM 0000categorys where FIND_IN_SET(parent_id,sTempChd)>0;
       END WHILE;
       RETURN sTemp;
END $$

DELIMITER ;


SELECT category_id, name, getpath(category_id) AS path FROM category;

#mysql 8.0以后的版本，获取路径
WITH RECURSIVE descendants(category_id, name, parent,  path ) AS
(
SELECT category_id, name, parent,CAST(name AS CHAR(500)) AS path
FROM category
WHERE category_id= 1
UNION ALL
SELECT t.category_id, t.name, t.parent, CONCAT(d.path, '/', t.name)
FROM descendants d, category t
WHERE t.parent=d.category_id
)
SELECT * FROM descendants ORDER BY path;

  insert into 0000categorys (name) values ('General'), ('Hogar'), ('Ferreteria'),
('Libreria'), ('Plasticos'), ('Juguetes'),('Festivo');
  ss:='#insert into 0000categorys (name, parent_id) values (''插板电线'',3),'
#('铁钉螺丝钉',3), ('锁',3),('胶带纸',3),('电视电话用品',3), ('工作手套',3),('Ollas',2),('Cuchillos',2),
#('Taza/Vasos',2), ('Nadal',7), ('Carnavas',7), ('Hallowen',7);';
  }
  {

   sqltext:='CREATE TABLE 0000CATEGORYS ( '
   +'`ID` int(11) unsigned NOT NULL AUTO_INCREMENT,'
  +'`Name` varchar(50) NOT NULL DEFAULT '''', '
  +'`DESCRIPCION` varchar(160) NOT NULL DEFAULT '''', '
  +' `Parent_id` int(11) default 0, '
  +'PRIMARY KEY (`ID`),  CONSTRAINT fk_category_parent FOREIGN KEY (parent_id) '
   +' REFERENCES category (id)) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;';


   sqltext:='DROP PROCEDURE IF EXISTS getpath; '
   +'DELIMITER $$ '
   +'CREATE PROCEDURE getpath(IN cat_id INT, OUT path TEXT)'
   +'BEGIN '
   +' DECLARE catname VARCHAR(20); '
   +' DECLARE temppath TEXT;        '
   +' DECLARE tempparent INT;       '
   +' SET max_sp_recursion_depth = 255; '
   +' SELECT name, parent_id FROM category WHERE id=cat_id INTO catname, tempparent; '
   +' IF tempparent IS NULL  '
   +' THEN '
   +'     SET path = catname;  '
   +' ELSE    '
   +'     CALL getpath(tempparent, temppath);  '
   +'     SET path = CONCAT(temppath,''/'', catname);  '
   +'  END IF;  '
   +'END$$  '
   +'DELIMITER ;';   }

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
       if Assigned(zdbCategorys.Selected) then
          begin

           // zdbCategorys.Items.AddNewChild(zdbCategorys.Selected,nodeCaption);

           dbCategory.Insert;
           dbCategory.FieldByName('CATEGORY').AsString:=nodeCaption;
           dbCategory.FieldByName('Descripcion').AsString:=Description;
           dbCategory.FieldByName('Parent_ID').AsInteger:=zdbCategorys.Selected.ID;
           dbCategory.Post;
          end
      // else //zdbCategorys.Items.AddNewChild(nil,nodeCaption);
        else ShowMessage(nMSG8);

     end;

 // frmDlgCaption.Free;
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
       end;
     end;


end;

procedure TFormCategory.FormCreate(Sender: TObject);
begin
  Getcategorias;
end;

procedure TFormCategory.btnMoveClick(Sender: TObject);
var
  ParentID, Code : Integer;
begin
  if Assigned(zdbCategorys.Selected) then
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
                 zdbCategorys.DataSource.DataSet.Edit;
                 zdbCategorys.DataSource.DataSet.FieldByName('Parent_ID').AsInteger := ParentID;
               end
            else ShowMessage('Invalid number!');
          end;
     end;
end;

procedure TFormCategory.btnApplyClick(Sender: TObject);
begin
   dbCategory.ApplyUpdates;
end;

procedure TFormCategory.btnDeleteClick(Sender: TObject);
begin
  if Assigned(zdbCategorys.Selected) then
     begin
       zdbCategorys.Selected.Delete;
     end;
end;

procedure TFormCategory.btnEditClick(Sender: TObject);
var
  Description : String;
begin
  if Assigned(zdbCategorys.Selected) then
     begin
       frmDlgCaption.Caption := nCaption5;
       Description:=zdbCategorys.DataSource.DataSet.FieldByName('Descripcion').AsString;
       frmDlgCaption.edtCaption.Text := zdbCategorys.Selected.Text;
       frmDlgCaption.Description.Text:= Description;
       frmDlgCaption.ShowModal;
       if frmDlgCaption.ModalResult = mrOK then
          begin
            zdbCategorys.DataSource.DataSet.Edit;
            zdbCategorys.DataSource.DataSet.FieldByName('CATEGORY').AsString :=
              frmDlgCaption.edtCaption.Text;
            zdbCategorys.DataSource.DataSet.FieldByName('Descripcion').AsString :=
              frmDlgCaption.Description.Text;
            zdbCategorys.DataSource.DataSet.Post;
          end;
     end
  else ShowMessage('You should select a node first!');
end;





end.

