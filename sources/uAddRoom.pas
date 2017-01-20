unit uAddRoom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask;

type
  TfAddRoom = class(TForm)
    btOK: TButton;
    cbRoomName: TComboBox;
    btCancel: TButton;
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NewRoom;
  end;

const
  RoomDefaultName = 'room';
  RoomsCategoryName = 'Все локации';

var
  fAddRoom: TfAddRoom;

implementation

uses uMain;

{$R *.dfm}

procedure TfAddRoom.btOKClick(Sender: TObject);
var
  F: TTreeNode;
  NewRoomName: string;
  I: Integer;
  S: TStringList;
begin
  NewRoomName := LowerCase(Trim(cbRoomName.Text));
  S := TStringList.Create;
  S.Assign(fMain.GetRooms(''));
  for I := 0 to S.Count - 1 do
    if (NewRoomName = '') or (NewRoomName = S.Strings[I]) then
    begin
      ShowMessage('!!!');
      Exit;
    end;
  if (NewRoomName = 'common') and (fMain.TVR.Items.Count <= 1) then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  F := fMain.TVR.Items.Item[0];
  fMain.TVR.Items.AddChild(F, NewRoomName);
  fMain.QL.Append('');
  S.Free;
  Self.ModalResult := mrOk;
end;

procedure TfAddRoom.NewRoom;
var
  I, C: Integer;
  S: TStringList;
  NewRoomName: string;
  F: Boolean;
begin
  NewRoomName := '';
  Self.cbRoomName.Clear;
  S := TStringList.Create;
  S.Assign(fMain.GetRooms(''));
  C := 0;
  repeat
    F := True;
    NewRoomName := RoomDefaultName + IntToStr(C);
    for I := 0 to S.Count - 1 do
    begin
      if (NewRoomName = S.Strings[I]) then
      begin
        Inc(C);
        F := False;
        Break;
      end;
    end;
  until F;
  Self.cbRoomName.Items.Assign(S);
  Self.cbRoomName.Text := NewRoomName;
  Self.ShowModal;
  S.Free;
end;

procedure TfAddRoom.FormShow(Sender: TObject);
begin
  Self.cbRoomName.SetFocus;
end;

end.
