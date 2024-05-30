unit uKorisnikChat;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, System.ImageList, FMX.ImgList, FMX.Controls.Presentation,
  FMX.Layouts, FMX.Edit, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TFrmKorisnikChat = class(TForm)
    Bottom: TLayout;
    recBottomBG: TRectangle;
    Middle: TLayout;
    Top: TLayout;
    recTopBG: TRectangle;
    cProfilePic: TCircle;
    txtTop: TText;
    Image1: TImage;
    btBack: TButton;
    recLinija: TRectangle;
    recChatting: TRectangle;
    edChatting: TEdit;
    btnPosalji: TButton;
    MemoChat: TMemo;
    Placanje: TLayout;
    Rectangle1: TRectangle;
    btPlati: TButton;
    btnOceni: TButton;
    procedure btBackClick(Sender: TObject);
    procedure btnPosaljiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btPlatiClick(Sender: TObject);
    procedure btnOceniClick(Sender: TObject);



  private

    FUsername: string;
    procedure LoadMessagesFromFile;
    procedure SaveMessagesToFile(const Msg: string);
    { Private declarations }
  public
  constructor Create(AOwner: TComponent; const AUsername: string); reintroduce; overload;
    { Public declarations }
  end;

var
  FrmKorisnikChat: TFrmKorisnikChat;

implementation

{$R *.fmx}

uses uKorisnikMain, uProfilIzvodjaca, uDM, uPlacanje, uOceni;
const
  ChatFileName = 'chat_log.txt';

constructor TFrmKorisnikChat.Create(AOwner: TComponent; const AUsername: string);
begin
  inherited Create(AOwner);
  FUsername := AUsername;
end;

procedure TFrmKorisnikChat.btBackClick(Sender: TObject);
begin
  if not Assigned(FrmProfilIzvodjaca) then
    FrmProfilIzvodjaca := TFrmProfilIzvodjaca.Create(Application);
    FrmProfilIzvodjaca.Show;

  Self.Hide;
end;




procedure TFrmKorisnikChat.btnOceniClick(Sender: TObject);
var
  UserId, PerformerId: Integer;
begin
  UserId := 1;
  PerformerId := 1;

  FrmOceni := TFrmOceni.Create(Application);
  FrmOceni.Initialize(UserId, PerformerId);
  FrmOceni.Show;

  Close;
end;

procedure TFrmKorisnikChat.btnPosaljiClick(Sender: TObject);
begin
  if edChatting.Text <> '' then
  begin

    MemoChat.Lines.Add(FUsername + ': ' + edChatting.Text);
    SaveMessagesToFile(FUsername + ': ' + edChatting.Text);

    edChatting.Text := '';
  end;
end;



procedure TFrmKorisnikChat.btPlatiClick(Sender: TObject);
var
  UserId, PerformerId: Integer;
  UserName, PerformerName: string;
begin

  UserId := 1;
  PerformerId := 1;
  UserName := 'User Name';


  FrmPlacanje := TFrmPlacanje.Create(Application);
  FrmPlacanje.Initialize(UserId, PerformerId, UserName, PerformerName);
  FrmPlacanje.Show;
  Self.Hide;
end;

procedure TFrmKorisnikChat.FormCreate(Sender: TObject);
begin
LoadMessagesFromFile;
end;

procedure TFrmKorisnikChat.LoadMessagesFromFile;
begin
  if FileExists(ChatFileName) then
  begin
    MemoChat.Lines.LoadFromFile(ChatFileName);
  end;
end;

procedure TFrmKorisnikChat.SaveMessagesToFile(const Msg: string);
begin

  var Lines: TStrings;
  Lines := TStringList.Create;
  try
    if FileExists(ChatFileName) then
      Lines.LoadFromFile(ChatFileName);
    Lines.Add(Msg);
    Lines.SaveToFile(ChatFileName);
  finally
    Lines.Free;
  end;
end;
end.
