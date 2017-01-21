unit uSelRoom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfSelRoom = class(TForm)
    RoomList: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    BitBtn3: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetRoom(const CurrentRoom: string): string;
  end;

var
  fSelRoom: TfSelRoom;

implementation

uses uMain, uAddRoom;

{$R *.dfm}

{ TfSelRoom }

function TfSelRoom.GetRoom(const CurrentRoom: string): string;
var
  I: Integer;
begin
  Result := '';
  RoomList.Items.Assign(fMain.GetRooms(CurrentRoom));
  I := RoomList.Items.IndexOf('common');
  if (I >= 0) then RoomList.Items.Delete(I);
  if (Self.ShowModal = mrCancel) or (RoomList.ItemIndex < 0) then Exit;
  Result := Trim(RoomList.Items.Strings[RoomList.ItemIndex]);
end;

procedure TfSelRoom.FormShow(Sender: TObject);
begin
  Self.RoomList.SetFocus;
  Self.RoomList.ItemIndex := 0;
end;

procedure TfSelRoom.BitBtn3Click(Sender: TObject);
begin
  fAddRoom.NewRoom; // Добавить новую комнату
end;

end.
