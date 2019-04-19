object DM: TDM
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 122
  Width = 152
  object idhtpS: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 55
    Top = 8
  end
  object SQLQuery: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnection
    Left = 24
    Top = 64
  end
  object SQLConnection: TSQLConnection
    DriverName = 'Sqlite'
    Params.Strings = (
      'DriverUnit=Data.DbxSqlite'
      
        'DriverPackageLoader=TDBXSqliteDriverLoader,DBXSqliteDriver250.bp' +
        'l'
      
        'MetaDataPackageLoader=TDBXSqliteMetaDataCommandFactory,DbxSqlite' +
        'Driver250.bpl'
      'FailIfMissing=True'
      'Database=')
    Left = 88
    Top = 64
  end
end
