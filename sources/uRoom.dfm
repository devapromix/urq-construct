object fRoom: TfRoom
  Left = 468
  Top = 154
  Width = 475
  Height = 236
  Caption = #1050#1086#1084#1085#1072#1090#1072
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001001010000001001800680300001600000028000000100000002000
    000001001800000000000000000000000000000000000000000000000000FF00
    FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
    00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
    FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
    FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
    00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
    FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
    FFFF00FFFF00FFFF00FFD6A684E78242E78242E78242E78242E78242E78242D6
    A684FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE78242BDB6B5
    B5AEADA5A2A59C96948C86847B7573E78242FF00FFFF00FFFF00FFFF00FFFF00
    FFFF00FFFF00FFFF00FFE78242BDB6B5FFFFFFFFFFFFFFFFFFFFFFFF7B797BE7
    8242FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE78242BDB6B5
    FFFFFFFFFFFFF7F7F7EFEBEF7B797BE78242FF00FFFF00FFFF00FFFF00FFFF00
    FFFF00FFFF00FFFF00FFE78242BDB6B5FFFBFFEFEFEFEFEFEFEFEFEF7B797BE7
    8242FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE78242BDB6B5
    E7E7E7E7E7E7EFEFEFF7F3F77B797BE78242FF00FFFF00FFFF00FFFF00FFFF00
    FFFF00FFFF00FFFF00FFE78242BDBABDB5AEADA5A2A59C96948C86847B7573E7
    8242FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD6A684E78242
    E78242E78242E78242E78242E78242D6A684FF00FFFF00FFFF00FFFF00FFFF00
    FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
    00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
    FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
    FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
    00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
    FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
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
    Width = 467
    Height = 184
    OnClickCheck = CLBClickCheck
    Align = alClient
    ItemHeight = 13
    PopupMenu = PM
    TabOrder = 1
    OnDblClick = CLBDblClick
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 467
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
    object btPrintLine: TToolButton
      Left = 31
      Top = 2
      Action = acPrintLn
    end
    object btPrint: TToolButton
      Left = 54
      Top = 2
      Action = acPrint
    end
    object ToolButton1: TToolButton
      Left = 77
      Top = 2
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btButton: TToolButton
      Left = 85
      Top = 2
      Action = acBtn
    end
    object ToolButton9: TToolButton
      Left = 108
      Top = 2
      Width = 8
      Caption = 'ToolButton9'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btGoto: TToolButton
      Left = 116
      Top = 2
      Action = acGoto
    end
    object btProc: TToolButton
      Tag = 1
      Left = 139
      Top = 2
      Action = acProc
    end
    object ToolButton6: TToolButton
      Left = 162
      Top = 2
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object btCLS: TToolButton
      Left = 170
      Top = 2
      Action = acCLS
    end
    object btCLSB: TToolButton
      Left = 193
      Top = 2
      Action = acCLSB
    end
    object btInvKill: TToolButton
      Left = 216
      Top = 2
      Action = acInvKill
    end
    object btPerKill: TToolButton
      Left = 239
      Top = 2
      Action = acPerKill
    end
    object ToolButton11: TToolButton
      Left = 262
      Top = 2
      Width = 8
      Caption = 'ToolButton11'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 270
      Top = 2
      Action = acExpression
    end
    object ToolButton8: TToolButton
      Left = 293
      Top = 2
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 301
      Top = 2
      Action = acStartBlock
    end
    object ToolButton5: TToolButton
      Left = 324
      Top = 2
      Action = acFinishBlock
    end
    object ToolButton2: TToolButton
      Left = 347
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object ToolButton12: TToolButton
      Left = 355
      Top = 2
      Hint = 'var'
      Caption = 'ToolButton12'
      ImageIndex = 4
      OnClick = ToolButton12Click
    end
    object ToolButton13: TToolButton
      Left = 378
      Top = 2
      Width = 8
      Caption = 'ToolButton13'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton14: TToolButton
      Left = 386
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
  object PM: TPopupMenu
    Images = ButsImages
    Left = 48
    Top = 40
    object N1: TMenuItem
      Action = acDelete
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Action = acClear
    end
  end
  object ActionList1: TActionList
    Images = ButsImages
    Left = 80
    Top = 40
    object acDelete: TAction
      Category = 'PopupMenu'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = acDeleteExecute
      OnUpdate = acDeleteUpdate
    end
    object acGoto: TAction
      Category = 'OperatorsGroupB'
      Caption = 'acGoto'
      Hint = 'goto'
      OnExecute = acOpGrBExecute
    end
    object acProc: TAction
      Tag = 1
      Category = 'OperatorsGroupB'
      Caption = 'acProc'
      Hint = 'proc'
      OnExecute = acOpGrBExecute
    end
    object acStartBlock: TAction
      Tag = 4
      Category = 'OperatorsGroupA'
      Caption = 'acPerKill'
      Hint = 'startblock'
      OnExecute = acOpGrAExecute
    end
    object acFinishBlock: TAction
      Tag = 5
      Category = 'OperatorsGroupA'
      Caption = 'acPerKill'
      Hint = 'finishblock'
      OnExecute = acOpGrAExecute
    end
    object acCLS: TAction
      Category = 'OperatorsGroupA'
      Caption = 'acCLS'
      Hint = 'cls'
      OnExecute = acOpGrAExecute
    end
    object acCLSB: TAction
      Tag = 1
      Category = 'OperatorsGroupA'
      Caption = 'acCLSB'
      Hint = 'clsb'
      OnExecute = acOpGrAExecute
    end
    object acInvKill: TAction
      Tag = 2
      Category = 'OperatorsGroupA'
      Caption = 'acInvKill'
      Hint = 'invkill'
      OnExecute = acOpGrAExecute
    end
    object acPerKill: TAction
      Tag = 3
      Category = 'OperatorsGroupA'
      Caption = 'acPerKill'
      Hint = 'perkill'
      OnExecute = acOpGrAExecute
    end
    object acBtn: TAction
      Category = 'OperatorsGroupC'
      Caption = 'acBtn'
      Hint = 'Btn'
      OnExecute = acOpGrCExecute
    end
    object acPrint: TAction
      Tag = 1
      Category = 'OperatorsGroupD'
      Caption = 'acPrint'
      Hint = 'print'
      OnExecute = acOpGrDExecute
    end
    object acPrintLn: TAction
      Category = 'OperatorsGroupD'
      Caption = 'acPrintLn'
      Hint = 'println'
      OnExecute = acOpGrDExecute
    end
    object acClear: TAction
      Category = 'PopupMenu'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnExecute = acClearExecute
      OnUpdate = acClearUpdate
    end
    object acExpression: TAction
      Category = 'OperatorsGroupE'
      Caption = 'acExpression'
      Hint = 'Expression'
      OnExecute = acOpGrEExecute
    end
  end
end