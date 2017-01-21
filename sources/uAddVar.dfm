object fAddVar: TfAddVar
  Left = 378
  Top = 232
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1087#1077#1088#1077#1084#1077#1085#1085#1091#1102
  ClientHeight = 290
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cbVarName: TComboBox
    Left = 104
    Top = 64
    Width = 201
    Height = 21
    DropDownCount = 25
    ItemHeight = 13
    TabOrder = 0
  end
  object btOK: TBitBtn
    Left = 56
    Top = 152
    Width = 113
    Height = 57
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = btOKClick
  end
  object btCancel: TBitBtn
    Left = 232
    Top = 160
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
