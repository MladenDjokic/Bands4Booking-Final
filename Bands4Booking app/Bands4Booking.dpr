program Bands4Booking;

uses
  System.StartUpCopy,
  FMX.Forms,
  uIntro in 'uIntro.pas' {FrmIntro},
  uIzbor in 'uIzbor.pas' {FrmIzbor},
  uKorisnikSignIn in 'uKorisnikSignIn.pas' {FrmKorisnikSignIn},
  uKorisnikMain in 'uKorisnikMain.pas' {FrmKorisnikMain},
  uDM in 'uDM.pas' {dm: TDataModule},
  uKorisnikSignUp in 'uKorisnikSignUp.pas' {FrmKorisnikSignUp},
  uIzvodjacSignIn in 'uIzvodjacSignIn.pas' {FrmIzvodjacSignIn},
  uIzvodjacSignUp in 'uIzvodjacSignUp.pas' {FrmIzvodjacSignUp},
  uIzvodjacMain in 'uIzvodjacMain.pas' {FrmIzvodjacMain},
  uIzvodjacOglas in 'uIzvodjacOglas.pas' {FrmIzvodjacOglas},
  uKorisnikChat in 'uKorisnikChat.pas' {FrmKorisnikChat},
  uKorisnikAllChat in 'uKorisnikAllChat.pas' {FrmKorisnikAllChat},
  uProfilIzvodjaca in 'uProfilIzvodjaca.pas' {FrmProfilIzvodjaca},
  uChatServer in 'uChatServer.pas' {ChatServer},
  uPlacanje in 'uPlacanje.pas' {FrmPlacanje},
  uOceni in 'uOceni.pas' {FrmOceni},
  uIzvodjacPostojeciOglas in 'uIzvodjacPostojeciOglas.pas' {FrmIzvodjacPostojeciOglas};

//error

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrmIntro, FrmIntro);
  //Application.CreateForm(TDataModule, data);
  Application.CreateForm(TFrmKorisnikSignUp, FrmKorisnikSignUp);
  Application.CreateForm(TFrmIzvodjacSignIn, FrmIzvodjacSignIn);
  Application.CreateForm(TFrmIzvodjacSignUp, FrmIzvodjacSignUp);
  //error
  Application.Run;
end.
