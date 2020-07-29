; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "进货管理"
#define MyAppVersion "202007026-1"
#define MyAppPublisher "My Company, Inc."
#define MyAppURL "http://www.example.com/"
#define MyAppExeName "BuyCheck.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{A3FF471E-ECDB-4615-BE3C-1F5350D65AD0}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\BuyCheck
DefaultGroupName={#MyAppName}
OutputDir=C:\Users\weido\Documents\GoodsCheck\output
OutputBaseFilename=BuyCheck Setup
SetupIconFile=C:\Users\weido\Documents\GoodsCheck\syn5.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
;Name: "chinese"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]                                                                     
Source: "C:\Users\weido\Documents\GoodsCheck\Conf.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\weido\Documents\GoodsCheck\BuyCheck.exe"; DestDir: "{app}"; Flags: ignoreversion 
Source: "C:\Users\weido\Documents\GoodsCheck\Locale\*"; DestDir: "{app}\Locale\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Users\weido\Documents\GoodsCheck\Sqllib\*"; DestDir: "{app}\Sqllib\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Users\weido\Documents\GoodsCheck\Report\*"; DestDir: "{app}\Report\"; Flags: ignoreversion recursesubdirs createallsubdirs


; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, "&", "&&")}}"; Flags: nowait postinstall skipifsilent

