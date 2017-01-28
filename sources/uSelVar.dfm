object fSelVar: TfSelVar
  Left = 380
  Top = 214
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1087#1077#1088#1077#1084#1077#1085#1085#1099#1093
  ClientHeight = 182
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
    Top = 0
    Width = 217
    Height = 13
    AutoSize = False
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1077#1088#1077#1084#1077#1085#1085#1086#1081
  end
  object Label2: TLabel
    Left = 0
    Top = 104
    Width = 217
    Height = 13
    AutoSize = False
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1087#1077#1088#1077#1084#1077#1085#1085#1086#1081' '#1080#1083#1080' '#1074#1099#1088#1072#1078#1077#1085#1080#1077
  end
  object edVar: TComboBox
    Left = 0
    Top = 16
    Width = 217
    Height = 21
    DropDownCount = 25
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
  end
  object edValue: TEdit
    Left = 0
    Top = 120
    Width = 217
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object BitBtn1: TBitBtn
    Left = 0
    Top = 152
    Width = 107
    Height = 30
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 112
    Top = 152
    Width = 107
    Height = 30
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object VarType: TRadioGroup
    Left = 0
    Top = 48
    Width = 217
    Height = 49
    Caption = #1058#1080#1087' '#1087#1077#1088#1077#1084#1077#1085#1085#1086#1081
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1042#1099#1088#1072#1078#1077#1085#1080#1077
      #1057#1090#1088#1086#1082#1072)
    TabOrder = 4
  end
end
