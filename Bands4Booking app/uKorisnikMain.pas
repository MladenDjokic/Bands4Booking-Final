unit uKorisnikMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, System.ImageList,
  FMX.ImgList, Data.DB, uDM, FMX.ListBox, System.Threading;

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
    BotHalf: TLayout;
    MidSlika: TLayout;
    imgSlikaMain: TImage;
    recBottomBG: TRectangle;
    Opcije: TLayout;
    btHome: TButton;
    ImageList1: TImageList;
    btFavorite: TButton;
    btChat: TButton;
    btNotif: TButton;
    recBotHalf: TRectangle;
    SortPanel: TPanel;
    cbSortGenre: TComboBox;
    Zabavna: TListBoxItem;
    Narodna: TListBoxItem;
    Strano: TListBoxItem;
    Pop: TListBoxItem;
    Folk: TListBoxItem;
    cbSortRating: TComboBox;
    cbSortType: TComboBox;
    Bend: TListBoxItem;
    Pevac: TListBoxItem;
    Gitarista: TListBoxItem;
    DJ: TListBoxItem;
    btnApplySort: TButton;
    OglasiPanel: TScrollBox;
    btnSort: TButton;
    btnBend: TButton;
    btnPevac: TButton;
    btnDJ: TButton;
    btnGitarista: TButton;
    btAddOglas: TButton;
    DetailButton: TButton;
    procedure btCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnApplySortClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure btnBendClick(Sender: TObject);
    procedure btnPevacClick(Sender: TObject);
    procedure btnDJClick(Sender: TObject);
    procedure btnGitaristaClick(Sender: TObject);
    procedure DetailButtonClick(Sender: TObject);
  private
    FFilterVrsta: string;
    procedure LoadOglasi(SortField: string = ''; SortValue: string = '');
    procedure FilterOglasi(const Vrsta: string);
    procedure LoadAllOglasi;
    procedure ShowOglasDetail(OglasID: Integer);
    procedure LoadAllOglasiAsync;
    procedure FilterOglasiAsync(const Vrsta: string);
    { Private declarations }
  public
    procedure imgSortClick(Sender: TObject);
    { Public declarations }
  end;

var
  FrmKorisnikMain: TFrmKorisnikMain;

implementation

{$R *.fmx}

uses uProfilIzvodjaca, uKorisnikAllChat, uIzbor;

procedure TFrmKorisnikMain.FilterOglasi(const Vrsta: string);
var
  OglasPanel: TPanel;
  OglasImage: TImage;
  OglasLabel: TLabel;
  DetailButton: TButton;
  Background: TRectangle;
begin
  OglasiPanel.Content.DeleteChildren;
  with DM.QTemp do
  begin
    SQL.Clear;
    SQL.Text := 'SELECT * FROM oglas WHERE vrsta = :vrsta';
    Params.ParamByName('vrsta').AsString := Vrsta;
    Open;
    while not Eof do
    begin
      OglasPanel := TPanel.Create(OglasiPanel);
      OglasPanel.Parent := OglasiPanel;
      OglasPanel.Width := OglasiPanel.Width - 20; // Adjust as needed
      OglasPanel.Height := 180; // Adjust as needed
      OglasPanel.Margins.Bottom := 10;
      OglasPanel.Align := TAlignLayout.Top;

      Background := TRectangle.Create(OglasPanel);
      Background.Parent := OglasPanel;
      Background.Align := TAlignLayout.Client;
      Background.Stroke.Kind := TBrushKind.Solid;
      Background.Stroke.Color := TAlphaColors.Black;
      Background.Stroke.Thickness := 1;
      Background.Fill.Kind := TBrushKind.Solid;
      Background.Fill.Color := TAlphaColors.White;

      OglasImage := TImage.Create(Background);
      OglasImage.Parent := Background;
      OglasImage.Align := TAlignLayout.Top;
      OglasImage.Height := 80; // Adjust as needed
      OglasImage.Margins.Bottom := 5;

      if not FieldByName('slika').IsNull then
      begin
        var Stream := TMemoryStream.Create;
        try
          TBlobField(FieldByName('slika')).SaveToStream(Stream);
          Stream.Position := 0;
          OglasImage.Bitmap.LoadFromStream(Stream);
        finally
          Stream.Free;
        end;
      end;

      OglasLabel := TLabel.Create(Background);
      OglasLabel.Parent := Background;
      OglasLabel.Align := TAlignLayout.Client;
      OglasLabel.Text := FieldByName('naziv_benda').AsString + sLineBreak +
                         'Vrsta: ' + FieldByName('vrsta').AsString + sLineBreak +
                         'Žanrovi: ' + FieldByName('zanrovi').AsString + sLineBreak +
                         'Ocena: ' + FieldByName('ocena').AsString;
      OglasLabel.TextAlign := TTextAlign.Center;
      OglasLabel.WordWrap := True;

      DetailButton := TButton.Create(Background);
      DetailButton.Parent := Background;
      DetailButton.Align := TAlignLayout.Bottom;
      DetailButton.Text := 'Detalji';
      DetailButton.Tag := FieldByName('id').AsInteger;
      DetailButton.OnClick := DetailButtonClick;

      Next;
    end;
  end;
end;

procedure TFrmKorisnikMain.LoadOglasi(SortField: string = ''; SortValue: string = '');
var
  SQLQuery: string;
begin
  SQLQuery := 'SELECT * FROM oglas';
  if SortField <> '' then
  begin
    SQLQuery := SQLQuery + ' WHERE ' + SortField + ' = :SortValue';
  end;
  DM.QTemp.SQL.Text := SQLQuery;
  if SortField <> '' then
  begin
    DM.QTemp.Params.ParamByName('SortValue').AsString := SortValue;
  end;
  DM.QTemp.Open;
  OglasiPanel.Content.DeleteChildren;
  while not DM.QTemp.Eof do
  begin
    var OglasPanel := TPanel.Create(Self);
    OglasPanel.Parent := OglasiPanel;
    OglasPanel.Height := 100;
    OglasPanel.Width := OglasiPanel.Width;
    OglasPanel.Align := TAlignLayout.Top;

    var OglasImage := TImage.Create(OglasPanel);
    OglasImage.Parent := OglasPanel;
    OglasImage.Align := TAlignLayout.Left;
    OglasImage.Width := 100;

    if not DM.QTemp.FieldByName('slika').IsNull then
    begin
      var Stream := TMemoryStream.Create;
      try
        TBlobField(DM.QTemp.FieldByName('slika')).SaveToStream(Stream);
        Stream.Position := 0;
        OglasImage.Bitmap.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
    end;

    var OglasLabel := TLabel.Create(OglasPanel);
    OglasLabel.Parent := OglasPanel;
    OglasLabel.Align := TAlignLayout.Client;
    OglasLabel.Text := DM.QTemp.FieldByName('naziv_benda').AsString + sLineBreak +
                       'Vrsta: ' + DM.QTemp.FieldByName('vrsta').AsString + sLineBreak +
                       'Žanrovi: ' + DM.QTemp.FieldByName('zanrovi').AsString + sLineBreak +
                       'Ocena: ' + DM.QTemp.FieldByName('ocena').AsString;

    var DetailButton := TButton.Create(OglasPanel);
    DetailButton.Parent := OglasPanel;
    DetailButton.Align := TAlignLayout.Right;
    DetailButton.Text := 'Detalji';
    DetailButton.Tag := DM.QTemp.FieldByName('id').AsInteger;
    DetailButton.OnClick := DetailButtonClick;

    DM.QTemp.Next;
  end;
end;

procedure TFrmKorisnikMain.LoadAllOglasi;
var
  OglasPanel: TPanel;
  OglasImage: TImage;
  OglasLabel: TLabel;
  DetailButton: TButton;
  Background: TRectangle;
begin
  try
    OglasiPanel.Content.DeleteChildren;
    with DM.QTemp do
    begin
      SQL.Clear;
      SQL.Text := 'SELECT * FROM oglas';
      Open;
      while not Eof do
      begin
        OglasPanel := TPanel.Create(OglasiPanel);
        OglasPanel.Parent := OglasiPanel;
        OglasPanel.Width := OglasiPanel.Width - 20; // Adjust as needed
        OglasPanel.Height := 180; // Adjust as needed
        OglasPanel.Margins.Bottom := 10;
        OglasPanel.Align := TAlignLayout.Top;

        Background := TRectangle.Create(OglasPanel);
        Background.Parent := OglasPanel;
        Background.Align := TAlignLayout.Client;
        Background.Stroke.Kind := TBrushKind.Solid;
        Background.Stroke.Color := TAlphaColors.Black;
        Background.Stroke.Thickness := 1;
        Background.Fill.Kind := TBrushKind.Solid;
        Background.Fill.Color := TAlphaColors.White;

        OglasImage := TImage.Create(Background);
        OglasImage.Parent := Background;
        OglasImage.Align := TAlignLayout.Top;
        OglasImage.Height := 80; // Adjust as needed
        OglasImage.Margins.Bottom := 5;

        if not FieldByName('slika').IsNull then
        begin
          var Stream := TMemoryStream.Create;
          try
            TBlobField(FieldByName('slika')).SaveToStream(Stream);
            Stream.Position := 0;
            OglasImage.Bitmap.LoadFromStream(Stream);
          finally
            Stream.Free;
          end;
        end;

        OglasLabel := TLabel.Create(Background);
        OglasLabel.Parent := Background;
        OglasLabel.Align := TAlignLayout.Client;
        OglasLabel.Text := FieldByName('naziv_benda').AsString + sLineBreak +
                           'Vrsta: ' + FieldByName('vrsta').AsString + sLineBreak +
                           'Žanrovi: ' + FieldByName('zanrovi').AsString + sLineBreak +
                           'Ocena: ' + FieldByName('ocena').AsString;
        OglasLabel.TextAlign := TTextAlign.Center;
        OglasLabel.WordWrap := True;

        DetailButton := TButton.Create(Background);
        DetailButton.Parent := Background;
        DetailButton.Align := TAlignLayout.Bottom;
        DetailButton.Text := 'Detalji';
        DetailButton.Tag := FieldByName('id').AsInteger;
        DetailButton.OnClick := DetailButtonClick;

        Next;
      end;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Greška prilikom učitavanja oglasa: ' + E.Message);
    end;
  end;
end;

procedure TFrmKorisnikMain.LoadAllOglasiAsync;
begin
  TTask.Run(procedure
  begin
    TThread.Synchronize(nil, procedure
    begin
      LoadAllOglasi;
    end);
  end);
end;

procedure TFrmKorisnikMain.FilterOglasiAsync(const Vrsta: string);
begin
  TTask.Run(procedure
  begin
    TThread.Synchronize(nil, procedure
    begin
      FilterOglasi(Vrsta);
    end);
  end);
end;

procedure TFrmKorisnikMain.btCloseClick(Sender: TObject);
begin
  if not Assigned(FrmIzbor) then
    FrmIzbor := TFrmIzbor.Create(Application);

  FrmIzbor.Show;
  FrmIzbor.BringToFront;
  Self.Hide;
end;

procedure TFrmKorisnikMain.btnApplySortClick(Sender: TObject);
var
  SortField, SortValue: string;
begin
  SortField := '';
  SortValue := '';
  if cbSortGenre.ItemIndex >= 0 then
  begin
    SortField := 'zanrovi';
    SortValue := cbSortGenre.Items[cbSortGenre.ItemIndex];
  end
  else if cbSortRating.ItemIndex >= 0 then
  begin
    SortField := 'ocena';
    SortValue := cbSortRating.Items[cbSortRating.ItemIndex];
  end
  else if cbSortType.ItemIndex >= 0 then
  begin
    SortField := 'vrsta';
    SortValue := cbSortType.Items[cbSortType.ItemIndex];
  end;

  if SortField <> '' then
  begin
    DM.QTemp.SQL.Text := 'SELECT * FROM oglas WHERE ' + SortField + ' = :SortValue';
    DM.QTemp.Params.ParamByName('SortValue').AsString := SortValue;
  end
  else
  begin
    DM.QTemp.SQL.Text := 'SELECT * FROM oglas';
  end;

  DM.QTemp.Open;
  OglasiPanel.Content.DeleteChildren;
  while not DM.QTemp.Eof do
  begin
    var OglasPanel := TPanel.Create(Self);
    OglasPanel.Parent := OglasiPanel;
    OglasPanel.Height := 100;
    OglasPanel.Width := OglasiPanel.Width;
    OglasPanel.Align := TAlignLayout.Top;

    var OglasImage := TImage.Create(OglasPanel);
    OglasImage.Parent := OglasPanel;
    OglasImage.Align := TAlignLayout.Left;
    OglasImage.Width := 100;

    if not DM.QTemp.FieldByName('slika').IsNull then
    begin
      var Stream := TMemoryStream.Create;
      try
        TBlobField(DM.QTemp.FieldByName('slika')).SaveToStream(Stream);
        Stream.Position := 0;
        OglasImage.Bitmap.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
    end;

    var OglasLabel := TLabel.Create(OglasPanel);
    OglasLabel.Parent := OglasPanel;
    OglasLabel.Align := TAlignLayout.Client;
    OglasLabel.Text := DM.QTemp.FieldByName('naziv_benda').AsString + sLineBreak +
                       'Vrsta: ' + DM.QTemp.FieldByName('vrsta').AsString + sLineBreak +
                       'Žanrovi: ' + DM.QTemp.FieldByName('zanrovi').AsString + sLineBreak +
                       'Ocena: ' + DM.QTemp.FieldByName('ocena').AsString;

    var DetailButton := TButton.Create(OglasPanel);
    DetailButton.Parent := OglasPanel;
    DetailButton.Align := TAlignLayout.Right;
    DetailButton.Text := 'Detalji';
    DetailButton.Tag := DM.QTemp.FieldByName('id').AsInteger;
    DetailButton.OnClick := DetailButtonClick;

    DM.QTemp.Next;
  end;

  SortPanel.Visible := False;
end;

procedure TFrmKorisnikMain.btnBendClick(Sender: TObject);
begin
  FilterOglasiAsync('Bend');
end;

procedure TFrmKorisnikMain.btnDJClick(Sender: TObject);
begin
  FilterOglasiAsync('DJ');
end;

procedure TFrmKorisnikMain.btnGitaristaClick(Sender: TObject);
begin
  FilterOglasiAsync('Gitarista');
end;

procedure TFrmKorisnikMain.btnPevacClick(Sender: TObject);
begin
  FilterOglasiAsync('Pevac');
end;

procedure TFrmKorisnikMain.btnSortClick(Sender: TObject);
begin
  SortPanel.Visible := not SortPanel.Visible;
end;

procedure TFrmKorisnikMain.DetailButtonClick(Sender: TObject);
begin
  if not Assigned(FrmProfilIzvodjaca) then
    FrmProfilIzvodjaca := TFrmProfilIzvodjaca.Create(Application);

  FrmProfilIzvodjaca.ShowProfile(TButton(Sender).Tag);
  FrmProfilIzvodjaca.BringToFront;
end;

procedure TFrmKorisnikMain.FormCreate(Sender: TObject);
begin
  SortPanel.Visible := False;
end;

procedure TFrmKorisnikMain.FormShow(Sender: TObject);
begin
  LoadAllOglasiAsync;
end;

procedure TFrmKorisnikMain.imgSortClick(Sender: TObject);
begin

end;

procedure TFrmKorisnikMain.ShowOglasDetail(OglasID: Integer);
begin
  ShowMessage('Prikaz detalja oglasa za ID: ' + OglasID.ToString);
end;

end.

