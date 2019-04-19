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
  uCEFApplication,
  uMainForm in 'uMainForm.pas' {MForm} ,
  uDataModule in 'uDataModule.pas' {DM: TDataModule} ,
  uSplash in 'uSplash.pas' {SpForm} ,
  uSetUnit in 'uSetUnit.pas' {SetForm} ,
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}
{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  GlobalCEFApp := TCefApplication.Create;
  GlobalCEFApp.EnableGPU := True;
  GlobalCEFApp.Cache := 'Cache\';
  GlobalCEFApp.UserDataPath := 'UserData\';

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
