; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Vmx Viewer. ��������� ����� �������������"
#define MyAppVersion "1.0"
#define MyAppPublisher "��� ������������"
#define MyAppURL "http://videomatrix.ru/"
#define MyAppExeName "VMXViewer.exe"
#define MyAppNameVmxV "VMX Viewer"
#define AppDirectory "{pf}"
#define SplashName "splash.png"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{DDA64AB5-D710-43FE-A790-373938CF8196}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\VMX\{#MyAppNameVmxV}
DisableProgramGroupPage=yes
OutputBaseFilename=setup-vmx-viewer-respond-operator_cpu
Compression=lzma
SolidCompression=yes
PrivilegesRequired=poweruser
;�� ������������ �����, ������� ������ ������������ � ������� ���
UsePreviousAppDir=no
;�� ������������ ������ ���� ����, ��������� ������������� ��� ���������� ���������
UsePreviousGroup=no
;�� ������������ ��� ���������, ��������� ������������� � ������� ���
UsePreviousSetupType=no
;�� ������������ �������, ������� ������ ������������ ��� ������� ���������
UsePreviousTasks=no
AlwaysShowDirOnReadyPage=yes
Uninstallable=yes

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Files]
Source: "d:\Work\Projects\Delphi\VmxViewer\Bin\Respondscpu\-118.html"; DestDir: "{app}\Respond\"; Flags: ignoreversion
Source: "d:\Work\Projects\Delphi\VmxViewer\Bin\Inicpu\vmxviewer.ini"; DestDir: "{app}\"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "Splash.png"; DestDir: {tmp}; Flags: ignoreversion dontcopy nocompression
Source: "isgsg.dll"; DestDir: {tmp}; Flags: ignoreversion dontcopy nocompression
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Tasks]
Name: bMSWS12R2; Description: "������������� � MS Windows Server 2012"; Flags: unchecked
Name: bLog; Description: "����� ������ ����� ���������"; Flags: unchecked
Name: bDLog; Description: "����� ������ glog (����� �������� � ���������� �������� �� ������� ����������)"; Flags: unchecked

[Icons]
Name: "VMX\Vmx Viewer\������ ��������� ���������"; Filename: "{uninstallexe}"; \
  AfterInstall: AfterInstallProc('VMX\Vmx Viewer\������ ��������� ���������.lnk')

[Code]
var 
  TDV: TFolderTreeView; 
  TLbl: TLabel;
  TChB: TCheckBox;
  UserDataDir: string;
  ISCP: TWizardPage;

procedure ShowSplashScreen(p1:HWND;p2:string;p3,p4,p5,p6,p7:integer;p8:boolean;p9:Cardinal;p10:integer); external 'ShowSplashScreen@files:isgsg.dll stdcall delayload';

procedure SetElevationBit(Filename: string);
var
  Buffer: string;
  Stream: TStream;
begin
  Filename := ExpandConstant(Filename);
  Log('Setting elevation bit for ' + Filename);

  Stream := TFileStream.Create(FileName, fmOpenReadWrite);
  try
    Stream.Seek(21, soFromBeginning);
    SetLength(Buffer, 1);
    Stream.ReadBuffer(Buffer, 1);
    Buffer[1] := Chr(Ord(Buffer[1]) or $20);
    Stream.Seek(-1, soFromCurrent);
    Stream.WriteBuffer(Buffer, 1);
  finally
    Stream.Free;
  end;
end;

function GetDir(): string;
begin
  Result := UserDataDir;
end;

procedure TDVOnChange(Sender: TObject); 
begin 
  UserDataDir := AddBackslash(AddBackslash(TDV.Directory)+'{#MyAppNameVmxV}'); 
end; 

procedure TChBOnClick(Sender: TObject); 
begin 
  TDV.Enabled := TChB.Checked; 
end; 
 
procedure UpdateIni();
var
  IniFileName: String;
begin
  //MsgBox('About to install MyProg.exe as.', mbInformation, MB_OK);
  IniFileName := ChangeFileExt(AddBackslash(AddBackslash(ExpandConstant('{#AppDirectory}')) + 'VMX\' + '{#MyAppNameVmxV}') + '{#MyAppExeName}', '.ini');
  if TChB.Checked then
  begin
    SetIniString('Application', 'sPathLog', GetDir() + 'Logs\', IniFileName);
    SetIniString('Application', 'sDefCookiesDir', GetDir() + 'Cookies\', IniFileName);
    SetIniString('Application', 'sCacheDir', GetDir() + 'Cache\', IniFileName);
    SetIniString('Application', 'sUserDataDir', GetDir() + 'UserData\', IniFileName);
  end;
  if WizardForm.TasksList.Checked[0] then
    SetIniBool('Application', 'bMSWS12R2', True, IniFileName)
  else
    SetIniBool('Application', 'bMSWS12R2', False, IniFileName);
  if WizardForm.TasksList.Checked[1] then
    SetIniBool('Application', 'bLog', True, IniFileName)
  else
    SetIniBool('Application', 'bLog', False, IniFileName);
  if WizardForm.TasksList.Checked[2] then
    SetIniBool('Application', 'bDLog', True, IniFileName)
  else
    SetIniBool('Application', 'bDLog', False, IniFileName);
end;

procedure AfterInstallProc(Filename: string);
begin
  UpdateIni();
  SetElevationBit(Filename);
end;

function GetUninstallString(): String;
var
  sUnInstPath: String;
  sUnInstallString: String;
begin
  sUnInstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}_is1');
  sUnInstallString := '';
  if not RegQueryStringValue(HKLM, sUnInstPath, 'UninstallString', sUnInstallString) then
    RegQueryStringValue(HKCU, sUnInstPath, 'UninstallString', sUnInstallString);
  Result := sUnInstallString;
end;
 
function IsUpgrade(): Boolean;
begin
  Result := (GetUninstallString() <> '');
end;
 
function UnInstallOldVersion(): Integer;
var
  sUnInstallString: String;
  iResultCode: Integer;
begin
// Return Values:
// 1 - uninstall string is empty
// 2 - error executing the UnInstallString
// 3 - successfully executed the UnInstallString
 
  // default return value
  Result := 0;
 
  // get the uninstall string of the old app
  sUnInstallString := GetUninstallString();
  if sUnInstallString <> '' then begin
    sUnInstallString := RemoveQuotes(sUnInstallString);
    if Exec(sUnInstallString, '/SILENT /NORESTART /SUPPRESSMSGBOXES','', SW_HIDE, ewWaitUntilTerminated, iResultCode) then
      Result := 3
    else
      Result := 2;
  end else
    Result := 1;
end;
 
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if (CurStep=ssInstall) then
  begin
    if (IsUpgrade()) then
    begin
      if MsgBox('� ������� ������� ������ ������ ���������. ���������� � �������, ����� ���������� ����� ������. �������?', mbConfirmation, MB_YESNO) = IDYES then
        UnInstallOldVersion();
    end;
  end;
end;

procedure InitializeWizard(); 
var
  BitmapImage1 : TBitmapImage;
  Splash  : TSetupForm;
begin
  ExtractTemporaryFile('Splash.png');
  ShowSplashScreen(WizardForm.Handle,ExpandConstant('{tmp}\Splash.png'), 700, 1400, 700, 0, 255, True, $FFFFFF, 10);

  ISCP := CreateCustomPage(wpWelcome, '����� ����������', '�������� ���������� ��� �������� �����, ���� � ������ ������������ (�� ��������� ��� ���������� � ����������).');

  TLbl := TLabel.Create(WizardForm);
  TLbl.Top := 5;
  TLbl.Caption := '�������� ���������� ��� �������� �����, ���� � ������ ������������:';
  TLbl.Parent := ISCP.Surface; 

  TChB := TCheckBox.Create(WizardForm);
  TChB.Top := TLbl.Top + 28;
  TChB.Caption := '�������� ���� �� ����������';
  TChB.Width := 200;
  TChB.Checked := False;
  TChB.Parent := ISCP.Surface; 
  TChB.OnClick := @TChBOnClick;

  TDV := TFolderTreeView.Create(WizardForm); 
  TDV.Top := TChB.Top + 28; 
  TDV.Width := 485; 
  TDV.Height := 203; 
  TDV.OnChange := @TDVOnChange; 
  TDV.Parent := ISCP.Surface;
  TDV.Directory := AddBackslash(AddBackslash(ExpandConstant('{#AppDirectory}')) + 'VMX\' + '{#MyAppNameVmxV}');
  TDV.Enabled := TChB.Checked;
end;
