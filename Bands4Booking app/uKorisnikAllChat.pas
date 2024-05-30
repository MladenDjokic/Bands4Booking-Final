unit uKorisnikAllChat;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, System.ImageList, FMX.ImgList,
  FMX.Layouts;

type
  TFrmKorisnikAllChat = class(TForm)
    Bottom: TLayout;
    recBottomBG: TRectangle;
    Middle: TLayout;
    recBG: TRectangle;
    Top: TLayout;
    recTopBG: TRectangle;
    cProfilePic: TCircle;
    Image1: TImage;
    txtTop: TText;
    btBack: TButton;
    lbBend: TRectangle;
    Chat1: TLayout;
    recChat1: TRectangle;
    Image2: TImage;
    Label1: TLabel;
    btBendChat: TButton;
    procedure btBackClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btBendChatClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmKorisnikAllChat: TFrmKorisnikAllChat;

implementation

{$R *.fmx}

uses uKorisnikMain, uKorisnikChat;

procedure TFrmKorisnikAllChat.btBackClick(Sender: TObject);
begin
  if not Assigned(FrmKorisnikMain) then
    FrmKorisnikMain := TFrmKorisnikMain.Create(nil);
  try
    FrmKorisnikMain.Show;
    FrmKorisnikMain.BringToFront;
    Self.Hide;
  except
    FrmKorisnikMain.Free;
    raise;
  end;
end;
procedure TFrmKorisnikAllChat.btBendChatClick(Sender: TObject);
begin

  FrmKorisnikChat := TFrmKorisnikChat.Create(nil);
  try

    FrmKorisnikChat.Show;

    Self.Hide;
  except
    FrmKorisnikChat.Free;
    raise;
  end;
end;

procedure TFrmKorisnikAllChat.btCloseClick(Sender: TObject);
begin
Application.Terminate;
end;

end.
