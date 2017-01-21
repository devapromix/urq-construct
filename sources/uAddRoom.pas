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
    FNewRoomName: string;
  public
    { Public declarations }
    function NewRoom: string;
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
  I: Integer;
  S: TStringList;
begin
  FNewRoomName := LowerCase(Trim(cbRoomName.Text));
  S := TStringList.Create;
  S.Assign(fMain.GetRooms(''));
  for I := 0 to S.Count - 1 do
    if (FNewRoomName = '') or (FNewRoomName = S.Strings[I]) then
    begin
      ShowMessage('!!!');
      Exit;
    end;
  if (FNewRoomName = 'common') and (fMain.TVR.Items.Count <= 1) then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  F := fMain.TVR.Items.Item[0];
  fMain.TVR.Items.AddChild(F, FNewRoomName);
  fMain.QL.Append('');
  S.Free;
  Self.ModalResult := mrOk;
end;

function TfAddRoom.NewRoom: string;
var
  I, C: Integer;
  S: TStringList;
  F: Boolean;
begin
  Result := '';
  FNewRoomName := '';
  Self.cbRoomName.Clear;
  S := TStringList.Create;
  S.Assign(fMain.GetRooms(''));
  C := 0;
  repeat
    F := True;
    FNewRoomName := RoomDefaultName + IntToStr(C);
    for I := 0 to S.Count - 1 do
    begin
      if (FNewRoomName = S.Strings[I]) then
      begin
        Inc(C);
        F := False;
        Break;
      end;
    end;
  until F;
  Self.cbRoomName.Items.Assign(S);
  Self.cbRoomName.Text := FNewRoomName;
  Self.ShowModal;
  Result := FNewRoomName;
  S.Free;
end;

procedure TfAddRoom.FormShow(Sender: TObject);
begin
  Self.cbRoomName.SetFocus;
end;

end.
