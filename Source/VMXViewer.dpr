program VMXViewer;

{$I cef.inc}

uses
{$IFDEF DELPHI16_UP}
  Vcl.Forms,
{$ELSE}
  Forms,
  Windows,
{$ENDIF }
  Dialogs,
  WinAPI.Windows,
  System.SysUtils,
  uCEFApplication,
  uCEFTypes,
  uMainForm in 'uMainForm.pas' {MForm} ,
  uDataModule in 'uDataModule.pas' {DM: TDataModule} ,
  uSplash in 'uSplash.pas' {SpForm} ,
  uSetUnit in 'uSetUnit.pas' {SetForm} ,
  Vcl.Themes,
  Vcl.Styles,
  IniFiles,
  uStrinListFiles in 'uStrinListFiles.pas',
  uMail in 'uMail.pas' {MailForm} ,
  uTabF in 'uTabF.pas' {TabF} ,
  uTForm in 'uTForm.pas' {TabForm};

{$R *.res}
{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE}

var
  sIniPath_d: string;
  ini_d: TMemIniFile;
  // bLog_d: Boolean;

function GetFullPath(shortName:string):string;
var
  fullpath: PWideChar;
  buffer:string;
  i:integer;
  ch:char;
begin
  setlength(buffer,255);
  GetFullPathName(@shortname[1],255,@Buffer[1],fullpath);
  ch:=char(0);
  i:=pos(ch,buffer);
  setlength(buffer,i-1);
  result:=buffer;
end;

begin
  GlobalCEFApp := TCefApplication.Create;
  GlobalCEFApp.AutoplayPolicy := appNoUserGestureRequired;
  if not FileExists(ParamStr(3)) or (Pos('\', ParamStr(3)) = 0) then
    sIniPath_d := ExtractFilePath(ParamStr(0)) + 'vmxviewer.ini'
  else
    sIniPath_d := ParamStr(3);
  ini_d := TMemIniFile.Create(sIniPath_d);
  with ini_d do
  begin
    if FileExists(sIniPath_d) then
    begin
      GlobalCEFApp.EnableGPU := ini_d.ReadBool('Application', 'bEnableGPU', True);
      GlobalCEFApp.Cache := ini_d.ReadString('Application', 'sCacheDir',
        'Cache\');
      GlobalCEFApp.UserDataPath := ini_d.ReadString('Application',
        'sUserDataDir', 'UserData\');
      if ini_d.ReadBool('Application', 'bDLog', False) then
      begin
        GlobalCEFApp.LogFile := GetFullPath(IncludeTrailingPathDelimiter(ini_d.ReadString('Application',
          'sPathLog', 'Logs\'))) + 'VmxViewer_Debug.log';
        GlobalCEFApp.LogSeverity := ini_d.ReadInteger('Application',
          'iMinLogLevel', 2);
      end;
      GlobalCEFApp.LogProcessInfo := ini_d.ReadBool('Application', 'bLogProcessInfo', False);
      ini_d.Free;
    end;
  end;

  if GlobalCEFApp.StartMainProcess then
  begin
    Application.Initialize;
    if FindWindow(nil, 'VMX - Viewer') <> 0 then
    begin
      MessageBox(Application.Handle,
        'Программа уже запущена. Запрещён запуск более одной копии программы.',
        'Внимание', MB_OK or MB_ICONWARNING);
      Exit;
    end
    else
    begin
      TStyleManager.TrySetStyle('Windows10 SlateGray');
      Application.CreateForm(TSpForm, SpForm);
      SpForm.Show;
      Application.ProcessMessages;
      Sleep(1200);
      SpForm.Destroy;
      Application.CreateForm(TMForm, MForm);
      Application.CreateForm(TDM, DM);
      Application.Run;
    end;
  end;
  DestroyGlobalCEFApp;

end.

