unit uEditText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Menus, ExtCtrls, ActnList, ImgList,
  StdActns, ToolWin, System.ImageList, System.Actions;

type
  TfEditText = class(TForm)
    RE: TRichEdit;
    PopupMenu1: TPopupMenu;
    Panel1: TPanel;
    btOk: TBitBtn;
    btCancel: TBitBtn;
    ActionList1: TActionList;
    ImageList1: TImageList;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    EditDelete1: TEditDelete;
    EditUndo1: TEditUndo;
    EditCut1: TEditCut;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditCopy1: TEditCopy;
    ToolBar1: TToolBar;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    btClear: TBitBtn;
    procedure btOkClick(Sender: TObject);
    procedure btClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fEditText: TfEditText;

implementation

uses uSelText;

{$R *.dfm}

procedure TfEditText.btClearClick(Sender: TObject);
begin
  // Очистить окно редактора от текста
  RE.Clear;
  RE.SetFocus;
end;

procedure TfEditText.btOkClick(Sender: TObject);
var
  I: Integer;
  S: string;
begin
  // Передать текст одной строкой в редактор
  S := '';
  for I := 0 to RE.Lines.Count - 1 do
    S := S + RE.Lines[I].Trim + #32;
  fSelText.edText.Text := S.Trim;
  fSelText.edText.SetFocus;
end;

end.
