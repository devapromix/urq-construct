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
    Label1: TLabel;
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    SL: TStringList;
    FNewRoomName: string;
  public
    { Public declarations }
    function NewRoom: string;
  end;

var
  fAddRoom: TfAddRoom;

implementation

uses uMain, uCommon;

{$R *.dfm}

procedure TfAddRoom.FormCreate(Sender: TObject);
begin
  SL := TStringList.Create;
end;

procedure TfAddRoom.btOKClick(Sender: TObject);
var
  I: Integer;
begin
  SL.Assign(GetResource(rtRoom, ''));
  FNewRoomName := LowerCase(Trim(cbRoomName.Text));
  for I := 0 to SL.Count - 1 do
    if (FNewRoomName = '') or (FNewRoomName = SL.Strings[I]) then
    begin
      ShowMessage('!!!');
      Exit;
    end;
  if (FNewRoomName = 'common') and (fMain.TVR.Items.Count <= 1) then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  AddTVItem(fMain.TVR, FNewRoomName, 3, 4);
  fMain.QL.Append('');
  fMain.Modified := True;
  Self.ModalResult := mrOk;
end;

function TfAddRoom.NewRoom: string;
var
  I, C: Integer;
  F: Boolean;
begin
  Result := '';
  FNewRoomName := '';
  Self.cbRoomName.Clear;
  SL.Assign(GetResource(rtRoom, ''));
  C := 0;
  repeat
    F := True;
    FNewRoomName := RoomDefaultName + IntToStr(C);
    for I := 0 to SL.Count - 1 do
    begin
      if (FNewRoomName = SL.Strings[I]) then
      begin
        Inc(C);
        F := False;
        Break;
      end;
    end;
  until F;
  Self.cbRoomName.Items.Assign(SL);
  Self.cbRoomName.Text := FNewRoomName;
  FormShowModal(Self);
  Result := FNewRoomName;
end;

procedure TfAddRoom.FormShow(Sender: TObject);
begin
  Self.cbRoomName.SetFocus;
end;

procedure TfAddRoom.FormDestroy(Sender: TObject);
begin
  SL.Free;
end;

end.
