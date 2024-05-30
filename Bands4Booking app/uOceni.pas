unit uOceni;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, Data.DB, uDM;

type
  TFrmOceni = class(TForm)
    Bottom: TLayout;
    recBottomBG: TRectangle;
    Middle: TLayout;
    Placanje: TLayout;
    Rectangle1: TRectangle;
    Top: TLayout;
    recTopBG: TRectangle;
    cProfilePic: TCircle;
    Image1: TImage;
    txtTop: TText;
    btBack: TButton;
    recLinija: TRectangle;
    lbOceni: TLabel;
    lbComment: TLabel;
    cbRating: TComboBox;
    Rectangle2: TRectangle;
    edComment: TEdit;
    btSubmitRating: TButton;
    procedure btSubmitRatingClick(Sender: TObject);
    procedure btBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
   FUserId: Integer;
    FPerformerId: Integer;
    { Private declarations }
  public
  procedure Initialize(UserId, PerformerId: Integer);
    { Public declarations }
  end;

var
  FrmOceni: TFrmOceni;

implementation

{$R *.fmx}

uses uKorisnikMain;

procedure TFrmOceni.btBackClick(Sender: TObject);
begin
  Self.Hide;
  if not Assigned(FrmKorisnikMain) then
    FrmKorisnikMain := TFrmKorisnikMain.Create(Application);

  FrmKorisnikMain.Show;
  FrmKorisnikMain.BringToFront;
end;

procedure TFrmOceni.btSubmitRatingClick(Sender: TObject);
var
  Rating: Integer;
  Comment: string;
begin
  if TryStrToInt(cbRating.Selected.Text, Rating) then
  begin
    Comment := edComment.Text;

    with DM.QTemp do
    begin
      SQL.Clear;
      SQL.Text := 'INSERT INTO ratings (user_id, performer_id, rating, comment) VALUES (:user_id, :performer_id, :rating, :comment)';
      Params.ParamByName('user_id').AsInteger := FUserId;
      Params.ParamByName('performer_id').AsInteger := FPerformerId;
      Params.ParamByName('rating').AsInteger := Rating;
      Params.ParamByName('comment').AsString := Comment;
      ExecSQL;

      ShowMessage('Vaša ocena je uspešno zabeležena.');
      Close;
    end;
  end
  else
  begin
    ShowMessage('Molimo unesite validnu ocenu.');
  end;
end;

procedure TFrmOceni.FormCreate(Sender: TObject);
begin

  cbRating.Items.Clear;
  cbRating.Items.Add('1');
  cbRating.Items.Add('2');
  cbRating.Items.Add('3');
  cbRating.Items.Add('4');
  cbRating.Items.Add('5');
  cbRating.ItemIndex := -1;
end;
procedure TFrmOceni.Initialize(UserId, PerformerId: Integer);
begin
  FUserId := UserId;
  FPerformerId := PerformerId;
end;

end.
