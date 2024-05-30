unit uKorisnikSignUp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TFrmKorisnikSignUp = class(TForm)
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
    procedure btSigninClick(Sender: TObject);
    procedure edEmailKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edUsernameKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edPasswordKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edPassword2KeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure btGoToKorisnikLogInClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmKorisnikSignUp: TFrmKorisnikSignUp;

implementation

{$R *.fmx}

uses uKorisnikSignIn;

procedure TFrmKorisnikSignUp.btGoToKorisnikLogInClick(Sender: TObject);
begin
FrmKorisnikSignIn.show;
FrmKorisnikSignUp.Hide;
end;

procedure TFrmKorisnikSignUp.btSigninClick(Sender: TObject);
begin
if trim(edUsername.Text)='' then
begin
  Showmessage('Please enter user name');
  edUsername.SetFocus;
end
else
begin

end;
end;

procedure TFrmKorisnikSignUp.edEmailKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if key=vkreturn then edUsername.SetFocus;
if key=vktab then edUsername.SetFocus;
end;

procedure TFrmKorisnikSignUp.edPassword2KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if key=vkreturn then btSignin.SetFocus;
if key=vktab then btSignin.SetFocus;
end;

procedure TFrmKorisnikSignUp.edPasswordKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if key=vkreturn then edPassword2.SetFocus;
if key=vktab then edPassword2.SetFocus;
end;

procedure TFrmKorisnikSignUp.edUsernameKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if key=vkreturn then edPassword.SetFocus;
if key=vktab then edPassword.SetFocus;
end;

end.
