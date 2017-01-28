object fSelRoom: TfSelRoom
  Left = 250
  Top = 155
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = #1042#1099#1073#1088#1072#1090#1100' '#1083#1086#1082#1072#1094#1080#1102
  ClientHeight = 214
  ClientWidth = 387
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
    Width = 387
    Height = 13
    Align = alTop
    AutoSize = False
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1089#1099#1083#1082#1091' '#1085#1072' '#1083#1086#1082#1072#1094#1080#1102
  end
  object RoomList: TListBox
    Left = 0
    Top = 13
    Width = 387
    Height = 161
    Align = alTop
    ItemHeight = 13
    TabOrder = 0
  end
  object btOK: TBitBtn
    Left = 168
    Top = 184
    Width = 105
    Height = 30
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TBitBtn
    Left = 280
    Top = 184
    Width = 107
    Height = 30
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object btNew: TBitBtn
    Left = 0
    Top = 184
    Width = 107
    Height = 30
    Caption = #1053#1086#1074#1072#1103
    TabOrder = 3
    OnClick = btNewClick
  end
end
