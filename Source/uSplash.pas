unit uSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TSpForm = class(TForm)
    img1: TImage;
    shp1: TShape;
    lbl1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SpForm: TSpForm;

implementation

{$R *.dfm}

end.
