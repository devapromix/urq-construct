object fEditItem: TfEditItem
  Left = 190
  Top = 107
  Width = 487
  Height = 480
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1087#1088#1077#1076#1084#1077#1090#1086#1074
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
  object edItem: TComboBox
    Left = 32
    Top = 24
    Width = 289
    Height = 21
    DropDownCount = 25
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
  end
  object edAmount: TEdit
    Left = 32
    Top = 136
    Width = 57
    Height = 21
    TabOrder = 1
    Text = '1'
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
  object Switch: TRadioGroup
    Left = 32
    Top = 64
    Width = 289
    Height = 49
    Caption = #1044#1077#1081#1089#1090#1074#1080#1077
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1044#1086#1073#1072#1074#1080#1090#1100
      #1059#1076#1072#1083#1080#1090#1100)
    TabOrder = 4
  end
  object UpDown1: TUpDown
    Left = 89
    Top = 136
    Width = 15
    Height = 21
    Associate = edAmount
    Min = 1
    Max = 32767
    Position = 1
    TabOrder = 5
  end
end
