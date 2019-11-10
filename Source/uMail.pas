unit uMail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  IdBaseComponent, IdComponent, IdTCPConnection, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, Vcl.StdCtrls, IdMessage, IdTCPClient,
  Vcl.Samples.Spin, IdIPWatch{, EASendMailObjLib_TLB};

type
  TMailForm = class(TForm)
    Button1: TButton;
    IdSMTP1: TIdSMTP;
    Button2: TButton;
    IdMessage1: TIdMessage;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit5: TEdit;
    se1: TSpinEdit;
    edt1: TEdit;
    grp1: TGroupBox;
    lbl3: TLabel;
    lbl4: TLabel;
    chkUseSSL: TCheckBox;
    grp2: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    btn1: TButton;
    IdIPWatch1: TIdIPWatch;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    {procedure btn1Click(Sender: TObject);}
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MailForm: TMailForm;

implementation

uses
  uMainForm;

{$R *.dfm}

{procedure TSender.btn1Click(Sender: TObject);
var
  oSmtp: TMail;
begin
  oSmtp := TMail.Create(Application);
  oSmtp.LicenseCode := 'TryIt';
  // Set your sender email address
  oSmtp.FromAddr := Edit1.Text;
  // Add recipient email address
  oSmtp.AddRecipientEx(Edit5.Text, 0);
  // Set email subject
  oSmtp.Subject := 'simple email from Delphi project';
  // Set email body
  oSmtp.BodyText :=
    'this is a test email sent from Delphi project, do not reply';
  // Your SMTP server address
  oSmtp.ServerAddr := Edit3.Text;
  oSmtp.ServerPort := 25;
  // User and password for ESMTP authentication, if your server doesn't require
  // user authentication, please remove the following codes
  oSmtp.UserName := Edit1.Text;
  oSmtp.Password := Edit2.Text;
  // If your SMTP server requires SSL connection, please add this line
  if chkUseSSL.Checked then
  begin
    // oSmtp.SSL_starttls := 1;
    oSmtp.SSL_init();
  end;
  if oSmtp.SendMail() = 0 then
    MessageBox(Self.Handle, 'Письмо отправлено', 'Информация',
      MB_OK or MB_ICONINFORMATION)
  else
    MessageBox(Self.Handle, PWideChar(oSmtp.GetLastErrDescription()), 'Ошибка',
      MB_OK or MB_ICONERROR);
end;}

procedure TMailForm.Button1Click(Sender: TObject);
begin
  try
    IdSMTP1.Host := Trim(Edit3.Text);
    IdSMTP1.Port := se1.Value;
    IdSMTP1.UserName := Trim(Edit1.Text);
    IdSMTP1.Password := Trim(Edit2.Text);
    // IdSMTP1.UseTLS := utUseRequireTLS;
    IdSMTP1.Connect;
      //    MessageBox(Self.Handle, 'Подлючено к SMTP-серверу', 'Информация', MB_OK or
//      MB_ICONINFORMATION);
  except//    on e: Exception do
//      MessageBox(Self.Handle, PWideChar(e.Message), 'Ошибка', MB_OK or
//        MB_ICONERROR);
    MForm.AddToLog('ERROR Ошибка подключения к почтовому серверу ' + Edit3.Text
      + ' порт ' + IntToStr(MForm.AppSett.iPort) + ' с учётной записью ' +
      Edit1.Text);
  end;
end;

function GetComputerNetName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;

function GetUserFromWindows: string;
const
  cnMaxUserNameLen = 254;
var
  sUserName: string;
  dwUserNameLen: DWORD;
begin
  dwUserNameLen := cnMaxUserNameLen - 1;
  SetLength(sUserName, cnMaxUserNameLen);
  GetUserName(PChar(sUserName), dwUserNameLen);
  SetLength(sUserName, dwUserNameLen);
  Result := sUserName;
end;

procedure TMailForm.Button2Click(Sender: TObject);
var
  msg: TIdMessage;
  s: string;
  sText: TStrings;
begin
  sText := TStringList.Create;
  try
    s := MForm.AppSett.sDefLink;
    sText.Add('Ошибка доступа к серверу Чёрного экрана. Сервер "' + s +
      '" недоступен у оператора.');
    sText.Add('IP: ' + Trim(IdIPWatch1.LocalIP));
    sText.Add('Имя компьютера: ' + Trim(GetComputerNetName));
    sText.Add('Имя пользователя: ' + Trim(GetUserFromWindows));
  except
    if sText <> nil then
      sText.Add('Ошибка доступа к серверу Чёрного экрана. Сервер "' + s +
        '" недоступен у оператора.');
  end;
  if not IdSMTP1.Connected then
    Button1.Click;
  if IdSMTP1.Connected then
  begin
    msg := TIdMessage.Create(Self);
    try
      SysLocale.PriLangID := LANG_RUSSIAN;
      msg.CharSet := 'UTF-8';
      msg.Body := sText;
      msg.Body.Text := UTF8Encode(msg.Body.Text);
      msg.Subject := 'ЧЭ. Сервер не доступен';
      msg.From.Address := Trim(Edit1.Text);
      msg.From.Name := 'ЧЭ. VmxViewer';
      msg.Recipients.EMailAddresses := Edit5.Text;
      msg.IsEncoded := True;
      IdSMTP1.Send(msg);
      msg.Free;
      IdSMTP1.Disconnect;
      //MessageBox(Self.Handle, 'Письмо отправлено', 'Информация',
      //  MB_OK or MB_ICONINFORMATION);
      MForm.AddToLog('Отправлено письмо на адрес: ' + Edit5.Text);
      MForm.AddToLog(sText.Text);
    except//        on e: Exception do
      begin
//          msg.Free;
        if IdSMTP1.Connected then
          IdSMTP1.Disconnect;
        //MessageBox(Self.Handle, PWideChar(e.Message), 'Ошибка',
        //  MB_OK or MB_ICONERROR);
        MForm.AddToLog('ERROR Ошибка отправки письма на адрес: ' + Edit5.Text);
        MForm.AddToLog(sText.Text);
      end;
    end;
  end;
//  except
//    MForm.AddToLog('Ошибка отправки письма');
//  end;
  Inc(MForm.ErrCount.Count118);
  Inc(MForm.ErrCount.Count2);
  sText.Free;
  Destroy;
end;

procedure TMailForm.FormCreate(Sender: TObject);
begin
  with MForm.AppSett do
  begin
    Edit1.Text := sFrom;
    Edit2.Text := sPass;
    Edit3.Text := sSMTP;
    se1.Value := iPort;
    Edit5.Text := sTo;
  end;
end;

end.

