unit uIzbor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmIzbor = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Image1: TImage;
    Text1: TText;
    Text2: TText;
    btnKorisnik: TCornerButton;
    btnIzvodjac: TCornerButton;
    Text3: TText;
    Text4: TText;
    Text5: TText;
    btClose: TButton;
    procedure btnKorisnikClick(Sender: TObject);
    procedure btnIzvodjacClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmIzbor: TFrmIzbor;

implementation

{$R *.fmx}

uses uKorisnikSignIn, uIzvodjacSignIn;

procedure TFrmIzbor.btCloseClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TFrmIzbor.btnIzvodjacClick(Sender: TObject);
 var FrmIzvodjacSignIn: TFrmIzvodjacSignin;
begin

  FrmIzvodjacSignIn := TFrmIzvodjacSignIn.Create(nil);
  try

    Self.Hide;

    FrmIzvodjacSignIn.ShowModal;
  finally

    FrmIzvodjacSignIn.Free;

    Self.Free;
  end;
end;


procedure TFrmIzbor.btnKorisnikClick(Sender: TObject);
begin
  if not Assigned(FrmKorisnikSignIn) then
    FrmKorisnikSignIn := TFrmKorisnikSignIn.Create(Application);
  try
    Self.Hide;
    FrmKorisnikSignIn.ShowModal;
  finally
    FreeAndNil(FrmKorisnikSignIn);
    Self.Show;
  end;
end;
end.
