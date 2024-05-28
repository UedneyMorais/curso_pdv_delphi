unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Cadastro2: TMenuItem;
    Cargo1: TMenuItem;
    procedure Cadastro2Click(Sender: TObject);
    procedure Cargo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses Users, Office;

procedure TFrmMenu.Cadastro2Click(Sender: TObject);
begin
      FrmUsers := TFrmUsers.Create(Self);
      FrmUsers.Show();
end;

procedure TFrmMenu.Cargo1Click(Sender: TObject);
begin
      FrmOffice := TFrmOffice.Create(self);
      FrmOffice.Show();
end;

end.
