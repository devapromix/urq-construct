object fRoom: TfRoom
  Left = 468
  Top = 154
  Width = 396
  Height = 236
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1083#1086#1082#1072#1094#1080#1081
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 152
    Top = 152
    Width = 33
    Height = 33
    TabOrder = 0
    Visible = False
    WordWrap = False
  end
  object CLB: TCheckListBox
    Left = 0
    Top = 25
    Width = 388
    Height = 183
    Align = alTop
    ItemHeight = 13
    TabOrder = 1
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 388
    Height = 25
    AutoSize = True
    ButtonHeight = 23
    Caption = 'ToolBar1'
    EdgeBorders = []
    EdgeInner = esNone
    EdgeOuter = esNone
    Images = ButsImages
    TabOrder = 2
    object btClose: TToolButton
      Left = 0
      Top = 2
      Hint = 'Close'
      Caption = 'btClose'
      ImageIndex = 3
      OnClick = btCloseClick
    end
    object ToolButton4: TToolButton
      Left = 23
      Top = 2
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 31
      Top = 2
      Hint = 'p'
      Caption = 'ToolButton7'
      ImageIndex = 4
      OnClick = ToolButton7Click
    end
    object ToolButton8: TToolButton
      Left = 54
      Top = 2
      Hint = 'pln'
      Caption = 'ToolButton8'
      ImageIndex = 5
      OnClick = ToolButton8Click
    end
    object ToolButton1: TToolButton
      Left = 77
      Top = 2
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButton10: TToolButton
      Left = 85
      Top = 2
      Hint = 'btn'
      Caption = 'ToolButton10'
      ImageIndex = 4
      OnClick = ToolButton10Click
    end
    object ToolButton9: TToolButton
      Left = 108
      Top = 2
      Width = 8
      Caption = 'ToolButton9'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btAddGoTo: TToolButton
      Left = 116
      Top = 2
      Hint = 'goto'
      ImageIndex = 0
      OnClick = btAddGoToClick
    end
    object ToolButton2: TToolButton
      Left = 139
      Top = 2
      Hint = 'proc'
      ImageIndex = 1
      OnClick = ToolButton2Click
    end
    object ToolButton6: TToolButton
      Left = 162
      Top = 2
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 170
      Top = 2
      Hint = 'cls'
      Caption = 'ToolButton3'
      ImageIndex = 2
      OnClick = ToolButton3Click
    end
    object ToolButton5: TToolButton
      Left = 193
      Top = 2
      Hint = 'clsb'
      Caption = 'ToolButton5'
      ImageIndex = 3
      OnClick = ToolButton5Click
    end
    object ToolButton11: TToolButton
      Left = 216
      Top = 2
      Width = 8
      Caption = 'ToolButton11'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButton12: TToolButton
      Left = 224
      Top = 2
      Hint = 'var'
      Caption = 'ToolButton12'
      ImageIndex = 4
      OnClick = ToolButton12Click
    end
    object ToolButton13: TToolButton
      Left = 247
      Top = 2
      Width = 8
      Caption = 'ToolButton13'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton14: TToolButton
      Left = 255
      Top = 2
      Hint = 'Item'
      Caption = 'ToolButton14'
      ImageIndex = 5
      OnClick = ToolButton14Click
    end
  end
  object ButsImages: TImageList
    Left = 16
    Top = 40
  end
end
