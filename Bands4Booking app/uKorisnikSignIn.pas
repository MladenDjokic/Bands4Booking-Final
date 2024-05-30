unit uKorisnikSignIn;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Edit, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TFrmKorisnikSignIn = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Image1: TImage;
    Text1: TText;
    Text2: TText;
    btLogin: TButton;
    Rectangle3: TRectangle;
    Text3: TText;
    Linput: TLayout;
    lineUsername: TLine;
    lbUsername: TLabel;
    edUsername: TEdit;
    linePassword: TLine;
    lbPassword: TLabel;
    edPassword: TEdit;
    reUsername: TRectangle;
    rePassword: TRectangle;
    cbShowPassword: TCheckBox;
    btGoToKorisnikSignUp: TButton;
    btBack: TButton;
    procedure cbShowPasswordChange(Sender: TObject);
    procedure edUsernameKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edPasswordKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure btLoginClick(Sender: TObject);
    procedure btGoToKorisnikSignUpClick(Sender: TObject);
    procedure btBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmKorisnikSignIn: TFrmKorisnikSignIn;

implementation


{$R *.fmx}
uses uDM, uKorisnikMain, uKorisnikSignUp, uIzbor;


procedure TFrmKorisnikSignIn.btBackClick(Sender: TObject);
begin
  Self.Hide;


  if not Assigned(FrmIzbor) then
    FrmIzbor := TFrmIzbor.Create(Application);


  FrmIzbor.Show;
  FrmIzbor.BringToFront;
end;

procedure TFrmKorisnikSignIn.btGoToKorisnikSignUpClick(Sender: TObject);
begin
FrmKorisnikSignUp.show;
FrmKorisnikSignIn.Hide;
end;

procedure TFrmKorisnikSignIn.btLoginClick(Sender: TObject);
 var pwd: string;
begin
if trim(edUsername.Text)='' then
begin
  Showmessage('Molimo unesite korisnicko ime.');
  edUsername.SetFocus;
end
else
begin

  with dm do begin
    dbBands4Booking.Open();
    qTemp.SQL.clear;
    qTemp.SQL.Text:='Select * From users Where username='+quotedstr(edUsername.Text);

     qTemp.Open();
   if qTemp.RecordCount > 0 then
      begin
        pwd := qTemp.FieldByName('password').AsString;
        if pwd = edPassword.Text then
        begin
         if not Assigned(FrmKorisnikMain) then
            FrmKorisnikMain := TFrmKorisnikMain.Create(Application);
          FrmKorisnikMain.lUser.Text := edUsername.Text;
          Self.Hide;
          FrmKorisnikMain.Show;
          FreeAndNil(FrmKorisnikSignIn);
        
        end
        else
        begin
          ShowMessage('Netacna lozinka!');
        end;
      end
      else
      begin
        ShowMessage('Netacno ime korisnika!');
      end;
    end;
  end;
end;

procedure TFrmKorisnikSignIn.cbShowPasswordChange(Sender: TObject);
begin
edPassword.Password:= not cbShowPassword.IsChecked;
end;

procedure TFrmKorisnikSignIn.edPasswordKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if key=vkreturn then btLogin.SetFocus;
end;

procedure TFrmKorisnikSignIn.edUsernameKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if key=vkreturn then edpassword.SetFocus;
if key=vktab then edpassword.SetFocus;

end;

end.
