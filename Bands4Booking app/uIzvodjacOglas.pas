unit uIzvodjacOglas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, System.ImageList, FMX.ImgList, FMX.Controls.Presentation,
  FMX.Layouts, FMX.Edit, uDM, Data.DB;

type
  TFrmIzvodjacOglas = class(TForm)
    Bottom: TLayout;
    recBottomBG: TRectangle;
    btChat: TButton;
    btFavorite: TButton;
    btHome: TButton;
    btNotif: TButton;
    Butt: TImageList;
    Middle: TLayout;
    UpHalf: TLayout;
    BotHalf: TLayout;
    recBotHalf: TRectangle;
    Top: TLayout;
    recTopBG: TRectangle;
    txtTop: TText;
    recBG: TRectangle;
    recImg: TRectangle;
    Image1: TImage;
    btnImg: TCornerButton;
    txtBiografija: TText;
    btBack: TButton;
    recBiografija: TRectangle;
    lineUsername: TLine;
    lbBiografija: TLabel;
    edBiografija: TEdit;
    recNaziv: TRectangle;
    Line1: TLine;
    lbNaziv: TLabel;
    edNaziv: TEdit;
    btnSave: TButton;
    OpenDialog1: TOpenDialog;
    procedure btBackClick(Sender: TObject);
    procedure btnImgClick(Sender: TObject);
    procedure btnNazivClick(Sender: TObject);
    procedure btnBiografijaClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    ImageFilePath: string;
    procedure SaveOglasToDatabase;
  public
    { Public declarations }
  end;

var
  FrmIzvodjacOglas: TFrmIzvodjacOglas;

implementation

{$R *.fmx}

uses uIzvodjacMain;

procedure TFrmIzvodjacOglas.btBackClick(Sender: TObject);
begin
  FrmIzvodjacMain.Show;
  Self.Close;
end;

procedure TFrmIzvodjacOglas.btnBiografijaClick(Sender: TObject);
begin
  if edBiografija.Text <> '' then
  begin
    SaveOglasToDatabase;
    ShowMessage('Biografija sačuvana.');
  end
  else
    ShowMessage('Unesite biografiju.');
end;


procedure TFrmIzvodjacOglas.btnImgClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    ImageFilePath := OpenDialog1.FileName;
    Image1.Bitmap.LoadFromFile(ImageFilePath);
    ShowMessage('Slika učitana.');
  end;
end;


procedure TFrmIzvodjacOglas.btnNazivClick(Sender: TObject);
begin
  if edNaziv.Text <> '' then
  begin
    SaveOglasToDatabase;
    ShowMessage('Naziv benda sačuvan.');
  end
  else
    ShowMessage('Unesite naziv benda.');
end;
procedure TFrmIzvodjacOglas.btnSaveClick(Sender: TObject);
begin
SaveOglasToDatabase;
end;

procedure TFrmIzvodjacOglas.SaveOglasToDatabase;
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


    DM.FDTransaction1.StartTransaction;
    try
      with DM.QTemp do
      begin
        SQL.Clear;
        SQL.Text := 'INSERT INTO oglas (username, naziv_benda, biografija, slika) VALUES (:username, :naziv, :biografija, :slika)';
        Params.ParamByName('username').AsString := 'your_username';
        Params.ParamByName('naziv').AsString := edNaziv.Text;
        Params.ParamByName('biografija').AsString := edBiografija.Text;
        if ImageFilePath <> '' then
          Params.ParamByName('slika').LoadFromStream(Stream, ftBlob)
        else
          Params.ParamByName('slika').Clear;
        ExecSQL;
      end;

      DM.FDTransaction1.Commit;
    except

      DM.FDTransaction1.Rollback;
      raise;
    end;
  finally
    Stream.Free;
  end;
  ShowMessage('Podaci su sačuvani.');
end;
end.
