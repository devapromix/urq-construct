object fAddItem: TfAddItem
  Left = 627
  Top = 233
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1088#1077#1076#1084#1077#1090
  ClientHeight = 78
  ClientWidth = 220
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 217
    Height = 13
    AutoSize = False
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1085#1086#1074#1086#1075#1086' '#1087#1088#1077#1076#1084#1077#1090#1072
  end
  object cbItemName: TComboBox
    Left = 0
    Top = 16
    Width = 220
    Height = 21
    DropDownCount = 25
    ItemHeight = 13
    TabOrder = 0
  end
  object btOK: TBitBtn
    Left = 0
    Top = 48
    Width = 107
    Height = 30
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = btOKClick
  end
  object btCancel: TBitBtn
    Left = 112
    Top = 48
    Width = 107
    Height = 30
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
