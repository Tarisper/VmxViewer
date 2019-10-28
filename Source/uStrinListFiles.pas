unit uStrinListFiles;

interface

uses Classes;

type
  TIniStringlist = class(TStringList)
  public
    procedure LoadFromIni(const FileName, Section: string);
    procedure SaveToIni(const FileName, Section: string);
end;

implementation

uses
  IniFiles, SysUtils;

procedure TIniStringList.LoadFromIni(const FileName, Section: string);
var
  index: Integer;
  Line: string;
begin
  with TIniFile.Create( FileName ) do
    try
      ReadSectionValues( Section, Self);
      for index:= 0 to Count - 1 do
      begin
        { Удаляем имя идентификатора ...}
        Line:= Values[ IntToStr( index ) ];
        { Удаляем тильду ... }
        System.Delete( Line, 1, 1);
        Strings[ index ]:= Line;
      end;
    finally
      Free;
    end;
end;

procedure TIniStringList.SaveToIni( const FileName, Section: string);
var
  index: Integer;
  Line: string;
begin
  with TIniFile.Create( FileName ) do
    try
      EraseSection( Section );
      for index:= 0 to Count - 1 do
      begin
        { Сохраняем белые пробелы, пустые строки ...}
        Line:= '~' + Strings[ index ];
        WriteString( Section, IntToStr( index ), Line);
      end;
    finally
      Free;
    end;
end;

end.
