object dm: Tdm
  Height = 405
  Width = 380
  object dbBands4Booking: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      
        'Database=C:\Users\mlade\OneDrive\Desktop\Bands4Booking ap - Copy' +
        '\assets\database\bands4bookingdp.db3')
    LoginPrompt = False
    Left = 160
    Top = 104
  end
  object QTemp: TFDQuery
    Connection = dbBands4Booking
    SQL.Strings = (
      'Select * from users')
    Left = 152
    Top = 192
  end
  object FDTransaction1: TFDTransaction
    Connection = dbBands4Booking
    Left = 264
    Top = 264
  end
end
