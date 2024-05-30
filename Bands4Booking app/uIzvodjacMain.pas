unit uIzvodjacMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, System.ImageList, FMX.ImgList, FMX.Controls.Presentation,
  FMX.Layouts, Data.DB, uDM;

type
  TFrmIzvodjacMain = class(TForm)
    Bottom: TLayout;
    recBottomBG: TRectangle;
    btChat: TButton;
    btFavorite: TButton;
    btHome: TButton;
    btNotif: TButton;
    ImageList1: TImageList;
    Middle: TLayout;
    UpHalf: TLayout;
    recBG: TRectangle;
    recPretraga: TRoundRect;
    lPretraga: TLabel;
    Image2: TImage;
    btSort: TCornerButton;
    imgSort: TImage;
    BotHalf: TLayout;
    recBotHalf: TRectangle;
    Opcije: TLayout;
    btOglasi: TCornerButton;
    btAddOglas: TCornerButton;
    BotIzvodjaci: TLayout;
    recIzvodjac: TRectangle;
    recSlika: TRectangle;
    imgBend: TImage;
    lNazivBenda: TLabel;
    lVrsta: TLabel;
    btnChange: TCornerButton;
    Top: TLayout;
    recTopBG: TRectangle;
    btClose: TButton;
    lUser: TLabel;
    lZdravo: TLabel;
    cProfilePic: TCircle;
    Image1: TImage;
    MidSlika: TLayout;
    Image3: TImage;
    procedure btAddOglasClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnChangeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  procedure LoadBendData;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  FrmIzvodjacMain: TFrmIzvodjacMain;

implementation

{$R *.fmx}

uses uIzvodjacOglas, uIzbor, uIzvodjacPostojeciOglas;

procedure TFrmIzvodjacMain.btAddOglasClick(Sender: TObject);
 var
  FrmIzvodjacOglas: TFrmIzvodjacOglas;
begin
  FrmIzvodjacOglas := TFrmIzvodjacOglas.Create(Application);
  FrmIzvodjacOglas.Show;
end;

procedure TFrmIzvodjacMain.btCloseClick(Sender: TObject);
begin
  Self.Close;
  if not Assigned(FrmIzbor) then
    FrmIzbor := TFrmIzbor.Create(Application);

  FrmIzbor.Show;
  FrmIzbor.BringToFront;
end;
procedure TFrmIzvodjacMain.btnChangeClick(Sender: TObject);
begin
  if not Assigned(FrmIzvodjacPostojeciOglas) then
    FrmIzvodjacPostojeciOglas := TFrmIzvodjacPostojeciOglas.Create(Application);

  Self.Hide;

  try
    FrmIzvodjacPostojeciOglas.LoadOglasData;
    FrmIzvodjacPostojeciOglas.ShowModal;

  finally
    FreeAndNil(FrmIzvodjacPostojeciOglas);
    Self.Show;
    Application.ProcessMessages;
  end;
end;

procedure TFrmIzvodjacMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := TCloseAction.caNone;
  Self.Hide;


  if not Assigned(FrmIzbor) then
    FrmIzbor := TFrmIzbor.Create(Application);


  FrmIzbor.Show;
  FrmIzbor.BringToFront;
end;

procedure TFrmIzvodjacMain.FormShow(Sender: TObject);
begin
LoadBendData;
end;

procedure TFrmIzvodjacMain.LoadBendData;
var
  Stream: TMemoryStream;
  username: string;
begin
  username := 'your_username';


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

        lNazivBenda.Text := FieldByName('naziv_benda').AsString;

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
        lNazivBenda.Text := 'Bend nije pronađen';
        imgBend.Bitmap := nil;
      end;
    end;
  finally
    Stream.Free;
  end;
end;

end.


