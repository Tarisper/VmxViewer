object SetForm: TSetForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 352
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grp1: TGroupBox
    Left = 8
    Top = 8
    Width = 321
    Height = 170
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
    TabOrder = 0
    object lbl1: TLabel
      Left = 16
      Top = 19
      Width = 79
      Height = 13
      Caption = #1040#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072':'
    end
    object lbl2: TLabel
      Left = 16
      Top = 46
      Width = 55
      Height = 13
      Caption = #1040#1076#1088#1077#1089' API:'
    end
    object lbl3: TLabel
      Left = 16
      Top = 65
      Width = 65
      Height = 26
      Caption = #1044#1080#1088#1077#1082#1090#1086#1088#1080#1103' Cookies:'
      WordWrap = True
    end
    object Label1: TLabel
      Left = 21
      Top = 124
      Width = 187
      Height = 26
      Caption = #1055#1072#1091#1079#1072' '#1087#1077#1088#1077#1076' '#1087#1086#1087#1099#1090#1082#1086#1081' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1085#1072' '#1075#1083#1072#1074#1085#1091#1102' '#1089#1090#1088#1072#1085#1080#1094#1091' ('#1074' '#1089#1077#1082'.):'
      WordWrap = True
    end
    object edtSrvAddr: TEdit
      Left = 101
      Top = 16
      Width = 209
      Height = 21
      TabOrder = 0
      OnChange = edtSrvAddrChange
    end
    object edtAPIAdr: TEdit
      Left = 101
      Top = 43
      Width = 209
      Height = 21
      TabOrder = 1
      OnChange = edtAPIAdrChange
    end
    object edtCookiesDir: TEdit
      Left = 101
      Top = 70
      Width = 172
      Height = 21
      TabOrder = 2
      OnChange = edtCookiesDirChange
    end
    object btnCookiesDir: TButton
      Left = 279
      Top = 70
      Width = 31
      Height = 21
      Caption = '...'
      TabOrder = 3
      OnClick = btnCookiesDirClick
    end
    object chkWriteLog: TCheckBox
      Left = 16
      Top = 97
      Width = 79
      Height = 17
      Caption = #1042#1077#1089#1090#1080' '#1083#1086#1075':'
      TabOrder = 4
      OnClick = chkWriteLogClick
    end
    object edtLogsDir: TEdit
      Left = 101
      Top = 97
      Width = 172
      Height = 21
      TabOrder = 5
      OnChange = edtLogsDirChange
    end
    object btnLogsDir: TButton
      Left = 279
      Top = 97
      Width = 31
      Height = 21
      Caption = '...'
      TabOrder = 6
      OnClick = btnLogsDirClick
    end
    object spedPause: TSpinEdit
      Left = 214
      Top = 124
      Width = 96
      Height = 22
      MaxValue = 300
      MinValue = 0
      TabOrder = 7
      Value = 0
      OnChange = spedPauseChange
    end
  end
  object grp2: TGroupBox
    Left = 8
    Top = 184
    Width = 321
    Height = 129
    Caption = #1042#1085#1077#1096#1085#1080#1081' '#1074#1080#1076
    TabOrder = 1
    object chkKiosk: TCheckBox
      Left = 16
      Top = 24
      Width = 169
      Height = 17
      Caption = #1047#1072#1087#1091#1089#1082' '#1074' '#1088#1077#1078#1080#1084#1077' "'#1082#1080#1086#1089#1082#1072'"'
      TabOrder = 0
      OnClick = chkKioskClick
    end
    object chkShowAddrStr: TCheckBox
      Left = 16
      Top = 47
      Width = 169
      Height = 17
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089#1090#1088#1086#1082#1091' '#1072#1076#1088#1077#1089#1072
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = chkShowAddrStrClick
    end
    object chkShohCloseBtn: TCheckBox
      Left = 16
      Top = 70
      Width = 273
      Height = 17
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1082#1085#1086#1087#1082#1091' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = chkShohCloseBtnClick
    end
    object chkShowSettBtn: TCheckBox
      Left = 16
      Top = 93
      Width = 273
      Height = 17
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1082#1085#1086#1087#1082#1091' '#1085#1072#1089#1090#1088#1086#1077#1082' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
      TabOrder = 3
      OnClick = chkShowSettBtnClick
    end
  end
  object btnOk: TButton
    Left = 48
    Top = 319
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnSave: TButton
    Left = 136
    Top = 319
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 222
    Top = 319
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = actCancelExecute
  end
  object dlgOpenDir: TOpenDialog
    Left = 272
    Top = 8
  end
end
