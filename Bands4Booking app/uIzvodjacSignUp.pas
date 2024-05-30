unit uIzvodjacSignUp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, uDM;



type
  TFrmIzvodjacSignUp = class(TForm)
    Layout1: TLayout;
    Image1: TImage;
    Text1: TText;
    Text2: TText;
    Layout2: TLayout;
    Rectangle3: TRectangle;
    Text3: TText;
    Linput: TLayout;
    reUsername: TRectangle;
    lineUsername: TLine;
    lbUsername: TLabel;
    edUsername: TEdit;
    rePassword: TRectangle;
    linePassword: TLine;
    lbPassword: TLabel;
    edPassword: TEdit;
    btSignin: TButton;
    reEmail: TRectangle;
    lineEmail: TLine;
    lbEmail: TLabel;
    edEmail: TEdit;
    rePassword2: TRectangle;
    linePassword2: TLine;
    lbPassword2: TLabel;
    edPassword2: TEdit;
    btGoToKorisnikLogIn: TButton;
    procedure btGoToKorisnikLogInClick(Sender: TObject);
    procedure btSigninClick(Sender: TObject);
  private
   {function ValidateInputs: Boolean;
    procedure RegisterUser;   }
  public
    { Public declarations }
  end;

var
  FrmIzvodjacSignUp: TFrmIzvodjacSignUp;

implementation

{$R *.fmx}

uses  uIzvodjacSignIn;

procedure TFrmIzvodjacSignUp.btGoToKorisnikLogInClick(Sender: TObject);
begin
FrmIzvodjacSignIn.show;
FrmIzvodjacSignUp.Hide;
end;





procedure TFrmIzvodjacSignUp.btSigninClick(Sender: TObject);
  begin
{begin
  if ValidateInputs then
  begin
    RegisterUser;
  end
  else
  begin
    ShowMessage('Please check your inputs.');
  end;
end;

 function TFrmIzvodjacSignUp.ValidateInputs: Boolean;
begin
  Result := False;

  if edEmail.Text = '' then
  begin
    ShowMessage('Email is required.');
    Exit;
  end;

  if edUsername.Text = '' then
  begin
    ShowMessage('Username is required.');
    Exit;
  end;

  if edPassword.Text = '' then
  begin
    ShowMessage('Password is required.');
    Exit;
  end;

  if edPassword.Text <> edPassword2.Text then
  begin
    ShowMessage('Passwords do not match.');
    Exit;
  end;

  Result := True;

  procedure TFrmIzvodjacSignUp.RegisterUser;
begin
  try
    dm.ConnectToDatabase;
    dm.FDQuery.SQL.Text := 'INSERT INTO users (email, username, password) VALUES (:Email, :Username, :Password)';
    dm.FDQuery.Params.ParamByName('Email').AsString := edEmail.Text;
    dm.FDQuery.Params.ParamByName('Username').AsString := edUsername.Text;
    dm.FDQuery.Params.ParamByName('Password').AsString := edPassword.Text;
    dm.FDQuery.ExecSQL;

    ShowMessage('User registered successfully.');
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
end;
end;
    }

      end;

end.
