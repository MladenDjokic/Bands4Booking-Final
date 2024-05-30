unit uPlacanje;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, Data.DB, uDm, FMX.Objects, FMX.Layouts;

type
  TFrmPlacanje = class(TForm)
    edAmount: TEdit;
    edDescription: TEdit;
    lbIzvodjac: TLabel;
    btPay: TButton;
    btCancel: TButton;
    Bottom: TLayout;
    recBottomBG: TRectangle;
    Middle: TLayout;
    Top: TLayout;
    recTopBG: TRectangle;
    cProfilePic: TCircle;
    Image1: TImage;
    txtTop: TText;
    btBack: TButton;
    recLinija: TRectangle;
    edCardNumber: TEdit;
    edExpiryDate: TEdit;
    edCVC: TEdit;
    lbCardNumber: TLabel;
    lbExpiryDate: TLabel;
    lbCVC: TLabel;
    lbIznos: TLabel;
    edCardholderName: TEdit;
    lbImeNaKartici: TLabel;
    recMidBG: TRectangle;
    procedure btPayClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btBackClick(Sender: TObject);
  private
    FUserId: Integer;
    FPerformerId: Integer;
    { Private declarations }
  public
  procedure Initialize(UserId, PerformerId: Integer; UserName, PerformerName: string);
    { Public declarations }
  end;

var
  FrmPlacanje: TFrmPlacanje;

implementation

{$R *.fmx}

uses uKorisnikMain;

procedure TFrmPlacanje.btBackClick(Sender: TObject);
begin

  Self.Hide;


  if not Assigned(FrmKorisnikMain) then
    FrmKorisnikMain := TFrmKorisnikMain.Create(Application);

  FrmKorisnikMain.Show;
  FrmKorisnikMain.BringToFront;
end;

procedure TFrmPlacanje.btCancelClick(Sender: TObject);
begin

  Self.Hide;


  if not Assigned(FrmKorisnikMain) then
    FrmKorisnikMain := TFrmKorisnikMain.Create(Application);

  FrmKorisnikMain.Show;
  FrmKorisnikMain.BringToFront;
end;

procedure TFrmPlacanje.Initialize(UserId, PerformerId: Integer; UserName, PerformerName: string);
begin
  FUserId := UserId;
  FPerformerId := PerformerId;


end;

procedure TFrmPlacanje.btPayClick(Sender: TObject);
var
  Amount: Double;
  Description, CardNumber, ExpiryDate, CVC, CardholderName: string;
begin
  if TryStrToFloat(edAmount.Text, Amount) then
  begin
    Description := edDescription.Text;
    CardNumber := edCardNumber.Text;
    ExpiryDate := edExpiryDate.Text;
    CVC := edCVC.Text;
    CardholderName := edCardholderName.Text;

    if (CardNumber = '') or (ExpiryDate = '') or (CVC = '') or (CardholderName = '') then
    begin
      ShowMessage('Molimo popunite sve podatke o kartici.');
      Exit;
    end;

    with DM.QTemp do
    begin
      SQL.Clear;
      SQL.Text := 'INSERT INTO payment (user_id, performer_id, amount, description, card_number, expiry_date, cvc, cardholder_name) ' +
                  'VALUES (:user_id, :performer_id, :amount, :description, :card_number, :expiry_date, :cvc, :cardholder_name)';
      Params.ParamByName('user_id').AsInteger := FUserId;
      Params.ParamByName('performer_id').AsInteger := FPerformerId;
      Params.ParamByName('amount').AsFloat := Amount;
      Params.ParamByName('description').AsString := Description;
      Params.ParamByName('card_number').AsString := CardNumber;
      Params.ParamByName('expiry_date').AsString := ExpiryDate;
      Params.ParamByName('cvc').AsString := CVC;
      Params.ParamByName('cardholder_name').AsString := CardholderName;
      ExecSQL;

      ShowMessage('Uplata je uspešno obrađena.');
    end;
  end
  else
  begin
    ShowMessage('Molimo unesite validan iznos.');
  end;
end;
end.
