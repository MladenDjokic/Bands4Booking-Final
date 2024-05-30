unit uProfilIzvodjaca;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, Data.DB, uDM,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TFrmProfilIzvodjaca = class(TForm)
    Top: TLayout;
    Bottom: TLayout;
    Middle: TLayout;
    recTop: TRectangle;
    recMid: TRectangle;
    RecBot: TRectangle;
    btnBack: TButton;
    lbTop: TLabel;
    btnFavorite: TButton;
    recImg: TRectangle;
    Image1: TImage;
    LabelNaziv: TLabel;
    MemoBiografija: TMemo;
    lbBiografija: TLabel;
    btnChat: TButton;
    imgRating: TImage;
    lbRating: TLabel;
    procedure btnBackClick(Sender: TObject);
    procedure btnChatClick(Sender: TObject);
  private
    { Private declarations }
  public
  procedure LoadProfilIzvodjaca(const Username: string);
    { Public declarations }
  end;

var
  FrmProfilIzvodjaca: TFrmProfilIzvodjaca;

implementation

{$R *.fmx}

uses uKorisnikMain, uKorisnikChat;
procedure TFrmProfilIzvodjaca.btnBackClick(Sender: TObject);
begin
  Self.Hide;

  if not Assigned(FrmKorisnikMain) then
    FrmKorisnikMain := TFrmKorisnikMain.Create(Application);

  FrmKorisnikMain.Show;
  FrmKorisnikMain.BringToFront;
  Application.ProcessMessages;
end;

procedure TFrmProfilIzvodjaca.btnChatClick(Sender: TObject);
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

procedure TFrmProfilIzvodjaca.LoadProfilIzvodjaca(const Username: string);
var
  Stream: TMemoryStream;
  AverageRating: Double;
begin
  Stream := TMemoryStream.Create;
  try
    with DM.QTemp do
    begin
      SQL.Clear;
      SQL.Text := 'SELECT naziv_benda, biografija, slika FROM oglas WHERE username = :username';
      Params.ParamByName('username').AsString := Username;
      Open;
      if not IsEmpty then
      begin
        LabelNaziv.Text := FieldByName('naziv_benda').AsString;
        MemoBiografija.Text := FieldByName('biografija').AsString;

        if not FieldByName('slika').IsNull then
        begin
          TBlobField(FieldByName('slika')).SaveToStream(Stream);
          Stream.Position := 0;
          Image1.Bitmap.LoadFromStream(Stream);
        end
        else
        begin
          Image1.Bitmap := nil;
        end;
      end
      else
      begin
        LabelNaziv.Text := 'Bend nije pronađen';
        MemoBiografija.Text := '';
        Image1.Bitmap := nil;
      end;


      SQL.Clear;
      SQL.Text := 'SELECT AVG(rating) AS avg_rating FROM ratings WHERE performer_id = (SELECT id FROM performers WHERE username = :username)';
      Params.ParamByName('username').AsString := Username;
      Open;

      if not FieldByName('avg_rating').IsNull then
      begin
        AverageRating := FieldByName('avg_rating').AsFloat;
        lbRating.Text := Format('Prosečna ocena: %.1f', [AverageRating]);
      end
      else
      begin
        lbRating.Text := 'Još nema ocena';
      end;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Greška prilikom učitavanja ocena: ' + E.Message);
      lbRating.Text := 'Greška pri učitavanju ocena';
    end;
  end;
  Stream.Free;
end;


end.
