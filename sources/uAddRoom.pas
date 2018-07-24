unit uAddRoom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, Buttons;

type
  TfAddRoom = class(TForm)
    btOK: TBitBtn;
    cbRoomName: TComboBox;
    btCancel: TBitBtn;
    lbDescr: TLabel;
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FNewRoomName: string;
  public
    { Public declarations }
    function NewRoom: string;
  end;

var
  fAddRoom: TfAddRoom;

implementation

uses uMain, uCommon, uUtils;

{$R *.dfm}

procedure TfAddRoom.btOKClick(Sender: TObject);
var
  I: Integer;
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    Common.GetResource(SL, rtRoom, '');
    FNewRoomName := LowerCase(Trim(cbRoomName.Text));
    if (FNewRoomName = '') then
    begin
      ShowMessage('!!!');
      Exit;
    end;
    for I := 0 to SL.Count - 1 do
      if (FNewRoomName = SL.Strings[I]) then
      begin
        ShowMessage('!!!');
        Exit;
      end;
    if (FNewRoomName = 'common') and (fMain.TVR.Items.Count <= 1) then
    begin
      ShowMessage('!!!');
      Exit;
    end;
    if Common.IsErName(FNewRoomName) then
    begin
      ShowMessage('!!!');
      Exit;
    end;
    if Common.IsErChar(FNewRoomName) then
    begin
      ShowMessage('!!!');
      Exit;
    end;
    Common.AddTVItem(fMain.TVR, FNewRoomName, 3, 4);
    fMain.QL.Append('');
    fMain.Modified := True;
    Self.ModalResult := mrOk;
  finally
    FreeAndNil(SL);
  end;
end;

function TfAddRoom.NewRoom: string;
var
  I, C: Integer;
  F: Boolean;
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    Result := '';
    FNewRoomName := '';
    Self.cbRoomName.Clear;
    Common.GetResource(SL, rtRoom, '');
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
    Utils.ShowForm(Self);
    Result := FNewRoomName;
    fMain.CreateRoom(FNewRoomName);
  finally
    FreeAndNil(SL);
  end;
end;

procedure TfAddRoom.FormShow(Sender: TObject);
begin
  Self.cbRoomName.SetFocus;
end;

end.
