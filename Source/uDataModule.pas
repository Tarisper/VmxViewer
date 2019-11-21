unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, IniFiles, Forms, uMainForm, Winapi.Windows,
  VCL.Graphics, Data.DB, Data.Win.ADODB, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Data.FMTBcd, Data.DbxSqlite,
  Data.SqlExpr;

type
  TDM = class(TDataModule)
    idhtpS: TIdHTTP;
    SQLQuery: TSQLQuery;
    SQLConnection: TSQLConnection;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure Write(sPath: string);
  public
    { Public declarations }
    function ReadIni(sPath: string): Boolean;
    procedure WriteIni(const sPath: string);
    function SetJson(sJson: string): string;
    procedure SQLCon(sPath: string);
    procedure GetParams;
    procedure SetParams;
    procedure SQLDisc;
    // procedure WriteIni;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses
  {synacode}uStrinListFiles;

function Encrypt(const AStr, Key: string): string; stdcall; external 'CrEnDEC_64.dll';
function Decrypt(const AStr, Key: string): string; stdcall; external 'CrEnDEC_64.dll';

procedure TDM.SQLCon(sPath: string);
begin
  MForm.AppSett.sDbPath := ExtractFileDir(ParamStr(0));
  SQLConnection.Params.Add('Database=' + sPath);
  try
    begin
      SQLConnection.ConnectionName := 'SQLITECONNECTION';
      SQLConnection.DriverName := 'Sqlite';
      SQLConnection.LoginPrompt := False;
      SQLConnection.Params.Values['Host'] := 'localhost'; // это не обязательно
      SQLConnection.Params.Values['FailIfMissing'] := 'False';
      SQLConnection.Params.Values['ColumnMetaDataSupported'] := 'False';
      SQLConnection.Params.Values['Database'] := MForm.AppSett.sDbPath;
      SQLConnection.Open;
    end;
  except
    on E: EDatabaseError do
      MForm.AddToLog(E.Message);
  end;
end;

procedure TDM.SQLDisc;
begin
  SQLConnection.Close;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  SQLDisc;
end;

procedure TDM.GetParams;
var
  slNames: TStringList;
begin
  with SQLQuery, MForm do
  begin
    SQL.Clear;
    SQL.Add('Select Name, Value from AppSettings order by ID');
    try
      Open;
    except
      on E: Exception do
        MForm.AddToLog(E.Message);
    end;
    if not IsEmpty then
    begin
      First;
      slNames := TStringList.Create;
      try
        GetFieldNames(slNames);
        while not Eof do
        begin
          if Fields.Fields[0].AsString = 'bKiosk' then
            AppSett.bKiosk := Fields.Fields[1].AsBoolean;
          if Fields.Fields[0].AsString = 'bNavPanel' then
            AppSett.bNavPanel := Fields.Fields[1].AsBoolean;
          if Fields.Fields[0].AsString = 'bLog' then
            AppSett.bLog := Fields.Fields[1].AsBoolean;
          if Fields.Fields[0].AsString = 'bShowCloseButton' then
            AppSett.bShowCloseButton := Fields.Fields[1].AsBoolean;
          if Fields.Fields[0].AsString = 'bShowOptionButton' then
            AppSett.bShowOptionButton := Fields.Fields[1].AsBoolean;
          if Fields.Fields[0].AsString = 'sPathLog' then
            AppSett.sPathLog := Fields.Fields[1].AsString;
          if Fields.Fields[0].AsString = 'sDefLink' then
            AppSett.sDefLink := Fields.Fields[1].AsString;
          if Fields.Fields[0].AsString = 'sDefCookiesDir' then
            AppSett.sDefCookiesDir := Fields.Fields[1].AsString;
          if Fields.Fields[0].AsString = 'sSQLPath' then
            AppSett.sSQLPath := Fields.Fields[1].AsString;
          if Fields.Fields[0].AsString = 'sWebAPIPath' then
            AppSett.sWebAPIPath := Fields.Fields[1].AsString;
          if Fields.Fields[0].AsString = 'sDbPath' then
            AppSett.sDbPath := Fields.Fields[1].AsString;
          Next;
        end;
      finally
        slNames.Free;
      end;
    end;
  end;
end;

procedure TDM.SetParams;
//var
//  slNames: TStringList;

  procedure SetV(sName, sValue: string);
  begin
    with SQLQuery do
    begin
      SQL.Clear;
      try
        SQL.Add('Update AppSettins set');
        SQL.Add(sValue + ' = ' + 'where Name = ' + sName);
        ExecSQL;
      except
        on E: Exception do
          MForm.AddToLog(E.Message);
      end;
    end;
  end;

begin
  with SQLQuery, MForm do
  begin
    SetV('bKiosk', BoolToStr(AppSett.bKiosk));
    SetV('bNavPanel', BoolToStr(AppSett.bNavPanel));
    SetV('bLog', BoolToStr(AppSett.bLog));
    SetV('bShowCloseButton', BoolToStr(AppSett.bShowCloseButton));
    SetV('bShowOptionButton', BoolToStr(AppSett.bShowOptionButton));
    SetV('sPathLog', AppSett.sPathLog);
    SetV('sDefLink', AppSett.sDefLink);
    SetV('sDefCookiesDir', AppSett.sDefCookiesDir);
    SetV('sSQLPath', AppSett.sSQLPath);
    SetV('sWebAPIPath', AppSett.sWebAPIPath);
    SetV('sDbPath', AppSett.sDbPath);
  end;
end;

procedure TDM.Write(sPath: string);
var
  ini: TMemIniFile;
begin
  ini := TMemIniFile.Create(MForm.AppSett.sIniPath);
  try
    with ini, MForm, AppSett do
    begin
      WriteBool('Application', 'bKiosk', bKiosk);
      WriteBool('Application', 'bNavPanel', bNavPanel);
      WriteBool('Application', 'bLog', bLog);
      WriteString('Application', 'sPathLog', sPathLog);
      WriteString('Application', 'sDefLink', sDefLink);
      WriteString('Application', 'sDefCookiesDir', sDefCookiesDir);
      WriteString('Application', 'sSQLPath', sSQLPath);
      WriteString('Application', 'sWebAPIPath', sWebAPIPath);
      WriteString('Application', 'sWebAPIPath', sWebAPIPath);
      WriteBool('Application', 'bShowCloseButton', bShowCloseButton);
      WriteBool('Application', 'bShowOptionButton', bShowOptionButton);
      WriteInteger('Application', 'iRefreshUrl', iRefreshUrl);
      UpdateFile;
    end;
  finally
    ini.Free;
  end;
end;

procedure TDM.WriteIni(const sPath: string);
begin
  if FileExists(sPath) then
    Write(sPath);
end;

function TDM.ReadIni(sPath: string): Boolean;
var
  ini: TMemIniFile;
  L: TIniStringList;
begin
  sPath := IncludeTrailingPathDelimiter(sPath);
  try
    if FileExists(MForm.AppSett.sIniPath) then
    begin
      ini := TMemIniFile.Create(MForm.AppSett.sIniPath);
      with ini, MForm, AppSett do
      begin
        bKiosk := ReadBool('Application', 'bKiosk', True);
        bLog := ReadBool('Application', 'bLog', False);
        bNavPanel := ReadBool('Application', 'bNavPanel', True);
        sDefLink := Trim(ReadString('Application', 'sDefLink',
          'http://localhost/'));
        sDefCookiesDir := Trim(ReadString('Application', 'sDefCookiesDir',
          ExtractFilePath(sAppName) + '\Cookies'));
        sSQLPath := Trim(ReadString('Application', 'sSQLPath', ''));
        sWebAPIPath := Trim(ReadString('Application', 'sWebAPIPath', ''));
        bShowCloseButton := ReadBool('Application', 'bShowCloseButton', True);
        bShowOptionButton := ReadBool('Application', 'bShowOptionButton', True);
        sPathLog := Trim(ReadString('Application', 'sPathLog', sPath));
        iRefreshUrl := ReadInteger('Application', 'iRefreshUrl', 1);
        iMinLogLevel := ReadInteger('Application', 'iMinLogLevel', 2);
        iTimeOut := ReadInteger('Application', 'iTimeOut', 3000);
        bMSWS12R2 := ReadBool('Application', 'bMSWS12R2', True);

        bSend := ReadBool('Mail', 'bSend', False);
        sFrom := ReadString('Mail', 'sFrom', 'a103-blackscreen1@vsk.sibur.ru');
        sTo := ReadString('Mail', 'sTo', '');
        sPass := Decrypt(ReadString('Mail', 'sPass', '40uzKdgA'), 'Vmx');
        sSMTP := ReadString('Mail', 'sSMTP', 'smtp.sibur.local');
        iPort := ReadInteger('Mail', 'iPort', 25);
        iMTimeOut := ReadInteger('Mail', 'iMTimeOut', 300000);
        iCamsCheckDelay := ReadInteger('Application', 'iCamsCheckDelay', 60);
        {$IFDEF DEBUG}
        iCamsCheckDelay := 2;
        {$ENDIF}
        if Assigned(AppSett.slCams) then
        begin
          L := TIniStringList.Create;
          L.LoadFromIni(MForm.AppSett.sIniPath, 'CamsList');
          AppSett.slCams.Text := L.Text;
          L.Free;
        end;
        if bLog then
          try
            // DirectoryExists иногда возвращает TRUE, даже если директории нет,
            // поэтому пришлось затраить
            if not DirectoryExists(sPathLog) then
              if not ForceDirectories(sPathLog) then
                sPathLog := sIniPath;
          except
            on E: Exception do
            begin
              MForm.AddToLog(E.Message + ':' + #13#10 +
                'Ошибка в параметре sPathLog. Невозможно создать директорию c именем "'
                + sPathLog + '". Лог будет записан в директорию с программой');
              sPathLog := sPath + 'Logs\';
            end;
          end;
      end;
      ini.Free;
    end;
  finally
    if not FileExists(MForm.AppSett.sIniPath) then
    begin
      MForm.AppSett.bKiosk := True;
      MForm.AppSett.sDefLink := 'http://localhost/';
      MForm.AppSett.sPathLog := ExtractFilePath(sAppName) + 'Logs\';
      MForm.AppSett.sDefCookiesDir := ExtractFilePath(sAppName) + 'Cookies\';
      Write(sPath);
    end;
  end;
  Result := True;
end;

function TDM.SetJson(sJson: string): string;
var
  sResponse: string;
  JsonToSend: TStringStream;
begin
  Result := '';
  JsonToSend := TStringStream.Create(sJson, TEncoding.UTF8);
  try
    idhtpS.Request.ContentType := 'application/json';
    idhtpS.Request.CharSet := 'utf-8';
    try
      sResponse := idhtpS.Post(MForm.AppSett.sWebAPIPath, JsonToSend);
      Result := sResponse;
    except
      on E: Exception do
        MForm.AddToLog(E.Message);
    end;
  finally
    JsonToSend.Free;
  end;
end;

end.
