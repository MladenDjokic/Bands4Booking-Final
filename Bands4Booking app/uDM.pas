unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Dialogs;
      //
type
  Tdm = class(TDataModule)
    dbBands4Booking: TFDConnection;
    QTemp: TFDQuery;
    FDTransaction1: TFDTransaction;
    //procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
  procedure ConnectToDatabase;
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}
 procedure Tdm.ConnectToDatabase;
var
  DBPath: string;
begin
  DBPath := ExtractFilePath(ParamStr(0)) + 'assets\database\bands4bookingdp.db3';

  ShowMessage('Database path: ' + DBPath);

  dbBands4Booking.Params.Database := DBPath;
  try
    dbBands4Booking.Connected := True;
  except
    on E: Exception do
      ShowMessage('Error connecting to database: ' + E.Message);
  end;
end;
{procedure Tdm.DataModuleCreate(Sender: TObject);
var
  DatabasePath: string;
begin
  inherited;
  DatabasePath := ExtractFilePath(ParamStr(0)) + 'bands4bookingdp.db3';


  dbBands4Booking.Params.Values['Database'] := DatabasePath;
  try
    dbBands4Booking.Connected := True;
  except
    on E: Exception do
      ShowMessage('Cannot connect to database: ' + E.Message);
  end;
end;   }
end.
