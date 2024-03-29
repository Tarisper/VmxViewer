object TabForm: TTabForm
  Left = 0
  Top = 0
  Caption = 'Initializing browser. Please wait...'
  ClientHeight = 404
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonPnl: TPanel
    Left = 0
    Top = 0
    Width = 512
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    Caption = 'ButtonPnl'
    Enabled = False
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 0
    object NavButtonPnl: TPanel
      Left = 5
      Top = 5
      Width = 125
      Height = 25
      Align = alLeft
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 1
      object BackBtn: TButton
        Left = 50
        Top = 0
        Width = 25
        Height = 25
        Align = alLeft
        Caption = '3'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = False
        OnClick = BackBtnClick
      end
      object ForwardBtn: TButton
        Left = 75
        Top = 0
        Width = 25
        Height = 25
        Align = alLeft
        Caption = '4'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Visible = False
        OnClick = ForwardBtnClick
      end
      object StopBtn: TButton
        Left = 100
        Top = 0
        Width = 25
        Height = 25
        Align = alLeft
        Caption = '='
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Visible = False
        OnClick = StopBtnClick
      end
      object RemoveTabBtn: TButton
        Left = 25
        Top = 0
        Width = 25
        Height = 25
        Align = alLeft
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = RemoveTabBtnClick
      end
      object AddTabBtn: TButton
        Left = 0
        Top = 0
        Width = 25
        Height = 25
        Align = alLeft
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = AddTabBtnClick
      end
    end
    object ConfigPnl: TPanel
      Left = 457
      Top = 5
      Width = 50
      Height = 25
      Align = alRight
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 2
      object GoBtn: TButton
        Left = 0
        Top = 0
        Width = 25
        Height = 25
        Align = alLeft
        Caption = #9658
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = GoBtnClick
      end
      object ReloadBtn: TButton
        Left = 25
        Top = 0
        Width = 25
        Height = 25
        Align = alLeft
        Caption = 'q'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = ReloadBtnClick
      end
    end
    object URLEditPnl: TPanel
      Left = 130
      Top = 5
      Width = 327
      Height = 25
      Align = alClient
      BevelOuter = bvNone
      Padding.Top = 2
      TabOrder = 0
      object URLCbx: TComboBox
        Left = 0
        Top = 2
        Width = 327
        Height = 21
        Align = alClient
        TabOrder = 0
        Text = 'https://www.google.com'
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 35
    Width = 512
    Height = 369
    Align = alClient
    TabOrder = 1
    OnChange = PageControl1Change
  end
end
