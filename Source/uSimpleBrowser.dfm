object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'VMX Viewer'
  ClientHeight = 516
  ClientWidth = 756
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ChromiumWindow1: TChromiumWindow
    Left = 0
    Top = 30
    Width = 756
    Height = 486
    Align = alClient
    TabStop = True
    TabOrder = 0
    OnClose = ChromiumWindow1Close
    OnBeforeClose = ChromiumWindow1BeforeClose
    OnAfterCreated = ChromiumWindow1AfterCreated
    ExplicitTop = 31
  end
  object AddressPnl: TPanel
    Left = 0
    Top = 0
    Width = 756
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    ShowCaption = False
    TabOrder = 1
    Visible = False
    object AddressEdt: TEdit
      Left = 5
      Top = 5
      Width = 715
      Height = 20
      Margins.Right = 5
      Align = alClient
      TabOrder = 0
      Text = 'http://www.google.com'
      ExplicitHeight = 21
    end
    object GoBtn: TButton
      Left = 720
      Top = 5
      Width = 31
      Height = 20
      Margins.Left = 5
      Align = alRight
      Caption = 'Go'
      TabOrder = 1
      OnClick = GoBtnClick
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 80
    Top = 56
  end
  object chrm1: TChromium
    OnBeforeContextMenu = chrm1BeforeContextMenu
    Left = 80
    Top = 120
  end
end
