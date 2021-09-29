unit uDisableGhosting;

// ���� ��������� � WinXP � ���� �������� Window Ghosting
// ��� ����� �������� �������� � ���������� ������ ��� ������� ������ �
// ������������ ������� � ��������� ��������� ���� �� �������� ������.
// � ������ �������, ���� ���������� ������������� ������, �� ������� ��� ��������
// � ������� ����������� �����.
// ������ �������� �� ����. ���������� ������ ��������� � Uses.

interface

uses Windows;

implementation

procedure DisableGhosting;
var
  User32: HMODULE;
  DisableProcessWindowsGhosting: procedure;
begin
  User32:=GetModuleHandle('USER32');
  if User32<>0 then begin
    DisableProcessWindowsGhosting:=GetProcAddress(User32,'DisableProcessWindowsGhosting');
    if assigned(DisableProcessWindowsGhosting) then
      DisableProcessWindowsGhosting;
  end;
end;

initialization
  DisableGhosting;

end.