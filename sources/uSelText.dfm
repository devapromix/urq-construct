object fSelText: TfSelText
  Left = 254
  Top = 197
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1090#1077#1082#1089#1090#1072
  ClientHeight = 78
  ClientWidth = 667
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
    Width = 665
    Height = 13
    AutoSize = False
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090
  end
  object btOK: TBitBtn
    Left = 448
    Top = 48
    Width = 107
    Height = 30
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btCancel: TBitBtn
    Left = 560
    Top = 48
    Width = 107
    Height = 30
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object edText: TEdit
    Left = 0
    Top = 16
    Width = 667
    Height = 21
    TabOrder = 2
  end
  object btClear: TBitBtn
    Left = 0
    Top = 48
    Width = 107
    Height = 30
    Caption = 'Clear'
    TabOrder = 3
    OnClick = btClearClick
  end
end
