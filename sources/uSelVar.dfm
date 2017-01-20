object fSelVar: TfSelVar
  Left = 338
  Top = 203
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1087#1077#1088#1077#1084#1077#1085#1085#1099#1093
  ClientHeight = 322
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edVar: TComboBox
    Left = 32
    Top = 24
    Width = 289
    Height = 21
    DropDownCount = 25
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
  end
  object edValue: TEdit
    Left = 32
    Top = 136
    Width = 289
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object BitBtn1: TBitBtn
    Left = 48
    Top = 216
    Width = 113
    Height = 57
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 256
    Top = 216
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object VarType: TRadioGroup
    Left = 32
    Top = 64
    Width = 289
    Height = 49
    Caption = #1058#1080#1087' '#1087#1077#1088#1077#1084#1077#1085#1085#1086#1081
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1042#1099#1088#1072#1078#1077#1085#1080#1077
      #1057#1090#1088#1086#1082#1072)
    TabOrder = 4
    OnClick = VarTypeClick
  end
end
