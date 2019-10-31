object MailForm: TMailForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'MailTest'
  ClientHeight = 304
  ClientWidth = 253
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 271
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 89
    Top = 271
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 3
    OnClick = Button2Click
  end
  object grp1: TGroupBox
    Left = 8
    Top = 8
    Width = 237
    Height = 161
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1080#1089#1093#1086#1076#1103#1097#1077#1081' '#1087#1086#1095#1090#1099
    TabOrder = 0
    object lbl3: TLabel
      Left = 11
      Top = 76
      Width = 45
      Height = 26
      Caption = #1040#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072':'
      WordWrap = True
    end
    object lbl4: TLabel
      Left = 11
      Top = 108
      Width = 41
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100':'
    end
    object Label1: TLabel
      Left = 12
      Top = 24
      Width = 31
      Height = 26
      Caption = 'E-mail "'#1054#1090'":'
      WordWrap = True
    end
    object Label2: TLabel
      Left = 12
      Top = 58
      Width = 41
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100':'
    end
    object Edit1: TEdit
      Left = 60
      Top = 24
      Width = 165
      Height = 21
      TabOrder = 0
      Text = 'a103-blackscreen1@vsk.sibur.ru'
    end
    object Edit2: TEdit
      Left = 59
      Top = 51
      Width = 165
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
      Text = '40uzKdgA'
    end
    object Edit3: TEdit
      Left = 60
      Top = 78
      Width = 165
      Height = 21
      TabOrder = 2
      Text = 'smtp.sibur.local'
    end
    object se1: TSpinEdit
      Left = 60
      Top = 105
      Width = 74
      Height = 22
      MaxLength = 5
      MaxValue = 65536
      MinValue = 1
      TabOrder = 3
      Value = 25
    end
    object chkUseSSL: TCheckBox
      Left = 11
      Top = 133
      Width = 202
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' SSL '#1096#1080#1092#1088#1086#1074#1072#1085#1080#1077
      TabOrder = 4
    end
  end
  object grp2: TGroupBox
    Left = 8
    Top = 175
    Width = 237
    Height = 90
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1072#1076#1088#1077#1089#1072#1090#1072
    TabOrder = 1
    object lbl1: TLabel
      Left = 11
      Top = 24
      Width = 37
      Height = 26
      Caption = 'E-mail "'#1050#1086#1084#1091'":'
      WordWrap = True
    end
    object lbl2: TLabel
      Left = 11
      Top = 58
      Width = 41
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100':'
    end
    object Edit5: TEdit
      Left = 60
      Top = 24
      Width = 165
      Height = 21
      TabOrder = 0
      Text = 'a103-blackscreen2@vsk.sibur.ru'
    end
    object edt1: TEdit
      Left = 60
      Top = 51
      Width = 165
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
      Text = 'BDPK5ny5'
    end
  end
  object btn1: TButton
    Left = 170
    Top = 271
    Width = 75
    Height = 25
    Caption = 'Send v2'
    TabOrder = 4
  end
  object IdSMTP1: TIdSMTP
    SASLMechanisms = <>
    Left = 128
    Top = 24
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 192
    Top = 24
  end
  object IdIPWatch1: TIdIPWatch
    Active = False
    HistoryFilename = 'iphist.dat'
    Left = 192
    Top = 104
  end
end
