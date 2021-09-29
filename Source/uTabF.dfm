object TabF: TTabF
  Left = 0
  Top = 0
  Caption = 'TabF'
  ClientHeight = 638
  ClientWidth = 748
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object pgcT: TPageControl
    Left = 0
    Top = 30
    Width = 748
    Height = 608
    Align = alClient
    TabOrder = 0
  end
  object tlb1: TToolBar
    Left = 0
    Top = 0
    Width = 748
    Height = 30
    AutoSize = True
    ButtonHeight = 30
    ButtonWidth = 41
    Caption = 'tlb1'
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 1
    object btnGo1: TToolButton
      Left = 0
      Top = 0
      ParentShowHint = False
      ShowHint = True
      OnClick = btnGo1Click
    end
  end
end
