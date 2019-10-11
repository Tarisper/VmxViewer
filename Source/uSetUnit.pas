unit uSetUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, System.Actions, Vcl.ActnList, Winapi.ShlObj, FileCtrl,
  Vcl.Samples.Spin;

type
  TSetForm = class(TForm)
    grp1: TGroupBox;
    edtSrvAddr: TEdit;
    lbl1: TLabel;
    edtAPIAdr: TEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    edtCookiesDir: TEdit;
    btnCookiesDir: TButton;
    grp2: TGroupBox;
    chkKiosk: TCheckBox;
    chkWriteLog: TCheckBox;
    edtLogsDir: TEdit;
    btnLogsDir: TButton;
    chkShowAddrStr: TCheckBox;
    chkShohCloseBtn: TCheckBox;
    chkShowSettBtn: TCheckBox;
    btnOk: TButton;
    btnSave: TButton;
    btnCancel: TButton;
    dlgOpenDir: TOpenDialog;
    Label1: TLabel;
    spedPause: TSpinEdit;
    procedure actCancelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkWriteLogClick(Sender: TObject);
    procedure edtSrvAddrChange(Sender: TObject);
    procedure edtAPIAdrChange(Sender: TObject);
    procedure edtCookiesDirChange(Sender: TObject);
    procedure edtLogsDirChange(Sender: TObject);
    procedure chkKioskClick(Sender: TObject);
    procedure chkShowAddrStrClick(Sender: TObject);
    procedure chkShohCloseBtnClick(Sender: TObject);
    procedure chkShowSettBtnClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCookiesDirClick(Sender: TObject);
    procedure btnLogsDirClick(Sender: TObject);
    procedure spedPauseChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetForm: TSetForm;

implementation

{$R *.dfm}

uses
  uMainForm, uDataModule;

procedure TSetForm.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TSetForm.btnCookiesDirClick(Sender: TObject);
var
  sPath: string;
begin
  if SelectDirectory('Выберите директория для хранения Cookies-файлов', '',
    sPath) then
    edtCookiesDir.Text := sPath;
end;

procedure TSetForm.btnLogsDirClick(Sender: TObject);
var
  sPath: string;
begin
  if SelectDirectory('Выберите директория для хранения Cookies-файлов', '',
    sPath) then
    edtCookiesDir.Text := sPath;
end;

procedure TSetForm.btnOkClick(Sender: TObject);
var
  iAsk: Integer;
begin
  if btnSave.Enabled then
  begin
    iAsk := MessageBox(SetForm.Handle,
      'Изменения настроек не сохранены. Сохранить?', 'Внимание', MB_YESNOCANCEL
      or MB_ICONQUESTION);
    case iAsk of
      mrYes:
        begin
          btnSave.Click;
          btnCancel.Click;
        end;
      mrCancel:
        Exit;
      mrNo:
        btnCancel.Click;
    end;
  end
  else
    btnCancel.Click;
end;

procedure TSetForm.btnSaveClick(Sender: TObject);
begin
  with MForm do
  begin
    AppSett.bLog := chkWriteLog.Checked;
    AppSett.bKiosk := chkKiosk.Checked;
    AppSett.bNavPanel := chkShowAddrStr.Checked;
    AppSett.sPathLog := edtLogsDir.Text;
    AppSett.sDefLink := edtSrvAddr.Text;
    AppSett.sDefCookiesDir := edtCookiesDir.Text;
    AppSett.sWebAPIPath := edtAPIAdr.Text;
    AppSett.bShowCloseButton := chkShohCloseBtn.Checked;
    AppSett.bShowOptionButton := chkShowSettBtn.Checked;
    DM.WriteIni(AppSett.sIniPath);
    btnSave.Enabled := False;
    btnShowSett.Visible := AppSett.bShowOptionButton;
    btnClose1.Visible := AppSett.bShowCloseButton;
    if not AppSett.bKiosk then
      pnlNavigation1.Visible := AppSett.bNavPanel;
  end;
end;

procedure TSetForm.chkKioskClick(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

procedure TSetForm.chkShohCloseBtnClick(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

procedure TSetForm.chkShowAddrStrClick(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

procedure TSetForm.chkShowSettBtnClick(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

procedure TSetForm.chkWriteLogClick(Sender: TObject);
begin
  if chkWriteLog.Checked then
  begin
    edtLogsDir.Enabled := True;
    btnLogsDir.Enabled := True;
  end
  else
  begin
    edtLogsDir.Enabled := False;
    btnLogsDir.Enabled := False;
  end;
  btnSave.Enabled := True;
end;

procedure TSetForm.edtAPIAdrChange(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

procedure TSetForm.edtCookiesDirChange(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

procedure TSetForm.edtLogsDirChange(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

procedure TSetForm.edtSrvAddrChange(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

procedure TSetForm.FormCreate(Sender: TObject);
begin
  with MForm do
  begin
    edtSrvAddr.Text := AppSett.sDefLink;
    edtAPIAdr.Text := AppSett.sWebAPIPath;
    edtCookiesDir.Text := AppSett.sDefCookiesDir;
    edtLogsDir.Text := AppSett.sPathLog;

    chkWriteLog.Checked := AppSett.bLog;
    chkKiosk.Checked := AppSett.bKiosk;
    chkShowAddrStr.Checked := AppSett.bNavPanel;
    chkShohCloseBtn.Checked := AppSett.bShowCloseButton;
    chkShowSettBtn.Checked := AppSett.bShowOptionButton;

    edtLogsDir.Enabled := chkShowSettBtn.Checked;
    btnLogsDir.Enabled := chkShowSettBtn.Checked;
    btnSave.Enabled := False;

    spedPause.Value := AppSett.iRefreshUrl;

    if AppSett.bKiosk then
    begin
      chkShohCloseBtn.Enabled := False;
      chkShohCloseBtn.Hint := 'Нельзя выбрать в режиме киоска';
      chkShohCloseBtn.ShowHint := True;

      chkShowAddrStr.Enabled := False;
      chkShowAddrStr.Checked := False;
      chkShowAddrStr.Hint := 'Нельзя выбрать в режиме киоска';
      chkShowAddrStr.ShowHint := True;
    end;
  end;
end;

procedure TSetForm.spedPauseChange(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

end.

