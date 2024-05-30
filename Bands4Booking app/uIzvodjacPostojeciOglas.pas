unit uIzvodjacPostojeciOglas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, System.ImageList, FMX.ImgList,
  FMX.Controls.Presentation, FMX.Layouts, uDM, Data.DB;

type
  TFrmIzvodjacPostojeciOglas = class(TForm)
    Bottom: TLayout;
    recBottomBG: TRectangle;
    btChat: TButton;
    btFavorite: TButton;
    btHome: TButton;
    btNotif: TButton;
    Butt: TImageList;
    Middle: TLayout;
    UpHalf: TLayout;
    recBG: TRectangle;
    recImg: TRectangle;
    Image1: TImage;
    btnImg: TCornerButton;
    BotHalf: TLayout;
    recBotHalf: TRectangle;
    txtBiografija: TText;
    recBiografija: TRectangle;
    lineUsername: TLine;
    edBiografija: TEdit;
    lbBiografija: TLabel;
    btnSave: TButton;
    recNaziv: TRectangle;
    Line1: TLine;
    lbNaziv: TLabel;
    edNaziv: TEdit;
    OpenDialog1: TOpenDialog;
    Top: TLayout;
    recTopBG: TRectangle;
    txtTop: TText;
    btBack: TButton;
    procedure btnImgClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnEditNameClick(Sender: TObject);
    procedure btnEditBiographyClick(Sender: TObject);
    procedure btnEditImageClick(Sender: TObject);
    procedure btBackClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    ImageFilePath: string;

    procedure SaveOglasToDatabase;
    { Private declarations }
  public
  procedure LoadOglasData;
    { Public declarations }
  end;

var
  FrmIzvodjacPostojeciOglas: TFrmIzvodjacPostojeciOglas;

implementation

{$R *.fmx}

uses uIzvodjacMain;

procedure TFrmIzvodjacPostojeciOglas.btBackClick(Sender: TObject);
begin
  Self.Hide;

  if not Assigned(FrmIzvodjacMain) then
    FrmIzvodjacMain := TFrmIzvodjacMain.Create(Application);

  FrmIzvodjacMain.Show;
  FrmIzvodjacMain.BringToFront;
  Application.ProcessMessages;
end;


procedure TFrmIzvodjacPostojeciOglas.btnEditBiographyClick(Sender: TObject);
begin
  edBiografija.ReadOnly := False;
end;

procedure TFrmIzvodjacPostojeciOglas.btnEditImageClick(Sender: TObject);
begin
  btnImgClick(Sender);
end;

procedure TFrmIzvodjacPostojeciOglas.btnEditNameClick(Sender: TObject);
begin
  edNaziv.ReadOnly := False;
end;
procedure TFrmIzvodjacPostojeciOglas.btnImgClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    ImageFilePath := OpenDialog1.FileName;
    Image1.Bitmap.LoadFromFile(ImageFilePath);
    ShowMessage('Slika učitana.');
  end;
end;

procedure TFrmIzvodjacPostojeciOglas.btnSaveClick(Sender: TObject);

begin
  SaveOglasToDatabase;
end;

procedure TFrmIzvodjacPostojeciOglas.FormCreate(Sender: TObject);
begin
OnShow := FormShow;
end;

procedure TFrmIzvodjacPostojeciOglas.FormShow(Sender: TObject);
begin
LoadOglasData;
end;

procedure TFrmIzvodjacPostojeciOglas.LoadOglasData;
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    with DM.QTemp do
    begin
      SQL.Clear;
      SQL.Text := 'SELECT naziv_benda, biografija, slika FROM oglas WHERE username = :username';
      Params.ParamByName('username').AsString := 'your_username';
      Open;

      if not IsEmpty then
      begin
        edNaziv.Text := FieldByName('naziv_benda').AsString;
        edBiografija.Text := FieldByName('biografija').AsString;

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
      end;
    end;
  finally
    Stream.Free;
  end;
end;

procedure TFrmIzvodjacPostojeciOglas.SaveOglasToDatabase;
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    if ImageFilePath <> '' then
    begin
      Image1.Bitmap.SaveToStream(Stream);
      Stream.Position := 0;
    end;

  with DM.QTemp do
    begin
      SQL.Clear;
      SQL.Text := 'UPDATE oglas SET naziv_benda = :naziv, biografija = :biografija, slika = :slika WHERE username = :username';
      Params.ParamByName('naziv').AsString := edNaziv.Text;
      Params.ParamByName('biografija').AsString := edBiografija.Text;


      Params.ParamByName('slika').DataType := ftBlob;

      if ImageFilePath <> '' then
        Params.ParamByName('slika').LoadFromStream(Stream, ftBlob)
      else
        Params.ParamByName('slika').Clear;

      Params.ParamByName('username').AsString := 'your_username';
      ExecSQL;
    end;

    ShowMessage('Podaci su uspešno ažurirani.');
  finally
    Stream.Free;
  end;
end;
end.
