unit uIzvodjacSignIn;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmIzvodjacSignIn = class(TForm)
    Layout1: TLayout;
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
    cbShowPassword: TCheckBox;
    btLogin: TButton;
    Image2: TImage;
    btGoToKorisnikSignUp: TButton;
    btBack: TButton;
    procedure btGoToKorisnikSignUpClick(Sender: TObject);
    procedure edUsernameKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure cbShowPasswordChange(Sender: TObject);
    procedure btLoginClick(Sender: TObject);
    procedure btBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmIzvodjacSignIn: TFrmIzvodjacSignIn;

implementation

{$R *.fmx}

uses uIzvodjacSignUp, uDM, uKorisnikSignIn, uIzvodjacMain, uIzbor;

procedure TFrmIzvodjacSignIn.btBackClick(Sender: TObject);
begin
  if not Assigned(FrmIzbor) then
    FrmIzbor := TFrmIzbor.Create(Application);

  FrmIzbor.Show;
  FrmIzbor.BringToFront;
  FreeAndNil(FrmIzvodjacMain);
end;

procedure TFrmIzvodjacSignIn.btGoToKorisnikSignUpClick(Sender: TObject);
begin
FrmIzvodjacSignUp.show;
FrmIzvodjacSignIn.Hide;
end;

procedure TFrmIzvodjacSignIn.btLoginClick(Sender: TObject);

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
      pwd:=qtemp.FieldByName('password').AsString;
     if pwd=edPassword.Text then
    begin
        if not Assigned(FrmIzvodjacMain) then
            FrmIzvodjacMain := TFrmIzvodjacMain.Create(Application);
          FrmIzvodjacMain.lUser.Text := edUsername.Text;
          Self.Hide;
          FrmIzvodjacMain.Show;

        end
      else
      begin
         showmessage('Netacna lozinka!');
      end;
     end
     else begin

     showmessage('Netacno ime korisnika!');
     end;
  end;
end;

end;

procedure TFrmIzvodjacSignIn.cbShowPasswordChange(Sender: TObject);
begin
edPassword.Password:= not cbShowPassword.IsChecked;
end;

procedure TFrmIzvodjacSignIn.edUsernameKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if key=vkreturn then edpassword.SetFocus;
if key=vktab then edpassword.SetFocus;
end;

end.
