unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmLogin = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    pnlLogin: TPanel;
    Image2: TImage;
    txtUsername: TEdit;
    txtPassword: TEdit;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
  private
    { Private declarations }
    procedure centerPanel;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

procedure TFrmLogin.centerPanel;
begin
  pnlLogin.Top := (Self.Height div 2) - (pnlLogin.Height div 2);
  pnlLogin.Left := (Self.Width div 2) - (pnlLogin.Width div 2)
end;

procedure TFrmLogin.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
      centerPanel;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
      centerPanel;
end;

end.
