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
    lblVrsta: TLabel;
    lblZanrovi: TLabel;
    procedure btnBackClick(Sender: TObject);
    procedure btnChatClick(Sender: TObject);
  private
    FOglasID: Integer;
    procedure LoadProfile;
  public
    procedure LoadProfilIzvodjaca(const OglasID: Integer);
    procedure ShowProfile(OglasID: Integer);
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

procedure TFrmProfilIzvodjaca.LoadProfile;
begin
  with DM.QTemp do
  begin
    SQL.Clear;
    SQL.Text := 'SELECT * FROM oglas WHERE id = :id';
    Params.ParamByName('id').AsInteger := FOglasID;
    Open;
    if not Eof then
    begin
      LabelNaziv.Text := FieldByName('naziv_benda').AsString;
      lblVrsta.Text := 'Vrsta: ' + FieldByName('vrsta').AsString;
      lblZanrovi.Text := 'Žanrovi: ' + FieldByName('zanrovi').AsString;
      MemoBiografija.Text := FieldByName('biografija').AsString;
      lbRating.Text := 'Ocena: ' + FieldByName('ocena').AsString;
      if not FieldByName('slika').IsNull then
      begin
        var Stream := TMemoryStream.Create;
        try
          TBlobField(FieldByName('slika')).SaveToStream(Stream);
          Stream.Position := 0;
          Image1.Bitmap.LoadFromStream(Stream);
        finally
          Stream.Free;
        end;
      end;
    end;
    Close;
  end;
end;

procedure TFrmProfilIzvodjaca.LoadProfilIzvodjaca(const OglasID: Integer);
begin
  FOglasID := OglasID;
  LoadProfile;
end;

procedure TFrmProfilIzvodjaca.ShowProfile(OglasID: Integer);
begin
  LoadProfilIzvodjaca(OglasID);
  Show;
end;

end.

