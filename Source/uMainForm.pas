// ------------------------------------------------------------------------------
// VmxViewer
// Copyright (c) 2019 ��� "������������"
// Author: Khaiitov D.D.
// Date: 15.04.2019

// ------------------------------------------------------------------------------
// ************************************************************************
// ***************************** CEF4Delphi *******************************
// ************************************************************************
//
// CEF4Delphi is based on DCEF3 which uses CEF3 to embed a chromium-based
// browser in Delphi applications.
//
// The original license of DCEF3 still applies to CEF4Delphi.
//
// For more information about CEF4Delphi visit :
// https://www.briskbard.com/index.php?lang=en&pageid=cef
//
// Copyright � 2019 Salvador Diaz Fau. All rights reserved.
//
// ************************************************************************
// ************ vvvv Original license and comments below vvvv *************
// ************************************************************************
(*
  *                       Delphi Chromium Embedded 3
  *
  * Usage allowed under the restrictions of the Lesser GNU General Public License
  * or alternatively the restrictions of the Mozilla Public License 1.1
  *
  * Software distributed under the License is distributed on an "AS IS" basis,
  * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
  * the specific language governing rights and limitations under the License.
  *
  * Unit owner : Henri Gourvest <hgourvest@gmail.com>
  * Web site   : http://www.progdigy.com
  * Repository : http://code.google.com/p/delphichromiumembedded/
  * Group      : http://groups.google.com/group/delphichromiumembedded
  *
  * Embarcadero Technologies, Inc is not permitted to use or redistribute
  * this source code without explicit permission.
  *
*)

unit uMainForm;

interface

uses
{$IFDEF DELPHI16_UP}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.UITypes,
{$ELSE}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
{$ENDIF}
  uCEFChromium, uCEFWindowParent, uCEFInterfaces, uCEFTypes, uCEFConstants,
  Vcl.ExtCtrls, uCEFWinControl, uCEFCookieVisitor, uCEFCookieManager,
  Vcl.StdCtrls, Vcl.WinXCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, System.Actions, Vcl.ActnList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.ToolWin, Winapi.ShellAPI, FileCtrl,
  System.DateUtils;

type
  TAppSettings = record
    sIniPath: string;
    bKiosk: Boolean;
    bNavPanel: Boolean;
    bLog: Boolean;
    iMinLogLevel: Integer;
    sPathLog: string;
    sDefLink: string;
    sDefCookiesDir: string;
    sSQLPath: string;
    sWebAPIPath: string;
    sDbPath: string;
    iRefreshUrl: Integer;
    bShowCloseButton: Boolean;
    bShowOptionButton: Boolean;
    bMSWS12R2: Boolean;
    slCams: TStringList;
    iTimeOut: Integer;
    sFrom, sPass, sTo, sSMTP: string;
    iPort: Integer;
    bSend, bRedirect3: Boolean;
    iMTimeOut, iCamsCheckDelay: Integer;
  end;

  TErrCount = record
    Count118, Count2: Integer;
  end;

type
  TMForm = class(TForm)
    CEFWindowParent1: TCEFWindowParent;
    chrmBrwsr: TChromium;
    tmrCrtBrwsr: TTimer;
    pnlNavigation: TPanel;
    edtAddress: TEdit;
    actvtyndctr1: TActivityIndicator;
    btn2: TButton;
    pnlNavigation2: TPanel;
    pnlNavigation1: TPanel;
    actlstComm: TActionList;
    actShowSett: TAction;
    actClose: TAction;
    vrtlmglst1: TVirtualImageList;
    imgclctn1: TImageCollection;
    tlb1: TToolBar;
    btnShowSett: TToolButton;
    btnClose1: TToolButton;
    actGo: TAction;
    btnGo1: TToolButton;
    btnHelp: TToolButton;
    actHelp: TAction;
    btn1: TButton;
    dlgSaveF: TSaveDialog;
    pnlCamResp: TPanel;
    lbl1: TLabel;
    tmrMail: TTimer;
    tmrAut: TTimer;
    tmrDelTh: TTimer;
    btnF5: TToolButton;
    btn4: TToolButton;
    procedure chrmBrwsrPreKeyEvent(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: PMsg; out isKeyboardShortcut, Result: Boolean);
    procedure chrmBrwsrKeyEvent(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: PMsg; out Result: Boolean);
    procedure FormShow(Sender: TObject);
    procedure chrmBrwsrAfterCreated(Sender: TObject; const browser: ICefBrowser);
    procedure tmrCrtBrwsrTimer(Sender: TObject);
    procedure chrmBrwsrBeforePopup(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo; var client: ICefClient; var settings: TCefBrowserSettings; var noJavascriptAccess: Boolean; var Result: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chrmBrwsrBeforeClose(Sender: TObject; const browser: ICefBrowser);
    procedure chrmBrwsrClose(Sender: TObject; const browser: ICefBrowser; out Result: Boolean);
    procedure chrmBrwsrBeforeContextMenu(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; const model: ICefMenuModel);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure chrmBrwsrLoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
    procedure chrmBrwsrLoadStart(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; transitionType: Cardinal);
    procedure edtAddressKeyPress(Sender: TObject; var Key: Char);
    procedure chrmBrwsrLoadError(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; errorCode: Integer; const errorText, failedUrl: ustring);
    procedure chrmBrwsrCertificateError(Sender: TObject; const browser: ICefBrowser; certError: Integer; const requestUrl: ustring; const sslInfo: ICefSslInfo; const callback: ICefRequestCallback; out Result: Boolean);
    procedure btn2Click(Sender: TObject);
    procedure actShowSettExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actGoExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure chrmBrwsrBeforeDownload(Sender: TObject; const browser: ICefBrowser; const downloadItem: ICefDownloadItem; const suggestedName: ustring; const callback: ICefBeforeDownloadCallback);
    procedure chrmBrwsrDownloadUpdated(Sender: TObject; const browser: ICefBrowser; const downloadItem: ICefDownloadItem; const callback: ICefDownloadItemCallback);
    procedure tmrMailTimer(Sender: TObject);
    procedure tmrAutTimer(Sender: TObject);
    procedure tmrDelThTimer(Sender: TObject);
    procedure chrmBrwsrAddressChange(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const url: ustring);
    procedure btnF5Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    { Private declarations }
    procedure WriteToFile(sPath, sText: string);
    procedure WriteLogFile(sText: string);
    procedure ApplyIni;
    procedure CamsCheck;
  protected
    // Variables to control when can we destroy the form safely
    FCanClose: Boolean; // Set to True in TChromium.OnBeforeClose
    FClosing: Boolean; // Set to True in the CloseQuery event.
    FVisitor: ICefCookieVisitor;
    dtCheck: TDateTime;
    bCamsIsChecked: Boolean;
    procedure WMMove(var aMessage: TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage: TMessage); message WM_MOVING;
    procedure WMEnterMenuLoop(var aMessage: TMessage); message WM_ENTERMENULOOP;
    procedure WMExitMenuLoop(var aMessage: TMessage); message WM_EXITMENULOOP;
    procedure BrowserCreatedMsg(var aMessage: TMessage); message CEF_AFTERCREATED;
    procedure BrowserDestroyMsg(var aMessage: TMessage); message CEF_DESTROY;
    procedure HandleKeyUp(const aMsg: TMsg; var aHandled: Boolean);
    procedure HandleKeyDown(const aMsg: TMsg; var aHandled: Boolean);
  public
    { Public declarations }
    AppSett: TAppSettings;
    ErrCount: TErrCount;
    procedure AddToLog(sValue: string; bAddDateTime: Boolean = True; fsStyle: TFontStyles = []; Color: Integer = 0);
  end;

type
  TEXEVersionData = record
    CompanyName, FileDescription, FileVersion, InternalName, LegalCopyright, LegalTrademarks, OriginalFileName, ProductName, ProductVersion, Comments, PrivateBuild, SpecialBuild: string;
  end;

  TAutCamsThread = class(TThread)
    sLink, sText: string;
  private
    { Private declarations }
    Aut: Boolean;
    procedure AutCam;
    procedure HidePnl;
    procedure Tabs;
    procedure TabsDest;
  protected
    procedure Execute; override;
  end;

const
  CHROME_ERROR_101 = -101;
  CHROME_ERROR_105 = -105;
  CHROME_ERROR_106 = -106;
  CHROME_ERROR_118 = -118;
  // ������������� ���� �� ������ ��������
  ERR_101 = 'Respond\-101.html';
  ERR_105 = 'Respond\-105.html';
  ERR_106 = 'Respond\-106.html';
  ERR_118 = 'Respond\-118.html';
  ERR_000 = 'Respond\-000.html';
  CEFBROWSER_DESTROYWNDPARENT = WM_APP + $100;
  CEFBROWSER_DESTROYTAB = WM_APP + $101;
  CEFBROWSER_INITIALIZED = WM_APP + $102;
  CEFBROWSER_CHECKTAGGEDTABS = WM_APP + $103;

var
  MForm: TMForm;
  sAppName: string;
  bAddr: Boolean;
  AutCamsThread: TAutCamsThread;
  bAllAut, bStartingError: Boolean;
  sRealDefLink: string;
  bIsStartHP, bError: Boolean;

implementation

{$R *.dfm}

uses
  uCEFApplication, uDataModule, uSetUnit, uMail, uTabF, uTForm;

// *****************************************************************************
// �������� ���������� �� ����������� �����
// *****************************************************************************
function GetEXEVersionData(const FileName: string): TEXEVersionData;
type
  PLandCodepage = ^TLandCodepage;

  TLandCodepage = record
    wLanguage, wCodePage: word;
  end;
var
  dummy, len: Cardinal;
  buf, pntr: pointer;
  lang: string;
begin
  len := GetFileVersionInfoSize(PChar(FileName), dummy);
  if len = 0 then
    RaiseLastOSError;
  GetMem(buf, len);
  try
    if not GetFileVersionInfo(PChar(FileName), 0, len, buf) then
      RaiseLastOSError;

    if not VerQueryValue(buf, '\VarFileInfo\Translation\', pntr, len) then
      RaiseLastOSError;

    lang := Format('%.4x%.4x', [PLandCodepage(pntr)^.wLanguage, PLandCodepage(pntr)^.wCodePage]);

    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\CompanyName'), pntr, len) { and (@len <> nil) } then
      Result.CompanyName := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\FileDescription'), pntr, len) { and (@len <> nil) } then
      Result.FileDescription := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\FileVersion'), pntr, len) { and (@len <> nil) } then
      Result.FileVersion := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\InternalName'), pntr, len) { and (@len <> nil) } then
      Result.InternalName := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\LegalCopyright'), pntr, len) { and (@len <> nil) } then
      Result.LegalCopyright := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\LegalTrademarks'), pntr, len) { and (@len <> nil) } then
      Result.LegalTrademarks := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\OriginalFileName'), pntr, len) { and (@len <> nil) } then
      Result.OriginalFileName := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\ProductName'), pntr, len) { and (@len <> nil) } then
      Result.ProductName := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\ProductVersion'), pntr, len) { and (@len <> nil) } then
      Result.ProductVersion := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\Comments'), pntr, len) { and (@len <> nil) } then
      Result.Comments := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\PrivateBuild'), pntr, len) { and (@len <> nil) } then
      Result.PrivateBuild := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\SpecialBuild'), pntr, len) { and (@len <> nil) } then
      Result.SpecialBuild := PChar(pntr);
  finally
    FreeMem(buf);
  end;
end;

procedure TMForm.CamsCheck;
begin
  chrmBrwsr.StopLoad;
  sRealDefLink := AppSett.sDefLink;
  if AppSett.slCams.Count > 0 then
  begin
    bAllAut := False;
    AddToLog('����������� �� �������');
    // AppSett.sDefLink := AppSett.slCams.Strings[0];
    AppSett.sDefLink := ExtractFilePath(ParamStr(0)) + 'Respond\start.html';
    pnlCamResp.Top := Round(CEFWindowParent1.Height / 2 - pnlCamResp.Height / 2);
    pnlCamResp.Left := Round(CEFWindowParent1.Width / 2 - pnlCamResp.Width / 2);
    pnlCamResp.Visible := True;
  end;
  if Assigned(AutCamsThread) then
    FreeAndNil(AutCamsThread);
  if not Assigned(AutCamsThread) and (AppSett.slCams.Count > 0) then
  begin
    AutCamsThread := TAutCamsThread.Create(False);
    AutCamsThread.Priority := tpNormal;
  end;
  dtCheck := Now;
  bCamsIsChecked := True;
end;

procedure TAutCamsThread.AutCam;
begin
  try
    MForm.AddToLog(sText + sLink, True);
    if Aut then
    begin
      if Assigned(TabForm) then
        TabForm.AddLink(sLink)
    end
    else if not bIsStartHP or bError then
      MForm.chrmBrwsr.LoadURL(sLink);
  except

  end;
end;

procedure TAutCamsThread.HidePnl;
begin
  try
    if MForm.pnlCamResp.Visible then
      MForm.pnlCamResp.Visible := False;
    MForm.tmrAut.Interval := MForm.AppSett.iCamsCheckDelay * 60 * 1000;
    MForm.tmrAut.Enabled := True;
    MForm.tmrDelTh.Enabled := True;
  except

  end;
end;

procedure TAutCamsThread.Tabs;
begin
  if not Assigned(TabForm) then
    Application.CreateForm(TTabForm, TabForm);
  // {$IFDEF DEBUG}
  if Assigned(TabForm) then
  begin
    //TabForm.Show;
    // TabForm.Hide;
  end;
  // {$ENDIF}
end;

procedure TAutCamsThread.TabsDest;
begin
  try
    MForm.AddToLog('TabsDest Starting', True);
    if Assigned(TabForm) then
    begin
      FreeAndNil(TabForm);
      MForm.AddToLog('FreeAndNil(TabForm)', True);
    end;
    MForm.AddToLog('TabsDest Ended', True);
  except

  end;
end;

procedure TAutCamsThread.Execute;
var
  i: Integer;
begin
  i := -1;
  Synchronize(Tabs);
  while not Self.Terminated do
  begin
    Inc(i);
    with MForm.AppSett do
    begin
      Sleep(iTimeOut);
      if slCams.Count >= 1 then
      begin
        if i < slCams.Count then
        begin
          sText := '�����������: ';
          sLink := slCams.Strings[i];
          Aut := True;
          Synchronize(AutCam);
        end
        else
          Self.Terminate;
      end
      else
        Self.Terminate;
    end;
  end;
  Sleep(100);
  // MForm.chrmBrwsr.StopLoad;
  if not bIsStartHP or bError then
  begin
    sText := '�������� ����� �����������: ';
    MForm.AppSett.sDefLink := sRealDefLink;
    sLink := MForm.AppSett.sDefLink;
  end;
  Aut := False;
  Synchronize(AutCam);
  Sleep(100);
  bIsStartHP := True;
  bAllAut := True;
  Synchronize(TabsDest);
  Sleep(100);
  Synchronize(HidePnl);
  Sleep(100);
end;

procedure TMForm.ApplyIni;
begin
  with AppSett do
  begin
    if not AppSett.bKiosk then
    begin
      if bShowCloseButton then
        btnClose1.Visible := True
      else
        btnClose1.Visible := False;
    end
    else
      btnClose1.Visible := True;
    if bShowOptionButton then
      btnShowSett.Visible := True
    else
      btnShowSett.Visible := False;
    if not bShowCloseButton and not bShowOptionButton and not pnlNavigation1.Visible then
      pnlNavigation.Visible := False;
  end;
end;

procedure TMForm.HandleKeyUp(const aMsg: TMsg; var aHandled: Boolean);
var
  TempMessage: TMessage;
  TempKeyMsg: TWMKey;
begin
  TempMessage.Msg := aMsg.message;
  TempMessage.wParam := aMsg.wParam;
  TempMessage.lParam := aMsg.lParam;
  TempKeyMsg := TWMKey(TempMessage);
  // if (TempKeyMsg.CharCode = VK_ESCAPE) then
  // begin
  // aHandled := True;
  //
  // PostMessage(Handle, WM_CLOSE, 0, 0);
  // end;
end;

procedure TMForm.tmrAutTimer(Sender: TObject);
begin
  bAllAut := False;
  if not Assigned(AutCamsThread) and (AppSett.slCams.Count > 0) then
  begin
    AutCamsThread := TAutCamsThread.Create(False);
    AutCamsThread.Priority := tpNormal;
  end;
end;

procedure TMForm.tmrCrtBrwsrTimer(Sender: TObject);
begin
  tmrCrtBrwsr.Enabled := False;
  if not (chrmBrwsr.CreateBrowser(CEFWindowParent1, '')) and not (chrmBrwsr.Initialized) then
    tmrCrtBrwsr.Enabled := True;
end;

procedure TMForm.tmrDelThTimer(Sender: TObject);
begin
  if Assigned(AutCamsThread) then
    FreeAndNil(AutCamsThread);
  tmrDelTh.Enabled := False;
end;

procedure TMForm.tmrMailTimer(Sender: TObject);
begin
  ErrCount.Count2 := 0;
  ErrCount.Count118 := 0;
end;

procedure TMForm.HandleKeyDown(const aMsg: TMsg; var aHandled: Boolean);
var
  TempMessage: TMessage;
  TempKeyMsg: TWMKey;
begin
  TempMessage.Msg := aMsg.message;
  TempMessage.wParam := aMsg.wParam;
  TempMessage.lParam := aMsg.lParam;
  TempKeyMsg := TWMKey(TempMessage);
  if (TempKeyMsg.CharCode = VK_ESCAPE) then
    aHandled := True;
  if TempKeyMsg.CharCode = VK_F5 then
    chrmBrwsr.Reload;
{$IFDEF DEBUG}
  if TempKeyMsg.CharCode = VK_F8 then
    btnGo1.Click;
{$ENDIF}
  if (TempKeyMsg.CharCode = VK_F6) then
    chrmBrwsr.browser.ReloadIgnoreCache;
  AddToLog('������ ������� = ' + IntToStr(TempKeyMsg.CharCode));
end;

procedure TMForm.chrmBrwsrAddressChange(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const url: ustring);
begin
  edtAddress.Text := url;
end;

procedure TMForm.chrmBrwsrAfterCreated(Sender: TObject; const browser: ICefBrowser);
begin
  PostMessage(Handle, CEF_AFTERCREATED, 0, 0);
end;

procedure TMForm.chrmBrwsrBeforeClose(Sender: TObject; const browser: ICefBrowser);
begin
  FCanClose := True;
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure TMForm.chrmBrwsrBeforeContextMenu(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; const model: ICefMenuModel);
begin
  model.Clear;
end;

procedure TMForm.chrmBrwsrBeforeDownload(Sender: TObject; const browser: ICefBrowser; const downloadItem: ICefDownloadItem; const suggestedName: ustring; const callback: ICefBeforeDownloadCallback);
var
  { TempMyDocuments, }   TempFullPath { , TempName } : string;
begin
  if not (chrmBrwsr.IsSameBrowser(browser)) or (downloadItem = nil) or not (downloadItem.IsValid) then
    exit;

  dlgSaveF.Filter := '��� �����|*.*';
  // dlgSaveF.Filter := 'Excel 97-2003|*.xls|Excel 2007|*.xlsx|Word 97-2003|*.doc|Word 2007|*.docx|ZIP-�����|*zip|��� �����|*.*';
  dlgSaveF.FileName := IncludeTrailingPathDelimiter('%USERPROFILE%\Downloads') + suggestedName;

  if not DirectoryExists(IncludeTrailingPathDelimiter('%USERPROFILE%\Downloads')) then
    dlgSaveF.FileName := IncludeTrailingPathDelimiter('%WINDIR%\Temp') + suggestedName;
  if AppSett.bMSWS12R2 then
    Self.SendToBack;
  if dlgSaveF.Execute then
  begin
    if (length(suggestedName) > 0) then
      TempFullPath := dlgSaveF.FileName
    else
      TempFullPath := 'report';

    callback.cont(TempFullPath, False);
  end;
  // var
  // TempMyDocuments, TempFullPath, TempName: string;
  // begin
  // if not(chrmBrwsr.IsSameBrowser(browser)) or (downloadItem = nil) or
  // not(downloadItem.IsValid) then
  // exit;
  //
  // if SelectDirectory('�������� ���������� ��� �������� Cookies-������', '',
  // TempMyDocuments) then
  // begin
  //
  // if (length(suggestedName) > 0) then
  // TempName := suggestedName
  // else
  // TempName := 'DownloadedFile';
  //
  // if (length(TempMyDocuments) > 0) then

  // TempFullPath := IncludeTrailingPathDelimiter(TempMyDocuments) + TempName
  // else
  // TempFullPath := TempName;
  // callback.cont(TempFullPath, False);
  // end;
end;

procedure TMForm.chrmBrwsrBeforePopup(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo; var client: ICefClient; var settings: TCefBrowserSettings; var noJavascriptAccess: Boolean; var Result: Boolean);
begin
  // ��� popup-��
  Result := (targetDisposition in [WOD_NEW_FOREGROUND_TAB, WOD_NEW_BACKGROUND_TAB, WOD_NEW_POPUP, WOD_NEW_WINDOW]);
end;

procedure TMForm.chrmBrwsrCertificateError(Sender: TObject; const browser: ICefBrowser; certError: Integer; const requestUrl: ustring; const sslInfo: ICefSslInfo; const callback: ICefRequestCallback; out Result: Boolean);
begin
  AddToLog('ERROR "' + IntToStr(certError) + '": chrmBrwsrCertificateError ' + VarToStr(requestUrl));
end;

procedure TMForm.chrmBrwsrClose(Sender: TObject; const browser: ICefBrowser; out Result: Boolean);
begin
  PostMessage(Handle, CEF_DESTROY, 0, 0);
  Result := True;
end;

procedure TMForm.chrmBrwsrDownloadUpdated(Sender: TObject; const browser: ICefBrowser; const downloadItem: ICefDownloadItem; const callback: ICefDownloadItemCallback);
begin
  if not (chrmBrwsr.IsSameBrowser(browser)) then
    exit;

  if downloadItem.IsComplete then
    MessageBox(Application.Handle, '���� ��������', '����������', MB_OK or MB_ICONINFORMATION);
end;

procedure TMForm.BrowserCreatedMsg(var aMessage: TMessage);
begin
  CEFWindowParent1.UpdateSize;
end;

procedure TMForm.BrowserDestroyMsg(var aMessage: TMessage);
begin
  CEFWindowParent1.Free;
end;

// ------------------------------------------------------------------------------
// ������ � SQLite - �� �������
// ------------------------------------------------------------------------------
procedure TMForm.btn1Click(Sender: TObject);
begin
  DM.SQLCon('config.db');
  DM.GetParams;
end;

// ------------------------------------------------------------------------------
// �������� JSON �� HTTP
// ------------------------------------------------------------------------------
procedure TMForm.btn2Click(Sender: TObject);
begin
  DM.SetJson('{userName:"aaa2", pwd:"123456"}');
end;

procedure TMForm.btn4Click(Sender: TObject);
begin
  chrmBrwsr.browser.ReloadIgnoreCache;
end;

procedure TMForm.btnF5Click(Sender: TObject);
begin
  chrmBrwsr.Reload;
end;

procedure TMForm.chrmBrwsrKeyEvent(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: PMsg; out Result: Boolean);
var
  TempMsg: TMsg;
begin
  Result := False;
  if (event <> nil) and (osEvent <> nil) then
    case osEvent.message of
      WM_KEYUP:
        begin
          TempMsg := osEvent^;
          HandleKeyUp(TempMsg, Result);
        end;
      WM_KEYDOWN:
        begin
          TempMsg := osEvent^;
          HandleKeyDown(TempMsg, Result);
        end;
    end;
end;

procedure TMForm.chrmBrwsrLoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
begin
  AddToLog('�������� �������� ��������� = ' + chrmBrwsr.browser.MainFrame.url);
  if Assigned(actvtyndctr1) then
  begin
    actvtyndctr1.Animate := False;
    actvtyndctr1.Visible := False;
  end;
end;

// -----------------------------------------------------------------------------
// ��������� ������ ������ �������� � ��������
// ���� ������ ���� �� ������ "-".
// -----------------------------------------------------------------------------
procedure TMForm.chrmBrwsrLoadError(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; errorCode: Integer; const errorText, failedUrl: ustring);
var
  myYear, myMonth, myDay: word;
  myHour, myMin, mySec, myMilli: word;
begin
  AddToLog('ERROR "' + IntToStr(errorCode) + '": ' + VarToStr(errorText) + ' ' + VarToStr(failedUrl));
  if bAllAut then
  // if not bStartingError then
  // bStartingError := True
  // else
  begin
    case errorCode of      // �ROME_ERROR_101: chrmBrwsr.LoadURL(ExtractFilePath(ParamStr(0)) + ERR_101);
      CHROME_ERROR_105:
        chrmBrwsr.LoadURL(ExtractFilePath(ParamStr(0)) + ERR_105 + '?url=' + AppSett.sDefLink + '&sec=' + IntToStr(AppSett.iRefreshUrl));
      CHROME_ERROR_106:
        chrmBrwsr.LoadURL(ExtractFilePath(ParamStr(0)) + ERR_106 + '?url=' + AppSett.sDefLink + '&sec=' + IntToStr(AppSett.iRefreshUrl));
      CHROME_ERROR_118:
        begin
          chrmBrwsr.LoadURL(ExtractFilePath(ParamStr(0)) + ERR_118 + '?url=' + AppSett.sDefLink + '&sec=' + IntToStr(AppSett.iRefreshUrl));
          Inc(ErrCount.Count118);
          ErrCount.Count2 := 0;
          DecodeDateTime(Now - dtCheck, myYear, myMonth, myDay, myHour, myMin, mySec, myMilli);
          if AppSett.slCams.Count > 0 then
          begin
            if (myMin > AppSett.iCamsCheckDelay) or not bCamsIsChecked then
            begin
              bError := True;
              CamsCheck;
            end;
          end
          else
            bAllAut := True;
        end;
      -3:
        if AppSett.bRedirect3 then
          if Pos('/misc/', LowerCase(VarToStr(failedUrl))) <= 0 then
            chrmBrwsr.LoadURL(AppSett.sDefLink);
    else
      chrmBrwsr.LoadURL(ExtractFilePath(ParamStr(0)) + ERR_118 + '?url=' + AppSett.sDefLink + '&sec=' + IntToStr(AppSett.iRefreshUrl));
      Inc(ErrCount.Count2);
      ErrCount.Count118 := 0;
      DecodeDateTime(Now - dtCheck, myYear, myMonth, myDay, myHour, myMin, mySec, myMilli);
      if AppSett.slCams.Count > 0 then
      begin
        if (myMin > AppSett.iCamsCheckDelay) or not bCamsIsChecked then
        begin
          bError := True;
          CamsCheck;
        end;
      end
      else
        bAllAut := True;
    end;
    if (ErrCount.Count2 = 2) or (ErrCount.Count118 = 2) then
    begin
      tmrMail.Enabled := False;
      Application.CreateForm(TMailForm, MailForm);
      MailForm.Button2.Click;
      // ErrCount.Count2 := 0;
      // ErrCount.Count118 := 0;
      tmrMail.Enabled := True;
    end;
  end;
  bAddr := True;
end;

procedure TMForm.chrmBrwsrLoadStart(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; transitionType: Cardinal);
var
  myYear, myMonth, myDay: word;
  myHour, myMin, mySec, myMilli: word;
begin
  if Assigned(actvtyndctr1) then
  begin
    actvtyndctr1.Visible := True;
    actvtyndctr1.Animate := True;
  end;
  if bAddr then
  begin
    edtAddress.Text := AppSett.sDefLink;
    bAddr := False;
  end
  else
    edtAddress.Text := chrmBrwsr.browser.MainFrame.url;
  AddToLog('�������� �������� = ' + chrmBrwsr.browser.MainFrame.url + ' ������ ' + IntToStr(chrmBrwsr.VisibleNavigationEntry.httpStatusCode));
  if (chrmBrwsr.VisibleNavigationEntry.httpStatusCode = 200) and (chrmBrwsr.browser.MainFrame.url = AppSett.sDefLink) then
  begin
    bCamsIsChecked := False;
    bError := False;
  end
  else if chrmBrwsr.VisibleNavigationEntry.httpStatusCode >= 400 then
  // ���� ����� �� 400 � ����, �� ������� �������� 118
  begin
    chrmBrwsr.LoadURL(ExtractFilePath(ParamStr(0)) + ERR_118 + '?url=' + AppSett.sDefLink + '&sec=' + IntToStr(AppSett.iRefreshUrl));
    Inc(ErrCount.Count2);
    ErrCount.Count118 := 0;
    DecodeDateTime(Now - dtCheck, myYear, myMonth, myDay, myHour, myMin, mySec, myMilli);
    if (myMin > AppSett.iCamsCheckDelay) or not bCamsIsChecked then
    begin
      bError := True;
      CamsCheck;
    end;
  end;
end;

procedure TMForm.chrmBrwsrPreKeyEvent(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: PMsg; out isKeyboardShortcut, Result: Boolean);
begin
  Result := False;

  if (event <> nil) and (event.kind in [KEYEVENT_KEYDOWN, KEYEVENT_KEYUP]) and (event.windows_key_code = VK_ESCAPE) then
    isKeyboardShortcut := True;
end;

procedure TMForm.edtAddressKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnGo1.Click;
end;

procedure TMForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  HTaskbar: HWND;
  OldVal: LongInt;
begin
  try
    // ���������� ������� �������
    // ���� ����� ��������
    HTaskbar := FindWindow('Shell_TrayWnd', nil);
    // ����� ������ ��� Win 95/98/ME. ������� �� ������ ������
    SystemParametersInfo(97, word(False), @OldVal, 0);
    // �������� �������
    EnableWindow(HTaskbar, True);
    // ���������� �������
    ShowWindow(HTaskbar, SW_SHOW);
    if Assigned(actvtyndctr1) then
      actvtyndctr1.Free;
    if Assigned(AppSett.slCams) then
      AppSett.slCams.Free;
    if Assigned(AutCamsThread) then
      FreeAndNil(AutCamsThread);
    if Assigned(MailForm) then
      MailForm.Destroy;
    if Assigned(TabF) then
      TabF.Destroy;
  except

  end;
  AddToLog('���������� �������', True, []);
end;

procedure TMForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
    if not (FClosing) then
    begin
      FClosing := True;
      Visible := False;
      chrmBrwsr.CloseBrowser(True);
    end;
  except

  end;
end;

procedure TMForm.FormCreate(Sender: TObject);
var
  CookieManager: ICefCookieManager;
  CookiesPath: string;
  ProcessID, ThreadID: Cardinal;
  EXEVersionData: TEXEVersionData;
begin
  bIsStartHP := False;
  bCamsIsChecked := False;
  AppSett.slCams := TStringList.Create;
  sAppName := ParamStr(0);
  if not FileExists(ParamStr(3)) or (Pos('\', ParamStr(3)) = 0) then
    AppSett.sIniPath := ExtractFilePath(sAppName) + 'vmxviewer.ini'
  else
    AppSett.sIniPath := ParamStr(3);
  EXEVersionData := GetEXEVersionData(sAppName);
  if DM.ReadIni(ExtractFilePath(sAppName)) then
  begin
{$IFDEF DEBUG}
    AddToLog(EXEVersionData.ProductName + ' ' + EXEVersionData.FileVersion + ' Debug');
{$ELSE}
    AddToLog(EXEVersionData.ProductName + ' ' + EXEVersionData.FileVersion + ' Release');
    pnlNavigation1.Enabled := False;
    btnGo1.Visible := False;
{$ENDIF}
    ThreadID := GetWindowThreadProcessId(Application.Handle, ProcessID);
    AddToLog('PID = ' + VarToStr(ThreadID));
    AddToLog('��������� ������� = ' + AppSett.sIniPath, True, []);
  end;
  if not AppSett.bNavPanel then
  begin
    pnlNavigation1.Visible := False;
    AddToLog('������������� ������ ������');
  end;
  edtAddress.Text := AppSett.sDefLink;
  // ��������� ���������� ��� �������
  CookiesPath := IncludeTrailingPathDelimiter(AppSett.sDefCookiesDir);
  CookieManager := TCefCookieManagerRef.Global(nil);
  CookieManager.SetStoragePath(CookiesPath, True, nil);
  FCanClose := False;
  FClosing := False;
  KeyPreview := True;
  bAddr := False;
  // ��������� ���������� ������� ����������
  if (UpperCase(Trim(ParamStr(2))) = 'KIOSK') or AppSett.bKiosk then
  begin
    if UpperCase(Trim(ParamStr(2))) = 'KIOSK' then
      AddToLog('������ � ������ ������. ParamStr = KIOSK', True, [])
    else
      AddToLog('������ � ������ ������. bKiosk = True', True, []);
    pnlNavigation1.Visible := False;
    with Self do
    begin
      BorderStyle := bsNone;
      // FormStyle := fsStayOnTop;
      Left := 0;
      Top := 0;
      Height := Screen.Height;
      Width := Screen.Width;
      OldCreateOrder := False;
    end;
  end;
  ApplyIni;
  bAllAut := False;
  bStartingError := False;
  sRealDefLink := AppSett.sDefLink;
  if AppSett.slCams.Count > 0 then
  begin
    // AppSett.sDefLink := AppSett.slCams.Strings[0];
    AppSett.sDefLink := ExtractFilePath(ParamStr(0)) + 'Respond\start.html';
    pnlCamResp.Top := Round(CEFWindowParent1.Height / 2 - pnlCamResp.Height / 2);
    pnlCamResp.Left := Round(CEFWindowParent1.Width / 2 - pnlCamResp.Width / 2);
    pnlCamResp.Visible := True;
  end;
  if length(Trim(ParamStr(1))) <> 0 then
  begin
    AddToLog('�������� �������� �� ��������� ����� ����� �������� ��������� ������', True, []);
    AppSett.sDefLink := Trim(ParamStr(1));
  end;

  if not Assigned(AutCamsThread) and (AppSett.slCams.Count > 0) then
  begin
    // Application.CreateForm(TTabF, TabF);
    // TabF.Show;
    AutCamsThread := TAutCamsThread.Create(False);
    AutCamsThread.Priority := tpNormal;
  end
  else if AppSett.slCams.Count = 0 then
    bAllAut := True;
  ErrCount.Count2 := 0;
  ErrCount.Count118 := 0;
  tmrMail.Interval := AppSett.iMTimeOut;
end;

procedure TMForm.FormResize(Sender: TObject);
begin
  // ��������� �������� ��������� �������� �������� ������ �� ������ ����
  if Assigned(actvtyndctr1) then
  begin
    if CEFWindowParent1.Height > Round(actvtyndctr1.Height / 2) then
      actvtyndctr1.Top := Round(CEFWindowParent1.Height / 2) - Round(actvtyndctr1.Height / 2);
    if CEFWindowParent1.Width > Round(actvtyndctr1.Width / 2) then
      actvtyndctr1.Left := Round(CEFWindowParent1.Width / 2) - Round(actvtyndctr1.Width / 2);
  end;
end;

procedure TMForm.FormShow(Sender: TObject);
begin
  chrmBrwsr.DefaultUrl := AppSett.sDefLink;
  AddToLog('�������� �� ��������� ������ = ' + AppSett.sDefLink);
  if not (chrmBrwsr.CreateBrowser(CEFWindowParent1, '')) then
    tmrCrtBrwsr.Enabled := True;
end;

procedure TMForm.WriteToFile(sPath, sText: string);
var
  tfFile: TextFile;
begin
{$I-}
  try
    if not DirectoryExists(AppSett.sPathLog) then
      SysUtils.ForceDirectories(AppSett.sPathLog);
    AssignFile(tfFile, sPath);
    Append(tfFile); // ��������� ���� ��� ����������� � �����
    if IoResult <> 0 then // ���������, ��� ��������
    // � ������ �������� Exception ��� ������ �����-������
    // ��������� �� ����� ������ �������� �� �����
    try
      ReWrite(tfFile);
    except
    end;
    try
      WriteLn(tfFile, sText);
    except
    end;
    try
      CloseFile(tfFile);
    except
    end;
  except

  end;
{$I+}
end;

procedure TMForm.WriteLogFile(sText: string);
var
  sPath: string;
begin
  sPath := IncludeTrailingPathDelimiter(AppSett.sPathLog);
  WriteToFile(AppSett.sPathLog + FormatDateTime('yyyymmdd', Now) + '.log', sText);
end;

// *****************************************************************************
// ������ ������ � ���
// *****************************************************************************
procedure TMForm.actCloseExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMForm.actGoExecute(Sender: TObject);
begin
  chrmBrwsr.StopLoad;
  chrmBrwsr.LoadURL(edtAddress.Text);
end;

procedure TMForm.actHelpExecute(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, PWideChar('readme.pdf'), nil, nil, SW_SHOWNORMAL);
end;

procedure TMForm.actShowSettExecute(Sender: TObject);
begin
  Application.CreateForm(TSetForm, SetForm);
  SetForm.ShowModal;
end;

procedure TMForm.AddToLog(sValue: string; bAddDateTime: Boolean = True; fsStyle: TFontStyles = []; Color: Integer = 0);
begin
  if AppSett.bLog then
  begin
    if bAddDateTime then
      sValue := '[' + DateTimeToStr(Now) + ']: ' + sValue;
    WriteLogFile(sValue);
  end;
end;

procedure TMForm.WMMove(var aMessage: TWMMove);
begin
  inherited;

  if (chrmBrwsr <> nil) then
    chrmBrwsr.NotifyMoveOrResizeStarted;
end;

procedure TMForm.WMMoving(var aMessage: TMessage);
begin
  inherited;

  if (chrmBrwsr <> nil) then
    chrmBrwsr.NotifyMoveOrResizeStarted;
end;

procedure TMForm.WMEnterMenuLoop(var aMessage: TMessage);
begin
  inherited;

  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then
    GlobalCEFApp.OsmodalLoop := True;
end;

procedure TMForm.WMExitMenuLoop(var aMessage: TMessage);
begin
  inherited;

  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then
    GlobalCEFApp.OsmodalLoop := False;
end;

end.

