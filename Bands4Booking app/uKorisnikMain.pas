unit uKorisnikMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, System.ImageList,
  FMX.ImgList, Data.DB, uDM;

type
  TFrmKorisnikMain = class(TForm)
    Top: TLayout;
    Bottom: TLayout;
    Middle: TLayout;
    lUser: TLabel;
    btClose: TButton;
    UpHalf: TLayout;
    recBG: TRectangle;
    lZdravo: TLabel;
    recTopBG: TRectangle;
    cProfilePic: TCircle;
    Image1: TImage;
    recPretraga: TRoundRect;
    lPretraga: TLabel;
    Image2: TImage;
    btSort: TCornerButton;
    imgSort: TImage;
    BotHalf: TLayout;
    recBotHalf: TRectangle;
    MidSlika: TLayout;
    imgSlikaMain: TImage;
    recBottomBG: TRectangle;
    Opcije: TLayout;
    btBend: TCornerButton;
    btPevac: TCornerButton;
    btDJ: TCornerButton;
    btGitarista: TCornerButton;
    BotIzvodjaci: TLayout;
    recIzvodjac: TRectangle;
    recSlika: TRectangle;
    imgBend: TImage;
    lbNazivBenda: TLabel;
    lbVrsta: TLabel;
    btHome: TButton;
    ImageList1: TImageList;
    btFavorite: TButton;
    btChat: TButton;
    btNotif: TButton;
    btnDodaj: TCornerButton;
    procedure btnDodajClick(Sender: TObject);
    procedure btChatClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  procedure LoadIzvodjacData(const Username: string);
  procedure LoadBendData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmKorisnikMain: TFrmKorisnikMain;

implementation

{$R *.fmx}

uses uProfilIzvodjaca, uKorisnikAllChat, uIzbor;

procedure TFrmKorisnikMain.btChatClick(Sender: TObject);
begin
  if not Assigned(FrmKorisnikAllChat) then
    FrmKorisnikAllChat := TFrmKorisnikAllChat.Create(nil);
  try
    Self.Hide;
    FrmKorisnikAllChat.Show;
    FrmKorisnikAllChat.BringToFront;
  except
    FrmKorisnikAllChat.Free;
    raise;
  end;
end;

procedure TFrmKorisnikMain.btCloseClick(Sender: TObject);
begin
  if not Assigned(FrmIzbor) then
    FrmIzbor := TFrmIzbor.Create(Application);

  FrmIzbor.Show;
  FrmIzbor.BringToFront;
  Self.Hide;
end;

procedure TFrmKorisnikMain.btnDodajClick(Sender: TObject);
begin
  if not Assigned(FrmProfilIzvodjaca) then
    FrmProfilIzvodjaca := TFrmProfilIzvodjaca.Create(Application);

  FrmProfilIzvodjaca.LoadProfilIzvodjaca('your_username');

  Self.Hide;

  try
    FrmProfilIzvodjaca.ShowModal;
  finally
    FrmProfilIzvodjaca.Free;
    Self.Show;
  end;
end;
procedure TFrmKorisnikMain.FormShow(Sender: TObject);
begin
LoadBendData;
end;
procedure TFrmKorisnikMain.LoadBendData;
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    with DM.QTemp do
    begin
      SQL.Clear;
      SQL.Text := 'SELECT naziv_benda, slika FROM oglas WHERE username = :username';
      Params.ParamByName('username').AsString := 'your_username';
      Open;

      if not IsEmpty then
      begin
        lbNazivBenda.Text := FieldByName('naziv_benda').AsString;

        if not FieldByName('slika').IsNull then
        begin
          TBlobField(FieldByName('slika')).SaveToStream(Stream);
          Stream.Position := 0;
          imgBend.Bitmap.LoadFromStream(Stream);
        end
        else
        begin
          imgBend.Bitmap := nil;
        end;
      end
      else
      begin
        lbNazivBenda.Text := 'Bend nije pronađen';
        imgBend.Bitmap := nil;
      end;
    end;
  finally
    Stream.Free;
  end;
end;
procedure TFrmKorisnikMain.LoadIzvodjacData(const Username: string);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    with DM.QTemp do
    begin
      SQL.Clear;
      SQL.Text := 'SELECT naziv_benda, slika FROM oglas WHERE username = :username';
      Params.ParamByName('username').AsString := Username;
      Open;
      if not IsEmpty then
      begin
        lbNazivBenda.Text := FieldByName('naziv_benda').AsString;

        if not FieldByName('slika').IsNull then
        begin
          TBlobField(FieldByName('slika')).SaveToStream(Stream);
          Stream.Position := 0;
          imgBend.Bitmap.LoadFromStream(Stream);
        end;
      end;
    end;
  finally
    Stream.Free;
  end;
end;

end.
