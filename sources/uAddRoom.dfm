object fAddRoom: TfAddRoom
  Left = 353
  Top = 207
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1083#1086#1082#1072#1094#1080#1102
  ClientHeight = 286
  ClientWidth = 303
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
  object btOK: TButton
    Left = 32
    Top = 192
    Width = 75
    Height = 41
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btOKClick
  end
  object cbRoomName: TComboBox
    Left = 80
    Top = 88
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 1
  end
  object btCancel: TButton
    Left = 184
    Top = 208
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
