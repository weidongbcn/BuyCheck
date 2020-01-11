unit Udata;

interface

uses
classes;
{
UniQuery1.SQL.Text:='CREATE TABLE IF NOT EXISTS ListConectPC ('
		   +'Id INTEGER PRIMARY KEY AUTOINCREMENT,'
		   +'HOST VARCHAR(40),'
		   +'Protocolo VARCHAR(40),'
		   +'Port INTEGER,'
		   +'User VARCHAR(40),'
		   +'Passwd VARCHAR(40),'
		   +'DataBase VARCHAR(40),'
		   +'EMID VARCHAR(40),'
		   +'PCID VARCHAR(20),'
       +'INDY_Server VARCHAR(40),'
       +'INDY_Port INTEGER'
       +' )';
}
Type
  TConectItem = class(TCollectionItem)
  private
    ciHost, ciProtocolo, ciUser, ciPasswd, ciDataBase, ciEMID, ciPCID, ciS_Server: string;
    ciPort, ciS_Port: integer;
  published
    property dbHost: string read ciHost write ciHost;
    property dbProtocolo: string read ciProtocolo write ciProtocolo;
    property dbUser: string read ciUser write ciUser;
    property dbPasswd: string read ciPasswd write ciPasswd;
    property dbDataBase: string read ciDataBase write ciDataBase;
    property EMID: string read ciEMID write ciEMID;
    property PCID: string read ciPCID write ciPCID;
    property Port: integer read ciPort write ciPort;
    property S_Server: string read ciS_Server write ciS_Server;
    property S_Port: integer read ciS_Port write ciS_Port;

    end;

  TConects = class(TComponent)
  private
    const
      tcFileExt = '.cdb';
    var
      tcItems: TOwnedCollection;
    procedure SetItems(avValue: TOwnedCollection);
    function StoreFile: string;
  public

    constructor Create(avOwner: TComponent);  overload;
    constructor Create; overload;
    destructor Destroy; override;
    procedure SaveItems;
    procedure LoadItems;
  published
    property Items: TOwnedCollection read tcItems write SetItems;
  end;


implementation

uses

  SysUtils; //uFS;

constructor TConects.Create(avOwner: TComponent);
begin
  inherited;
  Self.tcItems := TOwnedCollection.Create(Self, TConectItem);
end;

constructor TConects.Create;
begin
  Self.Create(nil);
end;

destructor TConects.Destroy;
begin
  Self.tcItems.Free;
  inherited;
end;

procedure TConects.SetItems(avValue: TOwnedCollection);
begin
  //Self.tvItems.Assign(avValue);

end;

function TConects.StoreFile: string;
var
AWin32Version: Extended;
s, DirConf:string;
begin
  AWin32Version := StrtoFloat(format('%d.%d' ,[Win32MajorVersion,Win32MinorVersion]));
     //s:=IncludeTrailingPathDelimiter(ExtractFileDir(ExtractFileDir(GetAppConfigDir(true))))+'LazPosc\';
  if (AWin32Version >= 6) then
    s:=GetEnvironmentVariable('ProgramData')+'\PosComecial\2\'
    else  s:=GetEnvironmentVariable('APPDATA')+'\PosComecial\2\';
   ForceDirectories(s);
   DirConf:=s;
  //Result := ChangeFileExt(ParamStr(0), Self.tcFileExt);
  Result :=DirConf+'LazPos'+Self.tcFileExt;
end;

procedure TConects.SaveItems;
begin
  with TFileStream.Create(Self.StoreFile, fmCreate) do
    try
      WriteComponent(Self);
    finally
      Destroy;
    end;
end;

procedure TConects.LoadItems;
var
  fn: string;
begin
  fn := Self.StoreFile;
  if FileExists(fn) then
    with TFileStream.Create(fn, fmOpenRead) do
      try
        ReadComponent(Self);
      finally
        Destroy;
      end;
end;

end.
