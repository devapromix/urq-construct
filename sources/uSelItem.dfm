object fSelItem: TfSelItem
  Left = 479
  Top = 159
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1087#1088#1077#1076#1084#1077#1090#1086#1074
  ClientHeight = 174
  ClientWidth = 219
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
  object Label1: TLabel
    Left = 0
    Top = 112
    Width = 137
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
  end
  object Label2: TLabel
    Left = 0
    Top = 0
    Width = 217
    Height = 13
    AutoSize = False
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1088#1077#1076#1084#1077#1090#1072
  end
  object edItem: TComboBox
    Left = 0
    Top = 16
    Width = 217
    Height = 21
    DropDownCount = 25
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
  end
  object edAmount: TEdit
    Left = 144
    Top = 112
    Width = 57
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object btOK: TBitBtn
    Left = 0
    Top = 144
    Width = 107
    Height = 30
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btOKClick
  end
  object btCancel: TBitBtn
    Left = 112
    Top = 144
    Width = 107
    Height = 30
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object Switch: TRadioGroup
    Left = 0
    Top = 48
    Width = 217
    Height = 49
    Caption = #1044#1077#1081#1089#1090#1074#1080#1077
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1044#1086#1073#1072#1074#1080#1090#1100
      #1059#1076#1072#1083#1080#1090#1100)
    TabOrder = 4
  end
  object UpDn: TUpDown
    Left = 201
    Top = 112
    Width = 15
    Height = 21
    Associate = edAmount
    Min = 1
    Max = 32767
    Position = 1
    TabOrder = 5
  end
end
