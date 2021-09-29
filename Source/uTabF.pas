unit uTabF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, uCEFChromium, uCEFWindowParent, uCEFInterfaces,
  uCEFTypes, uCEFConstants, uCEFWinControl, uCEFCookieVisitor,
  uCEFCookieManager, Vcl.ToolWin;

type
  TTabF = class(TForm)
    pgcT: TPageControl;
    tlb1: TToolBar;
    btnGo1: TToolButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnGo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLink(const Link: string);
  protected
    function SearchChromium(aPageIndex: integer; var aChromium: TChromium):
      boolean;
    function GetPageIndex(const aSender: TObject; var aPageIndex: integer):
      boolean;
    procedure Chromium_OnClose(Sender: TObject; const browser: ICefBrowser; var
      aAction: TCefCloseBrowserAction);
    procedure Chromium_OnBeforeClose(Sender: TObject; const browser:
      ICefBrowser);
    procedure Chromium_OnAfterCreated(Sender: TObject; const browser:
      ICefBrowser);
    procedure Chromium_OnAddressChange(Sender: TObject; const browser:
      ICefBrowser; const frame: ICefFrame; const url: ustring);
    procedure CloseAllBrowsers;
    procedure AddTab;
  end;

var
  TabF: TTabF;
  TempSheet: TTabSheet;
  TempWindowParent: TCEFWindowParent;
  TempChromium: TChromium;

implementation

{$R *.dfm}

uses
  uMainForm;

function TTabF.SearchChromium(aPageIndex: integer; var aChromium: TChromium):
  Boolean;
var
  i, j: integer;
  TempComponent: TComponent;
begin
  Result := False;
  aChromium := nil;

  if (aPageIndex >= 0) and (aPageIndex < pgcT.PageCount) then
  begin
    TempSheet := pgcT.Pages[aPageIndex];
    i := 0;
    j := TempSheet.ComponentCount;

    while (i < j) and not (Result) do
    begin
      TempComponent := TempSheet.Components[i];

      if (TempComponent <> nil) and (TempComponent is TChromium) then
      begin
        aChromium := TChromium(TempComponent);
        Result := True;
      end
      else
        inc(i);
    end;
  end;
end;

function TTabF.GetPageIndex(const aSender: TObject; var aPageIndex: integer):
  boolean;
begin
  Result := False;
  aPageIndex := -1;

  if (aSender <> nil) and (aSender is TComponent) and (TComponent(aSender).Owner
    <> nil) and (TComponent(aSender).Owner is TTabSheet) then
  begin
    aPageIndex := TTabSheet(TComponent(aSender).Owner).PageIndex;
    Result := True;
  end;
end;

procedure TTabF.Chromium_OnClose(Sender: TObject; const browser: ICefBrowser;
  var aAction: TCefCloseBrowserAction);
var
  TempPageIndex: integer;
begin
  if GetPageIndex(Sender, TempPageIndex) then
    PostMessage(Handle, CEFBROWSER_DESTROYWNDPARENT, 0, TempPageIndex);
end;

procedure TTabF.Chromium_OnBeforeClose(Sender: TObject; const browser:
  ICefBrowser);
var
  TempPageIndex: integer;
begin
  if GetPageIndex(Sender, TempPageIndex) then
  begin
//    if FClosing then
      PostMessage(Handle, CEFBROWSER_CHECKTAGGEDTABS, 0, TempPageIndex)
//    else
//      PostMessage(Handle, CEFBROWSER_DESTROYTAB, 0, TempPageIndex);
  end;
end;

procedure TTabF.Chromium_OnAfterCreated(Sender: TObject; const browser:
  ICefBrowser);
var
  TempPageIndex: integer;
begin
  if GetPageIndex(Sender, TempPageIndex) then
    PostMessage(Handle, CEF_AFTERCREATED, 0, TempPageIndex);
end;

procedure TTabF.Chromium_OnAddressChange(Sender: TObject; const browser:
  ICefBrowser; const frame: ICefFrame; const url: ustring);
//var
//  TempPageIndex: integer;
begin
//
end;

procedure TTabF.AddTab;

begin
  pgcT.Enabled := False;

  TempSheet := TTabSheet.Create(pgcT);
  TempSheet.Caption := 'New Tab';
  TempSheet.PageControl := pgcT;

  TempWindowParent := TCEFWindowParent.Create(TempSheet);
  TempWindowParent.Parent := TempSheet;
  TempWindowParent.Color := clWhite;
  TempWindowParent.Align := alClient;

  TempChromium := TChromium.Create(TempSheet);
  TempChromium.OnAfterCreated := Chromium_OnAfterCreated;

  TempChromium.OnClose := Chromium_OnClose;
  TempChromium.OnBeforeClose := Chromium_OnBeforeClose;

  TempChromium.CreateBrowser(TempWindowParent, '');
end;

procedure TTabF.AddLink(const Link: string);
begin
  AddTab;
  if SearchChromium(pgcT.TabIndex, TempChromium) then
    TempChromium.LoadURL(Link);
end;

procedure TTabF.btnGo1Click(Sender: TObject);
begin
  AddLink('https://www.google.com/');
end;

procedure TTabF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (pgcT.PageCount <> 0) then
  begin
    Visible := False;
    CloseAllBrowsers;
  end;
end;

procedure TTabF.CloseAllBrowsers;
var
  i, j, k: integer;
  TempComponent: TComponent;
  TempCtnue: boolean;
begin
  k := pred(pgcT.PageCount);

  while (k >= 0) do
  begin
    TempSheet := pgcT.Pages[k];
    TempCtnue := True;
    i := 0;
    j := TempSheet.ComponentCount;

    while (i < j) and TempCtnue do
    begin
      TempComponent := TempSheet.Components[i];

      if (TempComponent <> nil) and (TempComponent is TChromium) then
      begin
        TChromium(TempComponent).CloseBrowser(True);
        TempCtnue := False;
      end
      else
        inc(i);
    end;

    dec(k);
  end;
end;

end.

