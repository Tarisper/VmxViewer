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
  uMainForm in 'uMainForm.pas' {MForm},
  uDataModule in 'uDataModule.pas' {DM: TDataModule},
  uSplash in 'uSplash.pas' {SpForm},
  uSetUnit in 'uSetUnit.pas' {SetForm},
  Vcl.Themes,
  Vcl.Styles,
  IniFiles,
  uStrinListFiles in 'uStrinListFiles.pas',
  uMail in 'uMail.pas' {MailForm};

{$R *.res}
{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE}

var
  sIniPath_d: string;
  ini_d: TMemIniFile;
  bLog_d: Boolean;

begin
  GlobalCEFApp := TCefApplication.Create;
  GlobalCEFApp.EnableGPU := True;
  GlobalCEFApp.Cache := 'Cache\';
  GlobalCEFApp.UserDataPath := 'UserData\';
  GlobalCEFApp.AutoplayPolicy := appNoUserGestureRequired;
  if not FileExists(ParamStr(3)) or (Pos('\', ParamStr(3)) = 0) then
    sIniPath_d := ExtractFilePath(ParamStr(0)) + 'vmxbrowser.ini'
  else
    sIniPath_d := ParamStr(3);
  ini_d := TMemIniFile.Create(sIniPath_d);
  with ini_d do
  begin
    if FileExists(sIniPath_d) then
    begin
      if ini_d.ReadBool('Application', 'bLog', False) then
      begin
        GlobalCEFApp.LogFile := ExtractFilePath(ParamStr(0)) +
          'Logs\VmxViewer_Debug.log';
        GlobalCEFApp.LogSeverity := ini_d.ReadInteger('Application',
          'iMinLogLevel', 2);;
        GlobalCEFApp.LogProcessInfo := True;
      end;
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
      Sleep(1500);
      SpForm.Destroy;
      Application.CreateForm(TMForm, MForm);
      Application.CreateForm(TDM, DM);
      Application.Run;
    end;
  end;
  DestroyGlobalCEFApp;

end.
