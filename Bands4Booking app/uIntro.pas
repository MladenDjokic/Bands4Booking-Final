unit uIntro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmIntro = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Rectangle1: TRectangle;
    slikabg: TImage;
    opacity: TRectangle;
    Layout3: TLayout;
    btZapocni: TCornerButton;
    Rectangle2: TRectangle;
    Text1: TText;
    Text2: TText;
    Text3: TText;
    procedure btZapocniClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmIntro: TFrmIntro;

implementation

{$R *.fmx}

uses uIzbor;

procedure TFrmIntro.btZapocniClick(Sender: TObject);

begin
  FrmIzbor := TFrmIzbor.Create(nil);
  FrmIzbor.Show;

  Application.MainForm := FrmIzbor;

  Self.Close;
end;
end.
